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
    