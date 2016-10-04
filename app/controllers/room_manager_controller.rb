class RoomManagerController < ApplicationController
  before_action :logged_in_user, only: [:list, :detail]
  
  def list
  end

  def detail
  end
end
