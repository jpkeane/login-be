RSpec.describe User, type: :model do
  describe 'attributes' do
    it { is_expected.to have_attribute :name }
    it { is_expected.to have_attribute :username }
    it { is_expected.to have_attribute :password_digest }

    it { is_expected.to respond_to :password }

    it 'persists a password digest based on the authentication password' do
      password = 'password123'
      subject = FactoryGirl.create(:user, password: password)
      expect(subject.authenticate(password)).to eq subject
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_presence_of :password }

    it 'validates uniqueness of usernames' do
      subject { FactoryGirl.create(:user) }
      expect(validate_uniqueness_of(:username).case_insensitive).to be_truthy
    end

    it 'validates format of usernames' do
      valid_un = %w(valid valid_name valid-name)
      valid_un.each do |un|
        user = FactoryGirl.build(:user, username: un)
        expect(user).to be_valid
      end

      invalid_un = %w(in@valid invalid&name invalid!name)
      invalid_un.each do |un|
        user = FactoryGirl.build(:user, username: un)
        expect(user).not_to be_valid
      end
    end
  end
end
