require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'product saves successfully' do
      @category = Category.find_or_create_by! name: 'Apparel'
      @product = Product.create(name: 'b', price: 200, quantity: 10, category: @category)
      expect(@product).to be_present
    end
    it 'name exists' do
      @category = Category.find_or_create_by! name: 'Apparel'
      @product = Product.create(price: 200, quantity: 10, category: @category)
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end
    it 'price exists' do
      @category = Category.find_or_create_by! name: 'Apparel'
      @product = Product.create(name: 'a', quantity: 10, category: @category)
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
    it 'quantity exists' do
      @category = Category.find_or_create_by! name: 'Apparel'
      @product = Product.create(name: 'a', price: 200, category: @category)
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
    it 'category exists' do
      @product = Product.create(name: 'a', price: 200, quantity: 10)
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
