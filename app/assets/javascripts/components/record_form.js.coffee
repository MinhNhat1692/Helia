@FilterForm = React.createClass
    getInitialState: ->
      type: 0
      selectList: null
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      if @props.datatype == "medicine_supplier"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'noid', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'contactname', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'spnumber', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'pnumber', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'address1', $('#filter_text').val().toLowerCase()
          when 7
            formData.append 'address2', $('#filter_text').val().toLowerCase()
          when 8
            formData.append 'address3', $('#filter_text').val().toLowerCase()
          when 9
            formData.append 'email', $('#filter_text').val().toLowerCase()
          when 10
            formData.append 'facebook', $('#filter_text').val().toLowerCase()
          when 11
            formData.append 'twitter', $('#filter_text').val().toLowerCase()
          when 12
            formData.append 'fax', $('#filter_text').val().toLowerCase()
          when 13
            formData.append 'taxcode', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "medicine_company"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'noid', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'pnumber', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'address', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'email', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'website', $('#filter_text').val().toLowerCase()
          when 7
            formData.append 'taxcode', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "medicine_sample"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'noid', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'typemedicine', $('#filter_text').val()
          when 4
            formData.append 'groupmedicine', Number($('#filter_text').val())
          when 5
            formData.append 'company', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'price', $('#filter_text').val()
          when 7
            formData.append 'weight', $('#filter_text').val()
          when 8
            formData.append 'remark', $('#filter_text').val()
          when 9
            formData.append 'expire', $('#filter_text').val()
      else if @props.datatype == "medicine_bill_in"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'billcode', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'supplier', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'remark', $('#filter_text').val()
          when 4
            formData.append 'dayin', $('#filter_text').val()
          when 5
            formData.append 'daybook', $('#filter_text').val()
          when 6
            formData.append 'pmethod', Number($('#filter_text').val())
          when 7
            formData.append 'tpayment', $('#filter_text').val()
          when 8
            formData.append 'discount', $('#filter_text').val()
          when 9
            formData.append 'payout', $('#filter_text').val()
          when 10
            formData.append 'status', Number($('#filter_text').val())
      else if @props.datatype == "medicine_bill_record"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'company', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'noid', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'signid', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'expire', $('#filter_text').val()
          when 7
            formData.append 'pmethod', $('#filter_text').val()
          when 8
            formData.append 'qty', $('#filter_text').val()
          when 9
            formData.append 'taxrate', $('#filter_text').val()
          when 10
            formData.append 'price', $('#filter_text').val()
      else if @props.datatype == "medicine_price"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'minam', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'price', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "medicine_prescript_external"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'code', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'cname', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'ename', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'number_id', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'address', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 7
            formData.append 'result_id', $('#filter_text').val()
          when 8
            formData.append 'date', $('#filter_text').val()
      else if @props.datatype == "medicine_external_record"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'cname', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'script_code', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'company', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'amount', $('#filter_text').val()
          when 7
            formData.append 'price', $('#filter_text').val()
          when 8
            formData.append 'total', $('#filter_text').val()
      else if @props.datatype == "medicine_prescript_internal"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'code', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'cname', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'ename', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'number_id', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'preparer', $('#filter_text').val().toLowerCase()
          when 7
            formData.append 'payer', $('#filter_text').val().toLowerCase()
          when 8
            formData.append 'result_id', $('#filter_text').val()
          when 9
            formData.append 'date', $('#filter_text').val()
          when 10
            formData.append 'tpayment', $('#filter_text').val()
          when 11
            formData.append 'discount', $('#filter_text').val()
          when 12
            formData.append 'tpayout', $('#filter_text').val()
          when 13
            formData.append 'pmethod', $('#filter_text').val()
      else if @props.datatype == "medicine_internal_record"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'cname', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'script_code', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'company', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'noid', $('#filter_text').val().toLowerCase()
          when 7
            formData.append 'signid', $('#filter_text').val().toLowerCase()
          when 8
            formData.append 'amount', $('#filter_text').val()
          when 9
            formData.append 'price', $('#filter_text').val()
          when 10
            formData.append 'discount', $('#filter_text').val()
          when 11
            formData.append 'tpayment', $('#filter_text').val()
          when 12
            formData.append 'status', $('#filter_text').val()
      else if @props.datatype == "medicine_stock_record"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'name', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'noid', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'signid', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'supplier', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'bill_in_code', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'internal_record_code', $('#filter_text').val().toLowerCase()
          when 7
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 8
            formData.append 'amount', $('#filter_text').val()
          when 9
            formData.append 'expire', $('#filter_text').val()
          when 10
            formData.append 'typerecord', $('#filter_text').val()
      else if @props.datatype == "customer_record"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'namestring', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'dob', $('#filter_text').val()
          when 3
            formData.append 'gender', $('#filter_text').val()
          when 4
            formData.append 'address', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'pnumber', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'noid', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "service"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'sname', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'price', $('#filter_text').val()
          when 3
            formData.append 'description', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "employee"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'ename', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'address', $('#filter_text').val()
          when 3
            formData.append 'noid', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'pnumber', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'gender', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "room"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'name', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "position"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'pname', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'description', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'rname', $('#filter_text').val()
      else if @props.datatype == "posmap"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'ename', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'pname', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "sermap"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'sname', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'rname', $('#filter_text').val().toLowerCase()
      else if @props.datatype == "order_map"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'cname', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'sername', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'status', $('#filter_text').val()
          when 5
            formData.append 'tpayment', $('#filter_text').val()
          when 6
            formData.append 'discount', $('#filter_text').val()
          when 7
            formData.append 'tpayout', $('#filter_text').val()
      else if @props.datatype == "check_info"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'ename', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'c_name', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'conclude', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'cdoan', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'hdieutri', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'status', $('#filter_text').val()
      else if @props.datatype == "doctor_check_info"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'ename', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'c_name', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'qtbenhly', $('#filter_text').val().toLowerCase()
          when 4
            formData.append 'klamsang', $('#filter_text').val().toLowerCase()
          when 5
            formData.append 'cdbandau', $('#filter_text').val().toLowerCase()
          when 6
            formData.append 'bktheo', $('#filter_text').val().toLowerCase()
          when 7
            formData.append 'cdicd', $('#filter_text').val().toLowerCase()
          when 8
            formData.append 'kluan', $('#filter_text').val()
      else if @props.datatype == "bill_info"
        switch Number($('#filter_type_select').val())
          when 1
            formData.append 'remark', $('#filter_text').val().toLowerCase()
          when 2
            formData.append 'c_name', $('#filter_text').val().toLowerCase()
          when 3
            formData.append 'dvi', $('#filter_text').val()
          when 4
            formData.append 'sluong', $('#filter_text').val()
          when 5
            formData.append 'tpayment', $('#filter_text').val()
          when 6
            formData.append 'discount', $('#filter_text').val()
          when 7
            formData.append 'tpayout', $('#filter_text').val()
      $.ajax
        url: '/' + @props.datatype + '/find'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @props.triggerSubmit result
          return
        ).bind(this)  
    triggerAutoCompleteInput: (e) ->
      e.preventDefault()
      @props.triggerInput $('#filter_text').val(), $('#filter_type_select').val(), option1: $('#checkbox_db').is(':checked')
    triggerAutoComplete: (record) ->
      if @props.datatype == "medicine_supplier"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.noid)
          when 2
            $('#filter_text').val(record.name)
          when 3
            $('#filter_text').val(record.contactname)
          when 4
            $('#filter_text').val(record.spnumber)
          when 5
            $('#filter_text').val(record.pnumber)
          when 6
            $('#filter_text').val(record.address1)
          when 7
            $('#filter_text').val(record.address2)
          when 8
            $('#filter_text').val(record.address3)
          when 9
            $('#filter_text').val(record.mail)
          when 10
            $('#filter_text').val(record.facebook)
          when 11
            $('#filter_text').val(record.twitter)
          when 12
            $('#filter_text').val(record.fax)
          when 13
            $('#filter_text').val(record.taxcode)
      else if @props.datatype == "medicine_company"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.noid)
          when 2
            $('#filter_text').val(record.name)
          when 3
            $('#filter_text').val(record.pnumber)
          when 4
            $('#filter_text').val(record.address)
          when 5
            $('#filter_text').val(record.mail)
          when 6
            $('#filter_text').val(record.website)
          when 7
            $('#filter_text').val(record.taxcode)
      else if @props.datatype == "medicine_sample"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.noid)
          when 2
            $('#filter_text').val(record.name)
          when 5
            $('#filter_text').val(record.company)
          when 6
            $('#filter_text').val(record.price)
          when 7
            $('#filter_text').val(record.weight)
          when 8
            $('#filter_text').val(record.remark)
          when 9
            $('#filter_text').val(record.expire)
      else if @props.datatype == "medicine_bill_in"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.billcode)
          when 2
            $('#filter_text').val(record.supplier)
          when 3
            $('#filter_text').val(record.remark)
      else if @props.datatype == "medicine_bill_record"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.name)
          when 2
            $('#filter_text').val(record.company)
          when 3
            $('#filter_text').val(record.noid)
          when 4
            $('#filter_text').val(record.signid)
          when 5
            $('#filter_text').val(record.remark)
      else if @props.datatype == "medicine_price"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.name)
          when 2
            $('#filter_text').val(record.remark)
      else if @props.datatype == "medicine_prescript_external"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.code)
          when 2
            $('#filter_text').val(record.cname)
          when 3
            $('#filter_text').val(record.ename)
          when 4
            $('#filter_text').val(record.number_id)
          when 5
            $('#filter_text').val(record.address)
          when 6
            $('#filter_text').val(record.remark)
      else if @props.datatype == "medicine_external_record"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.name)
          when 2
            $('#filter_text').val(record.cname)
          when 3
            $('#filter_text').val(record.script_code)
          when 4
            $('#filter_text').val(record.remark)
          when 5
            $('#filter_text').val(record.company)
      else if @props.datatype == "medicine_prescript_internal"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.code)
          when 2
            $('#filter_text').val(record.cname)
          when 3
            $('#filter_text').val(record.ename)
          when 4
            $('#filter_text').val(record.number_id)
          when 5
            $('#filter_text').val(record.remark)
          when 6
            $('#filter_text').val(record.preparer)
          when 7
            $('#filter_text').val(record.payer)
      else if @props.datatype == "medicine_internal_record"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.name)
          when 2
            $('#filter_text').val(record.cname)
          when 3
            $('#filter_text').val(record.script_code)
          when 4
            $('#filter_text').val(record.remark)
          when 5
            $('#filter_text').val(record.company)
          when 6
            $('#filter_text').val(record.noid)
          when 7
            $('#filter_text').val(record.signid)
      else if @props.datatype == "medicine_stock_record"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.name)
          when 2
            $('#filter_text').val(record.noid)
          when 3
            $('#filter_text').val(record.signid)
          when 4
            $('#filter_text').val(record.supplier)
          when 5
            $('#filter_text').val(record.bill_in_code)
          when 6
            $('#filter_text').val(record.internal_record_code)
          when 7
            $('#filter_text').val(record.remark)
      else if @props.datatype == "patient_record"
        switch Number($('#filter_type_select').val())
          when 1
            if record.dob != null
              $('#filter_text').val(record.cname + "," + record.dob.substring(8, 10) + "/" + record.dob.substring(5, 7) + "/" + record.dob.substring(0, 4))
            else
              $('#filter_text').val(record.cname)
          when 4
            $('#filter_text').val(record.address)
      else if @props.datatype == "service"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.sname)
          when 3
            $('#filter_text').val(record.description)
      else if @props.datatype == "employee"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.ename)
          when 2
            $('#filter_text').val(record.address)
          when 3
            $('#filter_text').val(record.noid)
          when 4
            $('#filter_text').val(record.pnumber)
      else if @props.datatype == "room"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.name)
      else if @props.datatype == "position"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.pname)
          when 2
            $('#filter_text').val(record.description)
          when 3
            $('#filer_text').val(record.rname)
      else if @props.datatype == "posmap"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.ename)
          when 2
            $('#filter_text').val(record.pname)
      else if @props.datatype == "sermap"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.sname)
          when 2
            $('#filter_text').val(record.name)
      else if @props.datatype == "order_map"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.cname)
          when 2
            $('#filter_text').val(record.sername)
          when 3
            $('#filter_text').val(record.remark)
      else if @props.datatype == "check_info"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.ename)
          when 2
            $('#filter_text').val(record.c_name)
          when 3
            $('#filter_text').val(record.conclude)
          when 4
            $('#filter_text').val(record.cdoan)
          when 5
            $('#filter_text').val(record.hdieutri)
      else if @props.datatype == "doctor_check_info"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.ename)
          when 2
            $('#filter_text').val(record.c_name)
          when 3
            $('#filter_text').val(record.qtbenhly)
          when 4
            $('#filter_text').val(record.klamsang)
          when 5
            $('#filter_text').val(record.cdbandau)
          when 6
            $('#filter_text').val(record.bktheo)
          when 7
            $('#filter_text').val(record.cdicd)
          when 8
            $('#filter_text').val(record.kluan)
      else if @props.datatype == "bill_info"
        switch Number($('#filter_type_select').val())
          when 1
            $('#filter_text').val(record.remark)
          when 2
            $('#filter_text').val(record.c_name)
      @props.triggerChose record
    triggerChangeType: (e) ->
      if @props.datatype == "medicine_sample"
        switch Number($('#filter_type_select').val())
          when 3
            @setState selectList: @props.typelist
          when 4
            @setState selectList: @props.grouplist
          else
            @setState selectList: null
      else if @props.datatype == "medicine_bill_in"
        switch Number($('#filter_type_select').val())
          when 7
            @setState selectList:[{id: 1, name: "Tiền mặt"},{id: 2, name: "Chuyển khoản"},{id: 3, name: "Khác"}] 
          when 10
            @setState selectList:[{id: 1,name: "Lưu kho"},{id: 2,name: "Đang di chuyển"},{id: 3, name: "Trả lại"}]
          else
            @setState selectList: null
      else if @props.datatype == "medicine_bill_record"
        switch Number($('#filter_type_select').val())
          when 7
            @setState selectList:[{id: 1, name: "Hộp"},{id: 2, name: "Lẻ"}] 
          else
            @setState selectList: null
      else if @props.datatype == "medicine_prescript_internal"
        switch Number($('#filter_type_select').val())
          when 13
            @setState selectList:[{id: 1, name: "Tiền mặt"},{id: 2, name: "Chuyển khoản"},{id: 3, name: "Khác"}]
          else
            @setState selectList: null
      else if @props.datatype == "medicine_internal_record"
        switch Number($('#filter_type_select').val())
          when 12
            @setState selectList:[{id: 1, name: "Đã chuyển hàng"},{id: 2, name: "Chưa chuyển hàng"},{id: 3, name: "Hàng trả lại"}]
          else
            @setState selectList: null
      else if @props.datatype == "medicine_stock_record"
        switch Number($('#filter_type_select').val())
          when 10
            @setState selectList:[{id: 1, name: "Nhập"},{id: 2, name: "Xuất"},{id: 3, name: "Vô hiệu"}]
          else
            @setState selectList: null
      else if @props.datatype == "patient_record"
        switch Number($('#filter_type_select').val())
          when 3
            @setState selectList:[{id: 1, name: "Nam"},{id: 2, name: "Nữ"}]
          else
            @setState selectList: null
      else if @props.datatype == "employee"
        switch Number($('#filter_type_select').val())
          when 5
            @setState selectList:[{id: 1, name: "Nam"},{id: 2, name: "Nữ"}]
          else
            @setState selectList: null
      else if @props.datatype == "order_map"
        switch Number($('#filter_type_select').val())
          when 4
            @setState selectList: [{id: 1, name: "Chưa thanh toán, chưa khám bệnh"},{id: 2, name: "Đã thanh toán, đang chờ khám"},{id: 3, name: "Đã thanh toán, đã khám bệnh"},{id: 4, name: "Chưa thanh toán, đã khám bệnh"}]
          else
            @setState selectList: null
      else if @props.datatype == "check_info"
        switch Number($('#filter_type_select').val())
          when 6
            @setState selectList: [{id: 1, name: "Chưa khám"},{id: 2, name: "Đang khám"},{id: 3, name: "Kết thúc khám"}]
          else
            @setState selectList: null
      else if @props.datatype == "bill_info"
        switch Number($('#filter_type_select').val())
          when 3
            @setState selectList: @props.dvi
          else
            @setState selectList: null
    triggerClear: (e) ->
      $('#filter_text').val("")
      @props.triggerClear e
    MedicineSupplier: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Mã'
              React.DOM.option value: 2, 'Tên nguồn'
              React.DOM.option value: 3, 'Người liên lạc'
              React.DOM.option value: 4, 'Số ĐT cố định'
              React.DOM.option value: 5, 'Số ĐT di động'
              React.DOM.option value: 6, 'Địa chỉ 1'
              React.DOM.option value: 7, 'Địa chỉ 2'
              React.DOM.option value: 8, 'Địa chỉ 3'
              React.DOM.option value: 9, 'Email'
              React.DOM.option value: 10, 'Link Facebook'
              React.DOM.option value: 11, 'Twitter'
              React.DOM.option value: 12, 'Fax'
              React.DOM.option value: 13, 'Mã số thuế'
          React.DOM.div className: 'col-sm-8',
            React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  if Number($('#filter_type_select').val()) == 1
                    React.createElement AutoComplete, key: record.id, text: record.noid, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 2
                    React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 3
                    React.createElement AutoComplete, key: record.id, text: record.contactname, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 4
                    React.createElement AutoComplete, key: record.id, text: record.spnumber, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 5
                    React.createElement AutoComplete, key: record.id, text: record.pnumber, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 6
                    React.createElement AutoComplete, key: record.id, text: record.address1, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 7
                    React.createElement AutoComplete, key: record.id, text: record.address2, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 8
                    React.createElement AutoComplete, key: record.id, text: record.address3, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 9
                    React.createElement AutoComplete, key: record.id, text: record.email, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 10
                    React.createElement AutoComplete, key: record.id, text: record.facebook, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 11
                    React.createElement AutoComplete, key: record.id, text: record.twitter, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 12
                    React.createElement AutoComplete, key: record.id, text: record.fax, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 13
                    React.createElement AutoComplete, key: record.id, text: record.taxcode, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicineCompany: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Mã'
              React.DOM.option value: 2, 'Tên doanh nghiệp'
              React.DOM.option value: 3, 'Số ĐT'
              React.DOM.option value: 4, 'Địa chỉ'
              React.DOM.option value: 5, 'Email'
              React.DOM.option value: 6, 'Website'
              React.DOM.option value: 7, 'Mã số thuế'
          React.DOM.div className: 'col-sm-8',
            React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  if Number($('#filter_type_select').val()) == 1
                    React.createElement AutoComplete, key: record.id, text: record.noid, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 2
                    React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 3
                    React.createElement AutoComplete, key: record.id, text: record.pnumber, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 4
                    React.createElement AutoComplete, key: record.id, text: record.address, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 5
                    React.createElement AutoComplete, key: record.id, text: record.email, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 6
                    React.createElement AutoComplete, key: record.id, text: record.website, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 7
                    React.createElement AutoComplete, key: record.id, text: record.taxcode, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicineSample: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Mã'
              React.DOM.option value: 2, 'Tên thuốc'
              React.DOM.option value: 3, 'Loại thuốc'
              React.DOM.option value: 4, 'Nhóm thuốc'
              React.DOM.option value: 5, 'Công ty sản xuất'
              React.DOM.option value: 6, 'Giá'
              React.DOM.option value: 7, 'Khối lượng'
              React.DOM.option value: 8, 'Ghi chú'
              React.DOM.option value: 9, 'Hạn sử dụng'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  if Number($('#filter_type_select').val()) == 1
                    React.createElement AutoComplete, key: record.id, text: record.noid, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 2
                    React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 5
                    React.createElement AutoComplete, key: record.id, text: record.company, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 6
                    React.createElement AutoComplete, key: record.id, text: record.price, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 7
                    React.createElement AutoComplete, key: record.id, text: record.weight, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 8
                    React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 9
                    React.createElement AutoComplete, key: record.id, text: record.expire, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicineBillIn: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Số hóa đơn'
              React.DOM.option value: 2, 'Người cung cấp'
              React.DOM.option value: 3, 'Ghi chú'
              React.DOM.option value: 4, 'Ngày nhập'
              React.DOM.option value: 5, 'Ngày đặt hàng'
              React.DOM.option value: 6, 'Cách thanh toán'
              React.DOM.option value: 7, 'Tổng giá hàng hóa'
              React.DOM.option value: 8, 'Giảm giá'
              React.DOM.option value: 9, 'Tổng giá thanh toán'
              React.DOM.option value: 10, 'Tình trạng hóa đơn'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  if Number($('#filter_type_select').val()) == 1
                    React.createElement AutoComplete, key: record.id, text: record.billcode, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 2
                    React.createElement AutoComplete, key: record.id, text: record.supplier, record: record, trigger: @triggerAutoComplete
                  else if Number($('#filter_type_select').val()) == 3
                    React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicineBillRecord: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên thuốc'
              React.DOM.option value: 2, 'Công ty sản xuất'
              React.DOM.option value: 3, 'Số hiệu'
              React.DOM.option value: 4, 'Ký hiệu'
              React.DOM.option value: 5, 'Ghi chú'
              React.DOM.option value: 6, 'Hạn sử dụng'
              React.DOM.option value: 7, 'Cách mua'
              React.DOM.option value: 8, 'Số lượng'
              React.DOM.option value: 9, '% thuế'
              React.DOM.option value: 10, 'Giá'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.company, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.noid, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.signid, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicinePrice: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên thuốc'
              React.DOM.option value: 2, 'Ghi chú'
              React.DOM.option value: 3, 'Số lượng tối thiểu'
              React.DOM.option value: 4, 'Giá'
          React.DOM.div className: 'col-sm-8',
            React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicinePrescriptExternal: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Mã đơn thuốc'
              React.DOM.option value: 2, 'Bệnh nhân'
              React.DOM.option value: 3, 'Người kê đơn'
              React.DOM.option value: 4, 'Số khám bệnh'
              React.DOM.option value: 5, 'Địa chỉ mua thuốc'
              React.DOM.option value: 6, 'Ghi chú'
              React.DOM.option value: 7, 'Kết quả khám'
              React.DOM.option value: 8, 'Ngày kê'
          React.DOM.div className: 'col-sm-8',
            React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.code, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.cname, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.ename, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.number_id, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.address, record: record, trigger: @triggerAutoComplete
                    when 6
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicineExternalRecord: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên thuốc'
              React.DOM.option value: 2, 'Tên bệnh nhân'
              React.DOM.option value: 3, 'Mã đơn thuốc'
              React.DOM.option value: 4, 'Ghi chú'
              React.DOM.option value: 5, 'Công ty sản xuất'
              React.DOM.option value: 6, 'Liều lượng'
              React.DOM.option value: 7, 'Giá'
              React.DOM.option value: 8, 'Tổng tiền'
          React.DOM.div className: 'col-sm-8',
            React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.cname, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.script_code, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.company, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicinePrescriptInternal: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Mã đơn thuốc'
              React.DOM.option value: 2, 'Bệnh nhân'
              React.DOM.option value: 3, 'Người kê đơn'
              React.DOM.option value: 4, 'Số khám bệnh'
              React.DOM.option value: 5, 'Ghi chú'
              React.DOM.option value: 6, 'Người chuẩn bị thuốc'
              React.DOM.option value: 7, 'Người thanh toán'
              React.DOM.option value: 8, 'Số kết quả khám'
              React.DOM.option value: 9, 'Ngày kê'
              React.DOM.option value: 10, 'Tổng giá trị'
              React.DOM.option value: 11, 'Giảm giá'
              React.DOM.option value: 12, 'Tổng tiền thanh toán'
              React.DOM.option value: 13, 'Cách thanh toán'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.code, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.cname, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.ename, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.number_id, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
                    when 6
                      React.createElement AutoComplete, key: record.id, text: record.preparer, record: record, trigger: @triggerAutoComplete
                    when 7
                      React.createElement AutoComplete, key: record.id, text: record.payer, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicineInternalRecord: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên thuốc'
              React.DOM.option value: 2, 'Tên bệnh nhân'
              React.DOM.option value: 3, 'Mã đơn thuốc'
              React.DOM.option value: 4, 'Ghi chú'
              React.DOM.option value: 5, 'Công ty sản xuất'
              React.DOM.option value: 6, 'Số kiệu'
              React.DOM.option value: 7, 'Ký hiệu'
              React.DOM.option value: 8, 'Liều lượng'
              React.DOM.option value: 9, 'Giá'
              React.DOM.option value: 10, 'Giảm giá'
              React.DOM.option value: 11, 'Tổng giá trị'
              React.DOM.option value: 12, 'Tình trạng'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.cname, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.script_code, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.company, record: record, trigger: @triggerAutoComplete
                    when 6
                      React.createElement AutoComplete, key: record.id, text: record.noid, record: record, trigger: @triggerAutoComplete
                    when 7
                      React.createElement AutoComplete, key: record.id, text: record.signid, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    MedicineStockRecord: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên thuốc'
              React.DOM.option value: 2, 'Kí hiệu'
              React.DOM.option value: 3, 'Số hiệu'
              React.DOM.option value: 4, 'Nguồn cung cấp'
              React.DOM.option value: 5, 'Mã hóa đơn vào'
              React.DOM.option value: 6, 'Mã đơn thuốc trong'
              React.DOM.option value: 7, 'Ghi chú'
              React.DOM.option value: 8, 'Số lượng'
              React.DOM.option value: 9, 'Hạn sử dụng'
              React.DOM.option value: 10, 'Tình trạng'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.name, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.noid, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.signid, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.supplier, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.bill_in_code, record: record, trigger: @triggerAutoComplete
                    when 6
                      React.createElement AutoComplete, key: record.id, text: record.internal_record_code, record: record, trigger: @triggerAutoComplete
                    when 7
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    CustomerRecord: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên bệnh nhân'
              React.DOM.option value: 2, 'Ngày sinh'
              React.DOM.option value: 3, 'Giới tính'
              React.DOM.option value: 4, 'Địa chỉ'
              React.DOM.option value: 5, 'Số điện thoại'
              React.DOM.option value: 6, 'CMTND'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...', name: 'filterText'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text:
                        if record.dob != null
                          record.cname + "," + record.dob.substring(8, 10) + "/" + record.dob.substring(5, 7) + "/" + record.dob.substring(0, 4)
                        else
                          record.cname
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.address, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    Service: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên dịch vụ'
              React.DOM.option value: 2, 'Giá'
              React.DOM.option value: 3, 'Mô tả dịch vụ'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...', name: 'filterText'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.sname
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.description, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    Employee: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên nhân viên'
              React.DOM.option value: 2, 'Địa chỉ'
              React.DOM.option value: 3, 'Mã số'
              React.DOM.option value: 4, 'Số điện thoại'
              React.DOM.option value: 5, 'Giới tính'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...', name: 'filterText'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.ename
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.address, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.noid
                    when 4
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.pnumber                    
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"    
    Room: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên phòng'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...', name: 'filterText'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.name
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    Position: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên chức vụ'
              React.DOM.option value: 2, 'Mô tả'
              React.DOM.option value: 3, 'Phòng'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...', name: 'filterText'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.pname
                    when 2
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.description
                    when 3
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.rname                      
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    PosMap: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên nhân viên'
              React.DOM.option value: 2, 'Tên chức vụ'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...', name: 'filterText'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.ename
                    when 2
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.pname                     
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    SerMap: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên dịch vụ'
              React.DOM.option value: 2, 'Tên phòng'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...', name: 'filterText'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.sname
                    when 2
                      React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoComplete, text: record.name                      
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    OrderMap: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên bệnh nhân'
              React.DOM.option value: 2, 'Tên dịch vụ'
              React.DOM.option value: 3, 'Ghi chú'
              React.DOM.option value: 4, 'Tình trạng'
              React.DOM.option value: 5, 'Tổng đơn giá'
              React.DOM.option value: 6, 'Giảm giá'
              React.DOM.option value: 7, 'Tổng thanh toán'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.cname, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.sername, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    CheckInfo: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên bác sỹ'
              React.DOM.option value: 2, 'Tên bệnh nhân'
              React.DOM.option value: 3, 'Kết luận'
              React.DOM.option value: 4, 'Chuẩn đoán'
              React.DOM.option value: 5, 'Hướng điều trị'
              React.DOM.option value: 6, 'Tình trạng'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.ename, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.c_name, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.conclude, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.cdoan, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.hdieutri, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    DoctorCheckInfo: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Tên bác sỹ'
              React.DOM.option value: 2, 'Tên bệnh nhân'
              React.DOM.option value: 3, 'Quá trình bệnh lý'
              React.DOM.option value: 4, 'Khám lâm sàng'
              React.DOM.option value: 5, 'Chuẩn đoán ban đầu'
              React.DOM.option value: 6, 'Bệnh kèm theo'
              React.DOM.option value: 7, 'Chuẩn đoán ICD'
              React.DOM.option value: 8, 'Kết luận'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.ename, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.c_name, record: record, trigger: @triggerAutoComplete
                    when 3
                      React.createElement AutoComplete, key: record.id, text: record.qtbenhly, record: record, trigger: @triggerAutoComplete
                    when 4
                      React.createElement AutoComplete, key: record.id, text: record.klamsang, record: record, trigger: @triggerAutoComplete
                    when 5
                      React.createElement AutoComplete, key: record.id, text: record.cdbandau, record: record, trigger: @triggerAutoComplete
                    when 6
                      React.createElement AutoComplete, key: record.id, text: record.bktheo, record: record, trigger: @triggerAutoComplete
                    when 7
                      React.createElement AutoComplete, key: record.id, text: record.cdicd, record: record, trigger: @triggerAutoComplete
                    when 8
                      React.createElement AutoComplete, key: record.id, text: record.kluan, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    BillInfo: ->
      React.DOM.form className: 'form-horizontal row', autoComplete: 'off', onSubmit: @handleSubmit,
        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
          React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
            React.DOM.select id: 'filter_type_select', className: 'form-control', name: 'filterType', onChange: @triggerChangeType,
              React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
              React.DOM.option value: 1, 'Diễn giải'
              React.DOM.option value: 2, 'Tên bệnh nhân'
              React.DOM.option value: 3, 'Đơn vị'
              React.DOM.option value: 4, 'Số lượng'
              React.DOM.option value: 5, 'Đơn giá'
              React.DOM.option value: 6, 'Giảm giá'
              React.DOM.option value: 7, 'Tổng thanh toán'
          React.DOM.div className: 'col-sm-8',
            if @state.selectList == null
              React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
            else
              React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
            React.DOM.div className: "auto-complete",
              if @props.autoComplete != null
                for record in @props.autoComplete
                  switch Number($('#filter_type_select').val())
                    when 1
                      React.createElement AutoComplete, key: record.id, text: record.remark, record: record, trigger: @triggerAutoComplete
                    when 2
                      React.createElement AutoComplete, key: record.id, text: record.c_name, record: record, trigger: @triggerAutoComplete
        React.DOM.div className: 'col-lg-6 text-center',
          React.DOM.div className: 'btn-group col-sm-9 text-center',
            React.DOM.button type: 'submit', className: 'btn btn-group-left',
              React.DOM.i className: 'zmdi zmdi-search'
              ' Tìm kiếm'
            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
              React.DOM.i className: 'zmdi zmdi-close'
              ' Về ban đầu'
          React.DOM.div className: 'form-group col-sm-3',
            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
              React.DOM.input id: 'checkbox_db', type: 'checkbox'  
              "Gợi ý"
    render: ->
      if @props.datatype == "medicine_supplier"
        @MedicineSupplier()
      else if @props.datatype == "medicine_company"
        @MedicineCompany()
      else if @props.datatype == "medicine_sample"
        @MedicineSample()
      else if @props.datatype == "medicine_bill_in"
        @MedicineBillIn()
      else if @props.datatype == "medicine_bill_record"
        @MedicineBillRecord()
      else if @props.datatype == "medicine_price"
        @MedicinePrice()
      else if @props.datatype == "medicine_prescript_external"
        @MedicinePrescriptExternal()
      else if @props.datatype == "medicine_external_record"
        @MedicineExternalRecord()
      else if @props.datatype == "medicine_prescript_internal"
        @MedicinePrescriptInternal()
      else if @props.datatype == "medicine_internal_record"
        @MedicineInternalRecord()
      else if @props.datatype == "medicine_stock_record"
        @MedicineStockRecord()
      else if @props.datatype == "customer_record"
        @CustomerRecord()
      else if @props.datatype == "service"
        @Service()
      else if @props.datatype == "employee"
        @Employee()
      else if @props.datatype == "room"
        @Room()
      else if @props.datatype == "position"
        @Position()
      else if @props.datatype == "posmap"
        @PosMap()
      else if @props.datatype == "sermap"
        @SerMap()
      else if @props.datatype == "order_map"
        @OrderMap()
      else if @props.datatype == "check_info"
        @CheckInfo()
      else if @props.datatype == "doctor_check_info"
        @DoctorCheckInfo()
      else if @props.datatype == "bill_info"
        @BillInfo()

