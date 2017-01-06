RSpec.describe Api::V1::ProductsController, type: :controller do
  before(:each) do
    @persisted_product = FactoryGirl.create(:product)
  end

  describe 'GET #index' do
    include_context 'customer authenticated controller'

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    include_context 'customer authenticated controller'

    it 'returns http success' do
      get :show, params: { id: @persisted_product.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    new_product = FactoryGirl.build(:product)
    let(:create_object) do
      {
        data: {
          type: 'products',
          attributes: {
            title: new_product.title,
            price: new_product.price,
            description: new_product.description
          }
        }
      }
    end

    context 'when correct user type' do
      include_context 'admin authenticated controller'

      it 'returns 201 with valid id' do
        post :create, params: create_object
        expect(response).to have_http_status(:created)
      end

      it 'returns 422 with bad data' do
        incorrect_object = create_object
        incorrect_object[:data][:attributes][:title] = ''
        post :create, params: incorrect_object
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when incorrect user type' do
      include_context 'customer authenticated controller'

      it 'returns 403 with valid id' do
        post :create, params: create_object
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when unauthenticated' do
      it 'returns 401' do
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH #update' do
    let(:update_object) do
      id = @persisted_product.id
      {
        id: id,
        data: {
          id: id,
          type: 'news',
          attributes: {
            title: 'NEW TITLE'
          }
        }
      }
    end

    context 'when correct user type' do
      include_context 'admin authenticated controller'

      it 'returns 201 with valid id' do
        patch :update, params: update_object
        expect(response).to have_http_status(:ok)
      end

      it 'returns 404 with invalid id' do
        incorrect_object = update_object
        incorrect_object['id'] = 0
        patch :update, params: incorrect_object
        expect(response).to have_http_status(:not_found)
      end

      it 'returns 422 with bad data' do
        incorrect_object = update_object
        incorrect_object[:data][:attributes][:title] = ''
        patch :update, params: incorrect_object
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when incorrect user type' do
      include_context 'customer authenticated controller'

      it 'returns 403 with valid id' do
        patch :update, params: update_object
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when unauthenticated' do
      it 'returns 401' do
        patch :update, params: { id: 0 }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when correct user type' do
      include_context 'admin authenticated controller'

      it 'returns 204 with valid id' do
        delete :destroy, params: { id: @persisted_product.id }
        expect(response).to have_http_status(:no_content)
      end

      it 'returns 404 with invalid id' do
        delete :destroy, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when incorrect user type' do
      include_context 'customer authenticated controller'

      it 'returns 403 with valid id' do
        delete :destroy, params: { id: @persisted_product.id }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when unauthenticated' do
      it 'returns 401 with valid id' do
        delete :destroy, params: { id: @persisted_product.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
