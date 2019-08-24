class Post < ApplicationRecord
  validates_presence_of :date, :rationale
  belongs_to :user
  
end
