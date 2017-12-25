require 'rails_helper'
require 'pp'

RSpec.describe ProductsController, type: :controller do

  describe 'new' do

    it 'renders the new template' do
        # Given: defaults...
        # When: we make a get request
        get :new
        # Then: we expect that the new template is rendered
        expect(response).to render_template(:new)
        # `response` is an object available in all controller specs
        # `render_template` is a rspec-rails matcher that checks that the
        # response object actually rendered a given template.
      end

      it 'sets an instance variable with a new product' do
        get :new
        expect(assigns(:product)).to be_a_new(Product)
        # `assigns(:campaign)` will check for the presence of an instance
        # variable named `@campaign` and will also return it if it exists.
        # `be_a_new` is an rspec matcher that will test that the given object
        # is an instance of the passed in class. In this case, it's testing
        # `assigns(:campaign) == Campaign.new`

      end

  end

  # describe 'new':
  # Test in terminal:
  # > rspec spec/controllers/products_controller_spec.rb
  # go to products_controller.rb, add a `new method` without anything
  # go to routes, add resources :products
  # go to views/campaigns/ , create a new.html.erb
  # go to products_controller.rb, add `@product = Product.new` to the new method
#--------------------------------------------------------------------------
  describe '#create' do

    context 'with valid parameters' do
      def valid_request
        post :create, params: {
          product: FactoryBot.attributes_for(:product)
        }
      end

      it 'createsa new product in the database' do
        count_before = Product.count
        valid_request
        pp Product.last
        # user = User.create(first_name: 'Jon', last_name: 'Snow', email: 'j@s.com')
        # p1 = Product.create!(
        #                       title:'unique title',
        #                       description: 'description blah',
        #                       price: 300,
        #                       user: user)
        # pp p1
        count_after = Product.count
        pp count_after
        count_after2 = Product.count - 1
        pp count_after2
        expect(count_before).to eq(count_after - 1)
      end

      # it 'redirects to the show page of that campaign' do # B in controller
      #   valid_request
      #   expect(response).to redirect_to(campaign_path(Campaign.last))
      # end
      #
      # it 'sets a flash message' do #C in controller
      #   valid_request
      #   expect(flash[:notice]).to be # check the existance
      # end
      #
    end

    # context 'with invalid parameters' do
    #   def invalid_request
    #     post :create, params: {
    #       campaign: FactoryBot.attributes_for(:campaign).merge({title: nil})
    #       # merge makes the title nil, so there's a rollback when create
    #     }
    #   end
    #
    #   it 'doesn\'t create a campaign in the database' do
    #     count_before = Campaign.count
    #     invalid_request
    #     count_after = Campaign.count
    #     expect(count_before).to eq(count_after)
    #   end
    #
    #   it 'renders the new template' do #D in controller
    #     invalid_request
    #     expect(response).to render_template(:new)
    #   end
    #
    # end

  end


end
