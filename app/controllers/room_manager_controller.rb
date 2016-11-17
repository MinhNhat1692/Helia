class RoomManagerController < ApplicationController
  before_action :logged_in_user, only: [:list, :detail]
  
  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find params[:id_station]
			  if params[:length] == "1"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Date(NOW()) and status IN (?,?)", 1, 2),
            :order_map_today => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Date(NOW())"),
            :total_income_today => OrderMap.select('service_id, SUM(tpayout) AS sum').group(:service_id).where("updated_at >= Date(NOW())"),
            :total_income_perhour => OrderMap.select('updated_at, service_id, SUM(tpayout) AS sum').group('HOUR(updated_at), service_id').where("updated_at >= Date(NOW())")
          }
			  elsif params[:length] == "30"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Month(NOW()) and status IN (?,?)", 1, 2),
            :order_map_today => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Month(NOW())"),
            :total_income_today => OrderMap.select('service_id, SUM(tpayout) AS sum').group(:service_id).where("updated_at >= Month(NOW())"),
            :total_income_perhour => OrderMap.select('updated_at, service_id, SUM(tpayout) AS sum').group('DATE(updated_at), service_id').where("updated_at >= Month(NOW())")
          }
        elsif params[:length] == "365"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Year(NOW()) and status IN (?,?)", 1, 2),
            :order_map_today => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Year(NOW())"),
            :total_income_today => OrderMap.select('service_id, SUM(tpayout) AS sum').group(:service_id).where("updated_at >= Year(NOW())"),
            :total_income_perhour => OrderMap.select('updated_at, service_id, SUM(tpayout) AS sum').group('MONTH(updated_at),service_id').where("updated_at >= Year(NOW())")
          }
        end
		  else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
			  if params[:length] == "1"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Date(NOW()) and status IN (?,?)", 1, 2),
            :order_map_today => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Date(NOW())"),
            :total_income_today => OrderMap.select('service_id, SUM(tpayout) AS sum').group(:service_id).where("updated_at >= Date(NOW())"),
            :total_income_perhour => OrderMap.select('updated_at, service_id, SUM(tpayout) AS sum').group('HOUR(updated_at), service_id').where("updated_at >= Date(NOW())")
          }
			  elsif params[:length] == "30"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Month(NOW()) and status IN (?,?)", 1, 2),
            :order_map_today => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Month(NOW())"),
            :total_income_today => OrderMap.select('service_id, SUM(tpayout) AS sum').group(:service_id).where("updated_at >= Month(NOW())"),
            :total_income_perhour => OrderMap.select('updated_at, service_id, SUM(tpayout) AS sum').group('DATE(updated_at), service_id').where("updated_at >= Month(NOW())")
          }
        elsif params[:length] == "365"
          render :json => {
            :room => Room.includes(:service_maps).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:service_maps] ),
            :position => Position.includes(:position_mappings).where(station_id: @station.id).order(updated_at: :desc).as_json( :include => [:position_mappings] ),
            :order_map_wait => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Year(NOW()) and status IN (?,?)", 1, 2),
            :order_map_today => OrderMap.select('service_id, COUNT(*) AS count').group(:service_id).where("updated_at >= Year(NOW())"),
            :total_income_today => OrderMap.select('service_id, SUM(tpayout) AS sum').group(:service_id).where("updated_at >= Year(NOW())"),
            :total_income_perhour => OrderMap.select('updated_at, service_id, SUM(tpayout) AS sum').group('MONTH(updated_at),service_id').where("updated_at >= Year(NOW())")
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
