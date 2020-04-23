create or replace package body product_api_pack is

  g_is_api boolean := false;

  -- создание продукта
  function create_product (pi_prd_name   product.prd_name%type,
                           pi_prd_price  product.prd_price%type := 0) return product.prd_id%type
  is
    v_res product.prd_id%type;
  begin
    g_is_api := true;

    insert into product
      (prd_id
      ,prd_name
      ,prd_price) 
    values 
      (product_pk.nextval
      ,pi_prd_name
      ,pi_prd_price)
      returning prd_id into v_res;
  
    g_is_api := false;
    return v_res;

  exception
    when others then
      g_is_api := false;
  end;

  -- обновление цены продукта
  procedure update_product_price(pi_product_id product.prd_id%type
                                ,pi_prd_price  product.prd_price%type) is
  v_prd_id product.prd_id%type;

  begin

   --проверка, что продукт существует	  
   select prd_id into v_prd_id
   from product where prd_id = pi_product_id;


    g_is_api := true;
   
    update product p
    set p.prd_price = pi_prd_price
    where p.prd_id = pi_product_id;
    g_is_api := false;
  exception
  when no_data_found then
      raise_application_error(-20007, 'product not found.');
      g_is_api := false;
    when others then
      g_is_api := false;
  end;

  -- удаление продукта
  procedure delete_product(pi_product_id product.prd_id%type) is
  begin
    g_is_api := true;
    delete from product p where p.prd_id = pi_product_id;
    g_is_api := false;
  exception
    when others then
      g_is_api := false;
  end;

  --проверка запрета ручных изменений
  procedure product_tab_trigger is
  begin
    if not (g_is_api or nvl(sys_context('clientcontext', 'force_dml'), 'false') = 'true')
    then
      raise_application_error(-20006,'manual change forbidden');
    end if;
  end;


end;
/