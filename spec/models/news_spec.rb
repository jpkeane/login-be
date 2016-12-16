RSpec.describe News, type: :model do
  describe 'attributes' do
    it { is_expected.to have_attribute :title }
    it { is_expected.to have_attribute :date }
    it { is_expected.to have_attribute :body }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_presence_of :body }
  end
end
