class MedicineAllRecordsController < ApplicationController
  before_action :logged_in_user, only: :summary

  def summary
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
			  @station = Station.find_by(user_id: current_user.id)
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          @data[0] = MedicineExternalRecord.from_date(n).group(:sample_id).sum(:amount)
          @data[1] = MedicineInternalRecord.from_date(n).group(:sample_id).sum(:amount)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicineExternalRecord.in_range(begin_date, end_date).group(:sample_id).sum(:amount)
          @data[1] = MedicineInternalRecord.in_range(begin_date, end_date).group(:sample_id).sum(:amount)
          render json: @data
        else
          redirect_to root_path
        end
      else
        head :no_content
      end
    else
      if has_station?
			  @station = Station.find_by(user_id: current_user.id)
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          @data[0] = MedicineExternalRecord.from_date(n).group(:sample_id).sum(:amount)
          @data[1] = MedicineInternalRecord.from_date(n).group(:sample_id).sum(:amount)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicineExternalRecord.in_range(begin_date, end_date).group(:sample_id).sum(:amount)
          @data[1] = MedicineInternalRecord.in_range(begin_date, end_date).group(:sample_id).sum(:amount)
          render json: @data
        else
					@data[0] = MedicineExternalRecord.group(:sample_id).sum(:amount)
          @data[1] = MedicineInternalRecord.group(:sample_id).sum(:amount)
          render json: @data
        end
      else
        redirect_to root_path
      end
    end
  end
end
