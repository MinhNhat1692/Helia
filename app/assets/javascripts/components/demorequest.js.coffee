@demoform = React.createClass
    getInitialState: ->
      style: 1
    showtoast: (message,toasttype) ->
	    toastr.options =
        closeButton: true
        progressBar: true
        positionClass: 'toast-top-right'
        showMethod: 'slideDown'
        hideMethod: 'fadeOut'
        timeOut: 4000
      if toasttype == 1
        toastr.success message
      else if toasttype == 2
        toastr.info(message)
      else if toasttype == 3
        toastr.error(message)
      return
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'fname', $('#first_name').val().toLowerCase()
      formData.append 'lname', $('#last_name').val().toLowerCase()
      formData.append 'email', $('#email').val().toLowerCase()
      formData.append 'sname', $('#company').val().toLowerCase()
      formData.append 'pnumber', $('#phone').val().toLowerCase()
      $.ajax
        url: '/enterprise/demo'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        error: ((result) ->
          @showtoast("Đăng ký demo thất bại, vui lòng thử lại",3)
          return
        ).bind(this)
        success: ((result) ->
          @showtoast('Yêu cầu của bạn sẽ được xem xét và giải quyết trong từ 3 đến 5 ngày',2)
          @showtoast('Chúc mừng ' + result.lname + ' ' + result.fname + ' đã đăng ký lên lịch demo thành công',1)
          return
        ).bind(this)
    FullRender: ->
      React.DOM.form id: 'schedule-demo', onSubmit: @handleSubmit, autoComplete: 'off',
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Tên'
          React.DOM.input className: 'form-control', id: 'first_name', placeholder: 'Tên'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Họ và đệm'
          React.DOM.input className: 'form-control', id: 'last_name', placeholder: 'Họ và đệm'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Email'
          React.DOM.input className: 'form-control', id: 'email', placeholder: 'Email'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Tên phòng khám'
          React.DOM.input className: 'form-control', id: 'company', placeholder: 'Tên phòng khám'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Số điện thoại'
          React.DOM.input className: 'form-control', id: 'phone', placeholder: 'Số điện thoại'
        React.DOM.div className: 'spacer20'
        React.DOM.div className: 'form-group',
          React.DOM.button type: 'submit', className: 'btn btn-block btn-success', 'Đăng ký Demo'
    render: ->
      @FullRender()