class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      redirect_to @subscription
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def edit
    @subscription = Subscription.find(params[:id])
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    redirect_to(root_url, :notice => "You will no longer receive tweets from #{@subscription.screen_name} by email.")
  end
end