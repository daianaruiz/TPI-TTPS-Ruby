class BookPolicy < ApplicationPolicy
    def show?
        @record.user_id == @user.id
    end
    def update?
        @record.user_id == @user.id
    end
end