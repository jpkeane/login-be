RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) do
    @persisted_user = FactoryGirl.create(:user)
  end

  describe 'GET #index' do
    context 'when admin user type' do
      include_context 'admin authenticated controller'

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when incorrect user type' do
      include_context 'customer authenticated controller'

      it 'returns 403' do
        get :index
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when unauthenticated' do
      it 'returns 401' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #show' do
    context 'when admin user type' do
      include_context 'admin authenticated controller'

      it 'returns http success' do
        get :show, params: { id: @persisted_user.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when own user' do
      let!(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: @persisted_user.id) }
      before do
        allow(controller).to receive(:doorkeeper_token) { token }
      end

      it 'returns http success' do
        get :show, params: { id: @persisted_user.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when incorrect user type' do
      include_context 'customer authenticated controller'

      it 'returns 403' do
        get :show, params: { id: @persisted_user.id }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when unauthenticated' do
      it 'returns 401' do
        get :show, params: { id: @persisted_user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    new_user = FactoryGirl.build(:user)
    let(:create_object) do
      {
        data: {
          type: 'users',
          attributes: {
            username: new_user.username,
            password: new_user.password,
            name:     new_user.name
          }
        }
      }
    end

    it 'returns 201 with valid id' do
      post :create, params: create_object
      expect(response).to have_http_status(:created)
    end

    it 'returns 422 with bad data' do
      incorrect_object = create_object
      incorrect_object[:data][:attributes][:username] = ''
      post :create, params: incorrect_object
      expect(response).to have_http_status(:unprocessable_entity)

      incorrect_object = create_object
      incorrect_object[:data][:attributes][:password] = ''
      post :create, params: incorrect_object
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH #update' do
    let(:update_object) do
      id = @persisted_user.id
      {
        id: id,
        data: {
          id: id,
          type: 'users',
          attributes: {
            name: 'NEW Name'
          }
        }
      }
    end

    context 'when admin user type' do
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
        incorrect_object[:data][:attributes][:name] = ''
        patch :update, params: incorrect_object
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when own user' do
      let!(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: @persisted_user.id) }
      before do
        allow(controller).to receive(:doorkeeper_token) { token }
      end

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
        incorrect_object[:data][:attributes][:name] = ''
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
end
