require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it {should belong_to :customer}
    it {should have_many :tea_subscriptions}
    it { should have_many(:teas).through(:tea_subscriptions) }
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :price}
    it {should validate_presence_of :status}
    it {should validate_presence_of :frequency}
  end

  it '#find_subs_by_customer' do
    customers = FactoryBot.create_list(:customer, 2)
    subscriptions = FactoryBot.create_list(:subscription, 3, status: 'active', customer_id: customers[0].id )
    subscriptions_2 = FactoryBot.create_list(:subscription, 2, status: 'cancelled', customer_id: customers[0].id )
    subscriptions_3 = FactoryBot.create_list(:subscription, 1, status: 'active', customer_id: customers[1].id )
    subscriptions_4 = FactoryBot.create_list(:subscription, 4, status: 'cancelled', customer_id: customers[1].id )
    teas = FactoryBot.create_list(:tea, 5)
    tea_subscription_1 = TeaSubscription.create!(subscription_id: subscriptions[0].id, tea_id: teas[0].id)
    tea_subscription_2 = TeaSubscription.create!(subscription_id: subscriptions[0].id, tea_id: teas[2].id)
    tea_subscription_3 = TeaSubscription.create!(subscription_id: subscriptions_3[0].id, tea_id: teas[1].id)
    tea_subscription_4 = TeaSubscription.create!(subscription_id: subscriptions_4[1].id, tea_id: teas[1].id)
    tea_subscription_5 = TeaSubscription.create!(subscription_id: subscriptions_4[2].id, tea_id: teas[4].id)

    expected = subscriptions_3 + subscriptions_4
    
    expect(Subscription.find_subs_by_customer(customers[1]).count).to eq(5)
    expect(Subscription.find_subs_by_customer(customers[1])).to eq(expected)
  end
end
