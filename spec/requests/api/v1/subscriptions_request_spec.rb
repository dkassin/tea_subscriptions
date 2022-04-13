require 'rails_helper'
RSpec.describe 'subscription API' do
  describe 'subscriptions' do
    before(:each) do
      @customers = FactoryBot.create_list(:customer, 2)
      @subscriptions = FactoryBot.create_list(:subscription, 3, status: 'active', customer_id: @customers[0].id )
      @subscriptions_2 = FactoryBot.create_list(:subscription, 2, status: 'cancelled', customer_id: @customers[0].id )
      @teas = FactoryBot.create_list(:tea, 5)
      @tea_subscription_1 = TeaSubscription.create!(subscription_id: @subscriptions[0].id, tea_id: @teas[0].id)
      @tea_subscription_2 = TeaSubscription.create!(subscription_id: @subscriptions[0].id, tea_id: @teas[2].id)
      @tea_subscription_3 = TeaSubscription.create!(subscription_id: @subscriptions[2].id, tea_id: @teas[1].id)
      @tea_subscription_4 = TeaSubscription.create!(subscription_id: @subscriptions_2[0].id, tea_id: @teas[1].id)
      @tea_subscription_5 = TeaSubscription.create!(subscription_id: @subscriptions[1].id, tea_id: @teas[4].id)
    end
  # before(:each) do
    # @customer = FactoryBot.create(:customer)
    # @customer_1 = Customer.create!(first_name: 'Chuck', last_name: 'Norris', email: 'chuck_5@gmail.com', address: '123 Fake Address')
  # end
    it 'An endpoint to subscribe a customer to a tea subscription' do
      data =
    {
      "subscription_id": @subscriptions[1].id, "tea_id": @teas[3].id
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/subscriptions', headers: headers, params: JSON.generate(data)

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(TeaSubscription.last.subscription_id).to eq(data[:subscription_id])
    expect(TeaSubscription.last.tea_id).to eq(data[:tea_id])
    end

    it 'An endpoint to cancel a customer’s tea subscription' do
      data =
    {
      "id": @tea_subscription_2.id, status: "cancelled"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    expect do
      patch '/api/v1/subscriptions', headers: headers, params: JSON.generate(data)
    end.to change {@tea_subscription_2.reload.subscription.status}
    expect(response).to be_successful
    expect(response.status).to eq(204)
    end

    it 'An endpoint to see all of a customer’s subsciptions (active and cancelled)' do

      get "/api/v1/subscriptions/#{@customers[0].id}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end
end
