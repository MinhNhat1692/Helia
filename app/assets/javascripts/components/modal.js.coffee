  @Modal = React.createClass
    getInitialState: ->
      type: @props.type
    componentDidMount: ->
      $(ReactDOM.findDOMNode(this)).modal 'show'
      $(ReactDOM.findDOMNode(this)).on 'hidden.bs.modal', @props.handleHideModal
    take_snapshot: ->
      Webcam.snap (data_uri) ->
        document.getElementById('results').innerHTML = '<h2>Here is your large image:</h2>' + '<img id="webcamout" src="' + data_uri + '"/>'
        return
      return
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'ename', $('#employee_form_ename').val()
      formData.append 'email', $('#employee_form_email').val()
      formData.append 'address', $('#employee_form_address').val()
      formData.append 'pnumber', $('#employee_form_pnumber').val()
      formData.append 'noid', $('#employee_form_noid').val()
      formData.append 'gender', $('#employee_form_gender').val()
      if $('#employee_form_avatar')[0].files[0] != undefined
        formData.append 'avatar', $('#employee_form_avatar')[0].files[0]
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
    handleSubmitCustomerRecord: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'name', $('#customer_form_name').val()
      formData.append 'dob', $('#customer_form_dob').val()
      formData.append 'address', $('#customer_form_address').val()
      formData.append 'pnumber', $('#customer_form_pnumber').val()
      formData.append 'noid', $('#customer_form_noid').val()
      formData.append 'gender', $('#customer_form_gender').val()
      if $('#customer_form_avatar')[0].files[0] != undefined
        formData.append 'avatar', $('#customer_form_avatar')[0].files[0]
      else if $('#webcamout') != undefined
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
          return
        ).bind(this)
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
                'Employee Form'
              React.DOM.small
                'Description'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-lg-12'
                  React.DOM.p null, 'Detail for this modal - short'
                  React.DOM.form
                    id: 'employee_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmit
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Email'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'employee_form_email'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Nhập email của nhân viên để giúp việc nhập thông tin nhanh hơn'
                          name: 'email'
                    React.DOM.hr null
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Họ và Tên'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'employee_form_ename'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Họ và tên'
                          name: 'ename'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Địa chỉ'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'employee_form_address'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Địa chỉ'
                          name: 'address'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Số ĐT'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'employee_form_pnumber'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'Số ĐT'
                          name: 'pnumber'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'CMTND'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'employee_form_noid'
                          type: 'number'
                          className: 'form-control'
                          placeholder: 'SốCMTND'
                          name: 'noid'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Giới tính'
                      React.DOM.div
                        className: 'col-sm-4'
                        React.DOM.select
                          id: 'employee_form_gender'
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
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Ảnh đại diện'
                      React.DOM.div
                        className: 'col-sm-4'
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
              React.DOM.small
                'Description'
            React.DOM.div
              className: 'modal-body'
              React.DOM.div
                className: 'row'
                React.DOM.div
                  className: 'col-md-8'
                  React.DOM.p null, 'Detail for this modal - short'
                  React.DOM.form
                    id: 'customer_record_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmitCustomerRecord
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
                          dataContainer: "body"
                          className: 'form-control'
                          placeholder: '31/01/1990'
                          name: 'dob'
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
                          placeholder: 'SốCMTND'
                          name: 'noid'
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
                  className: 'col-md-4'
                  React.DOM.div
                    id: 'results'
                    'Your captured image will appear here...'
                  React.DOM.div
                    id: 'my_camera'
                    Webcam.set
                      width: 320
                      height: 240
                      dest_width: 320
                      dest_height: 240
                      crop_width: 240
                      crop_height: 240
                      image_format: 'jpeg'
                      jpeg_quality: 90
                    Webcam.attach '#my_camera'
                  React.DOM.button
                    type: 'button'
                    value: 'take Large Snapshot'
                    onClick: @take_snapshot
                    name: 'close'
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