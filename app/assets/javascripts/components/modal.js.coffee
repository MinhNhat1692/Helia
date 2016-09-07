  @Modal = React.createClass
    getInitialState: ->
      type: @props.type
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
              React.DOM.small
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
              React.DOM.small
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
              React.DOM.small
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
    propTypes: handleHideModal: React.PropTypes.func.isRequired
    render: ->
      if @state.type == 'employee'
        @employeeForm()
      else if @state.type == 'employee_edit'
        @employeeForm()
      else if @state.type == 'customer_record'
        @customerForm()
      else if @state.type == 'customer_edit_record'
        @customerForm()
      else if @state.type == 'room_add'
        @roomForm()
      else if @state.type == 'room_edit'
        @roomForm()