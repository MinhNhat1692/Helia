class Employee < ApplicationRecord
  has_many :position_mapping, dependent: :destroy
  attr_accessor :activation_token
  belongs_to :station
  before_create :create_activation_digest
  after_update :update_postion_mapping, :update_prescript_int, :update_prescript_ext,
    :update_check_info, :update_doctor_check_info
  has_attached_file :avatar, :default_url => "assets/noavatar.jpg"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  
  def Employee.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	
	# Returns a random token.
	def Employee.new_token
		SecureRandom.urlsafe_base64
	end
  
  # Activates an employee Record.
	def activate(employee)
    @user = User.find_by(id: employee.user_id)
    @profile = DoctorProfile.find_by(user_id: @user.id)
		update_attributes(activated: true, activated_at: Time.zone.now, ename: @profile.lname + " " + @profile.fname, country: @profile.country, city: @profile.city, province: @profile.province, address: @profile.address, pnumber: @profile.pnumber, avatar: @profile.avatar, gender: @profile.gender)
	end

	# Sends activation email.
	def send_activation_email(user,station,employee)
		EmployeeMailer.record_activation(user,station,employee).deliver_now
	end
	
  private
		# Creates and assigns the activation token and digest.
		def create_activation_digest
			self.activation_token  = Employee.new_token
			self.activation_digest = self.activation_token
		end

    def update_postion_mapping
      pos_maps = self.position_mapping
      if pos_maps && self.ename != self.ename_was
        pos_maps.each do |pm|
          pm.update(ename: self.ename)
        end
      end
    end

    def update_prescript_ext
      scripts = MedicinePrescriptExternal.where(employee_id: self.id)
      if scripts && self.ename != self.ename_was
        scripts.each do |script|
          script.update(ename: self.ename)
        end
      end
    end

    def update_prescript_int
      scripts = MedicinePrescriptInternal.where(employee_id: self.id)
      if scripts && self.ename != self.ename_was
        scripts.each do |script|
          script.update(ename: self.ename)
        end
      end
      prepare_scrips = MedicinePrescriptInternal.where(preparer_id: self.id)
      if prepare_scrips && self.ename != self.ename_was
        prepare_scrips.each do |script|
          script.update(preparer: self.ename)
        end
      end
    end

    def update_check_info
      infos = CheckInfo.where(e_id: self.id)
      if infos && self.ename != self.ename_was
        infos.each do |info|
          info.update(ename: self.ename)
        end
      end
    end

    def update_doctor_check_info
      infos = DoctorCheckInfo.where(e_id: self.id)
      if infos && self.ename != self.ename_was
        infos.each do |info|
          info.update(ename: self.ename)
        end
      end
    end
end
