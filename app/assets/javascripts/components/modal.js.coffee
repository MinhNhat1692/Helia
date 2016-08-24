@Modal = React.createClass
    getInitialState: ->
      type: @props.data.type
    componentDidMount: ->
      $(ReactDOM.findDOMNode(this)).modal 'show'
      $(ReactDOM.findDOMNode(this)).on 'hidden.bs.modal', @props.handleHideModal
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'ename', $('#employee_form_ename').val()
      formData.append 'email', $('#employee_form_email').val()
      formData.append 'address', $('#employee_form_address').val()
      formData.append 'pnumber', $('#employee_form_pnumber').val()
      formData.append 'noid', $('#employee_form_noid').val()
      formData.append 'gender', $('#employee_form_gender').val()
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
          @props.handleEmployeeRecord result
          @setState @getInitialState()
          return
        ).bind(this)
    handleSubmitPosition: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'pname', $('#position_form_pname').val()
      formData.append 'lang', $('#position_form_lang').val()
      formData.append 'description', $('#position_form_description').val()
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
          @props.handlePositionRecord result
          @setState @getInitialState()
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
                'Position Form'
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
                    id: 'position_form'
                    encType: 'multipart/form-data'
                    className: 'form-horizontal'
                    onSubmit: @handleSubmitPosition
                    React.DOM.hr null
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Tên chức vụ'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'position_form_pname'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Hãy nhập vào tên chức vụ'
                          name: 'pname'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Ngôn ngữ hiển thị'
                      React.DOM.div
                        className: 'col-sm-10'
                        React.DOM.input
                          id: 'position_form_lang'
                          type: 'text'
                          className: 'form-control'
                          placeholder: 'Hãy nhập vào ngôn ngữ hiển thị của chức vụ này'
                          name: 'address'
                          value: 'vi'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'Mô tả công việc'
                      React.DOM.textarea
                        className: 'form-control col-sm-10'
                        rows: 3
                        id: 'position_form_description'
                        placeholder: 'Hãy nhập vào tóm tắt mô tả công việc'
                        name: 'description'
                    React.DOM.div
                      className: 'form-group'
                      React.DOM.label
                        className: 'col-sm-2 control-label'
                        'File đính kèm'
                      React.DOM.div
                        className: 'col-sm-4'
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
    propTypes: handleHideModal: React.PropTypes.func.isRequired
    render: ->
      if @state.type == 'employee'
        @employeeForm()
      else if @state.type == 'position'
        @positionForm()