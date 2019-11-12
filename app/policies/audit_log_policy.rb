class AuditLogPolicy < ApplicationPolicy

  def index?
    return true if admin?
  end

  def confirm?
    record.user_id == user.id
  end

  private

    def admin?
      admin_types.include?(user.type)
    end

end
