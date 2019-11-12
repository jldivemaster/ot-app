class ManagerMailer < ApplicationMailer
  def email manager
    mail(to: manager.email, subject: 'Overtime App Request Email')
  end
end
