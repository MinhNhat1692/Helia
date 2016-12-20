class PermissionsController < ApplicationController
  before_action :logged_in_user, only: [:owner_list, :doctor_list, :create, :update, :destroy]
  before_action :must_be_staion_owner, only: [:create, :update, :destroy]

  def owner_list
    if params.has_key?(:station_id)
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        @data = []
        @data[0] = @station.permissions
        user_ids = @station.permissions.pluck(:user_id).uniq
        arr =[]
        user_ids.each do |id|
          h = Hash.new
          h[:user_id] = id
          h[:name] = User.find(id).name
          arr << h
        end
        @data[1] = arr
        render json: @data
      else
        redirect_to root_path
      end
    end
  end

  def doctor_list
    @data = []
    @data[0] = current_user.permissions
    station_ids = current_user.permissions.pluck(:station_id).uniq
    arr = []
    station_ids.each do |id|
      h = Hash.new
      h[:station] = Station.find(id)
      arr << h
    end
    @data[1] = arr
    render json: @data
  end

  def create
    @station = Station.find_by(user_id: current_user.id)
    permit = Permission.find_by(user_id: params[:user_id], station_id: @station.id, 
                                table_id: params[:table_id])
    @data = []
    if permit
      if permit.update(c_permit: params[:c_permit], u_permit: params[:u_permit], r_permit: params[:r_permit], d_permit: params[:r_permit])
        @data[0] = permit
        user = User.find_by(id: params[:user_id])
        @data[1] = user.doctor_profile if user && user.doctor_profile
        render json: @data
      else
        render json: permit.errors, status: :unprocessable_entity
      end
    else
      record = Permission.new(user_id: params[:user_id], station_id: @station.id,
                              table_id: params[:table_id], c_permit: params[:c_permit],
                              u_permit: params[:u_permit], r_permit: params[:r_permit], d_permit: params[:d_permit])
      if record.save
        @data[0] = record
        user = User.find_by(id: params[:user_id])
        @data[1] = user.doctor_profile if user && user.doctor_profile
        render json: @data
      else
        render json: record.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    @station = Station.find_by(user_id: current_user.id)
    permit = Permission.find params[:record_id]
    if permit.belongs_to_station @station
      @data = []
      if permit.update(user_id: params[:user_id], station_id: params[:station_id], table_id: params[:table_id], c_permit: params[:c_permit], u_permit: params[:u_permit], r_permit: params[:r_permit], d_permit: params[:d_permit])
        @data[0] = permit
        user = permit.user
        @data[1] = user.doctor_profile if user && user.doctor_profile
        render json: @data
      else
        render json: permit.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @station = Station.find_by(user_id: current_user.id)
    permit = Permission.find params[:record_id]
    if permit.belongs_to_station @station
      permit.destroy
      head :no_content
    end
  end

  private 
    def must_be_staion_owner
      unless has_station?
        redirect_to root_path
        flash[:warning] = "You must be station owner to do this"
      end
    end
end
