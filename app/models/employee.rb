class Employee < ApplicationRecord
  has_many :position_mapping, dependent: :destroy
  attr_accessor :activation_token
  belongs_to :station
  before_create :create_activation_digest
  has_attached_file :avatar
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
end
