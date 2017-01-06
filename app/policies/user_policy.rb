class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.role.name == 'admin'
  end

  def show?
    user == record || user.role.name == 'admin'
  end

  def create?
    true
  end

  def update?
    user == record || user.role.name == 'admin'
  end
end
