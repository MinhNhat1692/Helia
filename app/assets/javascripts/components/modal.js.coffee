  @ModalOutside = React.createClass
    getInitialState: ->
      autoComplete: null
      code: null
      selected: 1
      selectRecord: null
      selectRecordId: null
    selectCode: (code)->
      @setState selected: code
    selectRecord: (result) ->
      @setState
        selectRecord: result
        selectRecordId: result.id
    handleDelete: (e) ->
      @props.triggerDelete @state.selectRecord
    refreshChildRecord: (code) ->
      if code == 'medicine_bill_record' and @props.record != null
        formData = new FormData
        formData.append 'bill_id', @props.record.id
      if code == 'medicine_external_record' and @props.record != null
        formData = new FormData
        formData.append 'script_id', @props.record.id
      if code == 'medicine_internal_record' and @props.record != null
        formData = new FormData
        formData.append 'script_id', @props.record.id
      if formData != undefined
        $.ajax
          url: '/' + code + '/find'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.triggerChildRefresh result
            return
          ).bind(this)
    setup_webcam: ->
      $('#webcamout').remove()
      Webcam.set
        width: 320
        height: 240
        dest_width: 320
        dest_height: 240
        crop_width: 320
        crop_height: 240
        image_format: 'jpeg'
        jpeg_quality: 100
      Webcam.attach '#my_camera'
    take_snapshot: ->
      Webcam.snap (data_uri) ->
        document.getElementById('results').innerHTML = '<img id="webcamout" class="" src="' + data_uri + '"/>'
        Webcam.reset()
        $('#my_camera').css('height':'0px')
        return
      return
    componentWillMount: ->
      $(APP).on 'fillmodal', ((e,code) ->
        @triggerUpdateFormValue(code)
      ).bind(this)
      $(APP).on 'clearmodal', ((e,code) ->
        @triggerClearFormValue(code)
      ).bind(this)
    triggersafe: ->
    trigger: ->
      @props.trigger 1
      $('#' + @props.id).modal('hide')
    triggerUpdateFormValue: (code) ->
      if code == "customer_record" and @props.record != null and @props.record != undefined
        $('#' + @props.id + ' #form_name').val(@props.record.cname)
        if @props.record.dob != null
          $('#' + @props.id + ' #form_dob').val(@props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4))
        $('#' + @props.id + ' #form_address').val(@props.record.address)
        $('#' + @props.id + ' #form_pnumber').val(@props.record.pnumber)
        $('#' + @props.id + ' #form_noid').val(@props.record.noid)
        $('#' + @props.id + ' #form_work_place').val(@props.record.work_place)
        $('#' + @props.id + ' #form_self_history').val(@props.record.self_history)
        $('#' + @props.id + ' #form_family_history').val(@props.record.family_history)
        $('#' + @props.id + ' #form_drug_history').val(@props.record.drug_history)
        $('#' + @props.id + ' #form_avatar').val("")
        document.getElementById('results').innerHTML = '<img id="sample_avatar" class="" style="max-width: 100%;max-height: 240px" src="' + @props.record.avatar + '"/>'
      else if code == 'employee' and @props.record != null and @props.record != undefined
        $('#' + @props.id + ' #form_ename').val(@props.record.ename)
        $('#' + @props.id + ' #form_address').val(@props.record.address)
        $('#' + @props.id + ' #form_pnumber').val(@props.record.pnumber)
        $('#' + @props.id + ' #form_noid').val(@props.record.noid)
        $('#' + @props.id + ' #form_avatar').val("")
        document.getElementById('results').innerHTML = '<img id="sample_avatar" class="" style="max-width: 100%;max-height: 240px" src="' + @props.record.avatar + '"/>'
      else if code == 'room' and @props.record != null and @props.record != undefined
        $('#' + @props.id + ' #form_name').val(@props.record.name)
        $('#' + @props.id + ' #form_lang').val(@props.record.lang)
        $('#' + @props.id + ' #form_map').val("")
      else if code == 'position'
        if @props.room != null and @props.room != undefined
          $('#' + @props.id + ' #form_r_id').val(@props.room.id)
          $('#' + @props.id + ' #form_rname').val(@props.room.name)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_rname').val(@props.record.rname)
          $('#' + @props.id + ' #form_r_id').val(@props.record.room_id)
          $('#' + @props.id + ' #form_pname').val(@props.record.pname)
          $('#' + @props.id + ' #form_lang').val(@props.record.lang)
          $('#' + @props.id + ' #form_description').val(@props.record.description)
          $('#' + @props.id + ' #form_file').val("")
      else if code == 'service' and @props.record != null and @props.record != undefined
        $('#' + @props.id + ' #form_sname').val(@props.record.sname)
        $('#' + @props.id + ' #form_lang').val(@props.record.lang)
        $('#' + @props.id + ' #form_price').val(@props.record.price)
        $('#' + @props.id + ' #form_currency').val(@props.record.currency)
        $('#' + @props.id + ' #form_description').val(@props.record.description)
        $('#' + @props.id + ' #form_file').val("")
      else if code == 'posmap'
        if @props.employee != null and @props.employee != undefined
          $('#' + @props.id + ' #form_e_id').val(@props.employee.id)
          $('#' + @props.id + ' #form_ename').val(@props.employee.ename)
        if @props.position != null and @props.position != undefined
          $('#' + @props.id + ' #form_p_id').val(@props.position.id)
          $('#' + @props.id + ' #form_pname').val(@props.position.pname)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_e_id').val(@props.record.position_id)
          $('#' + @props.id + ' #form_ename').val(@props.record.ename)
          $('#' + @props.id + ' #form_p_id').val(@props.record.employee_id)
          $('#' + @props.id + ' #form_pname').val(@props.record.pname)
      else if code == 'sermap'
        if @props.room != null and @props.room != undefined
          $('#' + @props.id + ' #form_r_id').val(@props.room.id)
          $('#' + @props.id + ' #form_rname').val(@props.room.name)
        if @props.service != null and @props.service != undefined
          $('#' + @props.id + ' #form_s_id').val(@props.service.id)
          $('#' + @props.id + ' #form_sname').val(@props.service.sname)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_sname').val(@props.record.sname)
          $('#' + @props.id + ' #form_s_id').val(@props.record.service_id)
          $('#' + @props.id + ' #form_rname').val(@props.record.rname)
          $('#' + @props.id + ' #form_r_id').val(@props.record.room_id)
      else if code == 'order_map'
        if @props.customer != null and @props.customer != undefined
          $('#' + @props.id + ' #form_c_id').val(@props.customer.id)
          $('#' + @props.id + ' #form_cname').val(@props.customer.cname)
        if @props.service != null and @props.service != undefined
          $('#' + @props.id + ' #form_s_id').val(@props.service.id)
          $('#' + @props.id + ' #form_sname').val(@props.service.sname)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_c_id').val(@props.record.customer_record_id)
          $('#' + @props.id + ' #form_cname').val(@props.record.cname)
          $('#' + @props.id + ' #form_s_id').val(@props.record.service_id)
          $('#' + @props.id + ' #form_sname').val(@props.record.sername)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_tpayment').val(@props.record.tpayment)
          $('#' + @props.id + ' #form_discount').val(@props.record.discount)
          $('#' + @props.id + ' #form_discount_percent').val(@props.record.discount/@props.record.tpayment * 100)
          $('#' + @props.id + ' #form_tpayout').val(@props.record.tpayout)
      else if code == 'medicine_supplier' and @props.record != null and @props.record != undefined
        $('#' + @props.id + ' #form_noid').val(@props.record.noid)
        $('#' + @props.id + ' #form_name').val(@props.record.name)
        $('#' + @props.id + ' #form_contact_name').val(@props.record.contactname)
        $('#' + @props.id + ' #form_spnumber').val(@props.record.spnumber)
        $('#' + @props.id + ' #form_pnumber').val(@props.record.pnumber)
        $('#' + @props.id + ' #form_address1').val(@props.record.address1)
        $('#' + @props.id + ' #form_address2').val(@props.record.address2)
        $('#' + @props.id + ' #form_address3').val(@props.record.address3)
        $('#' + @props.id + ' #form_email').val(@props.record.email)
        $('#' + @props.id + ' #form_facebook').val(@props.record.facebook)
        $('#' + @props.id + ' #form_twitter').val(@props.record.twitter)
        $('#' + @props.id + ' #form_fax').val(@props.record.fax)
        $('#' + @props.id + ' #form_taxcode').val(@props.record.taxcode)
      else if code == 'medicine_company' and @props.record != null and @props.record != undefined
        $('#' + @props.id + ' #form_noid').val(@props.record.noid)
        $('#' + @props.id + ' #form_name').val(@props.record.name)
        $('#' + @props.id + ' #form_pnumber').val(@props.record.pnumber)
        $('#' + @props.id + ' #form_address').val(@props.record.address)
        $('#' + @props.id + ' #form_email').val(@props.record.email)
        $('#' + @props.id + ' #form_website').val(@props.record.website)
        $('#' + @props.id + ' #form_taxcode').val(@props.record.taxcode)
      else if code == 'medicine_sample'
        if @props.company != null and @props.company != undefined
          $('#' + @props.id + ' #form_company_id').val(@props.company.id)
          $('#' + @props.id + ' #form_company').val(@props.company.name)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_noid').val(@props.record.noid)
          $('#' + @props.id + ' #form_name').val(@props.record.name)
          $('#' + @props.id + ' #form_price').val(@props.record.price)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_weight').val(@props.record.weight)
          $('#' + @props.id + ' #form_expire').val(@props.record.expire)
          $('#' + @props.id + ' #form_company').val(@props.record.company)
          $('#' + @props.id + ' #form_company_id').val(@props.record.company_id)
      else if code == 'medicine_bill_in'
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_billcode').val(@props.record.billcode)
          $('#' + @props.id + ' #form_supplier_id').val(@props.record.supplier_id)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_supplier').val(@props.record.supplier)
          if @props.record.dayin != null
            $('#' + @props.id + ' #form_dayin').val(@props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4))
          if @props.record.daybook != null
            $('#' + @props.id + ' #form_daybook').val(@props.record.daybook.substring(8, 10) + "/" + @props.record.daybook.substring(5, 7) + "/" + @props.record.daybook.substring(0, 4))
          $('#' + @props.id + ' #form_tpayment').val(@props.record.tpayment)
          $('#' + @props.id + ' #form_discount').val(@props.record.discount)
          $('#' + @props.id + ' #form_discount_percent').val(@props.record.discount/@props.record.tpayment * 100)
          $('#' + @props.id + ' #form_tpayout').val(@props.record.tpayout)
      else if code == 'medicine_bill_record'
        if @props.bill_in != null and @props.bill_in != undefined
          $('#' + @props.id + ' #form_billcode').val(@props.bill_in.billcode)
          $('#' + @props.id + ' #form_billcode_id').val(@props.bill_in.id)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_billcode_id').val(@props.record.bill_id)
          $('#' + @props.id + ' #form_billcode').val(@props.record.billcode)
          $('#' + @props.id + ' #form_sample_id').val(@props.record.sample_id)
          $('#' + @props.id + ' #form_sample').val(@props.record.name)
          $('#' + @props.id + ' #form_company_id').val(@props.record.company_id)
          $('#' + @props.id + ' #form_company').val(@props.record.company)
          $('#' + @props.id + ' #form_noid').val(@props.record.noid)
          $('#' + @props.id + ' #form_signid').val(@props.record.signid)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_expire').val(@props.record.expire)
          $('#' + @props.id + ' #form_qty').val(@props.record.qty)
          $('#' + @props.id + ' #form_taxrate').val(@props.record.taxrate)
          $('#' + @props.id + ' #form_price').val(@props.record.price)
      else if code == 'medicine_price'
        if @props.sample != null and @props.sample != undefined
          $('#' + @props.id + ' #form_sample').val(@props.sample.name)
          $('#' + @props.id + ' #form_sample_id').val(@props.sample.id)
          $('#' + @props.id + ' #form_price').val(@props.sample.price)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_sample_id').val(@props.record.sample_id)
          $('#' + @props.id + ' #form_sample').val(@props.record.name)
          $('#' + @props.id + ' #form_minam').val(@props.record.minam)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_price').val(@props.record.price)
      else if code == 'medicine_prescript_external'
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_code').val(@props.record.code)
          $('#' + @props.id + ' #form_c_id').val(@props.record.customer_id)
          $('#' + @props.id + ' #form_cname').val(@props.record.cname)
          $('#' + @props.id + ' #form_e_id').val(@props.record.employee_id)
          $('#' + @props.id + ' #form_ename').val(@props.record.ename)
          if @props.record.date != null
            $('#' + @props.id + ' #form_date').val(@props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4))
          $('#' + @props.id + ' #form_result_id').val(@props.record.result_id)
          $('#' + @props.id + ' #form_number_id').val(@props.record.number_id)
          $('#' + @props.id + ' #form_address').val(@props.record.address)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
      else if code == 'medicine_external_record'
        if @props.prescript != null and @props.prescript != undefined
          $('#' + @props.id + ' #form_script_code').val(@props.prescript.code)
          $('#' + @props.id + ' #form_script_id').val(@props.prescript.id)
          $('#' + @props.id + ' #form_c_id').val(@props.prescript.customer_id)
          $('#' + @props.id + ' #form_cname').val(@props.prescript.cname)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_sample').val(@props.record.name)
          $('#' + @props.id + ' #form_sample_id').val(@props.record.sample_id)
          $('#' + @props.id + ' #form_c_id').val(@props.record.customer_id)
          $('#' + @props.id + ' #form_cname').val(@props.record.cname)
          $('#' + @props.id + ' #form_script_id').val(@props.record.script_id)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_company').val(@props.record.company)
          $('#' + @props.id + ' #form_company_id').val(@props.record.company_id)
          $('#' + @props.id + ' #form_amount').val(@props.record.amount)
          $('#' + @props.id + ' #form_script_code').val(@props.record.script_code)
          $('#' + @props.id + ' #form_price').val(@props.record.price)
          $('#' + @props.id + ' #form_total').val(@props.record.total)
      else if code == 'medicine_prescript_internal'
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_code').val(@props.record.code)
          $('#' + @props.id + ' #form_c_id').val(@props.record.customer_id)
          $('#' + @props.id + ' #form_cname').val(@props.record.cname)
          $('#' + @props.id + ' #form_e_id').val(@props.record.employee_id)
          $('#' + @props.id + ' #form_ename').val(@props.record.ename)
          if @props.record.date != null
            $('#' + @props.id + ' #form_date').val(@props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4))
          $('#' + @props.id + ' #form_result_id').val(@props.record.result_id)
          $('#' + @props.id + ' #form_number_id').val(@props.record.number_id)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_e_p_id').val(@props.record.preparer_id)
          $('#' + @props.id + ' #form_epname').val(@props.record.preparer)
          $('#' + @props.id + ' #form_payer').val(@props.record.payer)
          $('#' + @props.id + ' #form_tpayment').val(@props.record.tpayment)
          $('#' + @props.id + ' #form_discount').val(@props.record.discount)
          $('#' + @props.id + ' #form_tpayout').val(@props.record.tpayout)
      else if code == 'medicine_internal_record'
        if @props.prescript != null and @props.prescript != undefined
          $('#' + @props.id + ' #form_script_code').val(@props.prescript.code)
          $('#' + @props.id + ' #form_script_id').val(@props.prescript.id)
          $('#' + @props.id + ' #form_c_id').val(@props.prescript.customer_id)
          $('#' + @props.id + ' #form_cname').val(@props.prescript.cname)
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_sample').val(@props.record.name)
          $('#' + @props.id + ' #form_sample_id').val(@props.record.sample_id)
          $('#' + @props.id + ' #form_c_id').val(@props.record.customer_id)
          $('#' + @props.id + ' #form_cname').val(@props.record.cname)
          $('#' + @props.id + ' #form_script_id').val(@props.record.script_id)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_company').val(@props.record.company)
          $('#' + @props.id + ' #form_company_id').val(@props.record.company_id)
          $('#' + @props.id + ' #form_amount').val(@props.record.amount)
          $('#' + @props.id + ' #form_script_code').val(@props.record.script_code)
          $('#' + @props.id + ' #form_price').val(@props.record.price)
          $('#' + @props.id + ' #form_tpayment').val(@props.record.tpayment)
          $('#' + @props.id + ' #form_noid').val(@props.record.noid)
          $('#' + @props.id + ' #form_signid').val(@props.record.signid)
      else if code == 'medicine_stock_record'
        if @props.billin != null and @props.billin != undefined
          $('#' + @props.id + ' #form_billcode_id').val(@props.billin.id)
          $('#' + @props.id + ' #form_billcode').val(@props.billin.billcode)
        if @props.prescript != null and @props.prescript != undefined
          $('#' + @props.id + ' #form_script_id').val(@props.prescript.id)
          $('#' + @props.id + ' #form_script_code').val(@props.prescript.code)  
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_sample').val(@props.record.name)
          $('#' + @props.id + ' #form_sample_id').val(@props.record.sample_id)
          $('#' + @props.id + ' #form_script_id').val(@props.record.internal_record_id)
          $('#' + @props.id + ' #form_script_code').val(@props.record.internal_record_code)
          $('#' + @props.id + ' #form_remark').val(@props.record.remark)
          $('#' + @props.id + ' #form_amount').val(@props.record.amount)
          $('#' + @props.id + ' #form_noid').val(@props.record.noid)
          $('#' + @props.id + ' #form_signid').val(@props.record.signid)
          if @props.record.expire != null
            $('#' + @props.id + ' #form_expire').val(@props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4))
          $('#' + @props.id + ' #form_supplier').val(@props.record.supplier)
          $('#' + @props.id + ' #form_supplier_id').val(@props.record.supplier_id)
          $('#' + @props.id + ' #form_billcode_id').val(@props.record.bill_in_id)
          $('#' + @props.id + ' #form_billcode').val(@props.record.bill_in_code)
      else if code == 'check_info'
        if @props.employee != null and @props.employee != undefined
          $('#' + @props.id + ' #form_e_id').val(@props.employee.id)
          $('#' + @props.id + ' #form_ename').val(@props.employee.ename)
        if @props.customer != null and @props.customer_id != undefined
          $('#' + @props.id + ' #form_c_id').val(@props.customer_id.id)
          $('#' + @props.id + ' #form_c_name').val(@props.customer_id.cname)  
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_ename').val(@props.record.ename)
          $('#' + @props.id + ' #form_e_id').val(@props.record.e_id)
          $('#' + @props.id + ' #form_c_id').val(@props.record.c_id)
          $('#' + @props.id + ' #form_cname').val(@props.record.c_name)
          $('#' + @props.id + ' #form_kluan').val(@props.record.kluan)
          $('#' + @props.id + ' #form_cdoan').val(@props.record.cdoan)
          $('#' + @props.id + ' #form_hdieutri').val(@props.record.hdieutri)
          if @props.record.daystart != null
            $('#' + @props.id + ' #form_daystart').val(@props.record.daystart.substring(8, 10) + "/" + @props.record.daystart.substring(5, 7) + "/" + @props.record.daystart.substring(0, 4))
          if @props.record.dayend != null
            $('#' + @props.id + ' #form_dayend').val(@props.record.dayend.substring(8, 10) + "/" + @props.record.dayend.substring(5, 7) + "/" + @props.record.dayend.substring(0, 4))
      else if code == 'doctor_check_info'
        if @props.employee != null and @props.employee != undefined
          $('#' + @props.id + ' #form_e_id').val(@props.employee.id)
          $('#' + @props.id + ' #form_ename').val(@props.employee.ename)
        if @props.customer != null and @props.customer_id != undefined
          $('#' + @props.id + ' #form_c_id').val(@props.customer_id.id)
          $('#' + @props.id + ' #form_c_name').val(@props.customer_id.cname)  
        if @props.record != null and @props.record != undefined
          $('#' + @props.id + ' #form_ename').val(@props.record.ename)
          $('#' + @props.id + ' #form_e_id').val(@props.record.e_id)
          $('#' + @props.id + ' #form_c_id').val(@props.record.c_id)
          $('#' + @props.id + ' #form_cname').val(@props.record.c_name)
          $('#' + @props.id + ' #form_qtbenhly').val(@props.record.qtbenhly)
          $('#' + @props.id + ' #form_klamsang').val(@props.record.klamsang)
          $('#' + @props.id + ' #form_nhiptim').val(@props.record.nhiptim)
          $('#' + @props.id + ' #form_nhietdo').val(@props.record.nhietdo)
          $('#' + @props.id + ' #form_hamin').val(@props.record.hamin)
          $('#' + @props.id + ' #form_hamax').val(@props.record.hamax)
          $('#' + @props.id + ' #form_ntho').val(@props.record.ntho)
          $('#' + @props.id + ' #form_cnang').val(@props.record.cnang)
          $('#' + @props.id + ' #form_cao').val(@props.record.cao)
          $('#' + @props.id + ' #form_cdbandau').val(@props.record.cdbandau)
          $('#' + @props.id + ' #form_bktheo').val(@props.record.bktheo)
          $('#' + @props.id + ' #form_cdicd').val(@props.record.cdicd)
          $('#' + @props.id + ' #form_kluan').val(@props.record.kluan)
          if @props.record.daycheck != null
            $('#' + @props.id + ' #form_daycheck').val(@props.record.daycheck.substring(8, 10) + "/" + @props.record.daycheck.substring(5, 7) + "/" + @props.record.daycheck.substring(0, 4))
    triggerClearFormValue: (code) ->
      if code == "customer_record"
        $('#' + @props.id + ' #form_name').val("")
        $('#' + @props.id + ' #form_dob').val("")
        $('#' + @props.id + ' #form_address').val("")
        $('#' + @props.id + ' #form_pnumber').val("")
        $('#' + @props.id + ' #form_noid').val("")
        $('#' + @props.id + ' #form_work_place').val("")
        $('#' + @props.id + ' #form_self_history').val("")
        $('#' + @props.id + ' #form_family_history').val("")
        $('#' + @props.id + ' #form_drug_history').val("")
        $('#' + @props.id + ' #form_avatar').val("")
        document.getElementById('results').innerHTML = '<img id="sample_avatar" class="" style="max-width: 100%;max-height: 240px" src="https://www.twomargins.com/images/noavatar.jpg"/>'
      else if code == 'employee'
        $('#' + @props.id + ' #form_ename').val("")
        $('#' + @props.id + ' #form_address').val("")
        $('#' + @props.id + ' #form_pnumber').val("")
        $('#' + @props.id + ' #form_noid').val("")
        $('#' + @props.id + ' #form_avatar').val("")
        document.getElementById('results').innerHTML = '<img id="sample_avatar" class="" style="max-width: 100%;max-height: 240px" src="https://www.twomargins.com/images/noavatar.jpg"/>'
      else if code == 'room'
        $('#' + @props.id + ' #form_name').val("")
        $('#' + @props.id + ' #form_lang').val("vi")
        $('#' + @props.id + ' #form_map').val("")
      else if code == 'position'
        $('#' + @props.id + ' #form_rname').val("")
        $('#' + @props.id + ' #form_r_id').val("")
        $('#' + @props.id + ' #form_pname').val("")
        $('#' + @props.id + ' #form_lang').val("vi")
        $('#' + @props.id + ' #form_description').val("")
        $('#' + @props.id + ' #form_file').val("")
      else if code == 'service'
        $('#' + @props.id + ' #form_sname').val('')
        $('#' + @props.id + ' #form_lang').val('vi')
        $('#' + @props.id + ' #form_price').val(0)
        $('#' + @props.id + ' #form_currency').val("VND")
        $('#' + @props.id + ' #form_description').val('')
        $('#' + @props.id + ' #form_file').val("")
      else if code == 'posmap'
        $('#' + @props.id + ' #form_e_id').val("")
        $('#' + @props.id + ' #form_ename').val("")
        $('#' + @props.id + ' #form_p_id').val("")
        $('#' + @props.id + ' #form_pname').val("")
      else if code == 'sermap'
        $('#' + @props.id + ' #form_sname').val('')
        $('#' + @props.id + ' #form_s_id').val('')
        $('#' + @props.id + ' #form_rname').val('')
        $('#' + @props.id + ' #form_r_id').val('')
      else if code == 'order_map'
        $('#' + @props.id + ' #form_c_id').val("")
        $('#' + @props.id + ' #form_cname').val("")
        $('#' + @props.id + ' #form_s_id').val("")
        $('#' + @props.id + ' #form_sname').val("")
        $('#' + @props.id + ' #form_remark').val("")
        $('#' + @props.id + ' #form_tpayment').val(0)
        $('#' + @props.id + ' #form_discount').val(0)
        $('#' + @props.id + ' #form_discount_percent').val(0)
        $('#' + @props.id + ' #form_tpayout').val(0)
      else if code == 'medicine_supplier'
        $('#' + @props.id + ' #form_noid').val('')
        $('#' + @props.id + ' #form_name').val('')
        $('#' + @props.id + ' #form_contact_name').val('')
        $('#' + @props.id + ' #form_spnumber').val('')
        $('#' + @props.id + ' #form_pnumber').val('')
        $('#' + @props.id + ' #form_address1').val('')
        $('#' + @props.id + ' #form_address2').val('')
        $('#' + @props.id + ' #form_address3').val('')
        $('#' + @props.id + ' #form_email').val('')
        $('#' + @props.id + ' #form_facebook').val('')
        $('#' + @props.id + ' #form_twitter').val('')
        $('#' + @props.id + ' #form_fax').val('')
        $('#' + @props.id + ' #form_taxcode').val('')
      else if code == 'medicine_company'
        $('#' + @props.id + ' #form_noid').val('')
        $('#' + @props.id + ' #form_name').val('')
        $('#' + @props.id + ' #form_pnumber').val('')
        $('#' + @props.id + ' #form_address').val('')
        $('#' + @props.id + ' #form_email').val('')
        $('#' + @props.id + ' #form_website').val('')
        $('#' + @props.id + ' #form_taxcode').val('')
      else if code == 'medicine_sample'
        $('#' + @props.id + ' #form_noid').val('')
        $('#' + @props.id + ' #form_name').val('')
        $('#' + @props.id + ' #form_price').val('')
        $('#' + @props.id + ' #form_remark').val('')
        $('#' + @props.id + ' #form_weight').val('')
        $('#' + @props.id + ' #form_expire').val('')
        $('#' + @props.id + ' #form_company').val('')
        $('#' + @props.id + ' #form_company_id').val('')
      else if code == 'medicine_bill_in'
        $('#' + @props.id + ' #form_billcode').val("")
        $('#' + @props.id + ' #form_supplier_id').val("")
        $('#' + @props.id + ' #form_remark').val("")
        $('#' + @props.id + ' #form_supplier').val("")
        $('#' + @props.id + ' #form_dayin').val("")
        $('#' + @props.id + ' #form_daybook').val("")
        $('#' + @props.id + ' #form_tpayment').val(0)
        $('#' + @props.id + ' #form_discount').val(0)
        $('#' + @props.id + ' #form_discount_percent').val(0)
        $('#' + @props.id + ' #form_tpayout').val(0)
      else if code == 'medicine_bill_record'
        $('#' + @props.id + ' #form_billcode_id').val('')
        $('#' + @props.id + ' #form_billcode').val('')
        $('#' + @props.id + ' #form_sample_id').val('')
        $('#' + @props.id + ' #form_sample').val('')
        $('#' + @props.id + ' #form_company_id').val('')
        $('#' + @props.id + ' #form_company').val('')
        $('#' + @props.id + ' #form_noid').val('')
        $('#' + @props.id + ' #form_signid').val('')
        $('#' + @props.id + ' #form_remark').val('')
        $('#' + @props.id + ' #form_expire').val('')
        $('#' + @props.id + ' #form_qty').val(0)
        $('#' + @props.id + ' #form_taxrate').val(10)
        $('#' + @props.id + ' #form_price').val(0)
      else if code == 'medicine_price'
        $('#' + @props.id + ' #form_sample_id').val('')
        $('#' + @props.id + ' #form_sample').val('')
        $('#' + @props.id + ' #form_minam').val('')
        $('#' + @props.id + ' #form_remark').val('')
        $('#' + @props.id + ' #form_price').val('')
      else if code == 'medicine_prescript_external'
        $('#' + @props.id + ' #form_code').val('')
        $('#' + @props.id + ' #form_c_id').val('')
        $('#' + @props.id + ' #form_cname').val('')
        $('#' + @props.id + ' #form_e_id').val('')
        $('#' + @props.id + ' #form_ename').val('')
        $('#' + @props.id + ' #form_date').val(moment().format('DD/MM/YYYY'))
        $('#' + @props.id + ' #form_result_id').val('')
        $('#' + @props.id + ' #form_number_id').val('')
        $('#' + @props.id + ' #form_address').val('')
        $('#' + @props.id + ' #form_remark').val('')
      else if code == 'medicine_external_record'
        $('#' + @props.id + ' #form_sample').val('')
        $('#' + @props.id + ' #form_sample_id').val('')
        $('#' + @props.id + ' #form_c_id').val('')
        $('#' + @props.id + ' #form_cname').val('')
        $('#' + @props.id + ' #form_script_id').val('')
        $('#' + @props.id + ' #form_remark').val('')
        $('#' + @props.id + ' #form_company').val('')
        $('#' + @props.id + ' #form_company_id').val('')
        $('#' + @props.id + ' #form_amount').val(0)
        $('#' + @props.id + ' #form_script_code').val('')
        $('#' + @props.id + ' #form_price').val(0)
        $('#' + @props.id + ' #form_total').val(0)
      else if code == 'medicine_prescript_internal'
        $('#' + @props.id + ' #form_code').val('')
        $('#' + @props.id + ' #form_c_id').val('')
        $('#' + @props.id + ' #form_cname').val('')
        $('#' + @props.id + ' #form_e_id').val('')
        $('#' + @props.id + ' #form_ename').val('')
        $('#' + @props.id + ' #form_date').val(moment().format('DD/MM/YYYY'))
        $('#' + @props.id + ' #form_result_id').val('')
        $('#' + @props.id + ' #form_number_id').val('')
        $('#' + @props.id + ' #form_remark').val('')
        $('#' + @props.id + ' #form_e_p_id').val('')
        $('#' + @props.id + ' #form_epname').val('')
        $('#' + @props.id + ' #form_payer').val('')
        $('#' + @props.id + ' #form_tpayment').val(0)
        $('#' + @props.id + ' #form_discount').val(0)
        $('#' + @props.id + ' #form_tpayout').val(0)
      else if code == 'medicine_internal_record'
        $('#' + @props.id + ' #form_sample').val('')
        $('#' + @props.id + ' #form_sample_id').val('')
        $('#' + @props.id + ' #form_c_id').val('')
        $('#' + @props.id + ' #form_cname').val('')
        $('#' + @props.id + ' #form_script_id').val('')
        $('#' + @props.id + ' #form_remark').val('')
        $('#' + @props.id + ' #form_company').val('')
        $('#' + @props.id + ' #form_company_id').val('')
        $('#' + @props.id + ' #form_amount').val(0)
        $('#' + @props.id + ' #form_script_code').val('')
        $('#' + @props.id + ' #form_price').val(0)
        $('#' + @props.id + ' #form_tpayment').val(0)
        $('#' + @props.id + ' #form_noid').val('')
        $('#' + @props.id + ' #form_signid').val('')
      else if code == 'medicine_stock_record'
        $('#' + @props.id + ' #form_sample').val('')
        $('#' + @props.id + ' #form_sample_id').val('')
        $('#' + @props.id + ' #form_script_id').val('')
        $('#' + @props.id + ' #form_remark').val('')
        $('#' + @props.id + ' #form_amount').val(0)
        $('#' + @props.id + ' #form_script_code').val('')
        $('#' + @props.id + ' #form_noid').val('')
        $('#' + @props.id + ' #form_signid').val('')
        $('#' + @props.id + ' #form_expire').val(moment().format('DD/MM/YYYY'))
        $('#' + @props.id + ' #form_supplier').val('')
        $('#' + @props.id + ' #form_supplier_id').val('')
        $('#' + @props.id + ' #form_billcode_id').val('')
        $('#' + @props.id + ' #form_billcode').val('')
    triggerAutoCompleteInputAlt: (code) ->
      if code == 'cname'
        if $('#' + @props.id + ' #form_cname').val().length > 3
          formData = new FormData
          formData.append 'cname', $('#' + @props.id + ' #form_cname').val().toLowerCase()
          $.ajax
            url: '/customer_record/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'ename'
        if $('#' + @props.id + ' #form_ename').val().length > 1
          formData = new FormData
          formData.append 'ename', $('#' + @props.id + ' #form_ename').val().toLowerCase()
          $.ajax
            url: '/employee/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'epname'
        if $('#' + @props.id + ' #form_epname').val().length > 1
          formData = new FormData
          formData.append 'ename', $('#' + @props.id + ' #form_epname').val().toLowerCase()
          $.ajax
            url: '/employee/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'sname'
        if $('#' + @props.id + ' #form_sname').val().length > 1
          formData = new FormData
          formData.append 'sname', $('#' + @props.id + ' #form_sname').val().toLowerCase()
          $.ajax
            url: '/service/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'pname'
        if $('#' + @props.id + ' #form_pname').val().length > 1
          formData = new FormData
          formData.append 'pname', $('#' + @props.id + ' #form_pname').val().toLowerCase()
          $.ajax
            url: '/position/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'rname'
        if $('#' + @props.id + ' #form_rname').val().length > 1
          formData = new FormData
          formData.append 'name', $('#' + @props.id + ' #form_rname').val().toLowerCase()
          $.ajax
            url: '/room/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'company'
        if $('#' + @props.id + ' #form_company').val().length > 1
          formData = new FormData
          formData.append 'name', $('#' + @props.id + ' #form_company').val().toLowerCase()
          $.ajax
            url: '/medicine_company/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'supplier'
        if $('#' + @props.id + ' #form_supplier').val().length > 1
          formData = new FormData
          formData.append 'name', $('#' + @props.id + ' #form_supplier').val().toLowerCase()
          $.ajax
            url: '/medicine_supplier/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'sample'
        if $('#' + @props.id + ' #form_sample').val().length > 1
          formData = new FormData
          formData.append 'name', $('#' + @props.id + ' #form_sample').val().toLowerCase()
          $.ajax
            url: '/medicine_sample/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'billcode'
        if $('#' + @props.id + ' #form_billcode').val().length > 1
          formData = new FormData
          formData.append 'billcode', $('#' + @props.id + ' #form_billcode').val().toLowerCase()
          $.ajax
            url: '/medicine_bill_in/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'sample_sell'
        if $('#' + @props.id + ' #form_sample').val().length > 1
          formData = new FormData
          formData.append 'name_sell', $('#' + @props.id + ' #form_sample').val().toLowerCase()
          $.ajax
            url: '/medicine_sample/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'script_ex'
        if $('#' + @props.id + ' #form_script_code').val().length > 1
          formData = new FormData
          formData.append 'code', $('#' + @props.id + ' #form_script_code').val().toLowerCase()
          $.ajax
            url: '/medicine_prescript_external/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
      else if code == 'script_in'
        if $('#' + @props.id + ' #form_script_code').val().length > 1
          formData = new FormData
          formData.append 'code', $('#' + @props.id + ' #form_script_code').val().toLowerCase()
          $.ajax
            url: '/medicine_prescript_internal/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: code
              return
            ).bind(this)
    triggerAutoComplete: (record) ->
      if @state.code == 'cname'
        $('#' + @props.id + ' #form_cname').val(record.cname)
        $('#' + @props.id + ' #form_c_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'ename'
        $('#' + @props.id + ' #form_ename').val(record.ename)
        $('#' + @props.id + ' #form_e_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'epname'
        $('#' + @props.id + ' #form_epname').val(record.ename)
        $('#' + @props.id + ' #form_e_p_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'sname'
        $('#' + @props.id + ' #form_sname').val(record.sname)
        $('#' + @props.id + ' #form_tpayment').val(record.price)
        $('#' + @props.id + ' #form_tpayout').val(record.price)
        $('#' + @props.id + ' #form_s_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'pname'
        $('#' + @props.id + ' #form_pname').val(record.pname)
        $('#' + @props.id + ' #form_p_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'rname'
        $('#' + @props.id + ' #form_rname').val(record.name)
        $('#' + @props.id + ' #form_r_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'company'
        $('#' + @props.id + ' #form_company').val(record.name)
        $('#' + @props.id + ' #form_company_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'supplier'
        $('#' + @props.id + ' #form_supplier').val(record.name)
        $('#' + @props.id + ' #form_supplier_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'sample'
        $('#' + @props.id + ' #form_sample').val(record.name)
        $('#' + @props.id + ' #form_sample_id').val(record.id)
        $('#' + @props.id + ' #form_company').val(record.company)
        $('#' + @props.id + ' #form_company_id').val(record.company_id)
        $('#' + @props.id + ' #form_price').val(record.price)
        @setState autoComplete: null
      else if @state.code == 'sample_sell'
        $('#' + @props.id + ' #form_sample').val(record.name)
        $('#' + @props.id + ' #form_sample_id').val(record.id)
        $('#' + @props.id + ' #form_company').val(record.company)
        $('#' + @props.id + ' #form_company_id').val(record.company_id)
        $('#' + @props.id + ' #form_price').val(record.price)
        @setState autoComplete: null
      else if @state.code == 'billcode'
        $('#' + @props.id + ' #form_billcode').val(record.billcode)
        $('#' + @props.id + ' #form_billcode_id').val(record.id)
        @setState autoComplete: null
      else if @state.code == 'script_ex'
        $('#' + @props.id + ' #form_script_code').val(record.code)
        $('#' + @props.id + ' #form_script_id').val(record.id)
        $('#' + @props.id + ' #form_c_id').val(record.customer_id)
        $('#' + @props.id + ' #form_cname').val(record.cname)
        @setState autoComplete: null
      else if @state.code == 'script_in'
        $('#' + @props.id + ' #form_script_code').val(record.code)
        $('#' + @props.id + ' #form_script_id').val(record.id)
        $('#' + @props.id + ' #form_c_id').val(record.customer_id)
        $('#' + @props.id + ' #form_cname').val(record.cname)
        @setState autoComplete: null
    triggerRecalPayment: (e) ->
      if @props.datatype == 'order_map' or @props.datatype == 'medicine_bill_in' or @props.datatype == 'medicine_prescript_internal'
        if $('#' + @props.id + ' #form_tpayment').val() > 0
          if $('#' + @props.id + ' #form_discount').val() > 0
            $('#' + @props.id + ' #form_discount_percent').val(Number($('#' + @props.id + ' #form_discount').val())/Number($('#' + @props.id + ' #form_tpayment').val())*100)
            $('#' + @props.id + ' #form_tpayout').val(Number($('#' + @props.id + ' #form_tpayment').val()) - Number($('#' + @props.id + ' #form_discount').val()))
          else
            if $('#' + @props.id + ' #form_discount_percent').val() > 0
              $('#' + @props.id + ' #form_discount').val(Number($('#' + @props.id + ' #form_discount_percent').val()) * Number($('#' + @props.id + ' #form_tpayment').val()) / 100)
              $('#' + @props.id + ' #form_tpayout').val(Number($('#' + @props.id + ' #form_tpayment').val()) - Number($('#' + @props.id + ' #form_discount').val()))
            else
              $('#' + @props.id + ' #form_tpayout').val(Number($('#' + @props.id + ' #form_tpayment').val()) - Number($('#' + @props.id + ' #form_discount').val()))
      else if @props.datatype == 'medicine_external_record_mini' or @props.datatype == 'medicine_external_record'
        if Number($('#' + @props.id + ' #form_price').val()) > 0 and Number($('#' + @props.id + ' #form_amount').val()) > 0
          $('#' + @props.id + ' #form_total').val(Number($('#' + @props.id + ' #form_price').val()) * Number($('#' + @props.id + ' #form_amount').val()))
      else if @props.datatype == 'medicine_internal_record_mini' or @props.datatype == 'medicine_internal_record'
        if Number($('#' + @props.id + ' #form_price').val()) > 0 and Number($('#' + @props.id + ' #form_amount').val()) > 0
          $('#' + @props.id + ' #form_tpayment').val(Number($('#' + @props.id + ' #form_price').val()) * Number($('#' + @props.id + ' #form_amount').val()))
    triggerSumChild: (code) ->
      if code == 'bill_record'
        sumout = 0
        for record in @props.bill_record
          sumout += record.price * record.qty
        $('#' + @props.id + ' #form_tpayment').val(sumout)
      else if code == 'internal_record'
        sumout = 0
        for record in @props.internal_record
          sumout += Number(record.tpayment)
        $('#' + @props.id + ' #form_tpayment').val(Number(sumout))
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      if @props.datatype == 'customer_record'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_gender').val() == "Giới tính"
            formData.append 'gender', @props.record.gender
          else
            formData.append 'gender', $('#' + @props.id + ' #form_gender').val()
        else
          formData.append 'gender', $('#' + @props.id + ' #form_gender').val()
        formData.append 'cname', $('#' + @props.id + ' #form_name').val()
        formData.append 'dob', $('#' + @props.id + ' #form_dob').val()
        formData.append 'address', $('#' + @props.id + ' #form_address').val()
        formData.append 'pnumber', $('#' + @props.id + ' #form_pnumber').val()
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        formData.append 'work_place', $('#' + @props.id + ' #form_work_place').val()
        formData.append 'self_history', $('#' + @props.id + ' #form_self_history').val()
        formData.append 'family_history', $('#' + @props.id + ' #form_family_history').val()
        formData.append 'drug_history', $('#' + @props.id + ' #form_drug_history').val()
        if $('#' + @props.id + ' #form_avatar')[0].files[0] != undefined
          formData.append 'avatar', $('#' + @props.id + ' #form_avatar')[0].files[0]
        else if $('#' + @props.id + ' #webcamout').attr('src') != undefined
          formData.append 'avatar', $('#' + @props.id + ' #webcamout').attr('src')
      else if @props.datatype == 'employee'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_gender').val() == 'Giới tính'
            formdata.append 'gender', @props.record.gender
          else
            formData.append 'gender', $('#' + @props.id + ' #form_gender').val()
        else
          formData.append 'gender', $('#' + @props.id + ' #form_gender').val()
        formData.append 'ename', $('#' + @props.id + ' #form_ename').val()
        formData.append 'address', $('#' + @props.id + ' #form_address').val()
        formData.append 'pnumber', $('#' + @props.id + ' #form_pnumber').val()
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        if $('#' + @props.id + ' #form_avatar')[0].files[0] != undefined
          formData.append 'avatar', $('#' + @props.id + ' #form_avatar')[0].files[0]
        else if $('#' + @props.id + ' #webcamout').attr('src') != undefined
          formData.append 'avatar', $('#' + @props.id + ' #webcamout').attr('src')
      else if @props.datatype == 'room'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'name', $('#' + @props.id + ' #form_name').val()
        formData.append 'lang', $('#' + @props.id + ' #form_lang').val()
        if $('#' + @props.id + ' #form_map')[0].files[0] != undefined
          formData.append 'map', $('#' + @props.id + ' #form_map')[0].files[0]
      else if @props.datatype == 'position'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'rname', $('#' + @props.id + ' #form_rname').val()
        formData.append 'r_id', $('#' + @props.id + ' #form_r_id').val()
        formData.append 'pname', $('#' + @props.id + ' #form_pname').val()
        formData.append 'lang', $('#' + @props.id + ' #form_lang').val()
        formData.append 'description', $('#' + @props.id + ' #form_description').val()
        if $('#' + @props.id + ' #form_file')[0].files[0] != undefined
          formData.append 'file', $('#' + @props.id + ' #form_file')[0].files[0]
      else if @props.datatype == 'service'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'sname', $('#' + @props.id + ' #form_sname').val()
        formData.append 'lang', $('#' + @props.id + ' #form_lang').val()
        formData.append 'price', $('#' + @props.id + ' #form_price').val()
        formData.append 'currency', $('#' + @props.id + ' #form_currency').val()
        formData.append 'description', $('#' + @props.id + ' #form_description').val()
        if $('#' + @props.id + ' #form_file')[0].files[0] != undefined
          formData.append 'file', $('#' + @props.id + ' #form_file')[0].files[0]
      else if @props.datatype == 'posmap'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'ename', $('#' + @props.id + ' #form_ename').val()
        formData.append 'e_id', $('#' + @props.id + ' #form_e_id').val()
        formData.append 'pname', $('#' + @props.id + ' #form_pname').val()
        formData.append 'p_id', $('#' + @props.id + ' #form_p_id').val()
      else if @props.datatype == 'sermap'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'sname', $('#' + @props.id + ' #form_sname').val()
        formData.append 's_id', $('#' + @props.id + ' #form_s_id').val()
        formData.append 'rname', $('#' + @props.id + ' #form_rname').val()
        formData.append 'r_id', $('#' + @props.id + ' #form_r_id').val()
      else if @props.datatype == 'order_map'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_status').val() == ''
            formData.append 'status', @props.record.status
          else
            formData.append 'status', $('#' + @props.id + ' #form_status').val()
        else
          formData.append 'status', $('#' + @props.id + ' #form_status').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'customer_id', $('#' + @props.id + ' #form_c_id').val()
        formData.append 'cname', $('#' + @props.id + ' #form_cname').val()
        formData.append 'service_id', $('#' + @props.id + ' #form_s_id').val()
        formData.append 'sername', $('#' + @props.id + ' #form_sname').val()
        formData.append 'tpayment', $('#' + @props.id + ' #form_tpayment').val()
        formData.append 'discount', $('#' + @props.id + ' #form_discount').val()
        formData.append 'tpayout', $('#' + @props.id + ' #form_tpayout').val()
      else if @props.datatype == 'medicine_supplier'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        formData.append 'name', $('#' + @props.id + ' #form_name').val()
        formData.append 'contactname', $('#' + @props.id + ' #form_contact_name').val()
        formData.append 'spnumber', $('#' + @props.id + ' #form_spnumber').val()
        formData.append 'pnumber', $('#' + @props.id + ' #form_pnumber').val()
        formData.append 'address1', $('#' + @props.id + ' #form_address1').val()
        formData.append 'address2', $('#' + @props.id + ' #form_address2').val()
        formData.append 'address3', $('#' + @props.id + ' #form_address3').val()
        formData.append 'email', $('#' + @props.id + ' #form_email').val()
        formData.append 'facebook', $('#' + @props.id + ' #form_facebook').val()
        formData.append 'twitter', $('#' + @props.id + ' #form_twitter').val()
        formData.append 'fax', $('#' + @props.id + ' #form_fax').val()
        formData.append 'taxcode', $('#' + @props.id + ' #form_taxcode').val()
      else if @props.datatype == 'medicine_company'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        formData.append 'name', $('#' + @props.id + ' #form_name').val()
        formData.append 'pnumber', $('#' + @props.id + ' #form_pnumber').val()
        formData.append 'address', $('#' + @props.id + ' #form_address').val()
        formData.append 'email', $('#' + @props.id + ' #form_email').val()
        formData.append 'website', $('#' + @props.id + ' #form_website').val()
        formData.append 'taxcode', $('#' + @props.id + ' #form_taxcode').val()
      else if @props.datatype == 'medicine_sample'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_typemedicine').val() == ""
            formData.append 'typemedicine', @props.record.typemedicine
          else
            formData.append 'typemedicine', $('#' + @props.id + ' #form_typemedicine').val()
          if $('#' + @props.id + ' #form_groupmedicine').val() == ""
            formData.append 'groupmedicine', @props.record.groupmedicine
          else
            formData.append 'groupmedicine', $('#' + @props.id + ' #form_groupmedicine').val()
        else
          formData.append 'typemedicine', $('#' + @props.id + ' #form_typemedicine').val()
          formData.append 'groupmedicine', $('#' + @props.id + ' #form_groupmedicine').val()
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        formData.append 'name', $('#' + @props.id + ' #form_name').val()
        formData.append 'company_id', $('#' + @props.id + ' #form_company_id').val()
        formData.append 'company', $('#' + @props.id + ' #form_company').val()
        formData.append 'price', $('#' + @props.id + ' #form_price').val()
        formData.append 'weight', $('#' + @props.id + ' #form_weight').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'expire', $('#' + @props.id + ' #form_expire').val()
      else if @props.datatype == 'medicine_bill_in'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_pmethod').val() == "Cách thanh toán"
            formData.append 'pmethod', @props.record.pmethod
          else
            formData.append 'pmethod', $('#' + @props.id + ' #form_pmethod').val()
          if $('#' + @props.id + ' #form_status').val() == ""
            formData.append 'status', @props.record.status
          else
            formData.append 'status', $('#' + @props.id + ' #form_status').val()
        else
          formData.append 'pmethod', $('#' + @props.id + ' #form_pmethod').val()
          formData.append 'status', $('#' + @props.id + ' #form_status').val()
        formData.append 'billcode', $('#' + @props.id + ' #form_billcode').val()
        formData.append 'supplier_id', $('#' + @props.id + ' #form_supplier_id').val()
        formData.append 'supplier', $('#' + @props.id + ' #form_supplier').val()
        formData.append 'dayin', $('#' + @props.id + ' #form_dayin').val()
        formData.append 'daybook', $('#' + @props.id + ' #form_daybook').val()
        formData.append 'tpayment', $('#' + @props.id + ' #form_tpayment').val()
        formData.append 'discount', $('#' + @props.id + ' #form_discount').val()
        formData.append 'tpayout', $('#' + @props.id + ' #form_tpayout').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'list_bill_record', JSON.stringify(@props.bill_record)
      else if @props.datatype == 'medicine_bill_record'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_pmethod').val() == 'Cách mua'
            formData.append 'pmethod', @props.record.pmethod
          else
            formData.append 'pmethod', $('#' + @props.id + ' #form_pmethod').val()
        else
          formData.append 'pmethod', $('#' + @props.id + ' #form_pmethod').val()
        formData.append 'billcode', $('#' + @props.id + ' #form_billcode').val()
        formData.append 'billcode_id', $('#' + @props.id + ' #form_billcode_id').val()
        formData.append 'name', $('#' + @props.id + ' #form_sample').val()
        formData.append 'company', $('#' + @props.id + ' #form_company').val()
        formData.append 'company_id', $('#' + @props.id + ' #form_company_id').val()
        formData.append 'sample_id', $('#' + @props.id + ' #form_sample_id').val()
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        formData.append 'signid', $('#' + @props.id + ' #form_signid').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'expire', $('#' + @props.id + ' #form_expire').val()
        formData.append 'qty', $('#' + @props.id + ' #form_qty').val()
        formData.append 'taxrate', $('#' + @props.id + ' #form_taxrate').val()
        formData.append 'price', $('#' + @props.id + ' #form_price').val()
      else if @props.datatype == 'medicine_price'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'sample_id', $('#' + @props.id + ' #form_sample_id').val()
        formData.append 'name', $('#' + @props.id + ' #form_sample').val()
        formData.append 'minam', $('#' + @props.id + ' #form_minam').val()
        formData.append 'price', $('#' + @props.id + ' #form_price').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
      else if @props.datatype == 'medicine_prescript_external'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'code', $('#' + @props.id + ' #form_code').val()
        formData.append 'customer_id', $('#' + @props.id + ' #form_c_id').val()
        formData.append 'cname', $('#' + @props.id + ' #form_cname').val()
        formData.append 'employee_id', $('#' + @props.id + ' #form_e_id').val()
        formData.append 'ename', $('#' + @props.id + ' #form_ename').val()
        formData.append 'result_id', $('#' + @props.id + ' #form_result_id').val()
        formData.append 'number_id', $('#' + @props.id + ' #form_number_id').val()
        formData.append 'date', $('#' + @props.id + ' #form_date').val()
        formData.append 'address', $('#' + @props.id + ' #form_address').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'list_external_record', JSON.stringify(@props.external_record)
      else if @props.datatype == 'medicine_external_record'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'name', $('#' + @props.id + ' #form_sample').val()
        formData.append 'sample_id', $('#' + @props.id + ' #form_sample_id').val()
        formData.append 'customer_id', $('#' + @props.id + ' #form_c_id').val()
        formData.append 'cname', $('#' + @props.id + ' #form_cname').val()
        formData.append 'script_id', $('#' + @props.id + ' #form_script_id').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'company', $('#' + @props.id + ' #form_company').val()
        formData.append 'company_id', $('#' + @props.id + ' #form_company_id').val()
        formData.append 'amount', $('#' + @props.id + ' #form_amount').val()
        formData.append 'script_code', $('#' + @props.id + ' #form_script_code').val()
        formData.append 'price', $('#' + @props.id + ' #form_price').val()
        formData.append 'total', $('#' + @props.id + ' #form_total').val()
      else if @props.datatype == 'medicine_prescript_internal'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_pmethod').val() == "Cách thanh toán"
            formData.append 'pmethod', @props.record.pmethod
          else
            formData.append 'pmethod', $('#' + @props.id + ' #form_pmethod').val()
        else
          formData.append 'pmethod', $('#' + @props.id + ' #form_pmethod').val()
        formData.append 'code', $('#' + @props.id + ' #form_code').val()
        formData.append 'customer_id', $('#' + @props.id + ' #form_c_id').val()
        formData.append 'cname', $('#' + @props.id + ' #form_cname').val()
        formData.append 'employee_id', $('#' + @props.id + ' #form_e_id').val()
        formData.append 'ename', $('#' + @props.id + ' #form_ename').val()
        formData.append 'result_id', $('#' + @props.id + ' #form_result_id').val()
        formData.append 'number_id', $('#' + @props.id + ' #form_number_id').val()
        formData.append 'date', $('#' + @props.id + ' #form_date').val()
        formData.append 'preparer', $('#' + @props.id + ' #form_epname').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'payer', $('#' + @props.id + ' #form_payer').val()
        formData.append 'tpayment', $('#' + @props.id + ' #form_tpayment').val()
        formData.append 'discount', $('#' + @props.id + ' #form_discount').val()
        formData.append 'tpayout', $('#' + @props.id + ' #form_tpayout').val()
        formData.append 'preparer_id', $('#' + @props.id + ' #form_e_p_id').val()
        formData.append 'list_internal_record', JSON.stringify(@props.internal_record)
      else if @props.datatype == 'medicine_internal_record'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_status').val() == "Tình trạng"
            formData.append 'status', @props.record.status
          else
            formData.append 'status', $('#' + @props.id + ' #form_status').val()
        else
          formData.append 'status', $('#' + @props.id + ' #form_status').val()  
        formData.append 'name', $('#' + @props.id + ' #form_sample').val()
        formData.append 'sample_id', $('#' + @props.id + ' #form_sample_id').val()
        formData.append 'customer_id', $('#' + @props.id + ' #form_c_id').val()
        formData.append 'cname', $('#' + @props.id + ' #form_cname').val()
        formData.append 'script_id', $('#' + @props.id + ' #form_script_id').val()
        formData.append 'script_code', $('#' + @props.id + ' #form_script_code').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
        formData.append 'company', $('#' + @props.id + ' #form_company').val()
        formData.append 'company_id', $('#' + @props.id + ' #form_company_id').val()
        formData.append 'amount', $('#' + @props.id + ' #form_amount').val()
        formData.append 'price', $('#' + @props.id + ' #form_price').val()
        formData.append 'discount', 0
        formData.append 'tpayment', $('#' + @props.id + ' #form_tpayment').val()
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        formData.append 'signid', $('#' + @props.id + ' #form_signid').val()
      else if @props.datatype == 'medicine_stock_record'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_typerecord').val() == "Trạng thái"
            formData.append 'typerecord', @props.record.typerecord
          else
            formData.append 'typerecord', $('#' + @props.id + ' #form_typerecord').val()
        else
          formData.append 'typerecord', $('#' + @props.id + ' #form_typerecord').val()
        formData.append 'name', $('#' + @props.id + ' #form_sample').val()
        formData.append 'sample_id', $('#' + @props.id + ' #form_sample_id').val()
        formData.append 'noid', $('#' + @props.id + ' #form_noid').val()
        formData.append 'signid', $('#' + @props.id + ' #form_signid').val()
        formData.append 'amount', $('#' + @props.id + ' #form_amount').val()
        formData.append 'expire', $('#' + @props.id + ' #form_expire').val()
        formData.append 'supplier', $('#' + @props.id + ' #form_supplier').val()
        formData.append 'supplier_id', $('#' + @props.id + ' #form_supplier_id').val()
        formData.append 'internal_record_id', $('#' + @props.id + ' #form_script_id').val()
        formData.append 'bill_in_id', $('#' + @props.id + ' #form_billcode_id').val()
        formData.append 'bill_in_code', $('#' + @props.id + ' #form_billcode').val()
        formData.append 'internal_record_code', $('#' + @props.id + ' #form_script_code').val()
        formData.append 'remark', $('#' + @props.id + ' #form_remark').val()
      else if @props.datatype == 'check_info'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#' + @props.id + ' #form_status').val() == ''
            formData.append 'status', @props.record.status
          else
            formData.append 'status', $('#' + @props.id + ' #form_status').val()
        else
          formData.append 'status', $('#' + @props.id + ' #form_status').val()
        formData.append 'ename', $('#' + @props.id + ' #form_ename').val()
        formData.append 'e_id', $('#' + @props.id + ' #form_e_id').val()
        formData.append 'c_name', $('#' + @props.id + ' #form_cname').val()
        formData.append 'c_id', $('#' + @props.id + ' #form_c_id').val()
        formData.append 'kluan', $('#' + @props.id + ' #form_kluan').val()
        formData.append 'cdoan', $('#' + @props.id + ' #form_cdoan').val()
        formData.append 'hdieutri', $('#' + @props.id + ' #form_hdieutri').val()
        formData.append 'daystart', $('#' + @props.id + ' #form_daystart').val()
        formData.append 'dayend', $('#' + @props.id + ' #form_dayend').val()
      else if @props.datatype == 'doctor_check_info'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'daycheck', $('#' + @props.id + ' #form_daycheck').val()
        formData.append 'ename', $('#' + @props.id + ' #form_ename').val()
        formData.append 'e_id', $('#' + @props.id + ' #form_e_id').val()
        formData.append 'c_id', $('#' + @props.id + ' #form_c_id').val()
        formData.append 'c_name', $('#' + @props.id + ' #form_cname').val()
        formData.append 'qtbenhly', $('#' + @props.id + ' #form_qtbenhly').val()
        formData.append 'klamsang', $('#' + @props.id + ' #form_klamsang').val()
        formData.append 'nhiptim', $('#' + @props.id + ' #form_nhiptim').val()
        formData.append 'nhietdo', $('#' + @props.id + ' #form_nhietdo').val()
        formData.append 'hamin', $('#' + @props.id + ' #form_hamin').val()
        formData.append 'hamax', $('#' + @props.id + ' #form_hamax').val()
        formData.append 'ntho', $('#' + @props.id + ' #form_ntho').val()
        formData.append 'cnang', $('#' + @props.id + ' #form_cnang').val()
        formData.append 'cao', $('#' + @props.id + ' #form_cao').val()
        formData.append 'cdbandau', $('#' + @props.id + ' #form_cdbandau').val()
        formData.append 'bktheo', $('#' + @props.id + ' #form_bktheo').val()
        formData.append 'cdicd', $('#' + @props.id + ' #form_cdicd').val()
        formData.append 'kluan', $('#' + @props.id + ' #form_kluan').val()
      if @props.record != null
        $.ajax
          url: '/' + @props.datatype
          type: 'PUT'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger2 @props.record, result
            $('#' + @props.id).modal('hide')
            return
          ).bind(this)
      else
        $.ajax
          url: '/' + @props.datatype
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            $('#' + @props.id).modal('hide')
            return
          ).bind(this)
    handleSubmitMini: (e) ->
      e.preventDefault()
      if @props.datatype == 'medicine_bill_record_mini'
        result = {
          id: @props.record_id
          billcode: null
          pmethod: $('#' + @props.id + ' #form_pmethod').val()
          sample_id: $('#' + @props.id + ' #form_sample_id').val()
          name: $('#' + @props.id + ' #form_sample').val()
          company: $('#' + @props.id + ' #form_company').val()
          company_id: $('#' + @props.id + ' #form_company_id').val()
          noid: $('#' + @props.id + ' #form_noid').val()
          signid: $('#' + @props.id + ' #form_signid').val()
          remark: $('#' + @props.id + ' #form_remark').val()
          expire: $('#' + @props.id + ' #form_expire').val()
          qty: $('#' + @props.id + ' #form_qty').val()
          taxrate: $('#' + @props.id + ' #form_taxrate').val()
          price: $('#' + @props.id + ' #form_price').val()
        }
      else if @props.datatype == 'medicine_external_record_mini'
        result = {
          id: @props.record_id
          cname: null
          customer_id: null
          script_code: null
          script_id: null
          name: $('#' + @props.id + ' #form_sample').val()
          sample_id: $('#' + @props.id + ' #form_sample_id').val() 
          company_id: $('#' + @props.id + ' #form_company_id').val()
          company: $('#' + @props.id + ' #form_company').val()
          amount: $('#' + @props.id + ' #form_amount').val()
          remark: $('#' + @props.id + ' #form_remark').val()
          total: $('#' + @props.id + ' #form_total').val()
          price: $('#' + @props.id + ' #form_price').val()
        }
      else if @props.datatype == 'medicine_internal_record_mini'
        result = {
          id: @props.record_id
          cname: null
          customer_id: null
          script_code: null
          script_id: null
          name: $('#' + @props.id + ' #form_sample').val()
          sample_id: $('#' + @props.id + ' #form_sample_id').val() 
          company_id: $('#' + @props.id + ' #form_company_id').val()
          company: $('#' + @props.id + ' #form_company').val()
          amount: $('#' + @props.id + ' #form_amount').val()
          remark: $('#' + @props.id + ' #form_remark').val()
          tpayment: $('#' + @props.id + ' #form_tpayment').val()
          status: $('#' + @props.id + ' #form_status').val()
          discount: 0
          price: $('#' + @props.id + ' #form_price').val()
        }
      if result != undefined
        @props.trigger result
        $('#' + @props.id).modal('hide')
    doctorRoomRender: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-navbar',
              React.DOM.div className: 'tab-nav',
                React.createElement TabNavCell, className: 'tab-cell-3', code: 1, text: ' Thông tin bệnh nhân', selected: @state.selected, trigger: @selectCode
                React.createElement TabNavCell, className: 'tab-cell-3', code: 2, text: ' Thông tin điều trị', selected: @state.selected, trigger: @selectCode
                React.createElement TabNavCell, className: 'tab-cell-3', code: 3, text: ' Khám lâm sàng', selected: @state.selected, trigger: @selectCode
                React.createElement TabNavCell, className: 'tab-cell-3', code: 4, text: ' Đơn thuốc', selected: @state.selected, trigger: @selectCode
              React.DOM.div className: 'tab-content-list',
                React.createElement TabContentCell, code: 1, selected: @state.selected, record:
                  if @props.record != null
                    @props.record[0]
                  else
                    null
                React.DOM.div className: 'tab-content',
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-9', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.div className: 'tab-content-header',
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Tiểu sử bệnh'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.p style: {'paddingLeft': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.p style: {'paddingLeft': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                    React.DOM.div className: 'col-md-3', style: {'textAlign':'center', 'paddingTop': '30px'},
                      React.DOM.div className: 'pmo-pic',
                        React.DOM.div className: 'p-relative',
                          React.DOM.a href: '',
                            React.DOM.img className: 'img-responsive', src: 'http://byrushan.com/projects/ma/1-6-1/jquery/dark/img/profile-pics/profile-pic-2.jpg'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.h4 null,
                        React.DOM.i className: 'fa fa-user'
                        ' Thông tin cá nhân'
                    React.DOM.div className: 'col-md-6', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Full Name'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'Mallinda Hollaway'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Gender'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'Nam'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Birthday'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'June 23, 1990'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Tuổi'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '26'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Phone Number'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '01290898923'
                    React.DOM.div className: 'col-md-6', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Địa chỉ'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '267 B Vĩnh Hưng, Hoàng Mai, Hà Nội'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Noid'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '01290898923'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Ngày cấp'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'June 23, 1990'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Nơi cấp'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'Hoàng Mai, Hà Nội'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Nơi làm việc'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '267 B Vĩnh Hưng, Hoàng Mai, Hà Nội'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 15px 40px'},
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                React.DOM.div className: 'tab-content',
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-8', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.div className: 'tab-content-header',
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Kết luận'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.div className: 'tab-content-header', style: {'paddingTop': '40px'},
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Chuẩn đoán'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.div className: 'tab-content-header', style: {'paddingTop': '40px'},
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Hướng điều trị'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                    React.DOM.div className: 'col-md-4', style: {'textAlign':'center', 'paddingTop': '30px'},
                      React.DOM.div className: 'pmo-pic',
                        React.DOM.div className: 'p-relative',
                          React.DOM.a href: '',
                            React.DOM.img className: 'img-responsive', src: 'http://byrushan.com/projects/ma/1-6-1/jquery/dark/img/profile-pics/profile-pic-2.jpg'
                      React.DOM.div className: 'col-md-12', style: {'paddingTop': '20px'},
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p style: {'fontWeight':'600'}, 'Tên bệnh nhân'
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p null, 'Mallinda Hollaway'
                      React.DOM.div className: 'col-md-12',
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p style: {'fontWeight':'600'}, 'Tình trạng'
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p null, 'Chưa khám'
                      React.DOM.div className: 'col-md-12',
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p style: {'fontWeight':'600'}, 'Người khám'
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p null, 'Trần Minh Hoàng'
                      React.DOM.div className: 'col-md-12',
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p style: {'fontWeight':'600'}, 'Ngày bắt đầu'
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p null, '12/05/2016'
                      React.DOM.div className: 'col-md-12',
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p style: {'fontWeight':'600'}, 'Ngày kết thúc'
                        React.DOM.div className: 'col-md-6',
                          React.DOM.p null, '12/05/2016'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 15px 40px'},
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                React.DOM.div className: 'tab-content',
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-9', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.div className: 'tab-content-header',
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Quá trình bệnh lý'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.div className: 'tab-content-header', style: {'paddingTop': '40px'},
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Khám lâm sàng'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                    React.DOM.div className: 'col-md-3', style: {'textAlign':'center', 'paddingTop': '30px'},
                      React.DOM.div className: 'pmo-pic',
                        React.DOM.div className: 'p-relative',
                          React.DOM.a href: '',
                            React.DOM.img className: 'img-responsive', src: 'http://byrushan.com/projects/ma/1-6-1/jquery/dark/img/profile-pics/profile-pic-2.jpg'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.h4 null,
                        React.DOM.i className: 'fa fa-user'
                        ' Thông tin cá nhân'
                    React.DOM.div className: 'col-md-6', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Full Name'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'Mallinda Hollaway'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Gender'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'Nam'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Birthday'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'June 23, 1990'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Tuổi'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '26'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Phone Number'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '01290898923'
                    React.DOM.div className: 'col-md-6', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Địa chỉ'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '267 B Vĩnh Hưng, Hoàng Mai, Hà Nội'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Noid'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '01290898923'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Ngày cấp'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'June 23, 1990'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Nơi cấp'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, 'Hoàng Mai, Hà Nội'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.p style: {'fontWeight':'600'}, 'Nơi làm việc'
                      React.DOM.div className: 'col-md-8',
                        React.DOM.p null, '267 B Vĩnh Hưng, Hoàng Mai, Hà Nội'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'padding': '10px 40px 15px 40px'},
                      React.DOM.div className: 'tab-content-header', style: {'paddingTop': '40px'},
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Chuẩn đoán ban đầu'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.div className: 'tab-content-header', style: {'paddingTop': '40px'},
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Bệnh kèm theo'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.div className: 'tab-content-header', style: {'paddingTop': '40px'},
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Chuẩn đoán ICD'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                      React.DOM.div className: 'tab-content-header', style: {'paddingTop': '40px'},
                        React.DOM.h4 null,
                          React.DOM.i className: 'zmdi zmdi-equalizer'
                          ' Kết luận'
                      React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, 'Sed eu est vulputate, fringilla ligula ac, maximus arcu. Donec sed felis vel
                                        magna mattis ornare ut non turpis. Sed id arcu elit. Sed nec sagittis tortor.
                                        Mauris ante urna, ornare sit amet mollis eu, aliquet ac ligula. Nullam dolor
                                        metus, suscipit ac imperdiet nec, consectetur sed ex. Sed cursus porttitor leo.'
                React.DOM.div className: 'tab-content',
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 0px 40px'},
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
                      React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Close'
    employeeForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin nhân viên'
              React.DOM.small null, 'Description'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-7',
                  React.DOM.form autoComplete: 'off', className: 'form-horizontal', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label', 'Họ và Tên'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_ename', type: 'text', className: 'form-control', placeholder: 'Họ và tên'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label', 'Địa chỉ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label', 'Số ĐT'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_pnumber', type: 'number', className: 'form-control', placeholder: 'Số ĐT'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label', 'Số hiệu NV'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_noid', type: 'number', className: 'form-control', placeholder: 'Số hiệu NV'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label', 'Giới tính'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.select id: 'form_gender', className: 'form-control',
                          React.DOM.option value: '', 'Giới tính'
                          React.DOM.option value: '1', 'Nam'
                          React.DOM.option value: '2', 'Nữ'
                      React.DOM.label className: 'col-sm-3 control-label', 'Ảnh đại diện'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_avatar', type: 'file', className: 'form-control'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
                React.DOM.div className: 'col-md-5', style: {'alignContent': 'center'},
                  React.DOM.div id: 'results',
                    React.DOM.img id: 'sample_avatar', style: {'maxWidth': '100%', 'maxHeight': '240px'}, src: 'https://www.twomargins.com/images/noavatar.jpg'
                  React.DOM.div id: 'my_camera'
                  React.DOM.button type: 'button', className: 'btn btn-default', onClick: @setup_webcam, 'Setup'
                  React.DOM.button type: 'button', className: 'btn btn-default', value: 'take Large Snapshot', onClick: @take_snapshot, 'Capture'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    roomForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin phòng'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', autoComplete: 'off', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Tên phòng'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên phòng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Ngôn ngữ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_lang', type: 'text', className: 'form-control', placeholder: 'Ngôn ngữ', defaultValue: "vi"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Bản đồ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_map', type: 'file', className: 'form-control'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    positionForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin chức vụ'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label hidden-xs', 'Tên phòng'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_r_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_rname', className: 'form-control', type: 'text', code: 'rname', placeholder: 'Tên phòng', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'rname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'room_mini', header: [{id: 1,name: "Tên phòng"},{id: 2,name: "Ngôn ngữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Tên chức vụ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_pname', type: 'text', className: 'form-control', placeholder: 'Tên chức vụ'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Ngôn ngữ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_lang', type: 'text', className: 'form-control', placeholder: 'Ngôn ngữ', defaultValue: "vi"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Miêu tả ngắn'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.textarea id: 'form_description', type: 'text', className: 'form-control', placeholder: 'Miêu tả ngắn'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'File đính kèm'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_file', type: 'file', className: 'form-control',
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    serviceForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin dịch vụ'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', autoComplete: 'off', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Tên dịch vụ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_sname', type: 'text', className: 'form-control', placeholder: 'Tên dịch vụ'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label','Ngôn ngữ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_lang',type: 'text', className: 'form-control', placeholder: 'Ngôn ngữ', defaultValue: "vi"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Giá'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_price', type: 'number', className: 'form-control', placeholder: 'Giá'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Đơn vị tiền'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_currency', type: 'text', className: 'form-control', placeholder: 'Đơn vị tiền', defaultValue: "VND"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Mô tả ngắn'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_description', type: 'text', className: 'form-control', placeholder: 'Mô tả ngắn'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Logo'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_file', type: 'file', className: 'form-control'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button','Close'
    posmapForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu định chức vụ'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên nhân viên'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_e_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_ename', className: 'form-control', type: 'text', code: 'ename', placeholder: 'Tên nhân viên', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'ename'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'employee_mini', header: [{id: 1,name: "Mã nhân viên"},{id: 2, name: "Tên"},{id: 3, name: "Số điện thoại"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên chức vụ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_p_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_pname', className: 'form-control', type: 'text', code: 'pname', placeholder: 'Tên chức vụ', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'pname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'position_mini', header: [{id: 1,name: "Tên phòng"},{id: 2, name: "Tên chức vụ"},{id: 3, name: "Diễn giải"}], trigger: @triggerAutoComplete
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Đóng'
    sermapForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu định phòng cho dịch vụ'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label hidden-xs', 'Tên dịch vụ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_s_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sname', className: 'form-control', type: 'text', code: 'sname', placeholder: 'Tên dịch vụ', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'service_mini', header: [{id: 1,name: "Tên dịch vụ"},{id: 2, name: "Giá"},{id: 3, name: "Đơn vị"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label hidden-xs', 'Tên phòng'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'form_r_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_rname', className: 'form-control', type: 'text', code: 'rname', placeholder: 'Tên phòng', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'rname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'room_mini', header: [{id: 1,name: "Tên phòng"},{id: 2,name: "Ngôn ngữ"}], trigger: @triggerAutoComplete
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    customerForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin bệnh nhân'
              React.DOM.small null, 'Mời bạn điền vào các thông tin yêu cầu'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-7',
                  React.DOM.form className: 'form-horizontal', autoComplete: 'off', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Họ và Tên'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Họ và tên'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Ngày sinh'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_dob', type: 'text', className: 'form-control', placeholder: '31/01/1990'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Địa chỉ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Số ĐT'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_pnumber', type: 'number', className: 'form-control', placeholder: 'Số ĐT'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'CMTND'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_noid', type: 'number', className: 'form-control', placeholder: 'Số CMTND'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Nơi làm việc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_work_place', type: 'text', className: 'form-control', placeholder: 'Nơi làm việc'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Tiền sử bệnh bản thân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_self_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh bản thân'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Tiền sử bệnh gia đình'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_family_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh gia đình'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Tiền sử dị ứng thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_drug_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử dị ứng thuốc'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 hidden-xs control-label', 'Giới tính'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.select id: 'form_gender', className: 'form-control',
                          React.DOM.option value: '', 'Giới tính'
                          React.DOM.option value: '1', 'Nam'
                          React.DOM.option value: '2', 'Nữ'
                      React.DOM.label className: 'col-sm-2 hidden-xs control-label', 'Ảnh đại diện'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_avatar', type: 'file', className: 'form-control'
                    React.DOM.button onClick: @handleSubmitCustomerRecord, className: 'btn btn-default pull-right', 'Lưu'
                React.DOM.div className: 'col-md-5', style: {'alignContent': 'center'},
                  React.DOM.div id: 'results',
                    React.DOM.img id: 'sample_avatar', style: {'maxWidth': '100%', 'maxHeight': '240px'}, src: 'https://www.twomargins.com/images/noavatar.jpg'
                  React.DOM.div id: 'my_camera'
                  React.DOM.button type: 'button', className: 'btn btn-default', onClick: @setup_webcam, 'Setup'
                  React.DOM.button type: 'button', className: 'btn btn-default', value: 'take Large Snapshot', onClick: @take_snapshot, 'Capture'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    orderMapForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Bản ghi dịch vụ'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tình trạng hóa đơn dịch vụ'
                      React.DOM.div className: 'col-sm-5',
                        React.createElement SelectBox, id: 'form_status', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Chưa thanh toán, chưa khám bệnh'},{id: 2, name: 'Đã thanh toán, đang chờ khám'},{id: 3, name: 'Đã thanh toán, đã khám bệnh'},{id: 4, name: 'Chưa thanh toán, đã khám bệnh'}], text: 'Tình trạng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'cname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên dịch vụ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_s_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'sid'
                        React.createElement InputField, id: 'form_sname', className: 'form-control', type: 'text', code: 'sname', placeholder: 'Tên dịch vụ', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "sname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'sname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'service_mini', header: [{id: 1,name: "Tên dịch vụ"},{id: 2, name: "Giá"},{id: 3, name: "Đơn vị"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-8',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng giá trị'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_tpayment', className: 'form-control', type: 'number', placeholder: 'Tổng giá trị', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggersafe
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_discount', className: 'form-control', type: 'number', placeholder: 'Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', '% Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_discount_percent', className: 'form-control', type: 'number', step: 'any', placeholder: '% Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng thanh toán'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_tpayout', className: 'form-control', type: 'number', placeholder: 'Tổng thanh toán', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineSupplierForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin nguồn cấp thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên nguồn'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên nguồn'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người liên lạc'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_contact_name', type: 'text', className: 'form-control', placeholder: 'Tên người liên lạc'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT cố định'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_spnumber', type: 'number', className: 'form-control', placeholder: 'SĐT cố định'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT di động'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT di động'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 1'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_address1', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 1'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 2'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_address2', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 2'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 3'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_address3', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 3'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-email"
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-facebook-box"
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_facebook', type: 'text', className: 'form-control', placeholder: 'Facebook Link'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-twitter-box"
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_twitter', type: 'text', className: 'form-control', placeholder: 'Twitter Link'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số fax'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_fax', type: 'number', className: 'form-control', placeholder: 'Fax'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineCompanyForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin Doanh nghiệp sản xuất thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên doanh nghiệp'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên doanh nghiệp sản xuất'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Email'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-link"
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_website', type: 'text', className: 'form-control', placeholder: 'Website'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineSampleForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin Mẫu thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên thuốc'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Loại thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'form_typemedicine', records: @props.typemedicine, className: 'form-control', type: 4, text: ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhóm thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'form_groupmedicine', records: @props.groupmedicine, className: 'form-control', type: 4, text: ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_price', type: 'number', className: 'form-control', placeholder: 'Giá thuốc'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', "Ghi chú"
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', type: 'text', className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Khối lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_weight', type: 'number', className: 'form-control', placeholder: 'Khối lượng'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hạn sử dụng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_expire', type: 'number', className: 'form-control', placeholder: 'Hạn sử dụng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Tên nhà sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'company'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineBillInForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu hóa đơn nhập thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã hóa đơn'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_billcode', type: 'text', className: 'form-control', placeholder: 'Mã hóa đơn'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày nhập'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_dayin', type: 'text', className: 'form-control', placeholder: '30/01/1990'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày đặt hàng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_daybook', type: 'text', className: 'form-control', placeholder: '30/01/1990'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nguồn cung cấp'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_supplier_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_supplier', className: 'form-control', type: 'text', code: 'supplier', placeholder: 'Nguồn cung cấp', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'supplier'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_supplier_mini', header: [{id: 1,name: "Mã"},{id: 2, name: "Tên nguồn"},{id: 3, name: "Người liên lạc"},{id: 4, name: "Điện thoại"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Cách thanh toán'
                        React.DOM.div className: 'col-sm-3',
                          React.createElement SelectBox, id: 'form_pmethod', className: 'form-control', text: "Cách thanh toán", type: 4, records: [{id: 1, name: "Tiền mặt"},{id: 2, name: "Chuyển khoản"},{id: 3, name: "Khác"}]
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tình trạng hóa đơn'
                        React.DOM.div className: 'col-sm-3',
                          React.createElement SelectBox, id: 'form_status', className: 'form-control', text: "Tình trạng hóa đơn", type: 4, records: [{id: 1, name: "Lưu kho"},{id: 2, name: "Đang di chuyển"},{id: 3, name: "Trả lại"}]
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Tổng giá trị'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'form_tpayment', type: 'number', className: 'form-control', placeholder: 'Tổng giá trị', onBlur: @triggerRecalPayment
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Giảm giá'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'form_discount', type: 'number', className: 'form-control', placeholder: 'Giảm giá', onBlur: @triggerRecalPayment
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', '% Giảm giá'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'form_discount_percent', type: 'number', className: 'form-control', placeholder: '% Giảm giá', onBlur: @triggerRecalPayment
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Thanh toán'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'form_tpayout', type: 'number', className: 'form-control', placeholder: 'Thanh toán', onBlur: @triggerRecalPayment
                    React.DOM.div className: 'row',
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.div className: 'card-body table-responsive',
                          React.DOM.table className: 'table table-hover table-condensed',
                            React.DOM.thead null,
                              React.DOM.tr null,
                                React.DOM.th null, 'Số hiệu'
                                React.DOM.th null, 'Ký hiệu'
                                React.DOM.th null, 'Tên thuốc'
                                React.DOM.th null, 'Công ty sản xuất'
                                React.DOM.th null, 'Hạn sử dụng'
                                React.DOM.th null, 'Số lượng'
                                React.DOM.th null, '% thuế'
                                React.DOM.th null, 'Giá trên đơn vị'
                                React.DOM.th null, 'Ghi chú'
                                React.DOM.th null, 'Cách mua'
                            React.DOM.tbody null,
                              if @props.bill_record != null
                                for record in @props.bill_record
                                  if @state.selectRecordId != null
                                    if record.id == @state.selectRecordId
                                      React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: true, selectRecord: @selectRecord
                                    else
                                      React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: false, selectRecord: @selectRecord
                                  else
                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: false, selectRecord: @selectRecord
                      React.DOM.div className: 'col-sm-3',
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm', modalid: 'modalbillrecordmini', type: 5
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Lấy tổng giá', type: 3, code: 'bill_record', Clicked: @triggerSumChild
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Tải danh sách thuốc', type: 3, code: 'medicine_bill_record', Clicked: @refreshChildRecord
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineBillRecordForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc nhập kho'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã hóa đơn'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_billcode_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_billcode', className: 'form-control', type: 'text', code: 'billcode', placeholder: 'Mã hóa đơn', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'billcode'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_bill_in_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã hóa đơn"},{id: 2, name: "Ngày nhập"},{id: 3, name: "Người cung cấp"},{id: 4, name: "Tổng giá thanh toán"},{id: 5, name: "Cách thanh toán"},{id: 6, name: "Tình trạng"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Công ty sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'company'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Số hiệu'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_signid', type: 'text', className: 'form-control', placeholder: 'Ký hiệu'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hạn sử dụng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_expire', type: 'text', className: 'form-control', placeholder: '30/01/1990'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Cách mua'
                      React.DOM.div className: 'col-sm-1',
                        React.createElement SelectBox, id: 'form_pmethod', className: 'form-control', text: "Cách mua", type: 4, records: [{id: 1, name: "Hộp"},{id: 2, name: "Lẻ"}]
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_qty', type: 'number', className: 'form-control', placeholder: 'Số lượng'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_taxrate', type: 'number', className: 'form-control', placeholder: 'Thuế suất'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_price', type: 'number', className: 'form-control', placeholder: 'Biểu giá'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineBillRecordMiniForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc nhập kho'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmitMini, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Công ty sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'company'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Số hiệu'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_signid', type: 'text', className: 'form-control', placeholder: 'Ký hiệu'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hạn sử dụng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_expire', type: 'text', className: 'form-control', placeholder: '30/01/1990'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Cách mua'
                      React.DOM.div className: 'col-sm-1',
                        React.createElement SelectBox, id: 'form_pmethod', className: 'form-control', text: "Cách mua", type: 4, records: [{id: 1, name: "Hộp"},{id: 2, name: "Lẻ"}]
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_qty', type: 'number', className: 'form-control', placeholder: 'Số lượng'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_taxrate', type: 'number', className: 'form-control', placeholder: 'Thuế suất'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_price', type: 'number', className: 'form-control', placeholder: 'Biểu giá'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicinePriceForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin giá thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng ít nhất'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'form_minam', type: 'number', className: 'form-control', placeholder: 'Số lượng ít nhất'
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'form_price', type: 'text', className: 'form-control', placeholder: 'Giá'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicinePrescriptExternalForm: ->
      React.DOM.div className: 'modal fade', id: @props.id, style: {"overflow": "auto"},
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin đơn thuốc ngoài'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã đơn đơn thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_code', className: 'form-control', type: 'text', code: '', placeholder: 'Mã đơn thuốc', style: '', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'cname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bác sỹ kê đơn'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_e_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_ename', className: 'form-control', type: 'text', code: 'ename', placeholder: 'Tên nhân viên', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'ename'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'employee_mini', header: [{id: 1,name: "Mã nhân viên"},{id: 2, name: "Tên"},{id: 3, name: "Số điện thoại"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số khám bệnh'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'form_number_id', className: 'form-control', type: 'text', code: '', placeholder: 'Số khám bệnh', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày kê đơn'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'form_date', className: 'form-control', type: 'text', code: '', placeholder: '31/01/2016', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ mua thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'form_address', className: 'form-control', type: 'text', code: '', placeholder: 'Địa chỉ mua thuốc', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.div className: 'row',
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.div className: 'card-body table-responsive',
                          React.DOM.table className: 'table table-hover table-condensed',
                            React.DOM.thead null,
                              React.DOM.tr null,
                                React.DOM.th null, 'Mã đơn thuốc'
                                React.DOM.th null, 'Tên thuốc'
                                React.DOM.th null, 'Tên bệnh nhân'
                                React.DOM.th null, 'Liều lượng'
                                React.DOM.th null, 'Ghi chú'
                                React.DOM.th null, 'Công ty sản xuất'
                                React.DOM.th null, 'Giá'
                                React.DOM.th null, 'Tổng tiền'
                            React.DOM.tbody null,
                              if @props.external_record != null
                                for record in @props.external_record
                                  if @state.selectRecordId != null
                                    if record.id == @state.selected
                                      React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_external_record', selected: true, selectRecord: @selectRecord
                                    else
                                      React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_external_record', selected: false, selectRecord: @selectRecord
                                  else
                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_external_record', selected: false, selectRecord: @selectRecord
                      React.DOM.div className: 'col-sm-3',
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm', modalid: 'modalexternalrecordmini', type: 5
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Tải danh sách các thuốc trong đơn', type: 3, code: 'medicine_external_record', Clicked: @refreshChildRecord
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineExternalRecordForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc kê ngoài'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_script_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_script_code', className: 'form-control', type: 'text', code: 'script_ex', placeholder: 'Mã đơn thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "script_ex_autocomplete",
                          if @state.autoComplete != null and @state.code == 'script_ex'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_prescript_external_mini', header: [{id: 1,name: "Mã đơn thuốc"},{id: 2,name: "Tên bệnh nhân"},{id: 3, name: "Người kê"},{id: 4, name: "Ngày kê"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'cname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample_sell', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample_sell'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Công ty sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'company'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete    
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_amount', className: 'form-control', type: 'number', code: '', placeholder: 'Số lượng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_price', className: 'form-control', type: 'number', code: 'form_price', placeholder: 'Tên thuốc', style: '', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tổng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_total', className: 'form-control', type: 'number', code: '', placeholder: 'Tổng', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineExternalRecordMiniForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc kê ngoài'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmitMini, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample_sell', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample_sell'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Công ty sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'company'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete    
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_amount', className: 'form-control', type: 'number', code: '', placeholder: 'Số lượng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_price', className: 'form-control', type: 'number', code: 'form_price', placeholder: 'Tên thuốc', style: '', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tổng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_total', className: 'form-control', type: 'number', code: '', placeholder: 'Tổng', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicinePrescriptInternalForm: ->
      React.DOM.div className: 'modal fade', id: @props.id, style: {"overflow": "auto"},
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin đơn thuốc trong'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã đơn đơn thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_code', className: 'form-control', type: 'text', code: '', placeholder: 'Mã đơn thuốc', style: '', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'cname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bác sỹ kê đơn'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_e_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_ename', className: 'form-control', type: 'text', code: 'ename', placeholder: 'Tên nhân viên', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'ename'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'employee_mini', header: [{id: 1,name: "Mã nhân viên"},{id: 2, name: "Tên"},{id: 3, name: "Số điện thoại"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người chuẩn bị'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_e_p_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_epname', className: 'form-control', type: 'text', code: 'epname', placeholder: 'Tên người chuẩn bị thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'epname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'employee_mini', header: [{id: 1,name: "Mã nhân viên"},{id: 2, name: "Tên"},{id: 3, name: "Số điện thoại"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số khám bệnh'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'form_number_id', className: 'form-control', type: 'text', code: '', placeholder: 'Số khám bệnh', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày kê đơn'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'form_date', className: 'form-control', type: 'text', code: '', placeholder: '31/01/2016', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người thanh toán'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'form_payer', className: 'form-control', type: 'text', code: '', placeholder: 'Người thanh toán', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-8',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                      React.DOM.div className: 'col-md-4',
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Cách thanh toán'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement SelectBox, id: 'form_pmethod', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Tiền mặt'},{id: 2, name: 'Chuyển khoản'},{id: 3, name: 'Khác'}], text: 'Cách thanh toán'
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng giá trị'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_tpayment', className: 'form-control', type: 'number', placeholder: 'Tổng giá trị', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggersafe
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_discount', className: 'form-control', type: 'number', placeholder: 'Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', '% Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_discount_percent', className: 'form-control', type: 'number', placeholder: '% Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng thanh toán'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'form_tpayout', className: 'form-control', type: 'number', placeholder: 'Tổng thanh toán', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                    React.DOM.div className: 'row',
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.div className: 'card-body table-responsive',
                          React.DOM.table className: 'table table-hover table-condensed',
                            React.DOM.thead null,
                              React.DOM.tr null,
                                React.DOM.th null, 'Mã đơn thuốc'
                                React.DOM.th null, 'Tên thuốc'
                                React.DOM.th null, 'Tên bệnh nhân'
                                React.DOM.th null, 'Liều lượng'
                                React.DOM.th null, 'Ghi chú'
                                React.DOM.th null, 'Công ty sản xuất'
                                React.DOM.th null, 'Giá'
                                React.DOM.th null, 'Giảm giá'
                                React.DOM.th null, 'Tổng giá trị'
                                React.DOM.th null, 'Tình trạng'
                                React.DOM.th null, 'Số kiệu'
                                React.DOM.th null, 'Ký hiệu'
                            React.DOM.tbody null,
                              if @props.internal_record != null
                                for record in @props.internal_record
                                  if @state.selectRecordId != null
                                    if record.id == @state.selected
                                      React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_internal_record', selected: true, selectRecord: @selectRecord
                                    else
                                      React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_internal_record', selected: false, selectRecord: @selectRecord
                                  else
                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_internal_record', selected: false, selectRecord: @selectRecord
                      React.DOM.div className: 'col-sm-3',
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm', modalid: 'modalinternalrecordmini', type: 5
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Lấy tổng giá', type: 3, code: 'internal_record', Clicked: @triggerSumChild
                        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Tải danh sách các thuốc trong đơn', type: 3, code: 'medicine_internal_record', Clicked: @refreshChildRecord
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineInternalRecordForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc kê trong'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã đơn thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'form_script_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_script_code', className: 'form-control', type: 'text', code: 'script_in', placeholder: 'Mã đơn thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "script_in_autocomplete",
                          if @state.autoComplete != null and @state.code == 'script_in'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_prescript_internal_mini', header: [{id: 1,name: "Mã đơn thuốc"},{id: 2,name: "Tên bệnh nhân"},{id: 3, name: "Người kê"},{id: 4, name: "Ngày kê"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'cname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample_sell', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample_sell'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Công ty sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'company'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete    
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_noid', className: 'form-control', type: 'text', code: '', placeholder: 'Số hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_signid', className: 'form-control', type: 'text', code: '', placeholder: 'Ký hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tình trạng thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'form_status', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Đã chuyển hàng'},{id: 2, name: 'Chưa chuyển hàng'},{id: 3, name: 'Khác'}], text: 'Tình trạng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_amount', className: 'form-control', type: 'number', code: '', placeholder: 'Số lượng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_price', className: 'form-control', type: 'number', code: 'form_price', placeholder: 'Tên thuốc', style: '', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tổng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_tpayment', className: 'form-control', type: 'number', code: '', placeholder: 'Tổng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineInternalRecordMiniForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc kê trong'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmitMini, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample_sell', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample_sell'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Công ty sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'company'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete    
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_noid', className: 'form-control', type: 'text', code: '', placeholder: 'Số hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_signid', className: 'form-control', type: 'text', code: '', placeholder: 'Ký hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tình trạng thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'form_status', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Đã chuyển hàng'},{id: 2, name: 'Chưa chuyển hàng'},{id: 3, name: 'Khác'}], text: 'Tình trạng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_amount', className: 'form-control', type: 'number', code: '', placeholder: 'Số lượng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_price', className: 'form-control', type: 'number', code: 'form_price', placeholder: 'Giá thuốc', style: '', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tổng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_tpayment', className: 'form-control', type: 'number', code: '', placeholder: 'Tổng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineStockRecordForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin kho thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Trạng thái'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'form_typerecord', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Nhập'},{id: 2, name: 'Xuất'},{id: 3, name: 'Vô hiệu'}], text: 'Trạng thái'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã hóa đơn'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_billcode_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_billcode', className: 'form-control', type: 'text', code: 'billcode', placeholder: 'Mã hóa đơn', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'billcode'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_bill_in_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Mã hóa đơn"},{id: 2, name: "Ngày nhập"},{id: 3, name: "Người cung cấp"},{id: 4, name: "Tổng giá thanh toán"},{id: 5, name: "Cách thanh toán"},{id: 6, name: "Tình trạng"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã đơn thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_script_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_script_code', className: 'form-control', type: 'text', code: 'script_in', placeholder: 'Mã đơn thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "script_in_autocomplete",
                          if @state.autoComplete != null and @state.code == 'script_in'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_prescript_internal_mini', header: [{id: 1,name: "Mã đơn thuốc"},{id: 2,name: "Tên bệnh nhân"},{id: 3, name: "Người kê"},{id: 4, name: "Ngày kê"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'sample'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_noid', className: 'form-control', type: 'text', code: '', placeholder: 'Số hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_signid', className: 'form-control', type: 'text', code: '', placeholder: 'Ký hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hết hạn'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_expire', className: 'form-control', type: 'text', code: '', placeholder: 'Hết hạn', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên nhà cung cấp'
                      React.DOM.div className: 'col-sm-6',
                        React.DOM.input id: 'form_supplier_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_supplier', className: 'form-control', type: 'text', code: 'supplier', placeholder: 'Nguồn cung cấp', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'supplier'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_supplier_mini', header: [{id: 1,name: "Mã"},{id: 2, name: "Tên nguồn"},{id: 3, name: "Người liên lạc"},{id: 4, name: "Điện thoại"}], trigger: @triggerAutoComplete
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'form_amount', className: 'form-control', type: 'number', code: 'form_amount', placeholder: 'Số lượng', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    checkInfoForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Thông tin điều trị'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tình trạng'
                      React.DOM.div className: 'col-sm-5',
                        React.createElement SelectBox, id: 'form_status', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Chưa khám'},{id: 2, name: 'Đang khám'},{id: 3, name: 'Kết thúc khám'}], text: 'Tình trạng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'cname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bác sỹ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_e_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_ename', className: 'form-control', type: 'text', code: 'ename', placeholder: 'Tên nhân viên', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'ename'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'employee_mini', header: [{id: 1,name: "Mã nhân viên"},{id: 2, name: "Tên"},{id: 3, name: "Số điện thoại"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Kết luận'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_kluan', className: 'form-control', placeholder: 'Kết luận'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Chuẩn đoán'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_cdoan', className: 'form-control', placeholder: 'Chuẩn đoán'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hướng điều trị'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_hdieutri', className: 'form-control', placeholder: 'Hướng điều trị'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ngày bắt đầu'
                        React.DOM.div className: 'col-sm-3',
                          React.DOM.input id: 'form_daystart', type: 'text', className: 'form-control', placeholder: 'Ngày bắt đầu'
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ngày kết thúc'
                        React.DOM.div className: 'col-sm-3',
                          React.DOM.input id: 'form_dayend', type: 'text', className: 'form-control', placeholder: 'Ngày kết thúc'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    doctorCheckInfoForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Thông tin khám'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ngày khám'
                        React.DOM.div className: 'col-sm-4',
                          React.DOM.input id: 'form_daycheck', type: 'text', className: 'form-control', placeholder: 'Ngày khám'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'cname'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên bác sỹ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'form_e_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                        React.createElement InputField, id: 'form_ename', className: 'form-control', type: 'text', code: 'ename', placeholder: 'Tên nhân viên', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                        React.DOM.div className: "auto-complete",
                          if @state.autoComplete != null and @state.code == 'ename'
                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'employee_mini', header: [{id: 1,name: "Mã nhân viên"},{id: 2, name: "Tên"},{id: 3, name: "Số điện thoại"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Quá trình bệnh lý'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_qtbenhly', className: 'form-control', placeholder: 'Quá trình bệnh lý'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Khám lâm sàng'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_klamsang', className: 'form-control', placeholder: 'Khám lâm sàng'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhịp tim'
                        React.DOM.div className: 'col-sm-2',
                          React.DOM.input id: 'form_nhiptim', type: 'number', className: 'form-control', placeholder: 'Nhịp tim'
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhiệt độ'
                        React.DOM.div className: 'col-sm-2',
                          React.DOM.input id: 'form_nhietdo', type: 'number', className: 'form-control', placeholder: 'Nhiệt độ'
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhịp thở'
                        React.DOM.div className: 'col-sm-2',
                          React.DOM.input id: 'form_ntho', type: 'number', className: 'form-control', placeholder: 'Nhịp thở'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Huyết áp min'
                        React.DOM.div className: 'col-sm-1',
                          React.DOM.input id: 'form_hamin', type: 'number', className: 'form-control', placeholder: 'Huyết ap min'
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Huyết áp max'
                        React.DOM.div className: 'col-sm-1',
                          React.DOM.input id: 'form_hamax', type: 'number', className: 'form-control', placeholder: 'Huyết áp max'
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Cân nặng'
                        React.DOM.div className: 'col-sm-1',
                          React.DOM.input id: 'form_cnang', type: 'number', className: 'form-control', placeholder: 'Cân nặng'
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Chiều cao'
                        React.DOM.div className: 'col-sm-1',
                          React.DOM.input id: 'form_cao', type: 'number', className: 'form-control', placeholder: 'Chiều cao'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Chuẩn đoán ban đầu'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_cdbandau', className: 'form-control', placeholder: 'Chuẩn đoán ban đầu'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Bệnh kèm theo'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_bktheo', className: 'form-control', placeholder: 'Bệnh kèm theo'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Chuẩn đoán ICD'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_cdicd', className: 'form-control', placeholder: 'Chuẩn đoán ICD'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-12',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Kết luận'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'form_kluan', className: 'form-control', placeholder: 'Kết luận'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    deleteForm: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-sm',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row', style: {'textAlign': 'center'},
                React.DOM.h4 null, "Bạn có chắc chắn muốn xóa"
                React.DOM.br null
                React.DOM.button className: 'btn btn-default btn-fixed', 'data-dismiss': 'modal', type: 'button', 'Không'
                React.createElement ButtonGeneral, className: 'btn btn-default btn-fixed bg-teal', icon: 'fa fa-check', text: ' Đồng ý', type: 1, Clicked: @trigger
    render: ->
      if @props.datatype == 'doctor_room'
        @doctorRoomRender()
      else if @props.datatype == 'delete_form'
        @deleteForm()
      else if @props.datatype == 'employee'
        @employeeForm()
      else if @props.datatype == 'room'
        @roomForm()
      else if @props.datatype == 'position'
        @positionForm()
      else if @props.datatype == 'service'
        @serviceForm()
      else if @props.datatype == 'sermap'
        @sermapForm()
      else if @props.datatype == 'posmap'
        @posmapForm()
      else if @props.datatype == 'customer_record'
        @customerForm()
      else if @props.datatype == 'order_map'
        @orderMapForm()
      else if @props.datatype == 'medicine_supplier'
        @medicineSupplierForm()
      else if @props.datatype == 'medicine_company'
        @medicineCompanyForm()
      else if @props.datatype == 'medicine_sample'
        @medicineSampleForm()
      else if @props.datatype == 'medicine_bill_in'
        @medicineBillInForm()
      else if @props.datatype == 'medicine_bill_record'
        @medicineBillRecordForm()
      else if @props.datatype == 'medicine_bill_record_mini'
        @medicineBillRecordMiniForm()
      else if @props.datatype == 'medicine_price'
        @medicinePriceForm()
      else if @props.datatype == 'medicine_prescript_external'
        @medicinePrescriptExternalForm()
      else if @props.datatype == 'medicine_external_record'
        @medicineExternalRecordForm()
      else if @props.datatype == 'medicine_external_record_mini'
        @medicineExternalRecordMiniForm()
      else if @props.datatype == 'medicine_prescript_internal'
        @medicinePrescriptInternalForm()
      else if @props.datatype == 'medicine_internal_record'
        @medicineInternalRecordForm()
      else if @props.datatype == 'medicine_internal_record_mini'
        @medicineInternalRecordMiniForm()
      else if @props.datatype == 'medicine_stock_record'
        @medicineStockRecordForm()
      else if @props.datatype == 'check_info'
        @checkInfoForm()
      else if @props.datatype == 'doctor_check_info'
        @doctorCheckInfoForm()
      

  @TabNavCell = React.createClass
    getInitialState: ->
      type: 1
    trigger: ->
      @props.trigger @props.code
    normalRender: ->
      if @props.selected == @props.code
        React.DOM.div className: @props.className + ' active', onClick: @trigger, @props.text
      else
        React.DOM.div className: @props.className, onClick: @trigger, @props.text
    render: ->
      @normalRender()

  @TabContentCell = React.createClass
    getInitialState: ->
      editmode: false
    trigger: ->
      @props.trigger
    doctorRoom1Render: ->
      if @props.selected == @props.code and !@state.editmode and @props.record != null
        React.DOM.div className: 'tab-content active',
          React.DOM.div className: 'row',
            React.DOM.div className: 'col-md-9', style: {'padding': '40px 40px 0px 40px'},
              React.DOM.div className: 'tab-content-header',
                React.DOM.h4 null,
                  React.DOM.i className: 'zmdi zmdi-equalizer'
                  ' Tiểu sử bệnh'
              React.DOM.p style: {'paddingLeft': '20px', 'paddingTop': '20px'}, @props.record.self_history
              React.DOM.p style: {'paddingLeft': '20px'}, @props.record.family_history
              React.DOM.p style: {'paddingLeft': '20px'}, @props.record.drug_history
            React.DOM.div className: 'col-md-3', style: {'textAlign':'center', 'paddingTop': '30px'},
              React.DOM.div className: 'pmo-pic',
                React.DOM.div className: 'p-relative',
                  React.DOM.a href: '',
                    React.DOM.img className: 'img-responsive', src: @props.record.avatar
          React.DOM.div className: 'row',
            React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 0px 40px'},
              React.DOM.h4 null,
                React.DOM.i className: 'fa fa-user'
                ' Thông tin cá nhân'
              React.DOM.div className: 'col-md-6', style: {'padding': '40px 40px 0px 40px'},
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Full Name'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, 'Mallinda Hollaway'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Gender'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, 'Nam'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Birthday'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, 'June 23, 1990'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Tuổi'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, '26'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Phone Number'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, '01290898923'
              React.DOM.div className: 'col-md-6', style: {'padding': '40px 40px 0px 40px'},
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Địa chỉ'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, '267 B Vĩnh Hưng, Hoàng Mai, Hà Nội'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Noid'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, '01290898923'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Ngày cấp'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, 'June 23, 1990'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Nơi cấp'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, 'Hoàng Mai, Hà Nội'
                React.DOM.div className: 'col-md-4',
                  React.DOM.p style: {'fontWeight':'600'}, 'Nơi làm việc'
                React.DOM.div className: 'col-md-8',
                  React.DOM.p null, '267 B Vĩnh Hưng, Hoàng Mai, Hà Nội'
          React.DOM.div className: 'row',
            React.DOM.div className: 'col-md-12', style: {'padding': '40px 40px 15px 40px'},
              React.DOM.button className: 'btn btn-default pull-right', 'data-dismiss': 'modal', type: 'button', 'Đóng'
              React.createElement ButtonGeneral, className: 'btn btn-default pull-right', icon: 'fa fa-trash-o', text: ' Sửa', type: 1, Clicked: @trigger
              React.createElement ButtonGeneral, className: 'btn btn-default pull-right', icon: 'fa fa-trash-o', text: ' Thêm', type: 1, Clicked: @trigger
      else
        React.DOM.div className: 'tab-content'
    render: ->
      @doctorRoom1Render()