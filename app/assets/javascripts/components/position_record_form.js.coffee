@PositionRecordForm = React.createClass
    getInitialState: ->
      type: 1
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'pname', $('#position_quick_pname').val()
      formData.append 'lang', $('#position_quick_lang').val()
      formData.append 'description', $('#position_quick_description').val()
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
          @props.handlePositionRecord result
          @setState @getInitialState()
          return
        ).bind(this)
    positionRecordFormRender: ->
      React.DOM.form
        id: 'position_quick'
        encType: 'multipart/form-data'
        className: 'form-horizontal row'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'form-group col-lg-3 col-sm-9'
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
        @positionRecordFormRender()