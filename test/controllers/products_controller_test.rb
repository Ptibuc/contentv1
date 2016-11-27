require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { client_id: @product.client_id, date_generation_long_description: @product.date_generation_long_description, date_generation_short_description: @product.date_generation_short_description, ean: @product.ean, long_description: @product.long_description, long_description_generated_by_us: @product.long_description_generated_by_us, photo: @product.photo, short_description: @product.short_description, short_description_generated_by_us: @product.short_description_generated_by_us, site_id: @product.site_id, title: @product.title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { client_id: @product.client_id, date_generation_long_description: @product.date_generation_long_description, date_generation_short_description: @product.date_generation_short_description, ean: @product.ean, long_description: @product.long_description, long_description_generated_by_us: @product.long_description_generated_by_us, photo: @product.photo, short_description: @product.short_description, short_description_generated_by_us: @product.short_description_generated_by_us, site_id: @product.site_id, title: @product.title } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
