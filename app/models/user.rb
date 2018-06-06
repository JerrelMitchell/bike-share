class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, confirmation: true
  validates :username, uniqueness: true, presence: true

  has_many :accessories, dependent: :destroy
  has_many :orders, dependent: :destroy

  enum role:[:default, :admin]
end
