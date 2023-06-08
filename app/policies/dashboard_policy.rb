class DashboardPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
     def resolve
       scope.where(user: user)
     end
  end

  def create?
    true
  end


  def index?
    true
    end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
