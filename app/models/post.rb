class Post < ApplicationRecord
  enum status: { submitted: 0, approved: 1, rejected: 2 }
  validates_presence_of :date, :rationale
  belongs_to :user

end
