class Order < ApplicationRecord
  validates :status, presence: true

  belongs_to :user

  has_many :accessory_orders
  has_many :accessories, through: :accessory_orders

  enum status: [:ordered, :paid, :cancelled, :completed]

  def assign_accessories(contents)
    contents.each do |key, value|
      value.times do
        AccessoryOrder.create(order_id: id, accessory_id: key.to_i)
      end
    end
  end

  def total_price
    accessories.sum(:price)
  end

  def self.by_status
    group(:status).count
  end

  def self.orders_paid
    where(status: "paid")
  end

  def self.orders_cancelled
    where(status: "cancelled")
  end

  def self.orders_completed
    where(status: "completed")
  end

  def self.orders_ordered
    where(status: "ordered")
  end
end
