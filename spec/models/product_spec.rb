require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'validations' do

    it 'requires a title' do
      p1 = Product.new
      p1.valid?
      expect(p1.errors.messages).to have_key(:title)
    end

    it 'requires a unique title' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'j@s.com')
      p1 = Product.create!(
                            title:'unique title',
                            description: 'description blah',
                            price: 300,
                            user: user)
      p2 = Product.new(
                        title:'unique title',
                        description: 'description blah',
                        price: 300,
                        user: user)
      p2.valid?
      expect(p2.errors.messages).to have_key(:title)
    end

    it 'requires a description' do
      # user = User.create!(first_name: 'Jon', last_name: 'Snow', email: 'j@s.com', password:
      # 'supersecret')
      # p1 = Product.create(title:'unique title', price: 300, user: user)
      p1 = Product.new
      p1.valid?
      expect(p1.errors.messages).to have_key(:description)
    end

    it 'requires a price' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'j@s.com')
      p1 = Product.create(title:'unique title', description: 'description blah', user: user)
      p1.price = nil # because we give a default price in product
      p1.valid?
      expect(p1.errors.messages).to have_key(:price)
    end

    it 'must have a price greater than 0' do
      user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com')
      p1 = Product.create(title:'unique title', description: 'description blah', price: 0, user: user)
      expect(p1.errors.messages).to have_key(:price)
    end

    it 'has a sale_price which is set to price by default if not present' do
      user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'j@s.com')
      p1 = Product.create(title:'unique title', description: 'description blah', user: user)
      result = p1.sale_price
      expect(result).to eq(p1.price)
    end

    it 'has a sale_price that must be less than or equal to price' do
      user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com')
      p1 = Product.create(title:'unique title', description: 'description blah', price: 10, sale_price:12, user: user)
      expect(p1.errors.messages).to have_key(:sale_price)
    end



  end

#--------------------------------------------------------------------------------

  describe '.on_sale?' do
    it 'returns true when the product is on sale' do
      user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com')
      p1 = Product.create(title:'unique title', description: 'description blah', price: 10, sale_price:9, user: user)

      result = p1.on_sale?
      expect(result).to eq(true)
    end
  end

#--------------------------------------------------------------------------------

  describe 'save' do

    it 'titleizes title after initialize' do
      user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com',       password: 'supersecret')
      p1 = Product.create!(title:'unique title', description: 'description blah', price: 300, user: user)
      result = p1.title
      expect(result).to eq('Unique Title')
    end

  end

  describe 'search products by description' do

    it 'search for a product by description' do
    user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com', password: 'supersecret')
    p1 = Product.create!(title:'unique_title1', description: 'blah blah blah blah', price: 10, user: user)
    p2 = Product.create!(title:'unique_title2', description: 'argh argh argh argh', price: 10, user: user)

    # result = Product.search('blah').size
    # expect(result).to eq(1)
    result1 = Product.search('blah').first.id
    expect(result1).to eq(p1.id)
    end

  end

  describe 'search products by title' do

    it 'search for a product by title' do
    user = User.create(first_name: 'Jon', last_name: 'Snow',  email: 'j@s.com', password: 'supersecret')
    p1 = Product.create!(title:'unique_title1', description: 'blah blah blah blah', price: 10, user: user)
    p2 = Product.create!(title:'unique_title2', description: 'argh argh argh argh', price: 10, user: user)

    # result = Product.search('unique_title1').size
    # expect(result).to eq(1)
    result1 = Product.search('unique_title1').first.id
    expect(result1).to eq(p1.id)
    end

  end

end
