class User < ApplicationRecord
  has_many :sales
  has_one :role
end
