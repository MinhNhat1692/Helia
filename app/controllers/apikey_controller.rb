class ApikeyController < ApplicationController
  before_action :logged_in_user, only: [:getkey, :changekey, :addkey]
  
  def getkey
    @user = current_user
    @keyapi = Apikey.find_by(user_id: @user.id)
    render json: [[@keyapi]]
  end

  def changekey
    @user = current_user
    if has_apikey?
      @keyapi = Apikey.find_by(user_id: @user.id)
      @keyapi.generateKey
      while !@keyapi.valid? do
        @keyapi.generateKey
      end
      if @keyapi.save
        render json: [@keyapi]
  		else
	  	  render json: @keyapi.errors, status: :unprocessable_entity
		  end
    end
  end

  def addkey
    @user = current_user
    if !has_apikey?
      @keyapi = Apikey.new(user_id: @user.id)
      while !@keyapi.valid? do
        @keyapi.generateKey
      end
      if @keyapi.save
        render json: [@keyapi]
  		else
	  	  render json: @keyapi.errors, status: :unprocessable_entity
		  end
    end
  end
end
