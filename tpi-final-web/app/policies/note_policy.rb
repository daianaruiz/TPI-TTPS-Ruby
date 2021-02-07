class NotePolicy < ApplicationPolicy
    def index?
        @record.user_id == @user.id
    end
    def show?
        @record.user_id == @user.id
    end
    def create?
        @record.user_id == @user.id
    end
    def update?
        @record.user_id == @user.id        
    end
end