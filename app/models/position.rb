class Position < ApplicationRecord
  belongs_to :station
  belongs_to :room
  after_update :update_postion_mapping
  has_many :position_mappings, dependent: :destroy
  has_attached_file :file, :default_url => "assets/noavatar.jpg"
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  private
    def update_postion_mapping
      pos_maps = self.position_mappings
      if pos_maps
        pos_maps.each do |pm|
          pm.update(pname: self.pname)
        end
      end
    end
end
