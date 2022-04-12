class Api::V1::SubscriptionsController < ApplicationController
  def create
    new_tea_subscription = TeaSubscription.create(subscription_id: params[:subscription_id], tea_id: params[:tea_id] )
    render status: :no_content
  end
end
