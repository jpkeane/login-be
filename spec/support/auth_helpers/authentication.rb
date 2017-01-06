RSpec.shared_context 'admin authenticated request', authenticated: true do
  before do
    @user = FactoryGirl.create(:admin_user)
    @access_token = Doorkeeper::AccessToken.create!(resource_owner_id: @user.id)
    header 'Authorization', "Bearer #{@access_token.token}"
  end
end

RSpec.shared_context 'customer authenticated request', authenticated: true do
  before do
    @user = FactoryGirl.create(:customer_user)
    @access_token = Doorkeeper::AccessToken.create!(resource_owner_id: @user.id)
    header 'Authorization', "Bearer #{@access_token.token}"
  end
end

RSpec.shared_context 'unauthenticated', unauthenticated: true do
  before do
    header 'Authorization', ''
  end
end

RSpec.shared_context 'admin authenticated controller', authenticated_controller: true do
  let!(:user) { FactoryGirl.create(:admin_user) }
  let!(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: user.id) }
  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end
end

RSpec.shared_context 'customer authenticated controller', authenticated_controller: true do
  let!(:user) { FactoryGirl.create(:customer_user) }
  let!(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: user.id) }
  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end
end
