class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
  validates_presence_of :title
  validates_presence_of :price
  validates_presence_of :status
  validates_presence_of :frequency

  def self.find_subs_by_customer(customer_id)
    Subscription.where(customer_id: customer_id)
  end
end
