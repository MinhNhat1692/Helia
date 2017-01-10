class CustomerRecordController < ApplicationController
  before_action :logged_in_user, only: [ :create, :update, :destroy, :list, :find_record, :add_record, :link_record, :clear_link_record, :update_record, :search, :find]
  
  def create
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 1
  			@station = Station.find params[:id_station]
	  		if params.has_key?(:email)
					@profile = User.find_by(email: params[:email])
					if @profile != nil
						@checkprofile = Profile.find_by(user_id: @profile.id)
						if @checkprofile != nil
							@customer = CustomerRecord.new(user_id: @profile.id, station_id: @station.id, cname: @profile.lname + " " + @profile.fname, address: @profile.address, pnumber: @profile.pnumber, avatar: @profile.avatar, gender: @profile.gender, noid: @profile.noid, issue_date: @profile.issue_date, issue_place: @profile.issue_place, dob: @profile.dob, work_place: @profile.work_place, self_history: @profile.self_history, family_history: @profile.family_history, drug_history: @profile.drug_history)
							if @customer.save
								render json: @customer
							else
								render json: @customer.errors, status: :unprocessable_entity
							end
						end
					end
				else
					if params.has_key?(:avatar)
						@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid], issue_date: params[:issue_date], issue_place: params[:issue_place], dob: params[:dob], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
						if @customer.save
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					else
						@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], gender: params[:gender], noid: params[:noid], dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
						if @customer.save
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					end
				end
      else
				head :no_content, :status => :bad_request
      end
    else
			if has_station?
				@station = Station.find_by(user_id: current_user.id)
				if params.has_key?(:email)
					@profile = User.find_by(email: params[:email])
					if @profile != nil
						@checkprofile = Profile.find_by(user_id: @profile.id)
						if @checkprofile != nil
							@customer = CustomerRecord.new(user_id: @profile.id, station_id: @station.id, cname: @profile.lname + " " + @profile.fname, address: @profile.address, pnumber: @profile.pnumber, avatar: @profile.avatar, gender: @profile.gender, noid: @profile.noid, issue_date: @profile.issue_date, issue_place: @profile.issue_place, dob: @profile.dob, work_place: @profile.work_place, self_history: @profile.self_history, family_history: @profile.family_history, drug_history: @profile.drug_history)
							if @customer.save
								render json: @customer
							else
								render json: @customer.errors, status: :unprocessable_entity
							end
						end
					end
				else
					if params.has_key?(:avatar)
						@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], avatar: params[:avatar], gender: params[:gender], noid: params[:noid], issue_date: params[:issue_date], issue_place: params[:issue_place], dob: params[:dob], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
						if @customer.save
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					else
						@customer = CustomerRecord.new(station_id: @station.id, cname: params[:cname], address: params[:address], pnumber: params[:pnumber], gender: params[:gender], noid: params[:noid], dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
						if @customer.save
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					end
				end
			else
			  redirect_to root_path
			end
		end
  end

  def update
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 2
  			@station = Station.find params[:id_station]
	  		@customer = CustomerRecord.find(params[:id])
				if @customer.station_id == @station.id
					if params.has_key?(:avatar)
						if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender],avatar: params[:avatar],dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					else
						if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender], dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					end
				end
      else
				head :no_content, :status => :bad_request
      end
    else
			if has_station?
			  @station = Station.find_by(user_id: current_user.id)
				@customer = CustomerRecord.find(params[:id])
				if @customer.station_id == @station.id
					if params.has_key?(:avatar)
						if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender],avatar: params[:avatar],dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					else
						if @customer.update(cname: params[:cname],address: params[:address], pnumber: params[:pnumber], noid: params[:noid], gender: params[:gender], dob: params[:dob], issue_date: params[:issue_date], issue_place: params[:issue_place], work_place: params[:work_place], self_history: params[:self_history], family_history: params[:family_history], drug_history: params[:drug_history])
							render json: @customer
						else
							render json: @customer.errors, status: :unprocessable_entity
						end
					end
				end
			else
			  redirect_to root_path
			end
		end
  end

  def destroy
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 2
  			@station = Station.find params[:id_station]
	  		@customer = CustomerRecord.find(params[:id])
				if @customer.station_id == @station.id
					@customer.destroy
					head :no_content
				end
      else
				head :no_content, :status => :bad_request
      end
    else
			if has_station?
				@station = Station.find_by(user_id: current_user.id)
				@customer = CustomerRecord.find(params[:id])
				if @customer.station_id == @station.id
					@customer.destroy
					head :no_content
				end
			else
				redirect_to root_path
			end
		end
	end
  
  def list
		if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 4
  			@station = Station.find params[:id_station]
	  		@data = []
			  if params.has_key?(:date)
			    n = params[:date].to_i
			    start = n.days.ago.beginning_of_day
			    fin = Time.now
			    @data[0] = CustomerRecord.where(station_id: @station.id, created_at: start..fin).order(updated_at: :desc).limit(1000)
			  elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
			    start = params[:begin_date].to_date.beginning_of_day
			    fin = params[:end_date].to_date.end_of_day
			    @data[0] = CustomerRecord.where(station_id: @station.id, created_at: start..fin).order(updated_at: :desc).limit(1000)
			  else
			    @data[0] = CustomerRecord.where(station_id: @station.id).order(updated_at: :desc).limit(1000)
			  end
				render json: @data
      else
				head :no_content, :status => :bad_request
      end
    else
			if has_station?
				@station = Station.find_by(user_id: current_user.id)
				@data = []
			  if params.has_key?(:date)
			    n = params[:date].to_i
			    start = n.days.ago.beginning_of_day
			    fin = Time.now
			    @data[0] = CustomerRecord.where(station_id: @station.id, created_at: start..fin).order(updated_at: :desc).limit(1000)
			    @data[1] = Gender.where(lang: 'vi')
			  elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
			    start = params[:begin_date].to_date.beginning_of_day
			    fin = params[:end_date].to_date.end_of_day
			    @data[0] = CustomerRecord.where(station_id: @station.id, created_at: start..fin).order(updated_at: :desc).limit(1000)
			    @data[1] = Gender.where(lang: 'vi')
			  else
			    @data[0] = CustomerRecord.where(station_id: @station.id).order(updated_at: :desc).limit(1000)
			    @data[1] = Gender.where(lang: 'vi')
			  end
				render json: @data
			else
			  redirect_to root_path
			end
		end
	end
  
  
  def find_record
		if has_station?
      @station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:email)
				@customer = User.find_by(email: params[:email])
				if @customer != nil
					@profile = Profile.find_by(user_id: @customer.id)
				else
					@profile = nil
				end
				if @profile == nil
				  @record = nil
				else
					@record = CustomerRecord.find_by(customer_id: @customer.id, station_id: @station.id)
			  end
			  @data = []
			  @data[0] = @profile
			  @data[1] = @record
			  if @customer == nil
					@data[2] = nil
				else
					@data[2] = @customer.id
			  end
			  render json: @data
			end
    else
      redirect_to root_path
		end
	end
	
	def add_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id)
				@customeruser = User.find(params[:id])
				if @customeruser != nil
					@profile = Profile.find_by(user_id: @customeruser.id)
					if @profile != nil
					  @record = CustomerRecord.find_by(customer_id: params[:id], station_id: @station.id)
				    if @record == nil
					    @record = CustomerRecord.new(customer_id: @customeruser.id, station_id: @station.id, cname: @profile.lname + " " + @profile.fname, dob: @profile.dob, gender: @profile.gender, address: @profile.address, pnumber: @profile.pnumber, noid: @profile.noid, issue_date: @profile.issue_date, issue_place: @profile.issue_place, avatar: @profile.avatar, work_place: @profile.work_place, self_history: @profile.self_history, family_history: @profile.family_history, drug_history: @profile.drug_history)
							if @record.save
								render json: @record
							else
								render json: @record.errors, status: :unprocessable_entity
							end
						end
				  end
				end
			end
	  else
			redirect_to root_path
		end
	end
	
	def link_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id) && params.has_key?(:idrecord)
				@customeruser = User.find(params[:id])
				if @customeruser != nil
					@record = CustomerRecord.find_by(id: params[:idrecord], customer_id: nil, station_id: @station.id)
				  if @record != nil
					  if @record.update(customer_id: @customeruser.id)
							render json: @record
						else
							render json: @record.errors, status: :unprocessable_entity
						end
				  end
				end
			end
	  else
			redirect_to root_path
		end
	end
	
	def clear_link_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:idrecord)
				@record = CustomerRecord.find_by(id: params[:idrecord], station_id: @station.id)
				if @record != nil
				  if @record.update(customer_id: nil)
						render json: @record
					else
						render json: @record.errors, status: :unprocessable_entity
					end
				end
			end
	  else
			redirect_to root_path
		end
	end
	
	def update_record
		if has_station?
			@station = Station.find_by(user_id: current_user.id)
			if params.has_key?(:id) && params.has_key?(:idrecord)
				@customeruser = User.find(params[:id])
				if @customeruser != nil
					@profile = Profile.find_by(user_id: @customeruser.id)
					if @profile != nil
						@record = CustomerRecord.find_by(id: params[:idrecord], customer_id: @customeruser.id, station_id: @station.id)
						if @record != nil
					    if @record.update(customer_id: @customeruser.id, station_id: @station.id, cname: @profile.lname + " " + @profile.fname, dob: @profile.dob, gender: @profile.gender, country: @profile.country, city: @profile.city, province: @profile.province, address: @profile.address, pnumber: @profile.pnumber, noid: @profile.noid, issue_date: @profile.issue_date, issue_place: @profile.issue_place, avatar: @profile.avatar, work_place: @profile.work_place, self_history: @profile.self_history, family_history: @profile.family_history, drug_history: @profile.drug_history)
							  render json: @record
						  else
							  render json: @record.errors, status: :unprocessable_entity
						  end
					  end
				  end
				end
			end
	  else
			redirect_to root_path
		end
	end
  
  def search
    if params.has_key?(:id_station)
			if current_user.check_permission params[:id_station], 1, 4
  			@station = Station.find params[:id_station]
				if params.has_key?(:cname)
					@customer_record = CustomerRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).order(updated_at: :desc).limit(5)
			    render json:@customer_record
        elsif params.has_key?(:namestring)
				  @customer_record = CustomerRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:namestring]}%", @station.id).group(:cname).order(updated_at: :desc).limit(5)
			    render json:@customer_record
        elsif params.has_key?(:address)
				  @customer_record = CustomerRecord.where("address LIKE ? and station_id = ?" , "%#{params[:address]}%", @station.id).group(:address).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:pnumber)
				  @customer_record = CustomerRecord.where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id).group(:pnumber).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:noid)
				  @customer_record = CustomerRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:work_place)
				  @customer_record = CustomerRecord.where("work_place LIKE ? and station_id = ?" , "%#{params[:work_place]}%", @station.id).group(:work_place).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:self_history)
				  @customer_record = CustomerRecord.where("self_history LIKE ? and station_id = ?" , "%#{params[:self_history]}%", @station.id).group(:self_history).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:family_history)
				  @customer_record = CustomerRecord.where("family_history LIKE ? and station_id = ?" , "%#{params[:family_history]}%", @station.id).group(:family_history).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:drug_history)
				  @customer_record = CustomerRecord.where("drug_history LIKE ? and station_id = ?" , "%#{params[:drug_history]}%", @station.id).group(:drug_history).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  end
			else
        redirect_to root_path
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:cname)
					@customer_record = CustomerRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).group(:cname).order(updated_at: :desc).limit(5)
			    render json:@customer_record
        elsif params.has_key?(:namestring)
				  @customer_record = CustomerRecord.where("cname LIKE ? and station_id = ?" , "%#{params[:namestring]}%", @station.id).group(:cname).order(updated_at: :desc).limit(5)
			    render json:@customer_record
        elsif params.has_key?(:address)
				  @customer_record = CustomerRecord.where("address LIKE ? and station_id = ?" , "%#{params[:address]}%", @station.id).group(:address).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:pnumber)
				  @customer_record = CustomerRecord.where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id).group(:pnumber).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:noid)
				  @customer_record = CustomerRecord.where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).group(:noid).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:work_place)
				  @customer_record = CustomerRecord.where("work_place LIKE ? and station_id = ?" , "%#{params[:work_place]}%", @station.id).group(:work_place).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:self_history)
				  @customer_record = CustomerRecord.where("self_history LIKE ? and station_id = ?" , "%#{params[:self_history]}%", @station.id).group(:self_history).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:family_history)
				  @customer_record = CustomerRecord.where("family_history LIKE ? and station_id = ?" , "%#{params[:family_history]}%", @station.id).group(:family_history).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  elsif params.has_key?(:drug_history)
				  @customer_record = CustomerRecord.where("drug_history LIKE ? and station_id = ?" , "%#{params[:drug_history]}%", @station.id).group(:drug_history).order(updated_at: :desc).limit(5)
			    render json:@customer_record
			  end
      else
        redirect_to root_path
      end
    end
  end

  def find
    if params.has_key?(:id_station)
      if current_user.check_permission params[:id_station], 1, 4
  			@station = Station.find params[:id_station]
  			if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = CustomerRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:cname)
					@customer_record = CustomerRecord.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:id)
				  @customer_record = CustomerRecord.where("id = ? and station_id = ?" , params[:id], @station.id)
			    render json:@customer_record
        elsif params.has_key?(:namestring)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:namestring]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
        elsif params.has_key?(:address)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("address LIKE ? and station_id = ?" , "%#{params[:address]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:pnumber)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:noid)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:work_place)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("work_place LIKE ? and station_id = ?" , "%#{params[:work_place]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:self_history)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("self_history LIKE ? and station_id = ?" , "%#{params[:self_history]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:family_history)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("family_history LIKE ? and station_id = ?" , "%#{params[:family_history]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:drug_history)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("drug_history LIKE ? and station_id = ?" , "%#{params[:drug_history]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:dob)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("dob = ? and station_id = ?" , params[:dob], @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:gender)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("gender = ? and station_id = ?" , params[:gender], @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  end
      end
    else
      if has_station?
        @station = Station.find_by(user_id: current_user.id)
        if params.has_key?(:date)
          n = params[:date].to_i
          start = n.days.ago.beginning_of_day
          fin = Time.now
        elsif params.has_key?(:begin_date) && params.has_key?(:end_date)
          start = params[:begin_date].to_date.beginning_of_day
          fin = params[:end_date].to_date.end_of_day
        else
          start = CustomerRecord.order(created_at: :asc).first.created_at
          fin = Time.now
        end
        if params.has_key?(:cname)
					@customer_record = CustomerRecord.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:cname]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
        elsif params.has_key?(:namestring)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("cname LIKE ? and station_id = ?" , "%#{params[:namestring]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:id)
				  @customer_record = CustomerRecord.where("id = ? and station_id = ?" , params[:id], @station.id)
			    render json:@customer_record
        elsif params.has_key?(:address)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("address LIKE ? and station_id = ?" , "%#{params[:address]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:pnumber)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("pnumber LIKE ? and station_id = ?" , "%#{params[:pnumber]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:noid)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("noid LIKE ? and station_id = ?" , "%#{params[:noid]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:work_place)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("work_place LIKE ? and station_id = ?" , "%#{params[:work_place]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:self_history)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("self_history LIKE ? and station_id = ?" , "%#{params[:self_history]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:family_history)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("family_history LIKE ? and station_id = ?" , "%#{params[:family_history]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:drug_history)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("drug_history LIKE ? and station_id = ?" , "%#{params[:drug_history]}%", @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:dob)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("dob = ? and station_id = ?" , params[:dob], @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  elsif params.has_key?(:gender)
				  @customer_record = CustomerRecord.where(created_at: start..fin).where("gender = ? and station_id = ?" , params[:gender], @station.id).order(updated_at: :desc)
			    render json:@customer_record
			  end
      else
        redirect_to root_path
      end
    end
  end
end