@SupportForm = React.createClass
    getInitialState: ->
      type: null
    handleSubmit: (e) ->
      if @props.datatype == 'comment'
        if @props.record != null
          e.preventDefault()
          formData = new FormData
          formData.append 'id', @props.record.id
          formData.append 'comment', $('#support_comment_infomation_add').val()
          if $('#support_comment_attachment_add')[0].files[0] != undefined
            formData.append 'attachment', $('#support_comment_attachment_add')[0].files[0]
          $.ajax
            url: '/support/comment'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @props.trigger result
              $('#support_comment_infomation_add').val('')
              $('#support_comment_attachment_add').val('')
              return
            ).bind(this)
      else if @props.datatype == 'ticket'
        e.preventDefault()
        formData = new FormData
        formData.append 'title', $('#support_ticket_title_add').val()
        formData.append 'infomation', $('#support_ticket_infomation_add').val()
        if $('#support_ticket_attachment_add')[0].files[0] != undefined
          formData.append 'attachment', $('#support_ticket_attachment_add')[0].files[0]
        $.ajax
          url: '/support/ticket'
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
    CommentForm: ->
      React.DOM.div className: 'mbl-compose',
        React.DOM.textarea id: 'support_comment_infomation_add', placeholder: 'Viết phản hồi của bạn tại đây', defaultValue: ''
        React.DOM.button onClick: @handleSubmit,
          React.DOM.i className: 'zmdi zmdi-mail-send',
        React.DOM.label htmlFor: "support_comment_attachment_add", style: {'cursor':'pointer'},
          React.DOM.i className: 'fa fa-file',
        React.DOM.input id: 'support_comment_attachment_add', type: 'file', style: {'display': 'none'}
    TicketForm: ->
      React.DOM.form className: 'form-horizontal', onSubmit: @handleSubmit, autoComplete: 'off',
        React.DOM.div className: 'form-group',
          React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tiêu đề'
          React.DOM.div className: 'col-sm-9',
            React.createElement InputField, id: 'support_ticket_title_add', className: 'form-control', type: 'text', code: '', placeholder: 'Tiêu đề', trigger: @trigger, trigger2: @trigger, trigger3: @trigger, defaultValue: ""
        React.DOM.div className: 'form-group',
          React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nội dung'
          React.DOM.div className: 'col-sm-9',
            React.DOM.textarea id: 'support_ticket_infomation_add', rows: '5', className: 'form-control', placeholder: 'Nội dung', defaultValue: ""
        React.DOM.div className: 'form-group',
          React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tệp đính kèm'
          React.DOM.div className: 'col-sm-4',
            React.DOM.input id:'support_ticket_attachment_add', type: 'file'
        React.DOM.button type: 'submit', className: 'btn btn-default pull-right', 'Gửi yêu cầu hỗ trợ'
    render: ->
      if @props.datatype == 'comment'
        @CommentForm()
      else if @props.datatype == 'ticket'
        @TicketForm()