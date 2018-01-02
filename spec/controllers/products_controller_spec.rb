require 'rails_helper'
require 'pp'

RSpec.describe ProductsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }


  describe '#new' do
    context 'without signed in user' do #------------------------------------
      it 'redirect the user to sessions#new page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context  'with signed in user' do #--------------------------------------
      before do
        request.session[:user_id] = user.id
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'sets an instance variable with a new product' do
        get :new
        expect(assigns(:product)).to be_a_new(Product)
      end

    end

  end

#------------------------------------------------------------------------------
describe '#create' do
  def valid_request
    post :create, params: {
      product: FactoryBot.attributes_for(:product)
    }
  end

  context 'with user not signed in' do #-------------------------------------
    it 'redirects to the new session path' do
      valid_request
      expect(response).to redirect_to(new_session_path)
    end
  end

  context 'with user signed in' do #----------------------------------------
    before do
      request.session[:user_id] = user.id
    end

    context 'with valid parameters' do
      it 'createsa new product in the database' do
        count_before = Product.count
        valid_request
        count_after = Product.count
        expect(count_before).to eq(count_after - 1)
      end

      it 'redirects to the show page of that product' do
        valid_request
        expect(response).to redirect_to(product_path(Product.last))
      end

      it 'associates the prodcut with the signed in user' do
        valid_request
        expect(Product.last.user).to eq(user)
      end

    end

    context 'with invalid parameters' do
      def invalid_request
        post :create, params: {
          product: FactoryBot.attributes_for(:product).merge({title: nil})

        }
      end

      it 'doesn\'t create a product in the database' do
        count_before = Product.count
        invalid_request
        count_after = Product.count
        expect(count_before).to eq(count_after)
      end

      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end

    end

  end
end
#------------------------------------------------------------------------------
  describe '#edit' do
    context 'with no user signed in' do
      it 'redirects the user to the new sessions path' do
        get :edit, params: {id: product.id}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do

      context 'with non-owner signed in' do
        before do
          request.session[:user_id] = user.id
        end
        # [Authorization]
        # add gem 'cancancan' to Gemfile
        # >  rails g cancan:ability
        # go to app/models/ability.rb
        # go to campaigns_controller, add `authorize_user!` method
        it 'redirects to the home page' do
          get :edit, params: {id: product.id}
          expect(response).to redirect_to(home_path)
        end
        it 'alerts the user with a flash' do
          get :edit, params: {id: product.id}
          expect(flash[:alert]).to be
        end
      end

      context 'with owner signed in' do
        before do
          request.session[:user_id] = product.user.id
        end

        it 'renders the edit template' do
          get :edit, params: { id: product.id }
          expect(response).to render_template(:edit)
        end

        it 'assigns an instance variable to the product being edited' do
          get :edit, params: { id: product.id }
          expect(assigns(:product)).to eq(product)
        end
      end

    end
  end
#------------------------------------------------------------------------------

    describe '#update' do
      context 'with no user signed in' do #------------------------------
        it 'redirects the user to the new sessions path' do
          get :edit, params: {id: product.id}
          expect(response).to redirect_to(new_session_path)
        end
      end

      context 'with user signed in' do #------------------------------------

        context 'with non-owner signed in' do
          before do
            request.session[:user_id] = user.id
          end
          it 'redirects to the home page' do
            get :edit, params: {id: product.id}
            expect(response).to redirect_to(home_path)
          end
          it 'alerts the user with a flash' do
            get :edit, params: {id: product.id}
            expect(flash[:alert]).to be
          end
        end

        context 'with owner signed in' do
          before do
            request.session[:user_id] = product.user.id
          end

             context 'with valid parameters' do
               before do
                 patch :update, params: {
                   id: product.id,
                   product: { title: 'abc' }
                 }
               end

               it 'saves the changes' do
                 expect(product.reload.title).to eq('Abc') # because of titlize
               end

               it 'redirects to the product show page' do
                 expect(response).to redirect_to(product_path(product))
               end
             end

             context 'with invalid parameters' do
               it 'renders the edit template' do
                  patch :update, params: {
                    id: product.id,
                    product: { title: '' }
                  }
                  expect(response).to render_template(:edit)
              end
             end
           end
       end

     end


end
