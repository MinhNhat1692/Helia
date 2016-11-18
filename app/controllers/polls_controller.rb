class PollsController < ApplicationController
  include ActionController::Live
  before_action :logged_in_user, only: :list
  
  def list
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], params[:table_id], 4
        @station = Station.find params[:id_station]
        t = Time.now
        h = Hash.new
        flag = false
        round = 0
        max = 10
        while !flag && round <= max do
          ActiveRecord::Base.connection.clear_query_cache
          h["bill_info"] = BillInfo.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["customer_record"] = CustomerRecord.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["employee"] = Employee.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_bill_in"] = MedicineBillIn.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_prescript_external"] = MedicinePrescriptExternal.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", 
                                                                             t, t)
          h["medicine_prescript_internal"] = MedicinePrescriptInternal.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", 
                                                                             t, t)
          h["medicine_price"] = MedicinePrice.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_sample"] = MedicineSample.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_supplier"] = MedicineSupplier.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["position"] = Position.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["room"] = Room.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          flag = h["bill_info"].present? || h["customer_record"].present? || h["employee"].present? || h["medicine_bill_in"].present? || h["medicine_prescript_external"].present? || h["medicine_prescript_internal"].present? || h["medicine_price"].present? || h["medicine_sample"].present? || h["medicine_supplier"].present? || h["position"].present? || h["room"].present?
          sleep 10
          round += 1
        end
        render json: h
      else
        head :no_content
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        t = Time.now
        h = Hash.new
        flag = false
        round = 0
        max = 10
        while !flag && round <= max do
          ActiveRecord::Base.connection.clear_query_cache
          h["bill_info"] = BillInfo.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["customer_record"] = CustomerRecord.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["employee"] = Employee.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_bill_in"] = MedicineBillIn.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_prescript_external"] = MedicinePrescriptExternal.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", 
                                                                             t, t)
          h["medicine_prescript_internal"] = MedicinePrescriptInternal.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", 
                                                                             t, t)
          h["medicine_price"] = MedicinePrice.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_sample"] = MedicineSample.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_supplier"] = MedicineSupplier.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["position"] = Position.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          h["room"] = Room.where(station_id: @station.id).where("created_at >= ? OR updated_at >= ?", t, t)
          flag = h["bill_info"].present? || h["customer_record"].present? || h["employee"].present? || h["medicine_bill_in"].present? || h["medicine_prescript_external"].present? || h["medicine_prescript_internal"].present? || h["medicine_price"].present? || h["medicine_sample"].present? || h["medicine_supplier"].present? || h["position"].present? || h["room"].present?
          sleep 10
          round += 1
        end
        render json: h
      else
        redirect_to root_path
      end
    end
  end
=begin
  def list
    response.headers['Content-Type'] = 'text'
    if params.has_key?(:id_station)
      redirect_to root_path
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        t = Time.now
        h = Hash.new
        flag = false
        while !flag do
          response.stream.write "asd"
          ActiveRecord::Base.connection.clear_query_cache
          h["bill_info"] = BillInfo.where("created_at >= ? OR updated_at >= ?", t, t)
          h["customer_record"] = CustomerRecord.where("created_at >= ? OR updated_at >= ?", t, t)
          h["employee"] = Employee.where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_bill_in"] = MedicineBillIn.where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_prescript_external"] = MedicinePrescriptExternal.where("created_at >= ? OR updated_at >= ?", 
                                                                             t, t)
          h["medicine_prescript_internal"] = MedicinePrescriptInternal.where("created_at >= ? OR updated_at >= ?", 
                                                                             t, t)
          h["medicine_price"] = MedicinePrice.where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_sample"] = MedicineSample.where("created_at >= ? OR updated_at >= ?", t, t)
          h["medicine_supplier"] = MedicineSupplier.where("created_at >= ? OR updated_at >= ?", t, t)
          h["position"] = Position.where("created_at >= ? OR updated_at >= ?", t, t)
          h["room"] = Room.where("created_at >= ? OR updated_at >= ?", t, t)
          flag = h["bill_info"].present? || h["customer_record"].present? || h["employee"].present? || h["medicine_bill_in"].present? || h["medicine_prescript_external"].present? || h["medicine_prescript_internal"].present? || h["medicine_price"].present? || h["medicine_sample"].present? || h["medicine_supplier"].present? || h["position"].present? || h["room"].present?
          sleep 10
        end
        response.stream.write h.to_json
      else
        redirect_to root_path
      end
    end
  ensure
    response.stream.close
  end
=end
end


