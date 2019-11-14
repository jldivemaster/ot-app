class User < ApplicationRecord
  has_many :posts
  has_many :audit_logs

  has_many :hands_associations, class_name: 'Hand'
  has_many :hands, through: :hands_associations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :phone, :ssn, :company

  PHONE_REGEX = /\A^[0-9]*\z/
  validates_format_of :phone, with: PHONE_REGEX
  validates :phone, length: { is: 10 }
  validates :ssn, length: { is: 4 }
  validates_numericality_of :ssn

  def full_name
    return self.last_name.upcase + ", " + self.first_name.upcase
  end


end
