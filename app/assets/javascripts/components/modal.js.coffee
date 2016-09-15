  @Modal = React.createClass
    getInitialState: ->
      type: @props.type
      autoComplete: null
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
      if @props.type == 'employee'
        e.preventDefault()
        formData = new FormData
        formData.append 'ename', $('#employee_form_ename').val()
        formData.append 'address', $('#employee_form_address').val()
        formData.append 'pnumber', $('#employee_form_pnumber').val()
        formData.append 'noid', $('#employee_form_noid').val()
        formData.append 'gender', $('#employee_form_gender').val()
        if $('#employee_form_avatar')[0].files[0] != undefined
          formData.append 'avatar', $('#employee_form_avatar')[0].files[0]
        else if $('#webcamout').attr('src') != undefined
          formData.append 'avatar', $('#webcamout').attr('src')
        $.ajax
          url: '/employee'
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
      else if @props.type == 'employee_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'ename', $('#employee_form_ename').val()
          formData.append 'address', $('#employee_form_address').val()
          formData.append 'pnumber', $('#employee_form_pnumber').val()
          formData.append 'noid', $('#employee_form_noid').val()
          if $('#employee_form_gender').val() == 'Giới tính'
            formdata.append 'gender', @props.record.gender
          else
            formData.append 'gender', $('#employee_form_gender').val()
          if $('#employee_form_avatar')[0].files[0] != undefined
            formData.append 'avatar', $('#employee_form_avatar')[0].files[0]
          else if $('#webcamout').attr('src') != undefined
            formData.append 'avatar', $('#webcamout').attr('src')
          $.ajax
            url: '/employee'
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
      else if @props.type == 'customer_record'
        e.preventDefault()
        formData = new FormData
        formData.append 'cname', $('#customer_form_name').val()
        formData.append 'dob', $('#customer_form_dob').val()
        formData.append 'address', $('#customer_form_address').val()
        formData.append 'pnumber', $('#customer_form_pnumber').val()
        formData.append 'noid', $('#customer_form_noid').val()
        formData.append 'gender', $('#customer_form_gender').val()
        if $('#customer_form_avatar')[0].files[0] != undefined
          formData.append 'avatar', $('#customer_form_avatar')[0].files[0]
        else if $('#webcamout').attr('src') != undefined
          formData.append 'avatar', $('#webcamout').attr('src')
        $.ajax
          url: '/customer_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)   
      else if @props.type == 'customer_edit_record'
        e.preventDefault()
        formData = new FormData
        formData.append 'id', @props.record.id
        formData.append 'cname', $('#customer_form_name').val()
        formData.append 'dob', $('#customer_form_dob').val()
        formData.append 'address', $('#customer_form_address').val()
        formData.append 'pnumber', $('#customer_form_pnumber').val()
        formData.append 'noid', $('#customer_form_noid').val()
        if $('#customer_form_gender').val() == "Giới tính"
          formData.append 'gender', @props.record.gender
        else
          formData.append 'gender', $('#customer_form_gender').val()
        if $('#customer_form_avatar')[0].files[0] != undefined
          formData.append 'avatar', $('#customer_form_avatar')[0].files[0]
        else if $('#webcamout').attr('src') != undefined
          formData.append 'avatar', $('#webcamout').attr('src')
        $.ajax
          url: '/customer_record'
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
      else if @props.type == 'room_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'name', $('#room_form_name').val()
          formData.append 'lang', $('#room_form_lang').val()
          if $('#room_form_map')[0].files[0] != undefined
            formData.append 'map', $('#room_form_map')[0].files[0]
          $.ajax
            url: '/rooms'
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
      else if @props.type == 'room_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'name', $('#room_form_name').val()
        formData.append 'lang', $('#room_form_lang').val()
        if $('#room_form_map')[0].files[0] != undefined
          formData.append 'map', $('#room_form_map')[0].files[0]
        $.ajax
          url: '/rooms'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'position_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'room', $('#position_form_room').val()
          formData.append 'pname', $('#position_form_pname').val()
          formData.append 'lang', $('#position_form_lang').val()
          formData.append 'description', $('#position_form_description').val()
          if $('#position_form_file')[0].files[0] != undefined
            formData.append 'file', $('#position_form_file')[0].files[0]
          $.ajax
            url: '/positions'
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
      else if @props.type == 'position_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'room', $('#position_form_room').val()
        formData.append 'pname', $('#position_form_pname').val()
        formData.append 'lang', $('#position_form_lang').val()
        formData.append 'description', $('#position_form_description').val()
        if $('#position_form_file')[0].files[0] != undefined
          formData.append 'file', $('#position_form_file')[0].files[0]
        $.ajax
          url: '/positions'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'service_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'sname', $('#service_form_sname').val()
          formData.append 'lang', $('#service_form_lang').val()
          formData.append 'price', $('#service_form_price').val()
          formData.append 'currency', $('#service_form_currency').val()
          formData.append 'description', $('#service_form_description').val()
          if $('#service_form_file')[0].files[0] != undefined
            formData.append 'file', $('#service_form_file')[0].files[0]
          $.ajax
            url: '/services'
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
      else if @props.type == 'service_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'sname', $('#service_form_sname').val()
        formData.append 'lang', $('#service_form_lang').val()
        formData.append 'price', $('#service_form_price').val()
        formData.append 'currency', $('#service_form_currency').val()
        formData.append 'description', $('#service_form_description').val()
        if $('#service_form_file')[0].files[0] != undefined
          formData.append 'file', $('#service_form_file')[0].files[0]
        $.ajax
          url: '/services'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'medicine_supplier_add'
        e.preventDefault()
        formData = new FormData
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
        $.ajax
          url: '/medicine_supplier'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'medicine_supplier_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
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
          $.ajax
            url: '/medicine_supplier'
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
      else if @props.type == 'medicine_company_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'noid', $('#medicine_company_noid').val()
        formData.append 'name', $('#medicine_company_name').val()
        formData.append 'pnumber', $('#medicine_company_pnumber').val()
        formData.append 'address', $('#medicine_company_address').val()
        formData.append 'email', $('#medicine_company_email').val()
        formData.append 'website', $('#medicine_company_website').val()
        formData.append 'taxcode', $('#medicine_company_taxcode').val()
        $.ajax
          url: '/medicine_company'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'medicine_company_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'noid', $('#medicine_company_noid').val()
          formData.append 'name', $('#medicine_company_name').val()
          formData.append 'pnumber', $('#medicine_company_pnumber').val()
          formData.append 'address', $('#medicine_company_address').val()
          formData.append 'email', $('#medicine_company_email').val()
          formData.append 'website', $('#medicine_company_website').val()
          formData.append 'taxcode', $('#medicine_company_taxcode').val()
          $.ajax
            url: '/medicine_company'
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
      else if @props.type == 'medicine_sample_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'noid', $('#medicine_sample_noid').val()
        formData.append 'name', $('#medicine_sample_name').val()
        formData.append 'typemedicine', $('#medicine_sample_typemedicine').val()
        formData.append 'groupmedicine', $('#medicine_sample_groupmedicine').val()
        formData.append 'company', $('#medicine_sample_company').val()
        formData.append 'price', $('#medicine_sample_price').val()
        formData.append 'weight', $('#medicine_sample_weight').val()
        formData.append 'remark', $('#medicine_sample_remark').val()
        formData.append 'expire', $('#medicine_sample_expire').val()
        $.ajax
          url: '/medicine_sample'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'medicine_sample_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'noid', $('#medicine_sample_noid').val()
          formData.append 'name', $('#medicine_sample_name').val()
          if $('#medicine_sample_typemedicine').val() == ""
            formData.append 'typemedicine', @props.record.typemedicine
          else
            formData.append 'typemedicine', $('#medicine_sample_typemedicine').val()
          if $('#medicine_sample_groupmedicine').val() == ""
            formData.append 'groupmedicine', @props.record.groupmedicine
          else
            formData.append 'groupmedicine', $('#medicine_sample_groupmedicine').val()
          formData.append 'company', $('#medicine_sample_company').val()
          formData.append 'price', $('#medicine_sample_price').val()
          formData.append 'weight', $('#medicine_sample_weight').val()
          formData.append 'remark', $('#medicine_sample_remark').val()
          formData.append 'expire', $('#medicine_sample_expire').val()
          $.ajax
            url: '/medicine_sample'
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
      else if @props.type == 'medicine_bill_in_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'billcode', $('#medicine_bill_in_billcode').val()
        formData.append 'supplier', $('#medicine_bill_in_supplier').val()
        formData.append 'dayin', $('#medicine_bill_in_dayin').val()
        formData.append 'daybook', $('#medicine_bill_in_daybook').val()
        formData.append 'pmethod', $('#medicine_bill_in_pmethod').val()
        formData.append 'tpayment', $('#medicine_bill_in_tpayment').val()
        formData.append 'discount', $('#medicine_bill_in_discount').val()
        formData.append 'tpayout', $('#medicine_bill_in_tpayout').val()
        formData.append 'remark', $('#medicine_bill_in_remark').val()
        formData.append 'status', $('#medicine_bill_in_status').val()
        $.ajax
          url: '/medicine_bill_in'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'medicine_bill_in_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'billcode', $('#medicine_bill_in_billcode').val()
          formData.append 'supplier', $('#medicine_bill_in_supplier').val()
          formData.append 'dayin', $('#medicine_bill_in_dayin').val()
          formData.append 'daybook', $('#medicine_bill_in_daybook').val()
          if $('#medicine_bill_in_pmethod').val() == "Cách thanh toán"
            formData.append 'pmethod', @props.record.pmethod
          else
            formData.append 'pmethod', $('#medicine_bill_in_pmethod').val()
          formData.append 'tpayment', $('#medicine_bill_in_tpayment').val()
          formData.append 'discount', $('#medicine_bill_in_discount').val()
          formData.append 'tpayout', $('#medicine_bill_in_tpayout').val()
          formData.append 'remark', $('#medicine_bill_in_remark').val()
          if $('#medicine_bill_in_status').val() == ""
            formData.append 'status', @props.record.status
          else
            formData.append 'status', $('#medicine_bill_in_status').val()
          $.ajax
            url: '/medicine_bill_in'
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
      else if @props.type == 'medicine_bill_record_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'billcode', $('#medicine_bill_record_billcode').val()
        formData.append 'name', $('#medicine_bill_record_name').val()
        formData.append 'company', $('#medicine_bill_record_company').val()
        formData.append 'noid', $('#medicine_bill_record_noid').val()
        formData.append 'signid', $('#medicine_bill_record_signid').val()
        formData.append 'remark', $('#medicine_bill_record_remark').val()
        formData.append 'expire', $('#medicine_bill_record_expire').val()
        formData.append 'pmethod', $('#medicine_bill_record_pmethod').val()
        formData.append 'qty', $('#medicine_bill_record_qty').val()
        formData.append 'taxrate', $('#medicine_bill_record_taxrate').val()
        formData.append 'price', $('#medicine_bill_record_price').val()
        $.ajax
          url: '/medicine_bill_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'medicine_bill_record_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'name', $('#medicine_bill_record_name').val()
          formData.append 'company', $('#medicine_bill_record_company').val()
          formData.append 'noid', $('#medicine_bill_record_noid').val()
          formData.append 'signid', $('#medicine_bill_record_signid').val()
          formData.append 'remark', $('#medicine_bill_record_remark').val()
          formData.append 'expire', $('#medicine_bill_record_expire').val()
          if $('#medicine_bill_record_pmethod').val() == 'Cách mua'
            formData.append 'pmethod', @props.record.pmethod
          else
            formData.append 'pmethod', $('#medicine_bill_record_pmethod').val()
          formData.append 'qty', $('#medicine_bill_record_qty').val()
          formData.append 'taxrate', $('#medicine_bill_record_taxrate').val()
          formData.append 'price', $('#medicine_bill_record_price').val()
          $.ajax
            url: '/medicine_bill_record'
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
      else if @props.type == 'medicine_price_add'
        e.preventDefault()
        formData = new FormData
        formData.append 'name', $('#medicine_price_name').val()
        formData.append 'minam', $('#medicine_price_minam').val()
        formData.append 'price', $('#medicine_price_price').val()
        formData.append 'remark', $('#medicine_price_remark').val()
        $.ajax
          url: '/medicine_price'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.trigger result
            return
          ).bind(this)
      else if @props.type == 'medicine_price_edit'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'name', $('#medicine_price_name').val()
          formData.append 'minam', $('#medicine_price_minam').val()
          formData.append 'price', $('#medicine_price_price').val()
          formData.append 'remark', $('#medicine_price_remark').val()
          $.ajax
            url: '/medicine_price'
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
      if @state.type == 'medicine_sample_add' or @state.type == 'medicine_sample_edit'
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
      else if @state.type == 'medicine_bill_in_add' or @state.type == 'medicine_bill_in_edit'
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
      else if @state.type == 'medicine_bill_record_add' or @state.type == 'medicine_bill_record_edit'
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
      else if @state.type == 'medicine_price_add' or @state.type == 'medicine_price_edit'
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
    triggerAutoComplete: (record) ->
      if @state.type == 'medicine_sample_add' or @state.type == 'medicine_sample_edit'
        $('#medicine_sample_company').val(record.name)
        @setState autoComplete: null
      else if @state.type == 'medicine_bill_in_add' or @state.type == 'medicine_bill_in_edit'
        $('#medicine_bill_in_supplier').val(record.name)
        @setState autoComplete: null
      else if @state.type == 'medicine_bill_record_add' or @state.type == 'medicine_bill_record_edit'
        $('#medicine_bill_record_name').val(record.name)
        $('#medicine_bill_record_company').val(record.company)
        @setState autoComplete: null
      else if @state.type == 'medicine_price_add' or @state.type == 'medicine_price_edit'
        $('#medicine_price_name').val(record.name)
        @setState autoComplete: null
    triggerRecalPayment: (e) ->
      if @state.type == 'medicine_bill_in_add' or @state.type == 'medicine_bill_in_edit'
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
    employeeForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin nhân viên'
              React.DOM.small null,
                'Description'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-7'
                  React.DOM.form
                    id: 'employee_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Họ và Tên'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'employee_form_ename'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Họ và tên'
                          defaultValue:
                            if @props.record != null
                              @props.record.ename
                            else
                              ""
                          name: 'ename'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Địa chỉ'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'employee_form_address'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Địa chỉ'
                          name: 'address'
                          defaultValue:
                            if @props.record != null
                              @props.record.address
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Số ĐT'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'employee_form_pnumber'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Số ĐT'
                          name: 'pnumber'
                          defaultValue:
                            if @props.record != null
                              @props.record.pnumber
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'CMTND'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'employee_form_noid'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Số hiệu NV'
                          name: 'noid'
                          defaultValue:
                            if @props.record != null
                              @props.record.noid
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-3 control-label'
                        'Giới tính'
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.select
                          id: 'employee_form_gender'
                          className: 'form-control'
                          name: 'gender'
                          defaultValue:
                            if @props.record != null
                              @props.record.gender
                            else
                              ""
                          React.DOM.option
                            value: ''
                            'Giới tính'
                          React.DOM.option
                            value: '1'
                            'Nam'
                          React.DOM.option
                            value: '2'
                            'Nữ'
                      React.DOM.label
                        className: 'col-sm-3 control-label'
                        'Ảnh đại diện'
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'employee_form_avatar'
                          type: 'file'
                          className: 'form-control'
                          name: 'avatar'
                    React.DOM.button
                      type: 'submit'
                      className: 'btn btn-default pull-right'
                      'Lưu'
                React.DOM.div
                  className: 'col-md-5'
                  style: {'alignContent': 'center'}
                  React.DOM.div
                    id: 'results'
                    React.DOM.img
                      style: {'maxWidth': '100%', 'maxHeight': '240px'}
                      src:
                        if @props.record != null
                          if @props.record.avatar != "/avatars/original/missing.png"
                            @props.record.avatar
                          else
                            'https://www.twomargins.com/images/noavatar.jpg'
                        else
                          'https://www.twomargins.com/images/noavatar.jpg'
                  React.DOM.div
                    id: 'my_camera'
                  React.DOM.button
                    type: 'button'
                    className: 'btn btn-default'
                    onClick: @setup_webcam
                    name: 'close'
                    'Setup'
                  React.DOM.button
                    type: 'button'
                    className: 'btn btn-default'
                    value: 'take Large Snapshot'
                    onClick: @take_snapshot
                    name: 'close'
                    'Capture'
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                className: 'btn btn-default'
                'data-dismiss': 'modal'
                type: 'button'
                'Close'
    customerForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Customer Record Form'
              React.DOM.small null,
                'Description'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-7'
                  React.DOM.p null, 'Detail for this modal - short'
                  React.DOM.form
                    id: 'customer_record_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Họ và Tên'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'customer_form_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Họ và tên'
                          name: 'name'
                          defaultValue:
                            if @props.record != null
                              @props.record.cname
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Ngày sinh'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'customer_form_dob'
                          type: 'text'
                          className: 'form-control'
                          placeholder: '31/01/1990'
                          name: 'dob'
                          defaultValue:
                            if @props.record != null
                              @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Địa chỉ'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'customer_form_address'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Địa chỉ'
                          name: 'address'
                          defaultValue:
                            if @props.record != null
                              @props.record.address
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Số ĐT'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'customer_form_pnumber'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Số ĐT'
                          name: 'pnumber'
                          defaultValue:
                            if @props.record != null
                              @props.record.pnumber
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'CMTND'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'customer_form_noid'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Số CMTND'
                          name: 'noid'
                          defaultValue:
                            if @props.record != null
                              @props.record.noid
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Giới tính'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.select
                          id: 'customer_form_gender'
                          className: 'form-control'
                          name: 'gender'
                          defaultValue:
                            if @props.record != null
                              @props.record.gender
                            else
                              ""
                          React.DOM.option
                            value: ''
                            'Giới tính'
                          React.DOM.option
                            value: '1'
                            'Nam'
                          React.DOM.option
                            value: '2'
                            'Nữ'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Ảnh đại diện'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'customer_form_avatar'
                          type: 'file'
                          className: 'form-control'
                          name: 'avatar'  
                    React.DOM.button
                      onClick: @handleSubmitCustomerRecord
                      className: 'btn btn-default pull-right'
                      'Lưu'
                React.DOM.div
                  className: 'col-md-5'
                  style: {'alignContent': 'center'}
                  React.DOM.div
                    id: 'results'
                    React.DOM.img
                      style: {'maxWidth': '100%', 'maxHeight': '240px'}
                      src:
                        if @props.record != null
                          if @props.record.avatar != "/avatars/original/missing.png"
                            @props.record.avatar
                          else
                            'https://www.twomargins.com/images/noavatar.jpg'
                        else
                          'https://www.twomargins.com/images/noavatar.jpg'
                  React.DOM.div
                    id: 'my_camera'
                  React.DOM.button
                    type: 'button'
                    className: 'btn btn-default'
                    onClick: @setup_webcam
                    name: 'close'
                    'Setup'
                  React.DOM.button
                    type: 'button'
                    className: 'btn btn-default'
                    value: 'take Large Snapshot'
                    onClick: @take_snapshot
                    name: 'close'
                    'Capture'
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                className: 'btn btn-default'
                'data-dismiss': 'modal'
                type: 'button'
                'Close'
    roomForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin phòng'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    id: 'employee_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Tên phòng'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'room_form_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên phòng'
                          defaultValue:
                            if @props.record != null
                              @props.record.name
                            else
                              ""
                          name: 'name'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Ngôn ngữ'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'room_form_lang'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Ngôn ngữ'
                          name: 'lang'
                          defaultValue:
                            if @props.record != null
                              @props.record.lang
                            else
                              "vi"
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Bản đồ'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'room_form_map'
                          type: 'file'
                          className: 'form-control'
                          name: 'map'
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
    positionForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin chức vụ'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    id: 'position_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Tên phòng'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.createElement SelectBox, records: @props.extra, type: 1, id: 'position_form_room', text: 'Tên phòng', defaultValue:
                          if @props.record != null
                            @props.record.room_id
                          else
                            null
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Tên chức vụ'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'position_form_pname'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên chức vụ'
                          name: 'pname'
                          defaultValue:
                            if @props.record != null
                              @props.record.pname
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Ngôn ngữ'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'position_form_lang'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Ngôn ngữ'
                          name: 'lang'
                          defaultValue:
                            if @props.record != null
                              @props.record.lang
                            else
                              "vi"
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Miêu tả ngắn'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.textarea
                          id: 'position_form_description'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Miêu tả ngắn'
                          name: 'description'
                          defaultValue:
                            if @props.record != null
                              @props.record.description
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'File đính kèm'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'position_form_file'
                          type: 'file'
                          className: 'form-control'
                          name: 'file'
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
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin dịch vụ'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    id: 'employee_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Tên dịch vụ'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'service_form_sname'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên dịch vụ'
                          defaultValue:
                            if @props.record != null
                              @props.record.sname
                            else
                              ""
                          name: 'sname'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Ngôn ngữ'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'service_form_lang'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Ngôn ngữ'
                          name: 'lang'
                          defaultValue:
                            if @props.record != null
                              @props.record.lang
                            else
                              "vi"
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Giá'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'service_form_price'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Giá'
                          name: 'price'
                          defaultValue:
                            if @props.record != null
                              @props.record.price
                            else
                              "0"
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Đơn vị tiền'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'service_form_currency'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Đơn vị tiền'
                          name: 'currency'
                          defaultValue:
                            if @props.record != null
                              @props.record.price
                            else
                              "VND"
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Mô tả ngắn'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'service_form_description'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Mô tả ngắn'
                          name: 'description'
                          defaultValue:
                            if @props.record != null
                              @props.record.description
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-4 control-label'
                        'Logo'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.input
                          id: 'service_form_file'
                          type: 'file'
                          className: 'form-control'
                          name: 'file'
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
    medicineSupplierForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg modal-sp-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin nguồn cấp thuốc'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Mã số'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_supplier_noid'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Mã số'
                          defaultValue:
                            if @props.record != null
                              @props.record.noid
                            else
                              ""
                          name: 'noid'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Tên nguồn'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_supplier_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên nguồn'
                          name: 'supplier_name'
                          defaultValue:
                            if @props.record != null
                              @props.record.name
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Người liên lạc'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_supplier_contact_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên nguồn'
                          name: 'supplier_contact_name'
                          defaultValue:
                            if @props.record != null
                              @props.record.contactname
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'SĐT cố định'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_supplier_spnumber'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'SĐT cố định'
                          name: 'supplier_spnumber'
                          defaultValue:
                            if @props.record != null
                              @props.record.spnumber
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'SĐT di động'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_supplier_pnumber'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'SĐT di động'
                          name: 'supplier_pnumber'
                          defaultValue:
                            if @props.record != null
                              @props.record.pnumber
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Địa chỉ 1'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input
                          id: 'medicine_supplier_address1'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Địa chỉ 1'
                          name: 'supplier_address1'
                          defaultValue:
                            if @props.record != null
                              @props.record.address1
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Địa chỉ 2'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input
                          id: 'medicine_supplier_address2'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Địa chỉ 2'
                          name: 'supplier_address2'
                          defaultValue:
                            if @props.record != null
                              @props.record.address2
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Địa chỉ 3'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input
                          id: 'medicine_supplier_address3'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Địa chỉ 3'
                          name: 'supplier_address3'
                          defaultValue:
                            if @props.record != null
                              @props.record.address3
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-1 control-label hidden-xs'
                        React.DOM.i
                          className: "zmdi zmdi-email"
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'medicine_supplier_email'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Email'
                          name: 'supplier_email'
                          defaultValue:
                            if @props.record != null
                              @props.record.email
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-1 control-label hidden-xs'
                        React.DOM.i
                          className: "zmdi zmdi-facebook-box"
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'medicine_supplier_facebook'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Facebook Link'
                          name: 'supplier_facebook'
                          defaultValue:
                            if @props.record != null
                              @props.record.facebook
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-1 control-label hidden-xs'
                        React.DOM.i
                          className: "zmdi zmdi-twitter-box"
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'medicine_supplier_twitter'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Twitter Link'
                          name: 'supplier_twitter'
                          defaultValue:
                            if @props.record != null
                              @props.record.twitter
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Số fax'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_supplier_fax'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Fax'
                          name: 'supplier_fax'
                          defaultValue:
                            if @props.record != null
                              @props.record.fax
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Mã số thuế'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_supplier_taxcode'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Mã số thuế'
                          name: 'supplier_taxcode'
                          defaultValue:
                            if @props.record != null
                              @props.record.taxcode
                            else
                              ""
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
    medicineCompanyForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin Doanh nghiệp sản xuất thuốc'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Mã số'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_company_noid'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Mã số'
                          defaultValue:
                            if @props.record != null
                              @props.record.noid
                            else
                              ""
                          name: 'noid'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Tên doanh nghiệp'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'medicine_company_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên doanh nghiệp sản xuất'
                          name: 'name'
                          defaultValue:
                            if @props.record != null
                              @props.record.name
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'SĐT'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_company_pnumber'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'SĐT'
                          name: 'pnumber'
                          defaultValue:
                            if @props.record != null
                              @props.record.pnumber
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Email'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_company_email'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Email'
                          name: 'email'
                          defaultValue:
                            if @props.record != null
                              @props.record.email
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Địa chỉ'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input
                          id: 'medicine_company_address'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Địa chỉ'
                          name: 'address'
                          defaultValue:
                            if @props.record != null
                              @props.record.address
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        React.DOM.i
                          className: "zmdi zmdi-link"
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_company_website'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Website'
                          name: 'website'
                          defaultValue:
                            if @props.record != null
                              @props.record.website
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Mã số thuế'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_company_taxcode'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Mã số thuế'
                          name: 'taxcode'
                          defaultValue:
                            if @props.record != null
                              @props.record.taxcode
                            else
                              ""
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
    medicineSampleForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg modal-sp-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin Mẫu thuốc'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Mã số'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_sample_noid'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Mã số'
                          defaultValue:
                            if @props.record != null
                              @props.record.noid
                            else
                              ""
                          name: 'noid'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Tên thuốc'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'medicine_sample_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên thuốc'
                          name: 'name'
                          defaultValue:
                            if @props.record != null
                              @props.record.name
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Loại thuốc'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.createElement SelectBox, id: 'medicine_sample_typemedicine', records: @props.extra[2], className: 'form-control', type: 4, text: ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Nhóm thuốc'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.createElement SelectBox, id: 'medicine_sample_groupmedicine', records: @props.extra[1], className: 'form-control', type: 4, text: ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Giá thuốc'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_sample_price'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Giá thuốc'
                          name: 'price'
                          defaultValue:
                            if @props.record != null
                              @props.record.price
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        "Ghi chú"
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.textarea
                          id: 'medicine_sample_remark'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Ghi chú'
                          name: 'remark'
                          defaultValue:
                            if @props.record != null
                              @props.record.remark
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Khối lượng'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_sample_weight'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Khối lượng'
                          name: 'weight'
                          defaultValue:
                            if @props.record != null
                              @props.record.weight
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Hạn sử dụng'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_sample_expire'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Hạn sử dụng'
                          name: 'expire'
                          defaultValue:
                            if @props.record != null
                              @props.record.expire
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Công ty sản xuất'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input
                          id: 'medicine_sample_company'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Công ty sản xuất'
                          name: 'company'
                          onChange: @triggerAutoCompleteInput
                          defaultValue:
                            if @props.record != null
                              @props.record.company
                            else
                              ""
                        React.DOM.div
                          className: "auto-complete"
                          id: "medicine_sample_company_autocomplete"
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
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
    medicineBillInForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg modal-sp-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu hóa đơn nhập thuốc'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Mã hóa đơn'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_bill_in_billcode'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Mã hóa đơn'
                          defaultValue:
                            if @props.record != null
                              @props.record.billcode
                            else
                              ""
                          name: 'billcode'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Ngày nhập'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_bill_in_dayin'
                          type: 'text'
                          className: 'form-control'
                          placeholder: '30/01/1990'
                          defaultValue:
                            if @props.record != null
                              if @props.record.dayin != null
                                @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
                              else
                                ""
                            else
                              ""
                          name: 'dayin'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Ngày đặt hàng'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_bill_in_daybook'
                          type: 'text'
                          className: 'form-control'
                          placeholder: '30/01/1990'
                          defaultValue:
                            if @props.record != null
                              if @props.record.daybook != null
                                @props.record.daybook.substring(8, 10) + "/" + @props.record.daybook.substring(5, 7) + "/" + @props.record.daybook.substring(0, 4)
                              else
                                ""
                            else
                              ""
                          name: 'dayin'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Nguồn cung cấp'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input
                          id: 'medicine_bill_in_supplier'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Nguồn cung cấp'
                          name: 'supplier'
                          onChange: @triggerAutoCompleteInput
                          defaultValue:
                            if @props.record != null
                              @props.record.supplier
                            else
                              ""
                        React.DOM.div
                          className: "auto-complete"
                          id: "medicine_bill_in_supplier_autocomplete"
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.div
                        className: 'col-sm-8'
                        React.DOM.label
                          className: 'col-sm-3 control-label hidden-xs'
                          'Cách thanh toán'
                        React.DOM.div
                          className: 'col-sm-3'
                          React.createElement SelectBox, id: 'medicine_bill_in_pmethod', className: 'form-control', text: "Cách thanh toán", type: 4, records: [{id: 1, name: "Tiền mặt"},{id: 2, name: "Chuyển khoản"},{id: 3, name: "Khác"}]
                        React.DOM.label
                          className: 'col-sm-3 control-label hidden-xs'
                          'Tình trạng hóa đơn'
                        React.DOM.div
                          className: 'col-sm-3'
                          React.createElement SelectBox, id: 'medicine_bill_in_status', className: 'form-control', text: "Tình trạng hóa đơn", type: 4, records: [{id: 1, name: "Lưu kho"},{id: 2, name: "Đang di chuyển"},{id: 3, name: "Trả lại"}]
                        React.DOM.label
                          className: 'col-sm-3 control-label hidden-xs'
                          'Ghi chú'
                        React.DOM.div
                          className: 'col-sm-9'
                          React.DOM.textarea
                            id: 'medicine_bill_in_remark'
                            type: 'text'
                            style: {'marginTop': '10px'}
                            className: 'form-control'
                            placeholder: 'Ghi chú'
                            defaultValue:
                              if @props.record != null
                                @props.record.remark
                              else
                                ""
                            name: 'remark'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.label
                          className: 'col-sm-5 control-label hidden-xs'
                          'Tổng giá trị'
                        React.DOM.div
                          className: 'col-sm-7'
                          React.DOM.input
                            id: 'medicine_bill_in_tpayment'
                            type: 'number'
                            className: 'form-control'
                            placeholder: 'Tổng giá trị'
                            onBlur: @triggerRecalPayment
                            defaultValue:
                              if @props.record != null
                                @props.record.tpayment
                              else
                                "0"
                            name: 'tpayment'
                        React.DOM.label
                          className: 'col-sm-5 control-label hidden-xs'
                          'Giảm giá'
                        React.DOM.div
                          className: 'col-sm-7'
                          React.DOM.input
                            id: 'medicine_bill_in_discount'
                            type: 'number'
                            className: 'form-control'
                            placeholder: 'Giảm giá'
                            onBlur: @triggerRecalPayment
                            defaultValue:
                              if @props.record != null
                                @props.record.discount
                              else
                                "0"
                            name: 'discount'
                        React.DOM.label
                          className: 'col-sm-5 control-label hidden-xs'
                          '% Giảm giá'
                        React.DOM.div
                          className: 'col-sm-7'
                          React.DOM.input
                            id: 'medicine_bill_in_discount_percent'
                            type: 'number'
                            className: 'form-control'
                            placeholder: '% Giảm giá'
                            onBlur: @triggerRecalPayment
                            defaultValue:
                              if @props.record != null
                                (@props.record.discount / @props.record.tpayment)*100
                              else
                                "0"
                            name: 'pdiscount'
                        React.DOM.label
                          className: 'col-sm-5 control-label hidden-xs'
                          'Thanh toán'
                        React.DOM.div
                          className: 'col-sm-7'
                          React.DOM.input
                            id: 'medicine_bill_in_tpayout'
                            type: 'number'
                            className: 'form-control'
                            placeholder: 'Thanh toán'
                            onBlur: @triggerRecalPayment
                            defaultValue:
                              if @props.record != null
                                @props.record.tpayout
                              else
                                "0"
                            name: 'discount'
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
    medicineBillRecordForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg modal-sp-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin thuốc nhập kho'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    if @props.record == null
                      React.DOM.div
                        className: 'form-group'
                        React.DOM.label
                          className: 'col-sm-2 control-label hidden-xs'
                          'Mã hóa đơn'
                        React.DOM.div
                          className: 'col-sm-2'
                          React.DOM.input
                            id: 'medicine_bill_record_billcode'
                            type: 'text'
                            className: 'form-control'
                            placeholder: 'Mã hóa đơn'
                            defaultValue: ""
                            name: 'billcode'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Tên thuốc'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_bill_record_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên thuốc'
                          name: 'name'
                          onChange: @triggerAutoCompleteInput
                          defaultValue:
                            if @props.record != null
                              @props.record.name
                            else
                              ""
                        React.DOM.div
                          className: "auto-complete"
                          id: "medicine_bill_record_name_autocomplete"
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Công ty sản xuất'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_bill_record_company'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Công ty sản xuất'
                          defaultValue:
                            if @props.record != null
                              @props.record.company
                            else
                              ""
                          name: 'company'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Số hiệu'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_bill_record_noid'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Số hiệu'
                          name: 'noid'
                          defaultValue:
                            if @props.record != null
                              @props.record.noid
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Ký hiệu'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_bill_record_signid'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Số hiệu'
                          name: 'signid'
                          defaultValue:
                            if @props.record != null
                              @props.record.signid
                            else
                              ""
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Hạn sử dụng'
                      React.DOM.div
                        className: 'col-sm-2'
                        React.DOM.input
                          id: 'medicine_bill_record_expire'
                          type: 'text'
                          className: 'form-control'
                          placeholder: '30/01/1990'
                          name: 'expire'
                          defaultValue:
                            if @props.record != null
                              if @props.record.expire != null
                                @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
                              else
                                ""
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Cách mua'
                      React.DOM.div
                        className: 'col-sm-1'
                        React.createElement SelectBox, id: 'medicine_bill_record_pmethod', className: 'form-control', text: "Cách mua", type: 4, records: [{id: 1, name: "Hộp"},{id: 2, name: "Lẻ"}]
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'medicine_bill_record_qty'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Số lượng'
                          defaultValue:
                            if @props.record != null
                              @props.record.qty
                            else
                              ""
                          name: 'qty'
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'medicine_bill_record_taxrate'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Thuế suất'
                          defaultValue:
                            if @props.record != null
                              @props.record.taxrate
                            else
                              ""
                          name: 'taxrate'
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'medicine_bill_record_price'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Biểu giá'
                          defaultValue:
                            if @props.record != null
                              @props.record.price
                            else
                              ""
                          name: 'price'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Ghi chú'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.textarea
                          id: 'medicine_bill_record_remark'
                          type: 'text'
                          style: {'marginTop': '10px'}
                          className: 'form-control'
                          placeholder: 'Ghi chú'
                          defaultValue:
                            if @props.record != null
                              @props.record.remark
                            else
                              ""
                          name: 'remark'
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
    medicinePriceForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Mẫu thông tin giá thuốc'
              React.DOM.small null,
                'mời bạn điền vào các thông tin yêu cầu dưới đây'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-12'
                  React.DOM.form
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Tên thuốc'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.input
                          id: 'medicine_price_name'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Tên thuốc'
                          name: 'name'
                          onChange: @triggerAutoCompleteInput
                          defaultValue:
                            if @props.record != null
                              @props.record.name
                            else
                              ""
                        React.DOM.div
                          className: "auto-complete"
                          id: "medicine_price_name_autocomplete"
                          if @state.autoComplete != null
                            for recordsearch in @state.autoComplete
                              React.createElement AutoComplete, key: recordsearch.id, text: recordsearch.name, record: recordsearch, trigger: @triggerAutoComplete
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Số lượng ít nhất'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.input
                          id: 'medicine_price_minam'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Số lượng ít nhất'
                          defaultValue:
                            if @props.record != null
                              @props.record.minam
                            else
                              ""
                          name: 'minam'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Giá'
                      React.DOM.div
                        className: 'col-sm-3'
                        React.DOM.input
                          id: 'medicine_price_price'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Giá'
                          name: 'Giá'
                          defaultValue:
                            if @props.record != null
                              @props.record.price
                            else
                              ""
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label hidden-xs'
                        'Ghi chú'
                      React.DOM.div
                        className: 'col-sm-9'
                        React.DOM.textarea
                          id: 'medicine_price_remark'
                          type: 'text'
                          style: {'marginTop': '10px'}
                          className: 'form-control'
                          placeholder: 'Ghi chú'
                          defaultValue:
                            if @props.record != null
                              @props.record.remark
                            else
                              ""
                          name: 'remark'
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
      if @state.type == 'employee' or @state.type == 'employee_edit'
        @employeeForm()
      else if @state.type == 'customer_record' or @state.type == 'customer_edit_record'
        @customerForm()
      else if @state.type == 'room_add' or @state.type == 'room_edit'
        @roomForm()
      else if @state.type == 'position_add' or @state.type == 'position_edit'
        @positionForm()
      else if @state.type == 'service_add' or @state.type == 'service_edit'
        @serviceForm()
      else if @state.type == 'medicine_supplier_add' or @state.type == 'medicine_supplier_edit'
        @medicineSupplierForm()
      else if @state.type == 'medicine_company_add' or @state.type == 'medicine_company_edit'
        @medicineCompanyForm()
      else if @state.type == 'medicine_sample_add' or @state.type == 'medicine_sample_edit'
        @medicineSampleForm()
      else if @state.type == 'medicine_bill_in_add' or @state.type == 'medicine_bill_in_edit'
        @medicineBillInForm()
      else if @state.type == 'medicine_bill_record_add' or @state.type == 'medicine_bill_record_edit'
        @medicineBillRecordForm()
      else if @state.type == 'medicine_price_add' or @state.type == 'medicine_price_edit'
        @medicinePriceForm()