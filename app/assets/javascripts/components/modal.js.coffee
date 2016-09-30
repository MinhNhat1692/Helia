  @Modal = React.createClass
    getInitialState: ->
      #we have @props.prefix to know which is add form, which is edit form
      type: @props.type
      autoComplete: null
      code: null
    componentDidMount: ->
      $(ReactDOM.findDOMNode(this)).modal 'show'
      $(ReactDOM.findDOMNode(this)).on 'hidden.bs.modal', @props.handleHideModal
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
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      if @props.type == 'employee'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#employee_form_gender').val() == 'Giới tính'
            formdata.append 'gender', @props.record.gender
          else
            formData.append 'gender', $('#employee_form_gender').val()
        else
          formData.append 'gender', $('#employee_form_gender').val()
        formData.append 'ename', $('#employee_form_ename').val()
        formData.append 'address', $('#employee_form_address').val()
        formData.append 'pnumber', $('#employee_form_pnumber').val()
        formData.append 'noid', $('#employee_form_noid').val()
        if $('#employee_form_avatar')[0].files[0] != undefined
          formData.append 'avatar', $('#employee_form_avatar')[0].files[0]
        else if $('#webcamout').attr('src') != undefined
          formData.append 'avatar', $('#webcamout').attr('src')
      else if @props.type == 'customer_record'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#customer_form_gender').val() == "Giới tính"
            formData.append 'gender', @props.record.gender
          else
            formData.append 'gender', $('#customer_form_gender').val()
        else
          formData.append 'gender', $('#customer_form_gender').val()
        formData.append 'cname', $('#customer_form_name').val()
        formData.append 'dob', $('#customer_form_dob').val()
        formData.append 'address', $('#customer_form_address').val()
        formData.append 'pnumber', $('#customer_form_pnumber').val()
        formData.append 'noid', $('#customer_form_noid').val()
        if $('#customer_form_avatar')[0].files[0] != undefined
          formData.append 'avatar', $('#customer_form_avatar')[0].files[0]
        else if $('#webcamout').attr('src') != undefined
          formData.append 'avatar', $('#webcamout').attr('src')
      else if @props.type == 'room'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'name', $('#room_form_name').val()
        formData.append 'lang', $('#room_form_lang').val()
        if $('#room_form_map')[0].files[0] != undefined
          formData.append 'map', $('#room_form_map')[0].files[0]
      else if @props.type == 'position'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#position_form_room').val() == "Tên phòng"
            formData.append 'room', @props.record.room_id
          else
            formData.append 'room', $('#position_form_room').val()
        else
          formData.append 'room', $('#position_form_room').val()
        formData.append 'pname', $('#position_form_pname').val()
        formData.append 'lang', $('#position_form_lang').val()
        formData.append 'description', $('#position_form_description').val()
        if $('#position_form_file')[0].files[0] != undefined
          formData.append 'file', $('#position_form_file')[0].files[0]
      else if @props.type == 'position_mapping' # need fix
        if @props.record != null
          formData.append 'id', @props.record.id
          formData.append 'posmap', $('#position_set_p_id').val()
          $.ajax
            url: '/position_mapping'
            type: 'PUT'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @props.trigger result
              return
            ).bind(this)
      else if @props.type == 'service'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'sname', $('#service_form_sname').val()
        formData.append 'lang', $('#service_form_lang').val()
        formData.append 'price', $('#service_form_price').val()
        formData.append 'currency', $('#service_form_currency').val()
        formData.append 'description', $('#service_form_description').val()
        if $('#service_form_file')[0].files[0] != undefined
          formData.append 'file', $('#service_form_file')[0].files[0]
      else if @props.type == 'medicine_supplier'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'noid', $('#medicine_supplier_noid').val()
        formData.append 'name', $('#medicine_supplier_name').val()
        formData.append 'contactname', $('#medicine_supplier_contact_name').val()
        formData.append 'spnumber', $('#medicine_supplier_spnumber').val()
        formData.append 'pnumber', $('#medicine_supplier_pnumber').val()
        formData.append 'address1', $('#medicine_supplier_address1').val()
        formData.append 'address2', $('#medicine_supplier_address2').val()
        formData.append 'address3', $('#medicine_supplier_address3').val()
        formData.append 'email', $('#medicine_supplier_email').val()
        formData.append 'facebook', $('#medicine_supplier_facebook').val()
        formData.append 'twitter', $('#medicine_supplier_twitter').val()
        formData.append 'fax', $('#medicine_supplier_fax').val()
        formData.append 'taxcode', $('#medicine_supplier_taxcode').val()
      else if @props.type == 'medicine_company'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'noid', $('#medicine_company_noid').val()
        formData.append 'name', $('#medicine_company_name').val()
        formData.append 'pnumber', $('#medicine_company_pnumber').val()
        formData.append 'address', $('#medicine_company_address').val()
        formData.append 'email', $('#medicine_company_email').val()
        formData.append 'website', $('#medicine_company_website').val()
        formData.append 'taxcode', $('#medicine_company_taxcode').val()
      else if @props.type == 'medicine_sample'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#medicine_sample_typemedicine').val() == ""
            formData.append 'typemedicine', @props.record.typemedicine
          else
            formData.append 'typemedicine', $('#medicine_sample_typemedicine').val()
          if $('#medicine_sample_groupmedicine').val() == ""
            formData.append 'groupmedicine', @props.record.groupmedicine
          else
            formData.append 'groupmedicine', $('#medicine_sample_groupmedicine').val()
        else
          formData.append 'typemedicine', $('#medicine_sample_typemedicine').val()
          formData.append 'groupmedicine', $('#medicine_sample_groupmedicine').val()
        formData.append 'noid', $('#medicine_sample_noid').val()
        formData.append 'name', $('#medicine_sample_name').val()
        formData.append 'company', $('#medicine_sample_company').val()
        formData.append 'price', $('#medicine_sample_price').val()
        formData.append 'weight', $('#medicine_sample_weight').val()
        formData.append 'remark', $('#medicine_sample_remark').val()
        formData.append 'expire', $('#medicine_sample_expire').val()
      else if @props.type == 'medicine_bill_in'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#medicine_bill_in_pmethod').val() == "Cách thanh toán"
            formData.append 'pmethod', @props.record.pmethod
          else
            formData.append 'pmethod', $('#medicine_bill_in_pmethod').val()
          if $('#medicine_bill_in_status').val() == ""
            formData.append 'status', @props.record.status
          else
            formData.append 'status', $('#medicine_bill_in_status').val()
        else
          formData.append 'pmethod', $('#medicine_bill_in_pmethod').val()
          formData.append 'status', $('#medicine_bill_in_status').val()
        formData.append 'billcode', $('#medicine_bill_in_billcode').val()
        formData.append 'supplier', $('#medicine_bill_in_supplier').val()
        formData.append 'dayin', $('#medicine_bill_in_dayin').val()
        formData.append 'daybook', $('#medicine_bill_in_daybook').val()
        formData.append 'tpayment', $('#medicine_bill_in_tpayment').val()
        formData.append 'discount', $('#medicine_bill_in_discount').val()
        formData.append 'tpayout', $('#medicine_bill_in_tpayout').val()
        formData.append 'remark', $('#medicine_bill_in_remark').val()
      else if @props.type == 'medicine_bill_record'
        if @props.record != null
          formData.append 'id', @props.record.id
          if $('#medicine_bill_record_pmethod').val() == 'Cách mua'
            formData.append 'pmethod', @props.record.pmethod
          else
            formData.append 'pmethod', $('#medicine_bill_record_pmethod').val()
        else
          formData.append 'billcode', $('#medicine_bill_record_billcode').val()
          formData.append 'pmethod', $('#medicine_bill_record_pmethod').val()
        formData.append 'name', $('#medicine_bill_record_name').val()
        formData.append 'company', $('#medicine_bill_record_company').val()
        formData.append 'noid', $('#medicine_bill_record_noid').val()
        formData.append 'signid', $('#medicine_bill_record_signid').val()
        formData.append 'remark', $('#medicine_bill_record_remark').val()
        formData.append 'expire', $('#medicine_bill_record_expire').val()
        formData.append 'qty', $('#medicine_bill_record_qty').val()
        formData.append 'taxrate', $('#medicine_bill_record_taxrate').val()
        formData.append 'price', $('#medicine_bill_record_price').val()
      else if @props.type == 'medicine_price'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'name', $('#medicine_price_name').val()
        formData.append 'minam', $('#medicine_price_minam').val()
        formData.append 'price', $('#medicine_price_price').val()
        formData.append 'remark', $('#medicine_price_remark').val()
      else if @props.type == 'medicine_prescript_external'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'code', $('#medicine_prescript_external_code').val()
        formData.append 'customer_id', $('#medicine_prescript_external_customer_id').val()
        formData.append 'cname', $('#medicine_prescript_external_cname').val()
        formData.append 'employee_id', $('#medicine_prescript_external_employee_id').val()
        formData.append 'ename', $('#medicine_prescript_external_ename').val()
        formData.append 'result_id', $('#medicine_prescript_external_result_id').val()
        formData.append 'number_id', $('#medicine_prescript_external_number_id').val()
        formData.append 'date', $('#medicine_prescript_external_date').val()
        formData.append 'address', $('#medicine_prescript_external_address').val()
        formData.append 'remark', $('#medicine_prescript_external_remark').val()
      else if @props.type == 'medicine_external_record'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'name', $('#medicine_external_record_name').val()
        formData.append 'customer_id', $('#medicine_external_record_customer_id').val()
        formData.append 'cname', $('#medicine_external_record_cname').val()
        formData.append 'script_id', $('#medicine_external_record_script_id').val()
        formData.append 'remark', $('#medicine_external_record_remark').val()
        formData.append 'company', $('#medicine_external_record_company').val()
        formData.append 'amount', $('#medicine_external_record_amount').val()
        formData.append 'script_code', $('#medicine_external_record_script_code').val()
        formData.append 'price', $('#medicine_external_record_price').val()
        formData.append 'total', $('#medicine_external_record_total').val()
      else if @props.type == 'medicine_prescript_internal'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'code', $('#medicine_prescript_internal_code').val()
        formData.append 'customer_id', $('#medicine_prescript_internal_customer_id').val()
        formData.append 'cname', $('#medicine_prescript_internal_cname').val()
        formData.append 'employee_id', $('#medicine_prescript_internal_employee_id').val()
        formData.append 'ename', $('#medicine_prescript_internal_ename').val()
        formData.append 'result_id', $('#medicine_prescript_internal_result_id').val()
        formData.append 'number_id', $('#medicine_prescript_internal_number_id').val()
        formData.append 'date', $('#medicine_prescript_internal_date').val()
        formData.append 'preparer', $('#medicine_prescript_internal_preparer').val()
        formData.append 'remark', $('#medicine_prescript_internal_remark').val()
        formData.append 'payer', $('#medicine_prescript_internal_payer').val()
        formData.append 'tpayment', $('#medicine_prescript_internal_tpayment').val()
        formData.append 'discount', $('#medicine_prescript_internal_discount').val()
        formData.append 'tpayout', $('#medicine_prescript_internal_tpayout').val()
        formData.append 'pmethod', $('#medicine_prescript_internal_pmethod').val()
        formData.append 'preparer_id', $('#medicine_prescript_internal_preparer_id').val()
      else if @props.type == 'medicine_internal_record'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'name', $('#medicine_internal_record_name').val()
        formData.append 'customer_id', $('#medicine_internal_record_customer_id').val()
        formData.append 'cname', $('#medicine_internal_record_cname').val()
        formData.append 'script_id', $('#medicine_internal_record_script_id').val()
        formData.append 'remark', $('#medicine_internal_record_remark').val()
        formData.append 'company', $('#medicine_internal_record_company').val()
        formData.append 'amount', $('#medicine_internal_record_amount').val()
        formData.append 'script_code', $('#medicine_internal_record_script_code').val()
        formData.append 'price', $('#medicine_internal_record_price').val()
        formData.append 'discount', $('#medicine_internal_record_discount').val()
        formData.append 'tpayment', $('#medicine_internal_record_tpayment').val()
        formData.append 'noid', $('#medicine_internal_record_noid').val()
        formData.append 'signid', $('#medicine_internal_record_signid').val()
        formData.append 'status', $('#medicine_internal_record_status').val()
      else if @props.type == 'medicine_stock_record'
        if @props.record != null
          formData.append 'id', @props.record.id
        formData.append 'name', $('#medicine_stock_record_name').val()
        formData.append 'typerecord', $('#medicine_stock_record_typerecord').val()
        formData.append 'noid', $('#medicine_stock_record_noid').val()
        formData.append 'signid', $('#medicine_stock_record_signid').val()
        formData.append 'amount', $('#medicine_stock_record_amount').val()
        formData.append 'expire', $('#medicine_stock_record_expire').val()
        formData.append 'supplier', $('#medicine_stock_record_supplier').val()
        formData.append 'internal_record_id', $('#medicine_stock_record_internal_record_id').val()
        formData.append 'bill_in_id', $('#medicine_stock_record_bill_in_id').val()
        formData.append 'bill_in_code', $('#medicine_stock_record_bill_in_code').val()
        formData.append 'internal_record_code', $('#medicine_stock_record_internal_record_code').val()
        formData.append 'remark', $('#medicine_stock_record_remark').val()
      if @props.prefix == "add"
        $.ajax
          url: '/' + @props.type
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            @setState @getInitialState()
            return
          ).bind(this)
      else if @props.prefix == "edit"
        $.ajax
          url: '/' + @props.type
          type: 'PUT'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger2 @props.record, result
            return
          ).bind(this)
    triggerAutoCompleteInput: (e) ->
      if @state.type == 'medicine_sample'
        if $('#medicine_sample_company').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_sample_company').val().toLowerCase()
          $.ajax
            url: '/medicine_company/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
      else if @state.type == 'medicine_bill_in'
        if $('#medicine_bill_in_supplier').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_bill_in_supplier').val().toLowerCase()
          $.ajax
            url: '/medicine_supplier/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
      else if @state.type == 'medicine_bill_record'
        if $('#medicine_bill_record_name').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_bill_record_name').val().toLowerCase()
          $.ajax
            url: '/medicine_sample/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
      else if @state.type == 'medicine_price'
        if $('#medicine_price_name').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_price_name').val().toLowerCase()
          $.ajax
            url: '/medicine_sample/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
    triggerAutoCompleteInputAlt: (code) ->
      if code == 'medicine_prescript_external_cname'
        if $('#medicine_prescript_external_cname').val().length > 1
          formData = new FormData
          formData.append 'cname', $('#medicine_prescript_external_cname').val().toLowerCase()
          $.ajax
            url: '/customer_record/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: 'medicine_prescript_external_cname'
              return
            ).bind(this)
      else if code == 'medicine_prescript_external_ename'
        if $('#medicine_prescript_external_ename').val().length > 1
          formData = new FormData
          formData.append 'ename', $('#medicine_prescript_external_ename').val().toLowerCase()
          $.ajax
            url: '/employee/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: 'medicine_prescript_external_ename'
              return
            ).bind(this)
      else if code == 'medicine_external_record_script_code'
        if $('#medicine_external_record_script_code').val().length > 1
          formData = new FormData
          formData.append 'code', $('#medicine_external_record_script_code').val().toLowerCase()
          $.ajax
            url: '/medicine_prescript_external/search'
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
      else if code == 'medicine_external_record_name'
        if $('#medicine_external_record_name').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_external_record_name').val().toLowerCase()
          $.ajax
            url: '/medicine_sample/search'
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
      else if code == 'medicine_external_record_cname'
        if $('#medicine_external_record_cname').val().length > 1
          formData = new FormData
          formData.append 'cname', $('#medicine_external_record_cname').val().toLowerCase()
          $.ajax
            url: '/customer_record/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: 'medicine_external_record_cname'
              return
            ).bind(this)
      else if code == 'medicine_external_record_price'
        if $('#medicine_external_record_name').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_external_record_name').val().toLowerCase()
          $.ajax
            url: '/medicine_price/search'
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
      else if code == 'medicine_prescript_internal_cname'
        if $('#medicine_prescript_internal_cname').val().length > 1
          formData = new FormData
          formData.append 'cname', $('#medicine_prescript_internal_cname').val().toLowerCase()
          $.ajax
            url: '/customer_record/search'
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
      else if code == 'medicine_prescript_internal_ename'
        if $('#medicine_prescript_internal_ename').val().length > 1
          formData = new FormData
          formData.append 'ename', $('#medicine_prescript_internal_ename').val().toLowerCase()
          $.ajax
            url: '/employee/search'
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
      else if code == 'medicine_prescript_internal_preparer'
        if $('#medicine_prescript_internal_preparer').val().length > 1
          formData = new FormData
          formData.append 'ename', $('#medicine_prescript_internal_preparer').val().toLowerCase()
          $.ajax
            url: '/employee/search'
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
      else if code == 'medicine_internal_record_script_code'
        if $('#medicine_internal_record_script_code').val().length > 1
          formData = new FormData
          formData.append 'code', $('#medicine_internal_record_script_code').val().toLowerCase()
          $.ajax
            url: '/medicine_prescript_internal/search'
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
      else if code == 'medicine_internal_record_name'
        if $('#medicine_internal_record_name').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_internal_record_name').val().toLowerCase()
          $.ajax
            url: '/medicine_sample/search'
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
      else if code == 'medicine_internal_record_cname'
        if $('#medicine_internal_record_cname').val().length > 1
          formData = new FormData
          formData.append 'cname', $('#medicine_internal_record_cname').val().toLowerCase()
          $.ajax
            url: '/customer_record/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState
                autoComplete: result
                code: 'medicine_internal_record_cname'
              return
            ).bind(this)
      else if code == 'medicine_internal_record_price'
        if $('#medicine_internal_record_name').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_internal_record_name').val().toLowerCase()
          $.ajax
            url: '/medicine_price/search'
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
      else if code == 'medicine_stock_record_name'
        if $('#medicine_stock_record_name').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_stock_record_name').val().toLowerCase()
          $.ajax
            url: '/medicine_sample/search'
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
      else if code == 'medicine_stock_record_supplier'
        if $('#medicine_stock_record_supplier').val().length > 1
          formData = new FormData
          formData.append 'name', $('#medicine_stock_record_supplier').val().toLowerCase()
          $.ajax
            url: '/medicine_supplier/search'
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
      else if code == 'order_map_cname'
        if $('#order_map_cname').val().length > 1
          formData = new FormData
          formData.append 'cname', $('#order_map_cname').val().toLowerCase()
          $.ajax
            url: '/customer/search'
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
      else if code == 'order_map_sername'
        if $('#order_map_sername').val().length > 1
          formData = new FormData
          formData.append 'sname', $('#order_map_sername').val().toLowerCase()
          $.ajax
            url: '/service/search'
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
      else if code == 'position_set_pname'
        if $('#position_set_pname').val().length > 1
          formData = new FormData
          formData.append 'pname', $('#position_set_pname').val().toLowerCase()
          $.ajax
            url: '/position/search'
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
      if @state.type == 'medicine_sample'
        $('#medicine_sample_company').val(record.name)
        @setState autoComplete: null
      else if @state.type == 'medicine_bill_in'
        $('#medicine_bill_in_supplier').val(record.name)
        @setState autoComplete: null
      else if @state.type == 'medicine_bill_record'
        $('#medicine_bill_record_name').val(record.name)
        $('#medicine_bill_record_company').val(record.company)
        @setState autoComplete: null
      else if @state.type == 'medicine_price'
        $('#medicine_price_name').val(record.name)
        @setState autoComplete: null
      if @state.code == 'medicine_prescript_external_cname'
        $('#medicine_prescript_external_customer_id').val(record.id)
        $('#medicine_prescript_external_cname').val(record.cname)
        @setState autoComplete: null
      else if @state.code == 'medicine_prescript_external_ename'
        $('#medicine_prescript_external_employee_id').val(record.id)
        $('#medicine_prescript_external_ename').val(record.ename)
        @setState autoComplete: null
      else if @state.code == 'medicine_external_record_script_code'
        $('#medicine_external_record_script_id').val(record.id)
        $('#medicine_external_record_script_code').val(record.code)
        $('#medicine_external_record_customer_id').val(record.customer_id)
        $('#medicine_external_record_cname').val(record.cname)
        @setState autoComplete: null
      else if @state.code == 'medicine_external_record_name'
        $('#medicine_external_record_name').val(record.name)
        $('#medicine_external_record_company').val(record.company)
        @setState autoComplete: null
      else if @state.code == 'medicine_external_record_cname'
        $('#medicine_external_record_customer_id').val(record.id)
        $('#medicine_external_record_cname').val(record.cname)
        @setState autoComplete: null
      else if @state.code == 'medicine_external_record_price'
        $('#medicine_external_record_price').val(record.price)
        @triggerRecalPayment()
        @setState autoComplete: null
      else if @state.code == 'medicine_prescript_internal_cname'
        $('#medicine_prescript_internal_customer_id').val(record.id)
        $('#medicine_prescript_internal_cname').val(record.cname)
        @setState autoComplete: null
      else if @state.code == 'medicine_prescript_internal_ename'
        $('#medicine_prescript_internal_employee_id').val(record.id)
        $('#medicine_prescript_internal_ename').val(record.ename)
        @setState autoComplete: null
      else if @state.code == 'medicine_prescript_internal_preparer'
        $('#medicine_prescript_internal_preparer_id').val(record.id)
        $('#medicine_prescript_internal_preparer').val(record.ename)
        @setState autoComplete: null
      else if @state.code == 'medicine_internal_record_script_code'
        $('#medicine_internal_record_script_id').val(record.id)
        $('#medicine_internal_record_script_code').val(record.code)
        $('#medicine_internal_record_customer_id').val(record.customer_id)
        $('#medicine_internal_record_cname').val(record.cname)
        @setState autoComplete: null
      else if @state.code == 'medicine_internal_record_name'
        $('#medicine_internal_record_name').val(record.name)
        $('#medicine_internal_record_company').val(record.company)
        @setState autoComplete: null
      else if @state.code == 'medicine_internal_record_cname'
        $('#medicine_internal_record_customer_id').val(record.id)
        $('#medicine_internal_record_cname').val(record.cname)
        @setState autoComplete: null
      else if @state.code == 'medicine_internal_record_price'
        $('#medicine_internal_record_price').val(record.price)
        @triggerRecalPayment()
        @setState autoComplete: null
      else if @state.code == 'medicine_stock_record_name'
        $('#medicine_stock_record_name').val(record.name)
        $('#medicine_stock_record_company').val(record.company)
        @setState autoComplete: null
      else if @state.code == 'medicine_stock_record_supplier'
        $('#medicine_stock_record_supplier').val(record.name)
        @setState autoComplete: null
      else if @state.code == 'position_set_pname'
        $('#position_set_p_id').val(record.id)
        $('#position_set_pname').val(record.pname)
        @setState autoComplete: null
    triggerRecalPayment: (e) ->
      if @state.type == 'medicine_bill_in'
        if $('#medicine_bill_in_tpayment').val() > 0
          if $('#medicine_bill_in_discount').val() > 0
            $('#medicine_bill_in_discount_percent').val(Number($('#medicine_bill_in_discount').val())/Number($('#medicine_bill_in_tpayment').val())*100)
            $('#medicine_bill_in_tpayout').val(Number($('#medicine_bill_in_tpayment').val()) - Number($('#medicine_bill_in_discount').val()))
          else
            if $('#medicine_bill_in_discount_percent').val() > 0
              $('#medicine_bill_in_discount').val(Number($('#medicine_bill_in_discount_percent').val()) * Number($('#medicine_bill_in_tpayment').val()) / 100)
              $('#medicine_bill_in_tpayout').val(Number($('#medicine_bill_in_tpayment').val()) - Number($('#medicine_bill_in_discount').val()))
            else
              $('#medicine_bill_in_tpayout').val(Number($('#medicine_bill_in_tpayment').val()) - Number($('#medicine_bill_in_discount').val()))
      if @state.type == 'medicine_external_record'
        $('#medicine_external_record_total').val(Number($('#medicine_external_record_price').val()) * Number($('#medicine_external_record_amount').val()))
      if @state.type == 'medicine_prescript_internal'
        if $('#medicine_prescript_internal_tpayment').val() > 0
          if $('#medicine_prescript_internal_discount').val() > 0
            $('#medicine_prescript_internal_discount_percent').val(Number($('#medicine_prescript_internal_discount').val())/Number($('#medicine_prescript_internal_tpayment').val())*100)
            $('#medicine_prescript_internal_tpayout').val(Number($('#medicine_prescript_internal_tpayment').val()) - Number($('#medicine_prescript_internal_discount').val()))
          else
            if $('#medicine_prescript_internal_discount_percent').val() > 0
              $('#medicine_prescript_internal_discount').val(Number($('#medicine_prescript_internal_discount_percent').val()) * Number($('#medicine_prescript_internal_tpayment').val()) / 100)
              $('#medicine_prescript_internal_tpayout').val(Number($('#medicine_prescript_internal_tpayment').val()) - Number($('#medicine_prescript_internal_discount').val()))
            else
              $('#medicine_prescript_internal_tpayout').val(Number($('#medicine_prescript_internal_tpayment').val()) - Number($('#medicine_prescript_internal_discount').val()))
      if @state.type == 'medicine_internal_record'
        $('#medicine_internal_record_tpayment').val(Number($('#medicine_internal_record_price').val()) * Number($('#medicine_internal_record_amount').val()))
    trigger: (e) ->
    employeeForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin nhân viên'
              React.DOM.small null, 'Description'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-7',
                  React.DOM.form id: 'employee_form', autoComplete: 'off', className: 'form-horizontal', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Họ và Tên'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'employee_form_ename', type: 'text', className: 'form-control', placeholder: 'Họ và tên', defaultValue:
                          if @props.record != null
                            @props.record.ename
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Địa chỉ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'employee_form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ', name: 'address', defaultValue:
                          if @props.record != null
                            @props.record.address
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Số ĐT'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'employee_form_pnumber', type: 'number', className: 'form-control', placeholder: 'Số ĐT', name: 'pnumber', defaultValue:
                          if @props.record != null
                            @props.record.pnumber
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'CMTND'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'employee_form_noid', type: 'number', className: 'form-control', placeholder: 'Số hiệu NV',  defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-3 control-label', 'Giới tính'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.select id: 'employee_form_gender', className: 'form-control',
                          React.DOM.option value: '', 'Giới tính'
                          React.DOM.option value: '1', 'Nam'
                          React.DOM.option value: '2', 'Nữ'
                      React.DOM.label className: 'col-sm-3 control-label', 'Ảnh đại diện'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'employee_form_avatar', type: 'file', className: 'form-control',
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
                React.DOM.div className: 'col-md-5', style: {'alignContent': 'center'},
                  React.DOM.div id: 'results',
                    React.DOM.img style: {'maxWidth': '100%', 'maxHeight': '240px'}, src:
                      if @props.record != null
                        if @props.record.avatar != "/avatars/original/missing.png"
                          @props.record.avatar
                        else
                          'https://www.twomargins.com/images/noavatar.jpg'
                      else
                        'https://www.twomargins.com/images/noavatar.jpg'
                  React.DOM.div id: 'my_camera',
                  React.DOM.button type: 'button', className: 'btn btn-default', onClick: @setup_webcam, 'Setup'
                  React.DOM.button type: 'button', className: 'btn btn-default', value: 'take Large Snapshot', onClick: @take_snapshot, 'Capture'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    customerForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Customer Record Form'
              React.DOM.small null, 'Description'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-7',
                  React.DOM.p null, 'Detail for this modal - short'
                  React.DOM.form id: 'customer_record_form', className: 'form-horizontal', autoComplete: 'off', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label', 'Họ và Tên'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'customer_form_name', type: 'text', className: 'form-control', placeholder: 'Họ và tên', defaultValue:
                          if @props.record != null
                            @props.record.cname
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label', 'Ngày sinh'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'customer_form_dob', type: 'text', className: 'form-control', placeholder: '31/01/1990', defaultValue:
                          if @props.record != null
                            @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label', 'Địa chỉ'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'customer_form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ', defaultValue:
                          if @props.record != null
                            @props.record.address
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label', 'Số ĐT'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'customer_form_pnumber', type: 'number', className: 'form-control', placeholder: 'Số ĐT', defaultValue:
                          if @props.record != null
                            @props.record.pnumber
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label', 'CMTND'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'customer_form_noid', type: 'number', className: 'form-control', placeholder: 'Số CMTND', defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label', 'Giới tính'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.select id: 'customer_form_gender', className: 'form-control',
                          React.DOM.option value: '', 'Giới tính'
                          React.DOM.option value: '1', 'Nam'
                          React.DOM.option value: '2', 'Nữ'
                      React.DOM.label className: 'col-sm-2 control-label', 'Ảnh đại diện'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'customer_form_avatar', type: 'file', className: 'form-control'
                    React.DOM.button onClick: @handleSubmitCustomerRecord, className: 'btn btn-default pull-right', 'Lưu'
                React.DOM.div className: 'col-md-5', style: {'alignContent': 'center'},
                  React.DOM.div id: 'results',
                    React.DOM.img style: {'maxWidth': '100%', 'maxHeight': '240px'}, src:
                      if @props.record != null
                        if @props.record.avatar != "/avatars/original/missing.png"
                          @props.record.avatar
                        else
                          'https://www.twomargins.com/images/noavatar.jpg'
                      else
                        'https://www.twomargins.com/images/noavatar.jpg'
                  React.DOM.div id: 'my_camera',
                  React.DOM.button type: 'button', className: 'btn btn-default', onClick: @setup_webcam, 'Setup'
                  React.DOM.button type: 'button', className: 'btn btn-default', value: 'take Large Snapshot', onClick: @take_snapshot, 'Capture'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    orderMapForm: ->
      React.DOM.div className: 'modal fade',
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
                      React.DOM.div className: 'col-sm-3',
                        React.createElement SelectBox, id: 'order_map_status', className: 'form-control', Change: @trigger, blurOut: @trigger, records: [{id: 1, name: 'Đã thanh toán'},{id: 2, name: 'Chưa thanh toán'},{id: 3, name: 'Khác'}], text: 'Tình trạng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'order_map_customer_record_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue:
                          if @props.record != null
                            @props.record.customer_record_id
                          else
                            if @props.customer != null
                              @props.customer.id
                            else
                              ""
                        React.createElement InputField, id: 'order_map_cname_code', className: 'form-control', type: 'text', code: 'order_map_customer_code', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.cname
                          else
                            if @props.customer != null
                              @props.customer.cname
                            else
                              ""
                        React.DOM.div className: "auto-complete", id: "oorder_map_cname_code_autocomplete",
                          if @state.autoComplete != null and @state.code == 'order_map_cname_code'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, record: recordsearch, trigger: @triggerAutoComplete, text:
                                if recordsearch.dob != null
                                  recordsearch.cname + "," + recordsearch.dob.substring(8, 10) + "/" + recordsearch.dob.substring(5, 7) + "/" + recordsearch.dob.substring(0, 4)
                                else
                                  recordsearch.cname
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên dịch vụ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'order_map_service_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'cid', defaultValue:
                          if @props.record != null
                            @props.record.service_id
                          else
                            if @props.service != null
                              @props.service.id
                            else  
                              ""
                        React.createElement InputField, id: 'order_map_sername', className: 'form-control', type: 'text', code: 'order_map_sername', placeholder: 'Tên dịch vụ', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.sername
                          else
                            if @props.service != null
                              @props.service.sname
                            else
                              ""
                        React.DOM.div className: "auto-complete", id: "order_map_sername_autocomplete",
                          if @state.autoComplete != null and @state.code == 'order_map_sername'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.sname, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tình trạng thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'order_map_status', className: 'form-control', Change: @trigger, blurOut: @trigger, records: [{id: 1, name: 'Đã chuyển hàng'},{id: 2, name: 'Chưa chuyển hàng'},{id: 3, name: 'Khác'}], text: 'Tình trạng'
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-8',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'order_map_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                            if @props.record != null
                              @props.record.remark
                            else
                              ''
                      React.DOM.div className: 'col-md-4',
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng giá trị'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'order_map_tpayment', className: 'form-control', type: 'number', placeholder: 'Tổng giá trị', trigger: @trigger, trigger3: @trigger, trigger2: @trigger, defaultValue:
                            if @props.record != null
                              @props.record.tpayment
                            else
                              0
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'order_map_discount', className: 'form-control', type: 'number', placeholder: 'Giảm giá', trigger: @trigger, trigger3: @trigger, trigger2: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.discount
                            else
                              0
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', '% Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'order_map_discount_percent', className: 'form-control', type: 'number', placeholder: '% Giảm giá', trigger: @trigger, trigger3: @trigger, trigger2: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.discount/@props.record.tpayment * 100
                            else
                              0
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng thanh toán'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'order_map_tpayout', className: 'form-control', type: 'number', placeholder: 'Tổng thanh toán', trigger: @trigger, trigger3: @trigger, trigger2: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.tpayout
                            else
                              0
                    React.DOM.button
                      type: 'submit'
                      className: 'btn btn-default pull-right'
                      'Lưu'
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                className: 'btn btn-default'
                'data-dismiss': 'modal'
                type: 'button'
                'Close' 
    roomForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin phòng'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form id: 'employee_form', className: 'form-horizontal', autoComplete: 'off', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Tên phòng'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'room_form_name', type: 'text', className: 'form-control', placeholder: 'Tên phòng', defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Ngôn ngữ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'room_form_lang', type: 'text', className: 'form-control', placeholder: 'Ngôn ngữ', defaultValue:
                          if @props.record != null
                            @props.record.lang
                          else
                            "vi"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Bản đồ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'room_form_map', type: 'file', className: 'form-control'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    positionForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin chức vụ'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form id: 'position_form', className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Tên phòng'
                      React.DOM.div className: 'col-sm-8',
                        React.createElement SelectBox, records: @props.extra, type: 1, id: 'position_form_room', text: 'Tên phòng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Tên chức vụ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'position_form_pname', type: 'text', className: 'form-control', placeholder: 'Tên chức vụ', defaultValue:
                          if @props.record != null
                            @props.record.pname
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Ngôn ngữ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'position_form_lang', type: 'text', className: 'form-control', placeholder: 'Ngôn ngữ', defaultValue:
                          if @props.record != null
                            @props.record.lang
                          else
                            "vi"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Miêu tả ngắn'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.textarea id: 'position_form_description', type: 'text', className: 'form-control', placeholder: 'Miêu tả ngắn', defaultValue:
                          if @props.record != null
                            @props.record.description
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'File đính kèm'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'position_form_file', type: 'file', className: 'form-control',
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    positionSetForm: ->
      React.DOM.div className: 'modal fade',
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
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhân viên'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'position_set_ename', className: 'form-control disabled', type: 'text', code: 'medicine_stock_record_name', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.ename
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên chức vụ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'position_set_p_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue: ""
                        React.createElement InputField, id: 'position_set_pname', className: 'form-control', type: 'text', code: 'position_set_pname', placeholder: 'Tên chức vụ', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:""
                        React.DOM.div className: "auto-complete", id: "position_set_pname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'position_set_pname'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.pname, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.button
                      type: 'submit'
                      className: 'btn btn-default pull-right'
                      'Lưu'
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                className: 'btn btn-default'
                'data-dismiss': 'modal'
                type: 'button'
                'Close'
    serviceForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin dịch vụ'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form id: 'employee_form', className: 'form-horizontal', autoComplete: 'off', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Tên dịch vụ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'service_form_sname', type: 'text', className: 'form-control', placeholder: 'Tên dịch vụ', defaultValue:
                          if @props.record != null
                            @props.record.sname
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label','Ngôn ngữ'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'service_form_lang',type: 'text', className: 'form-control', placeholder: 'Ngôn ngữ', name: 'lang', defaultValue:
                          if @props.record != null
                            @props.record.lang
                          else
                            "vi"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Giá'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'service_form_price', type: 'number', className: 'form-control', placeholder: 'Giá', name: 'price', defaultValue:
                          if @props.record != null
                            @props.record.price
                          else
                            "0"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Đơn vị tiền'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'service_form_currency', type: 'text', className: 'form-control', placeholder: 'Đơn vị tiền', name: 'currency', defaultValue:
                          if @props.record != null
                            @props.record.currency
                          else
                            "VND"
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Mô tả ngắn'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'service_form_description', type: 'text', className: 'form-control', placeholder: 'Mô tả ngắn', defaultValue:
                          if @props.record != null
                            @props.record.description
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-4 control-label', 'Logo'
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.input id: 'service_form_file', type: 'file', className: 'form-control'
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button','Close'
    medicineSupplierForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin nguồn cấp thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_supplier_noid', type: 'text', className: 'form-control', placeholder: 'Mã số', defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên nguồn'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_supplier_name', type: 'text', className: 'form-control', placeholder: 'Tên nguồn', defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người liên lạc'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_supplier_contact_name', type: 'text', className: 'form-control', placeholder: 'Tên nguồn', defaultValue:
                          if @props.record != null
                            @props.record.contactname
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT cố định'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_supplier_spnumber', type: 'number', className: 'form-control', placeholder: 'SĐT cố định', defaultValue:
                          if @props.record != null
                            @props.record.spnumber
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT di động'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_supplier_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT di động', defaultValue:
                          if @props.record != null
                            @props.record.pnumber
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 1'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_supplier_address1', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 1', defaultValue:
                          if @props.record != null
                            @props.record.address1
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 2'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_supplier_address2', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 2', defaultValue:
                          if @props.record != null
                            @props.record.address2
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 3'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_supplier_address3', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 3', defaultValue:
                          if @props.record != null
                            @props.record.address3
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-1 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-email"
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'medicine_supplier_email', type: 'text', className: 'form-control', placeholder: 'Email', defaultValue:
                          if @props.record != null
                            @props.record.email
                          else
                            ""
                      React.DOM.label className: 'col-sm-1 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-facebook-box"
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'medicine_supplier_facebook', type: 'text', className: 'form-control', placeholder: 'Facebook Link', defaultValue:
                          if @props.record != null
                            @props.record.facebook
                          else
                            ""
                      React.DOM.label className: 'col-sm-1 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-twitter-box"
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'medicine_supplier_twitter', type: 'text', className: 'form-control', placeholder: 'Twitter Link', defaultValue:
                          if @props.record != null
                            @props.record.twitter
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số fax'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_supplier_fax', type: 'number', className: 'form-control', placeholder: 'Fax', defaultValue:
                          if @props.record != null
                            @props.record.fax
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_supplier_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế', defaultValue:
                          if @props.record != null
                            @props.record.taxcode
                          else
                            ""
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineCompanyForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin Doanh nghiệp sản xuất thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_company_noid', type: 'text', className: 'form-control', placeholder: 'Mã số', defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên doanh nghiệp'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'medicine_company_name', type: 'text', className: 'form-control', placeholder: 'Tên doanh nghiệp sản xuất', defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_company_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT', defaultValue:
                          if @props.record != null
                            @props.record.pnumber
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Email'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_company_email', type: 'text', className: 'form-control', placeholder: 'Email', defaultValue:
                          if @props.record != null
                            @props.record.email
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_company_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ', defaultValue:
                          if @props.record != null
                            @props.record.address
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                        React.DOM.i className: "zmdi zmdi-link"
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_company_website', type: 'text', className: 'form-control', placeholder: 'Website', defaultValue:
                          if @props.record != null
                            @props.record.website
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_company_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế', defaultValue:
                          if @props.record != null
                            @props.record.taxcode
                          else
                            ""
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineSampleForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin Mẫu thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_sample_noid', type: 'text', className: 'form-control', placeholder: 'Mã số', defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-10',
                        React.DOM.input id: 'medicine_sample_name', type: 'text', className: 'form-control', placeholder: 'Tên thuốc', defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Loại thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'medicine_sample_typemedicine', records: @props.extra[2], className: 'form-control', type: 4, text: ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhóm thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'medicine_sample_groupmedicine', records: @props.extra[1], className: 'form-control', type: 4, text: ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_sample_price', type: 'number', className: 'form-control', placeholder: 'Giá thuốc', defaultValue:
                          if @props.record != null
                            @props.record.price
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', "Ghi chú"
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'medicine_sample_remark', type: 'text', className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                          if @props.record != null
                            @props.record.remark
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Khối lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_sample_weight', type: 'number', className: 'form-control', placeholder: 'Khối lượng', defaultValue:
                          if @props.record != null
                            @props.record.weight
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hạn sử dụng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_sample_expire', type: 'number', className: 'form-control', placeholder: 'Hạn sử dụng', defaultValue:
                          if @props.record != null
                            @props.record.expire
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_sample_company', type: 'text', className: 'form-control', placeholder: 'Công ty sản xuất', onChange: @triggerAutoCompleteInput, defaultValue:
                          if @props.record != null
                            @props.record.company
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_sample_company_autocomplete",
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button, className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineBillInForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu hóa đơn nhập thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã hóa đơn'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_bill_in_billcode', type: 'text', className: 'form-control', placeholder: 'Mã hóa đơn', defaultValue:
                          if @props.record != null
                            @props.record.billcode
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày nhập'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_bill_in_dayin', type: 'text', className: 'form-control', placeholder: '30/01/1990', defaultValue:
                          if @props.record != null
                            if @props.record.dayin != null
                              @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
                            else
                              ""
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày đặt hàng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_bill_in_daybook', type: 'text', className: 'form-control', placeholder: '30/01/1990', defaultValue:
                          if @props.record != null
                            if @props.record.daybook != null
                              @props.record.daybook.substring(8, 10) + "/" + @props.record.daybook.substring(5, 7) + "/" + @props.record.daybook.substring(0, 4)
                            else
                              ""
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nguồn cung cấp'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_bill_in_supplier', type: 'text', className: 'form-control', placeholder: 'Nguồn cung cấp', onChange: @triggerAutoCompleteInput, defaultValue:
                          if @props.record != null
                            @props.record.supplier
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_bill_in_supplier_autocomplete",
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-sm-8',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Cách thanh toán'
                        React.DOM.div className: 'col-sm-3',
                          React.createElement SelectBox, id: 'medicine_bill_in_pmethod', className: 'form-control', text: "Cách thanh toán", type: 4, records: [{id: 1, name: "Tiền mặt"},{id: 2, name: "Chuyển khoản"},{id: 3, name: "Khác"}]
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tình trạng hóa đơn'
                        React.DOM.div className: 'col-sm-3',
                          React.createElement SelectBox, id: 'medicine_bill_in_status', className: 'form-control', text: "Tình trạng hóa đơn", type: 4, records: [{id: 1, name: "Lưu kho"},{id: 2, name: "Đang di chuyển"},{id: 3, name: "Trả lại"}]
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'medicine_bill_in_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                            if @props.record != null
                              @props.record.remark
                            else
                              ""
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Tổng giá trị'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'medicine_bill_in_tpayment', type: 'number', className: 'form-control', placeholder: 'Tổng giá trị', onBlur: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.tpayment
                            else
                              "0"
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Giảm giá'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'medicine_bill_in_discount', type: 'number', className: 'form-control', placeholder: 'Giảm giá', onBlur: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.discount
                            else
                              "0"
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', '% Giảm giá'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'medicine_bill_in_discount_percent', type: 'number', className: 'form-control', placeholder: '% Giảm giá', onBlur: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              (@props.record.discount / @props.record.tpayment)*100
                            else
                              "0"
                        React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Thanh toán'
                        React.DOM.div className: 'col-sm-7',
                          React.DOM.input id: 'medicine_bill_in_tpayout', type: 'number', className: 'form-control', placeholder: 'Thanh toán', onBlur: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.tpayout
                            else
                              "0"
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineBillRecordForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc nhập kho'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit,
                    if @props.record == null
                      React.DOM.div className: 'form-group',
                        React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã hóa đơn'
                        React.DOM.div className: 'col-sm-2',
                          React.DOM.input id: 'medicine_bill_record_billcode', type: 'text', className: 'form-control', placeholder: 'Mã hóa đơn', defaultValue: "", name: 'billcode'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_bill_record_name', type: 'text', className: 'form-control', placeholder: 'Tên thuốc', onChange: @triggerAutoCompleteInput, defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_bill_record_name_autocomplete",
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_bill_record_company', type: 'text', className: 'form-control', placeholder: 'Công ty sản xuất', defaultValue:
                          if @props.record != null
                            @props.record.company
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_bill_record_noid', type: 'text', className: 'form-control', placeholder: 'Số hiệu', defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_bill_record_signid', type: 'text', className: 'form-control', placeholder: 'Số hiệu', defaultValue:
                          if @props.record != null
                            @props.record.signid
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hạn sử dụng'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_bill_record_expire', type: 'text', className: 'form-control', placeholder: '30/01/1990', defaultValue:
                          if @props.record != null
                            if @props.record.expire != null
                              @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
                            else
                              ""
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Cách mua'
                      React.DOM.div className: 'col-sm-1',
                        React.createElement SelectBox, id: 'medicine_bill_record_pmethod', className: 'form-control', text: "Cách mua", type: 4, records: [{id: 1, name: "Hộp"},{id: 2, name: "Lẻ"}]
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'medicine_bill_record_qty', type: 'number', className: 'form-control', placeholder: 'Số lượng', defaultValue:
                          if @props.record != null
                            @props.record.qty
                          else
                            ""
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'medicine_bill_record_taxrate', type: 'number', className: 'form-control', placeholder: 'Thuế suất', defaultValue:
                          if @props.record != null
                            @props.record.taxrate
                          else
                            ""
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'medicine_bill_record_price', type: 'number', className: 'form-control', placeholder: 'Biểu giá', defaultValue:
                          if @props.record != null
                            @props.record.price
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'medicine_bill_record_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                          if @props.record != null
                            @props.record.remark
                          else
                            "" 
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicinePriceForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin giá thuốc'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit,
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_price_name', type: 'text', className: 'form-control', placeholder: 'Tên thuốc', onChange: @triggerAutoCompleteInput, defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_price_name_autocomplete",
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng ít nhất'
                      React.DOM.div className: 'col-sm-4',
                        React.DOM.input id: 'medicine_price_minam', type: 'number', className: 'form-control', placeholder: 'Số lượng ít nhất', defaultValue:
                          if @props.record != null
                            @props.record.minam
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-3',
                        React.DOM.input id: 'medicine_price_price', type: 'text', className: 'form-control', placeholder: 'Giá', defaultValue:
                          if @props.record != null
                            @props.record.price
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'medicine_price_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                          if @props.record != null
                            @props.record.remark
                          else
                            ""
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicinePrescriptExternalForm: ->
      React.DOM.div className: 'modal fade',
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
                        React.createElement InputField, id: 'medicine_prescript_external_code', className: 'form-control', type: 'text', code: '', placeholder: 'Mã đơn thuốc', style: '', trigger: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.code
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_prescript_external_customer_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'cid', defaultValue:
                          if @props.record != null
                            @props.record.customer_id
                          else
                            ""
                        React.createElement InputField, id: 'medicine_prescript_external_cname', className: 'form-control', type: 'text', code: 'medicine_prescript_external_cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, defaultValue:
                          if @props.record != null
                            @props.record.cname
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_prescript_external_cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_prescript_external_cname'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.cname, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bác sỹ kê đơn'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_prescript_external_employee_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue:
                          if @props.record != null
                            @props.record.employee_id
                          else
                            0
                        React.createElement InputField, id: 'medicine_prescript_external_ename', className: 'form-control', type: 'text', code: 'medicine_prescript_external_ename', placeholder: 'Tên bác sỹ kê đơn', style: '', trigger: @triggerAutoCompleteInputAlt, defaultValue:
                          if @props.record != null
                            @props.record.ename
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_prescript_external_ename_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_prescript_external_ename'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.ename, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số khám bệnh'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'medicine_prescript_external_number_id', className: 'form-control', type: 'text', code: '', placeholder: 'Số khám bệnh', trigger: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.number_id
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày kê đơn'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'medicine_prescript_external_date', className: 'form-control', type: 'text', code: '', placeholder: '31/01/2016', trigger: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
                          else
                            moment().format('DD/MM/YYYY')
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ mua thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'medicine_prescript_external_address', className: 'form-control', type: 'text', code: '', placeholder: 'Địa chỉ mua thuốc', trigger: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.address
                          else
                            ''
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'medicine_prescript_external_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                          if @props.record != null
                            @props.record.remark
                          else
                            ''
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineExternalRecordForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', 'Mẫu thông tin thuốc kê ngoài'
              React.DOM.small null, 'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
                  React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã đơn thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.DOM.input id: 'medicine_external_record_script_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue:
                          if @props.record != null
                            @props.record.script_id
                          else
                            ""
                        React.createElement InputField, id: 'medicine_external_record_script_code', className: 'form-control', type: 'text', code: 'medicine_external_record_script_code', placeholder: 'Mã đơn thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.script_code
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_external_record_script_code_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_external_record_script_code'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.code, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_external_record_customer_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'cid', defaultValue:
                          if @props.record != null
                            @props.record.customer_id
                          else
                            ""
                        React.createElement InputField, id: 'medicine_external_record_cname', className: 'form-control', type: 'text', code: 'medicine_external_record_cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.cname
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_external_record_cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_external_record_cname'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.cname, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'medicine_external_record_name', className: 'form-control', type: 'text', code: 'medicine_external_record_name', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_external_record_name_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_external_record_name'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'medicine_external_record_company', className: 'form-control', type: 'text', code: '', placeholder: 'Công ty sản xuất', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.company
                          else
                            ""  
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'medicine_external_record_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                          if @props.record != null
                            @props.record.remark
                          else
                            ''
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_external_record_amount', className: 'form-control', type: 'number', code: '', placeholder: 'Số lượng', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.amount
                          else
                            0
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_external_record_price', className: 'form-control', type: 'number', code: 'medicine_external_record_price', placeholder: 'Tên thuốc', style: '', trigger: @trigger, trigger3: @triggerAutoCompleteInputAlt, trigger2: @triggerRecalPayment, defaultValue:
                          if @props.record != null
                            @props.record.price
                          else
                            0
                        React.DOM.div className: "auto-complete", id: "medicine_external_record_price_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_external_record_price'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.price, record: recordsearch, trigger: @triggerAutoComplete
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tổng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_external_record_total', className: 'form-control', type: 'number', code: '', placeholder: 'Tổng', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.total
                          else
                            0
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicinePrescriptInternalForm: ->
      React.DOM.div className: 'modal fade',
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
                        React.createElement InputField, id: 'medicine_prescript_internal_code', className: 'form-control', type: 'text', code: '', placeholder: 'Mã đơn thuốc', style: '', trigger: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.code
                          else
                            ""
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_prescript_internal_customer_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'cid', defaultValue:
                          if @props.record != null
                            @props.record.customer_id
                          else
                            ""
                        React.createElement InputField, id: 'medicine_prescript_internal_cname', className: 'form-control', type: 'text', code: 'medicine_prescript_internal_cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.cname
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_prescript_internal_cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_prescript_internal_cname'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.cname, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bác sỹ kê đơn'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_prescript_internal_employee_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue:
                          if @props.record != null
                            @props.record.employee_id
                          else
                            0
                        React.createElement InputField, id: 'medicine_prescript_internal_ename', className: 'form-control', type: 'text', code: 'medicine_prescript_internal_ename', placeholder: 'Tên bác sỹ kê đơn', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.ename
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_prescript_internal_ename_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_prescript_internal_ename'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.ename, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người chuẩn bị'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input id: 'medicine_prescript_internal_preparer_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue:
                          if @props.record != null
                            @props.record.preparer_id
                          else
                            0
                        React.createElement InputField, id: 'medicine_prescript_internal_preparer', className: 'form-control', type: 'text', code: 'medicine_prescript_internal_preparer', placeholder: 'Người chuẩn bị thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.ename
                          else
                            ""
                        React.DOM.div
                          className: "auto-complete"
                          id: "medicine_prescript_internal_preparer_autocomplete"
                          if @state.autoComplete != null and @state.code == 'medicine_prescript_internal_preparer'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.ename, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số khám bệnh'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'medicine_prescript_internal_number_id', className: 'form-control', type: 'text', code: '', placeholder: 'Số khám bệnh', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.number_id
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày kê đơn'
                      React.DOM.div className: 'col-sm-4',
                        React.createElement InputField, id: 'medicine_prescript_internal_date', className: 'form-control', type: 'text', code: '', placeholder: '31/01/2016', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
                          else
                            moment().format('DD/MM/YYYY')
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người thanh toán'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'medicine_prescript_internal_payer', className: 'form-control', type: 'text', code: '', placeholder: 'Người thanh toán', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.payer
                          else
                            ''
                    React.DOM.div className: 'form-group',
                      React.DOM.div className: 'col-md-8',
                        React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                        React.DOM.div className: 'col-sm-9',
                          React.DOM.textarea id: 'medicine_prescript_internal_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                            if @props.record != null
                              @props.record.remark
                            else
                              ''
                      React.DOM.div className: 'col-md-4',
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Cách thanh toán'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement SelectBox, id: 'medicine_prescript_internal_pmethod', className: 'form-control', Change: @trigger, blurOut: @trigger, records: [{id: 1, name: 'Tiền mặt'},{id: 2, name: 'Chuyển khoản'},{id: 3, name: 'Khác'}], text: 'Cách thanh toán'
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng giá trị'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'medicine_prescript_internal_tpayment', className: 'form-control', type: 'number', placeholder: 'Tổng giá trị', trigger: @trigger, trigger3: @trigger, trigger2: @trigger, defaultValue:
                            if @props.record != null
                              @props.record.tpayment
                            else
                              0
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'medicine_prescript_internal_discount', className: 'form-control', type: 'number', placeholder: 'Giảm giá', trigger: @trigger, trigger3: @trigger, trigger2: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.discount
                            else
                              0
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', '% Giảm giá'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'medicine_prescript_internal_discount_percent', className: 'form-control', type: 'number', placeholder: '% Giảm giá', trigger: @trigger, trigger3: @trigger, trigger2: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.discount/@props.record.tpayment * 100
                            else
                              0
                        React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng thanh toán'
                        React.DOM.div className: 'col-sm-6',
                          React.createElement InputField, id: 'medicine_prescript_internal_tpayout', className: 'form-control', type: 'number', placeholder: 'Tổng thanh toán', trigger: @trigger, trigger3: @trigger, trigger2: @triggerRecalPayment, defaultValue:
                            if @props.record != null
                              @props.record.tpayout
                            else
                              0
                    React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Lưu'
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    medicineInternalRecordForm: ->
      React.DOM.div className: 'modal fade',
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
                        React.DOM.input id: 'medicine_internal_record_script_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue:
                          if @props.record != null
                            @props.record.script_id
                          else
                            ""
                        React.createElement InputField, id: 'medicine_internal_record_script_code', className: 'form-control', type: 'text', code: 'medicine_internal_record_script_code', placeholder: 'Mã đơn thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.script_code
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_internal_record_script_code_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_internal_record_script_code'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.code, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên bệnh nhân'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.input id: 'medicine_internal_record_customer_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'cid', defaultValue:
                          if @props.record != null
                            @props.record.customer_id
                          else
                            ""
                        React.createElement InputField, id: 'medicine_internal_record_cname', className: 'form-control', type: 'text', code: 'medicine_internal_record_cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.cname
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_internal_record_cname_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_internal_record_cname'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.cname, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'medicine_internal_record_name', className: 'form-control', type: 'text', code: 'medicine_internal_record_name', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_internal_record_name_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_internal_record_name'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'medicine_internal_record_company', className: 'form-control', type: 'text', code: '', placeholder: 'Công ty sản xuất', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.company
                          else
                            ""  
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_internal_record_noid', className: 'form-control', type: 'text', code: '', placeholder: 'Số hiệu', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_internal_record_signid', className: 'form-control', type: 'text', code: '', placeholder: 'Ký hiệu', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.signid
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tình trạng thuốc'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement SelectBox, id: 'medicine_internal_record_status', className: 'form-control', Change: @trigger, blurOut: @trigger, records: [{id: 1, name: 'Đã chuyển hàng'},{id: 2, name: 'Chưa chuyển hàng'},{id: 3, name: 'Khác'}], text: 'Tình trạng'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'medicine_internal_record_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                          if @props.record != null
                            @props.record.remark
                          else
                            ''
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_internal_record_amount', className: 'form-control', type: 'number', code: '', placeholder: 'Số lượng', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.amount
                          else
                            0
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_internal_record_price', className: 'form-control', type: 'number', code: 'medicine_internal_record_price', placeholder: 'Tên thuốc', style: '', trigger: @trigger, trigger3: @triggerAutoCompleteInputAlt, trigger2: @triggerRecalPayment, defaultValue:
                          if @props.record != null
                            @props.record.price
                          else
                            0
                        React.DOM.div
                          className: "auto-complete"
                          id: "medicine_internal_record_price_autocomplete"
                          if @state.autoComplete != null and @state.code == 'medicine_internal_record_price'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.price, record: recordsearch, trigger: @triggerAutoComplete
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tổng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_internal_record_tpayment', className: 'form-control', type: 'number', code: '', placeholder: 'Tổng', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.total
                          else
                            0
                    React.DOM.button
                      type: 'submit'
                      className: 'btn btn-default pull-right'
                      'Lưu'
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                className: 'btn btn-default'
                'data-dismiss': 'modal'
                type: 'button'
                'Close'
    medicineStockRecordForm: ->
      React.DOM.div className: 'modal fade',
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
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
                        React.createElement SelectBox, id: 'medicine_stock_record_typerecord', className: 'form-control', Change: @trigger, blurOut: @trigger, records: [{id: 1, name: 'Nhập'},{id: 2, name: 'Xuất'},{id: 3, name: 'Vô hiệu'}], text: 'Trạng thái'
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                      React.DOM.div className: 'col-sm-9',
                        React.createElement InputField, id: 'medicine_stock_record_name', className: 'form-control', type: 'text', code: 'medicine_stock_record_name', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.name
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_stock_record_name_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_stock_record_name'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_stock_record_noid', className: 'form-control', type: 'text', code: '', placeholder: 'Số hiệu', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.noid
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_stock_record_signid', className: 'form-control', type: 'text', code: '', placeholder: 'Ký hiệu', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.signid
                          else
                            ""
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hết hạn'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_stock_record_expire', className: 'form-control', type: 'text', code: '', placeholder: 'Hết hạn', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
                          else
                            moment().format('DD/MM/YYYY')        
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên nhà cung cấp'
                      React.DOM.div className: 'col-sm-6',
                        React.createElement InputField, id: 'medicine_stock_record_supplier', className: 'form-control', type: 'text', code: 'medicine_stock_record_supplier', placeholder: 'Tên nhà cung cấp', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.supplier
                          else
                            ""
                        React.DOM.div className: "auto-complete", id: "medicine_stock_record_supplier_autocomplete",
                          if @state.autoComplete != null and @state.code == 'medicine_stock_record_supplier'
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                      React.DOM.div className: 'col-sm-2',
                        React.createElement InputField, id: 'medicine_stock_record_amount', className: 'form-control', type: 'number', code: 'medicine_stock_record_amount', placeholder: 'Số lượng', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue:
                          if @props.record != null
                            @props.record.amount
                          else
                            0
                    React.DOM.div className: 'form-group',
                      React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                      React.DOM.div className: 'col-sm-9',
                        React.DOM.textarea id: 'medicine_stock_record_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue:
                          if @props.record != null
                            @props.record.remark
                          else
                            ''
                    React.DOM.button
                      type: 'submit'
                      className: 'btn btn-default pull-right'
                      'Lưu'
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                className: 'btn btn-default'
                'data-dismiss': 'modal'
                type: 'button'
                'Close'
    propTypes: handleHideModal: React.PropTypes.func.isRequired
    render: ->
      if @state.type == 'employee'
        @employeeForm()
      else if @state.type == 'customer_record'
        @customerForm()
      else if @state.type == 'order_map'
        @orderMapForm()
      else if @state.type == 'room'
        @roomForm()
      else if @state.type == 'position'
        @positionForm()
      else if @state.type == 'service'
        @serviceForm()
      else if @state.type == 'medicine_supplier'
        @medicineSupplierForm()
      else if @state.type == 'medicine_company'
        @medicineCompanyForm()
      else if @state.type == 'medicine_sample'
        @medicineSampleForm()
      else if @state.type == 'medicine_bill_in'
        @medicineBillInForm()
      else if @state.type == 'medicine_bill_record'
        @medicineBillRecordForm()
      else if @state.type == 'medicine_price'
        @medicinePriceForm()
      else if @state.type == 'medicine_prescript_external'
        @medicinePrescriptExternalForm()
      else if @state.type == 'medicine_external_record'
        @medicineExternalRecordForm()
      else if @state.type == 'medicine_prescript_internal'
        @medicinePrescriptInternalForm()
      else if @state.type == 'medicine_internal_record'
        @medicineInternalRecordForm()
      else if @state.type == 'medicine_stock_record'
        @medicineStockRecordForm()
      else if @state.type == 'position_set'
        @positionSetForm()
        
        
  @ModalOutside = React.createClass
    getInitialState: ->
      type: @props.type
      autoComplete: null
      code: null
    sampleRender: ->
      React.DOM.div className: 'modal fade', id: @props.id,
        React.DOM.div className: 'modal-dialog modal-lg modal-sp-lg',
          React.DOM.div className: 'modal-content',
            React.DOM.div className: 'modal-header text-center',
              React.DOM.h4 className: 'modal-title', @props.title
              React.DOM.small null, @props.undertitle
            React.DOM.div className: 'modal-body',
              React.DOM.div className: 'row',
                React.DOM.div className: 'col-md-12',
            React.DOM.div className: 'modal-footer',
              React.DOM.button className: 'btn btn-default', 'data-dismiss': 'modal', type: 'button', 'Close'
    render: ->
      @sampleRender()
