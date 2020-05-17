class UserSelection < ApplicationRecord
  belongs_to :user, optional: true
  has_many :moviePerson
end
