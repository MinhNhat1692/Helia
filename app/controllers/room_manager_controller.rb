class RoomManagerController < ApplicationController
  before_action :logged_in_user, only: [:list, :detail]
  
  def list
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params[:length] == "1"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.group(:service_id).where("updated_at >= Date(NOW()) and status IN (?,?)", 1, 2).count,
            :order_map_today => OrderMap.group(:service_id).where("updated_at >= Date(NOW())").count,
            :total_income_today => OrderMap.group(:service_id).where("updated_at >= Date(NOW())").sum(:tpayout)
          }
			  elsif params[:length] == "30"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.group(:service_id).where("updated_at >= Month(NOW()) and status IN (?,?)", 1, 2).count,
            :order_map_today => OrderMap.group(:service_id).where("updated_at >= Month(NOW())").count,
            :total_income_today => OrderMap.group(:service_id).where("updated_at >= Month(NOW())").sum(:tpayout)
          }
        elsif params[:length] == "365"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.group(:service_id).where("updated_at >= Year(NOW()) and status IN (?,?)", 1, 2).count,
            :order_map_today => OrderMap.group(:service_id).where("updated_at >= Year(NOW())").count,
            :total_income_today => OrderMap.group(:service_id).where("updated_at >= Year(NOW())").sum(:tpayout)
          }
        end
		  else
        redirect_to root_path
      end
    end
  end

  def detail
  end
end
