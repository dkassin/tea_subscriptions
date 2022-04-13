class Api::V1::SubscriptionsController < ApplicationController
  def create
    TeaSubscription.create(tea_sub_params)
    render status: :no_content
  end

  def update
    subscription = TeaSubscription.find(params[:id]).subscription
    subscription.update(subscription_params)
    render status: :no_content
  end

  def index
    Subscription.find_subs_by_customer(params[:id])
  end
end

private

  def subscription_params
    params.permit(:title, :price, :status, :frequency)
  end

  def tea_sub_params
    params.permit(:subscription_id, :tea_id)
  end
