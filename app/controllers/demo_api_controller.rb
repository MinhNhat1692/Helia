class DemoApiController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  def add_customer
    api_key = Apikey.find_by(adminapi: params[:key])
    if api_key
      user = api_key.user
      station = Station.find_by(user_id: user.id)
      customer = CustomerRecord.new(station_id: station.id, gender: params[:gender], cname: params[:cname], dob: params[:dob], 
                                    address: params[:address], pnumber: params[:pnumber], noid: params[:noid], avatar: params[:avatar],
                                    issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place],
                                    self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
      if customer.valid?
        if customer.save
          service_name = Service.find_by(id: params[:service_id]).try(:sname)
          service_price = Service.find_by(id: params[:service_id]).try(:price)
          data = OrderMap.new(customer_record_id: customer.id, service_id: params[:service_id], status: 1,
                              cname: customer.cname, sername: service_name, tpayment: service_price,
                              station_id: station.id, code: params[:token])
          if data.valid?
            if data.save
              render json: { message: "Success", result: data }
            else
              render json: { message: "Internal server error" }
            end
          else
            render json: { message: data.errors.full_messages }
          end
        else
          render json: { message: "Internal Server error" }
        end
      else
        render json: { message: customer.errors.full_messages } 
      end
    else
      render json: { message: "Api key ko hop le" }
    end
  end

  def list_service
    api_key = Apikey.find_by(soapi: params[:key])
    if api_key
      user = api_key.user
      station = Station.find_by(user_id: user.id)
      data = Service.where(station_id: station.id)
      render json: { message: "Success", result: data }
    else
      render json: { message: "Api ko hop le" }
    end
  end

  def get_result
    api_key = Apikey.find_by(soapi: params[:key])
    if api_key
      user = api_key.user
      station = Station.find_by(user_id: user.id)
      if params[:om_id] && params[:code]
        ordermap = OrderMap.find_by(station_id: station.id, id: params[:om_id], code: params[:code])
        if ordermap
          customer = CustomerRecord.find_by(id: ordermap.customer_record_id, station_id: station.id)
          check_info = CheckInfo.find_by(order_map_id: ordermap.id, station_id: station.id)
          doc_check_info = DoctorCheckInfo.find_by(order_map_id: ordermap.id, station_id: station.id)
          ex_script = MedicinePrescriptExternal.find_by(number_id: ordermap.id, station_id: station.id)
          in_script = MedicinePrescriptInternal.find_by(number_id: ordermap.id, station_id: station.id)
          if ex_script
            ex_script = ex_script.attributes
            ex_script["record"] = MedicineExternalRecord.where(script_id: ex_script["id"], station_id: station.id)
          end
          if in_script
            in_script = in_script.attributes
            in_record["record"] = MedicineInternalRecord.where(script_id: in_script["id"], station_id: station.id)
          end
          render json: { message: "Success", result: [customer, check_info, doc_check_info, ex_script, in_script] }
        else
          render json: { message: "Khong thay thong tin phieu kham" }
        end
      else
        render json: { message: "Input ko hop le" }
      end
    else
      render json: { message: "Api ko hop le" }
    end
  end
end
