create or replace package product_api_pack is

  -- создание продукта
  function create_product (pi_prd_name   product.prd_name%type
                          ,pi_prd_price  product.prd_price%type := 0) return product.prd_id%type;

  --обновление цены продукта
  procedure update_product_price(pi_product_id product.prd_id%type
                                ,pi_prd_price  product.prd_price%type);
  
  -- удаление продукта
  procedure delete_product(pi_product_id product.prd_id%type);

  --проверка запрета ручных изменений
  procedure product_tab_trigger;

end;
/