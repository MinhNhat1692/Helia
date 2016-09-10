  @RecordForm = React.createClass
    getInitialState: ->
      title: ''
      date: ''
      amount: ''
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'ename', $('#employee_quick_ename').val()
      formData.append 'email', $('#employee_quick_email').val()
      formData.append 'address', $('#employee_quick_address').val()
      formData.append 'pnumber', $('#employee_quick_pnumber').val()
      formData.append 'noid', $('#employee_quick_noid').val()
      formData.append 'gender', $('#employee_quick_gender').val()
      if $('#employee_quick_avatar')[0].files[0] != undefined
        formData.append 'avatar', $('#employee_quick_avatar')[0].files[0]
      $.ajax
        url: '/employee'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @props.handleEmployeeRecord result
          @setState @getInitialState()
          return
        ).bind(this)
    render: ->
      React.DOM.form
        id: 'employee_quick'
        encType: 'multipart/form-data'
        className: 'form-horizontal row'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'employee_quick_ename'
              type: 'text'
              className: 'form-control'
              placeholder: 'Họ và tên'
              name: 'ename'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'employee_quick_address'
              type: 'text'
              className: 'form-control'
              placeholder: 'Địa chỉ'
              name: 'address'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'employee_quick_pnumber'
              type: 'number'
              className: 'form-control'
              placeholder: 'Số ĐT'
              name: 'pnumber'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'employee_quick_noid'
              type: 'number'
              className: 'form-control'
              placeholder: 'SốCMTND'
              name: 'noid'
        React.DOM.div
          className: 'form-group col-lg-4 col-sm-6'
          React.DOM.div
            className: 'col-sm-6'
            style: {'marginBottom': '15px'}
            React.DOM.select
              id: 'employee_quick_gender'
              className: 'form-control'
              name: 'gender'
              React.DOM.option
                value: ''
                'Giới tính'
              React.DOM.option
                value: '1'
                'Nam'
              React.DOM.option
                value: '2'
                'Nữ'
          React.DOM.div
            className: 'col-sm-5'
            React.DOM.input
              id: 'employee_quick_avatar'
              type: 'file'
              className: 'form-control'
              name: 'avatar'
        React.DOM.button
          type: 'submit'
          className: 'btn bg-green col-lg-1 col-md-4 col-sm-6'
          React.DOM.i
            className: 'zmdi zmdi-plus'
          ' Thêm'
    

  @RoomForm = React.createClass
    getInitialState: ->
      type: 1
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'name', $('#room_quick_name').val()
      formData.append 'lang', $('#room_quick_lang').val()
      if $('#room_quick_map')[0].files[0] != undefined
        formData.append 'map', $('#room_quick_map')[0].files[0]
      $.ajax
        url: '/rooms'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @props.handleRoomAdd result
          @setState @getInitialState()
          return
        ).bind(this)
    render: ->
      React.DOM.form
        id: 'room_quick'
        encType: 'multipart/form-data'
        className: 'form-horizontal row'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group col-lg-6 col-sm-12'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'room_quick_name'
              type: 'text'
              className: 'form-control'
              placeholder: 'Tên phòng'
              name: 'name'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'room_quick_lang'
              type: 'text'
              className: 'form-control'
              placeholder: 'Ngôn ngữ hiển thị'
              name: 'lang'
              defaultValue: 'vi'
        React.DOM.div
          className: 'form-group col-lg-3 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'room_quick_map'
              type: 'file'
              className: 'form-control'
              name: 'map'
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          'Create record'
  
          
  @ServiceForm = React.createClass
    getInitialState: ->
      type: 1
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'sname', $('#service_quick_sname').val()
      formData.append 'lang', $('#service_quick_lang').val()
      formData.append 'price', $('#service_quick_price').val()
      formData.append 'currency', $('#service_quick_currency').val()
      formData.append 'description', $('#service_quick_description').val()
      if $('#service_quick_file')[0].files[0] != undefined
        formData.append 'file', $('#service_quick_file')[0].files[0]
      $.ajax
        url: '/services'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @props.handleServiceAdd result
          @setState @getInitialState()
          return
        ).bind(this)
    render: ->
      React.DOM.form
        id: 'service_quick'
        encType: 'multipart/form-data'
        className: 'form-horizontal row'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group col-lg-4 col-sm-8'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'service_quick_sname'
              type: 'text'
              className: 'form-control'
              placeholder: 'Tên dịch vụ'
              name: 'sname'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-4'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'service_quick_lang'
              type: 'text'
              className: 'form-control'
              placeholder: 'Ngôn ngữ hiển thị'
              name: 'lang'
              defaultValue: 'vi'
        React.DOM.div
          className: 'form-group col-lg-3 col-sm-3'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'service_quick_price'
              type: 'number'
              className: 'form-control'
              placeholder: 'Giá dịch vụ'
              name: 'price'
        React.DOM.div
          className: 'form-group col-lg-3 col-sm-3'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'service_quick_currency'
              type: 'text'
              className: 'form-control'
              placeholder: 'Đơn vị giá'
              defaultValue: 'VND'
              name: 'currency'
        React.DOM.div
          className: 'form-group col-lg-8 col-sm-6'
          React.DOM.div
            className: 'col-lg-12'
            React.DOM.textarea
              className: 'form-control col-lg-12'
              rows: 3
              id: 'service_quick_description'
              placeholder: 'Mô tả ngắn dịch vụ'
              name: 'description'
        React.DOM.div
          className: 'form-group col-lg-4 col-sm-4'
          React.DOM.div
            className: 'col-sm-6'
            React.DOM.input
              id: 'service_quick_file'
              type: 'file'
              className: 'form-control'
              name: 'file'
          React.DOM.button
            type: 'submit'
            className: 'btn btn-primary col-sm-6'
            'Create record'

  
  @PatientForm = React.createClass
    getInitialState: ->
      type: 1
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'sname', $('#service_quick_sname').val()
      formData.append 'lang', $('#service_quick_lang').val()
      formData.append 'price', $('#service_quick_price').val()
      formData.append 'currency', $('#service_quick_currency').val()
      formData.append 'description', $('#service_quick_description').val()
      if $('#service_quick_file')[0].files[0] != undefined
        formData.append 'file', $('#service_quick_file')[0].files[0]
      $.ajax
        url: '/services'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @props.handleServiceAdd result
          @setState @getInitialState()
          return
        ).bind(this)
    render: ->
      React.DOM.form
        id: 'patient_quick'
        className: 'form-horizontal row'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group col-lg-3 col-sm-8'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'patient_quick_name'
              type: 'text'
              className: 'form-control'
              placeholder: 'Tên BN'
              name: 'name'
        React.DOM.div
          className: 'form-group col-lg-3 col-sm-4'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'patient_quick_dob'
              type: 'date'
              className: 'form-control'
              placeholder: 'DOB'
              name: 'dob'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'patient_quick_noid'
              type: 'text'
              className: 'form-control'
              placeholder: 'CMTND'
              name: 'noid'
        React.DOM.div
          className: 'form-group col-lg-3 col-sm-6'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'patient_quick_pnumber'
              type: 'text'
              className: 'form-control'
              placeholder: 'SDT'
              name: 'pnumber'
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          style: {'marginRight': '5px'}
          'Filter'
        React.DOM.button
          type: 'button'
          className: 'btn btn-primary'
          'Clear'


  @PositionForm = React.createClass
    getInitialState: ->
      rooms: @props.rooms
      type: 1
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'room', $('#position_quick_room').val()
      formData.append 'pname', $('#position_quick_pname').val()
      formData.append 'lang', $('#position_quick_lang').val()
      formData.append 'description', $('#position_quick_description').val()
      if $('#position_quick_file')[0].files[0] != undefined
        formData.append 'file', $('#position_quick_file')[0].files[0]
      $.ajax
        url: '/positions'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @props.handlePositionAdd result
          @setState @getInitialState()
          return
        ).bind(this)
    positionFormRender: ->
      React.DOM.form
        id: 'position_quick'
        encType: 'multipart/form-data'
        className: 'form-horizontal row'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-9'
          React.DOM.div
            className: 'col-sm-12'
            React.createElement SelectBox, records: @state.rooms, type: 1, id: 'position_quick_room', text: 'Tên phòng'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-9'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'position_quick_pname'
              type: 'text'
              className: 'form-control'
              placeholder: 'Tên chức vụ'
              name: 'pname'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-3'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'position_quick_lang'
              type: 'text'
              className: 'form-control'
              placeholder: 'Ngôn ngữ hiển thị'
              name: 'lang'
              defaultValue: 'vi'
        React.DOM.div
          className: 'form-group col-lg-5 col-sm-8'
          React.DOM.div
            className: 'col-lg-12'
            React.DOM.textarea
              className: 'form-control col-lg-12'
              rows: 3
              id: 'position_quick_description'
              placeholder: 'Mô tả ngắn công việc'
              name: 'description'
        React.DOM.div
          className: 'form-group col-lg-2 col-sm-4'
          React.DOM.div
            className: 'col-sm-12'
            React.DOM.input
              id: 'position_quick_file'
              type: 'file'
              className: 'form-control'
              name: 'file'
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          'Create record'
    render: ->
      if @state.type == 1
        @positionFormRender()
  
  
  @FilterForm = React.createClass
    getInitialState: ->
      type: 0
    triggerAutoCompleteInput: (e) ->
      e.preventDefault()
      @props.triggerInput $('#filter_text').val(), $('#filter_type_select').val(), option1: $('#checkbox_db').is(':checked')
    triggerAutoComplete: (record) ->
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
      
    triggerChangeType: (e) ->
      console.log(1)
    MedicineSupplier: ->
      React.DOM.form
        className: 'form-horizontal row'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group col-lg-6 col-sm-12'
          React.DOM.div
            className: 'col-sm-4'
            style: {'marginBottom': '15px'}
            React.DOM.select
              id: 'filter_type_select'
              className: 'form-control'
              name: 'filterType'
              onChange: @triggerChangeType
              React.DOM.option
                value: ''
                'Chọn tiêu chuẩn lọc'
              React.DOM.option
                value: 1
                'Mã'
              React.DOM.option
                value: 2
                'Tên nguồn'
              React.DOM.option
                value: 3
                'Người liên lạc'
              React.DOM.option
                value: 4
                'Số ĐT cố định'
              React.DOM.option
                value: 5
                'Số ĐT di động'
              React.DOM.option
                value: 6
                'Địa chỉ 1'
              React.DOM.option
                value: 7
                'Địa chỉ 2'
              React.DOM.option
                value: 8
                'Địa chỉ 3'
              React.DOM.option
                value: 9
                'Email'
              React.DOM.option
                value: 10
                'Link Facebook'
              React.DOM.option
                value: 11
                'Twitter'
              React.DOM.option
                value: 12
                'Fax'
              React.DOM.option
                value: 13
                'Mã số thuế'
          React.DOM.div
            className: 'col-sm-8'
            React.DOM.input
              id: 'filter_text'
              type: 'text'
              className: 'form-control'
              defaultValue: ''
              onChange: @triggerAutoCompleteInput
              placeholder: 'Type here ...'
              name: 'filterText'
            React.DOM.div
              className: "auto-complete"
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
        React.DOM.button
          type: 'submit'
          className: 'btn bg-green col-lg-1 col-md-4 col-sm-6'
          React.DOM.i
            className: 'zmdi zmdi-search'
          ' Tìm kiếm'
        React.DOM.button
          type: 'submit'
          className: 'btn bg-green col-lg-1 col-md-4 col-sm-6'
          React.DOM.i
            className: 'zmdi zmdi-close'
          ' Clear'
        React.DOM.div
          className: 'form-group col-lg-4 col-sm-12'
          React.DOM.label
            className: 'checkbox checkbox-inline m-r-20'
            React.DOM.input
              type: 'checkbox'
              id: 'checkbox_db'
            "Tìm kỹ (chậm và đầy đủ)"
    render: ->
      if @props.datatype == "medicine_supplier"
        @MedicineSupplier()