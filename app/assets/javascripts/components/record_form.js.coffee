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
            className: 'col-sm-6'
            React.DOM.input
              id: 'employee_quick_avatar'
              type: 'file'
              className: 'form-control'
              name: 'avatar'
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          'Create record'
    

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
              value: 'vi'
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
              value: 'vi'
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
              value: 'VND'
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
              value: 'vi'
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
