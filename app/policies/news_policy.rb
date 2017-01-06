class NewsPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role.name == 'admin'
  end

  def update?
    user.role.name == 'admin'
  end

  def destroy?
    user.role.name == 'admin'
  end
end
