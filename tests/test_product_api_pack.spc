create or replace package test_product_api_pack is

  --%suite(Test product_api_pack)
  --%suitepath(product)

  --> КЕЙСЫ ДЛЯ CREATE_PRODUCT

  --%test(Успешное создание продукта)
  --%aftertest(delete_product)
  procedure create_product_success;


  --> КЕЙСЫ ДЛЯ UPDATE_PRODUCT_PRICE

  --%test(Успешное обновление цены продукта)
  --%beforetest(create_product)
  --%aftertest(delete_product)
  procedure update_existent_prd_price;

  --%test(Обновление цены несуществующего продукта)
  --%throws(-20007)
  procedure update_nonexistent_prd_price;



  --> КЕЙСЫ ДЛЯ DELETE_PRODUCT_PRICE

  --%test(Удаление существующего продукта)
  --%beforetest(create_product)
  --%aftertest(delete_product)
  procedure delete_existent_product;

  --%test(Удаление несуществующего продукта)
  procedure delete_nonexistent_product;



  --> ДОП ПРОЦЕДУРЫ

  procedure create_product;

  procedure delete_product;

end;
/