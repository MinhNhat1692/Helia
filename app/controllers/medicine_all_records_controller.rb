class MedicineAllRecordsController < ApplicationController
  before_action :logged_in_user

  def summary
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
			  @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          bill_ins = MedicineBillIn.where(station_id: @station.id).from_date(n)
          @data[0] = []
          bill_ins.each do |bill|
            bill_data = bill.attributes
            bill_data["record"] = MedicineBillRecord.where(station_id: @station.id, bill_id: bill.id)
            @data[0] << bill_data
          end
          internal_prescripts = MedicinePrescriptInternal.where(station_id: @station.id).from_date(n)
          @data[1] = []
          internal_prescripts.each do |script|
            script_data = script.attributes
            script_data["record"] = MedicineInternalRecord.where(station_id: @station.id, script_id: script.id)
            @data[1] << script_data
          end
          @data[2] = MedicineStockRecord.where(station_id: @station.id).from_date(n)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          bill_ins = MedicineBillIn.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[0] = []
          bill_ins.each do |bill|
            bill_data = bill.attributes
            bill_data["record"] = MedicineBillRecord.where(station_id: @station.id, bill_id: bill.id)
            @data[0] << bill_data
          end
          internal_prescripts = MedicinePrescriptInternal.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[1] = []
          internal_prescripts.each do |script|
            script_data = script.attributes
            script_data["record"] = MedicineInternalRecord.where(station_id: @station.id, script_id: script.id)
            @data[1] << script_data
          end
          @data[2] = MedicineStockRecord.where(station_id: @station.id).in_range(begin_date, end_date)
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
          bill_ins = MedicineBillIn.where(station_id: @station.id).from_date(n)
          @data[0] = []
          bill_ins.each do |bill|
            bill_data = bill.attributes
            bill_data["record"] = MedicineBillRecord.where(station_id: @station.id, bill_id: bill.id)
            @data[0] << bill_data
          end
          internal_prescripts = MedicinePrescriptInternal.where(station_id: @station.id).from_date(n)
          @data[1] = []
          internal_prescripts.each do |script|
            script_data = script.attributes
            script_data["record"] = MedicineInternalRecord.where(station_id: @station.id, script_id: script.id)
            @data[1] << script_data
          end
          @data[2] = MedicineStockRecord.where(station_id: @station.id).from_date(n)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          bill_ins = MedicineBillIn.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[0] = []
          bill_ins.each do |bill|
            bill_data = bill.attributes
            bill_data["record"] = MedicineBillRecord.where(station_id: @station.id, bill_id: bill.id)
            @data[0] << bill_data
          end
          internal_prescripts = MedicinePrescriptInternal.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[1] = []
          internal_prescripts.each do |script|
            script_data = script.attributes
            script_data["record"] = MedicineInternalRecord.where(station_id: @station.id, script_id: script.id)
            @data[1] << script_data
          end
          @data[2] = MedicineStockRecord.where(station_id: @station.id).in_range(begin_date, end_date)
          render json: @data
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end

  def bill_status
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          @data[0] = MedicineBillIn.where(station_id: @station.id).from_date(n)
          @data[1] = MedicineBillRecord.where(station_id: @station.id).from_date(n)
          supplier_ids = @data[0].pluck(:supplier_id).uniq
          company_ids = @data[1].pluck(:company_id).uniq
          sample_ids = @data[1].pluck(:sample_id).uniq
          @data[2] = MedicineSample.where(station_id: @station.id, id: sample_ids)
          @data[3] = MedicineSupplier.where(station_id: @station.id, id: supplier_ids)
          @data[4] = MedicineCompany.where(station_id: @station.id, id: company_ids)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicineBillIn.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[1] = MedicineBillRecord.where(station_id: @station.id).in_range(begin_date, end_date)
          supplier_ids = @data[0].pluck(:supplier_id).uniq
          company_ids = @data[1].pluck(:company_id).uniq
          sample_ids = @data[1].pluck(:sample_id).uniq
          @data[2] = MedicineSample.where(station_id: @station.id, id: sample_ids)
          @data[3] = MedicineSupplier.where(station_id: @station.id, id: supplier_ids)
          @data[4] = MedicineCompany.where(station_id: @station.id, id: company_ids)
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
          @data[0] = MedicineBillIn.where(station_id: @station.id).from_date(n)
          @data[1] = MedicineBillRecord.where(station_id: @station.id).from_date(n)
          supplier_ids = @data[0].pluck(:supplier_id).uniq
          company_ids = @data[1].pluck(:company_id).uniq
          sample_ids = @data[1].pluck(:sample_id).uniq
          @data[2] = MedicineSample.where(station_id: @station.id, id: sample_ids)
          @data[3] = MedicineSupplier.where(station_id: @station.id, id: supplier_ids)
          @data[4] = MedicineCompany.where(station_id: @station.id, id: company_ids)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicineBillIn.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[1] = MedicineBillRecord.where(station_id: @station.id).in_range(begin_date, end_date)
          supplier_ids = @data[0].pluck(:supplier_id).uniq
          company_ids = @data[1].pluck(:company_id).uniq
          sample_ids = @data[1].pluck(:sample_id).uniq
          @data[2] = MedicineSample.where(station_id: @station.id, id: sample_ids)
          @data[3] = MedicineSupplier.where(station_id: @station.id, id: supplier_ids)
          @data[4] = MedicineCompany.where(station_id: @station.id, id: company_ids)
          render json: @data
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end

  def sale_record
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 2, 4
        @station = Station.find params[:id_station]
        @data = []
        if params.has_key?(:date)
          n = params[:date].to_i
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id).from_date(n)
          @data[1] = MedicineInternalRecord.where(station_id: @station.id).from_date(n)
          @data[2] = MedicinePrice.where(station_id: @station.id)
          sign_no_id = @data[1].pluck(:noid, :signid).uniq
          bill_records = MedicineBillRecord.where(station_id: @station.id)
          @data[3] = []
          bill_records.each do |record|
            record_sign_no_id = [record.noid, record.signid]
            @data[3] << record if record_sign_no_id.in?(sign_no_id)
          end
          bill_in_ids = @data[3].map { |record| record[:bill_id] }
          @data[4] = MedicineBillIn.where(station_id: @station.id, id: bill_in_ids.uniq)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[1] = MedicineInternalRecord.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[2] = MedicinePrice.where(station_id: @station.id)
          sign_no_id = @data[1].pluck(:noid, :signid).uniq
          bill_records = MedicineBillRecord.where(station_id: @station.id)
          @data[3] = []
          bill_records.each do |record|
            record_sign_no_id = [record.noid, record.signid]
            @data[3] << record if record_sign_no_id.in?(sign_no_id)
          end
          bill_in_ids = @data[3].map { |record| record[:bill_id] }
          @data[4] = MedicineBillIn.where(station_id: @station.id, id: bill_in_ids.uniq)
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
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id).from_date(n)
          @data[1] = MedicineInternalRecord.where(station_id: @station.id).from_date(n)
          @data[2] = MedicinePrice.where(station_id: @station.id)
          sign_no_id = @data[1].pluck(:noid, :signid).uniq
          bill_records = MedicineBillRecord.where(station_id: @station.id)
          @data[3] = []
          bill_records.each do |record|
            record_sign_no_id = [record.noid, record.signid]
            @data[3] << record if record_sign_no_id.in?(sign_no_id)
          end
          bill_in_ids = @data[3].map { |record| record[:bill_id] }
          @data[4] = MedicineBillIn.where(station_id: @station.id, id: bill_in_ids.uniq)
          render json: @data
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          begin_date = params[:begin_date].to_date
          end_date = params[:end_date].to_date
          @data[0] = MedicinePrescriptInternal.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[1] = MedicineInternalRecord.where(station_id: @station.id).in_range(begin_date, end_date)
          @data[2] = MedicinePrice.where(station_id: @station.id)
          sign_no_id = @data[1].pluck(:noid, :signid).uniq
          bill_records = MedicineBillRecord.where(station_id: @station.id)
          @data[3] = []
          bill_records.each do |record|
            record_sign_no_id = [record.noid, record.signid]
            @data[3] << record if record_sign_no_id.in?(sign_no_id)
          end
          bill_in_ids = @data[3].map { |record| record[:bill_id] }
          @data[4] = MedicineBillIn.where(station_id: @station.id, id: bill_in_ids.uniq)
          render json: @data
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    end
  end
end
