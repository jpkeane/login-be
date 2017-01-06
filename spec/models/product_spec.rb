RSpec.describe Product, type: :model do
  describe 'attributes' do
    it { is_expected.to have_attribute :title }
    it { is_expected.to have_attribute :price }
    it { is_expected.to have_attribute :description }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :price }
  end
end
