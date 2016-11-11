class CustomerRecord < ApplicationRecord
  belongs_to :station
  after_update :update_ext_prescript, :update_ext_record, :update_int_prescript,
    :update_int_record, :update_order_map, :update_doctor_check_info, :update_check_info
  has_attached_file :avatar, :default_url => "assets/noavatar.jpg"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  private
    def update_ext_prescript
      scripts = MedicinePrescriptExternal.where(customer_id: self.id)
      if scripts && self.cname != self.cname_was
        scripts.each do |script|
          script.update(cname: self.cname)
        end
      end
    end

    def update_int_prescript
      scripts = MedicinePrescriptInternal.where(customer_id: self.id)
      if scripts && self.cname != self.cname_was
        scripts.each do |script|
          script.update(cname: self.cname)
        end
      end
    end

    def update_ext_record
      records = MedicineExternalRecord.where(customer_id: self.id)
      if records && self.cname != self.cname_was
        records.each do |record|
          record.update(cname: self.cname)
        end
      end
    end

    def update_int_record
      records = MedicineInternalRecord.where(customer_id: self.id)
      if records && self.cname != self.cname_was
        records.each do |record|
          record.update(cname: self.cname)
        end
      end
    end

    def update_order_map
      maps = OrderMap.where(customer_record_id: self.id)
      if maps && self.cname != self.cname_was
        maps.each do |map|
          map.update(cname: self.cname)
        end
      end
    end

    def update_doctor_check_info
      infos = DoctorCheckInfo.where(c_id: self.id)
      if infos && self.cname != self.cname_was
        infos.each do |info|
          info.update(c_name: self.cname)
        end
      end
    end

    def update_check_info
      infos = CheckInfo.where(c_id: self.id)
      if infos && self.cname != self.cname_was
        infos.each do |info|
          info.update(c_name: self.cname)
        end
      end

    end
end
