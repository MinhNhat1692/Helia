class Apikey < ApplicationRecord
  belongs_to :user
  validates :appid, presence: true, length: { minimum: 20 }, uniqueness: true
  validates :soapi, presence: true, length: { minimum: 20 }, uniqueness: true
  validates :mapi, presence: true, length: { minimum: 20 }, uniqueness: true
  validates :adminapi, presence: true, length: { minimum: 20 }, uniqueness: true
  
  def generateKey
    self.soapi = SecureRandom.random_number(36**20).to_s(36).rjust(20, "0")
		self.mapi = SecureRandom.random_number(36**20).to_s(36).rjust(20, "0")
		self.adminapi = SecureRandom.random_number(36**20).to_s(36).rjust(20, "0")
	end
  
end
