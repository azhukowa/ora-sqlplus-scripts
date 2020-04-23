create or replace package body test_product_api_pack is

  g_prd_id product.prd_id%type;

  --> КЕЙС ДЛЯ CREATE_PRODUCT

  procedure create_product_success is
    v_prd_name     product.prd_name%type := 'test product name';
    v_prd_price    product.prd_price%type := 100;
    v_prd_row      product%rowtype;
  begin

    g_prd_id := product_api_pack.create_product (pi_prd_name  => v_prd_name,
                                                 pi_prd_price => v_prd_price);

    select *
    into v_prd_row
    from product p
    where p.prd_id = g_prd_id;
  
    ut.expect(v_prd_row.prd_name).to_equal(v_prd_name);
    ut.expect(v_prd_row.prd_price).to_equal(v_prd_price);
  
  end;


 --> КЕЙСЫ ДЛЯ UPDATE_PRODUCT_PRICE

  procedure update_existent_prd_price is
    v_prd_price product.prd_price%type := 777;
    v_prd_new_price product.prd_price%type;
  begin
    
    product_api_pack.update_product_price(pi_product_id => g_prd_id,
                                          pi_prd_price => v_prd_price);

    select prd_price 
    into v_prd_new_price
    from product p 
    where p.prd_id = g_prd_id;
        
    ut.expect(v_prd_new_price).to_equal(777);

  end;


  procedure update_nonexistent_prd_price is
    v_prd_price product.prd_price%type := 777;
    v_prd_id product.prd_id%type := 0;
  begin
    product_api_pack.update_product_price(pi_product_id => v_prd_id,
                                          pi_prd_price => v_prd_price);
  end;



 --> КЕЙСЫ ДЛЯ DELETE_PRODUCT_PRICE

  procedure delete_existent_product is
    v_count number;
  begin
    
    product_api_pack.delete_product(pi_product_id => g_prd_id);

    select count(*) 
    into v_count
    from product p 
    where p.prd_id = g_prd_id;
        
    ut.expect(v_count).to_equal(0);

  end;


  procedure delete_nonexistent_product is
    v_prd_id product.prd_id%type := 0;
  begin
    product_api_pack.delete_product(pi_product_id => v_prd_id);
  end;



  --> ДОП ПРОЦЕДУРЫ


  procedure create_product is
  begin
    dbms_session.set_context('clientcontext', 'force_dml', 'true');
  
    insert into product
      (prd_id
      ,prd_name
      ,prd_price) 
    values 
      (product_pk.nextval
      ,'product_name'
      ,500)
      returning prd_id into g_prd_id;
  
    dbms_session.set_context('clientcontext', 'force_dml', 'false');
  exception
    when others then
      raise_application_error(-20008, 'chtoto ne tak.');
      dbms_session.set_context('clientcontext', 'force_dml', 'false');
  end;



  procedure delete_product is
  begin
    if g_prd_id is null
    then
      return;
    end if;
  
    dbms_session.set_context('clientcontext', 'force_dml', 'true');
  
    delete product where prd_id = g_prd_id;
  
    g_prd_id := null;
  
    dbms_session.set_context('clientcontext', 'force_dml', 'false');
  exception
    when others then
      g_prd_id := null;
      dbms_session.set_context('clientcontext', 'force_dml', 'false');
  end;


end;
/