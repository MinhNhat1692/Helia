  @Record = React.createClass
    getInitialState: ->
      edit: false
    handleEdit: (e) ->
      e.preventDefault()
      data =
        id: @props.record.id
        ename: @refs.ename.value
      # jQuery doesn't have a $.put shortcut method either
      $.ajax
        method: 'PUT'
        url: "/employee"
        dataType: 'JSON'
        data:
          record: data
        success: (data) =>
          @setState edit: false
          @props.handleEditRecord @props.record, data
    handleToggle: (e) ->
      e.preventDefault()
      @setState edit: !@state.edit
    handleDelete: (e) ->
      e.preventDefault()
      # yeah... jQuery doesn't have a $.delete shortcut method
      $.ajax
        method: 'DELETE'
        url: "/employee"
        dataType: 'JSON'
        data: {id: @props.record.id}
        success: () =>
          @props.handleDeleteRecord @props.record
    recordForm: ->
      React.DOM.tr null,
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.station_id
            ref: 'station_id'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.ename
            ref: 'ename'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: 'smt'
            ref: ''
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            style: {margin: '5px'}
            onClick: @handleEdit
            'Update'
          React.DOM.a
            className: 'btn btn-danger'
            style: {margin: '5px'}
            onClick: @handleToggle
            'Cancel'
    recordRow: ->
      React.DOM.tr null,
        React.DOM.td null, @props.record.station_id
        React.DOM.td null, @props.record.ename
        React.DOM.td null, "Stm"
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            style: {margin: '5px'}
            onClick: @handleToggle
            'Edit'
          React.DOM.a
            className: 'btn btn-danger'
            style: {margin: '5px'}
            onClick: @handleDelete
            'Delete'
    render: ->
      if @state.edit
        @recordForm()
      else
        @recordRow()


  @Room = React.createClass
    getInitialState: ->
      edit: false
    handleEdit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'id', @props.record.id
      formData.append 'name', $('#room_edit_name').val()
      formData.append 'lang', $('#room_edit_lang').val()
      formData.append 'map', $('#room_edit_map')[0].files[0]
      $.ajax
        url: '/rooms'
        type: 'PUT'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @setState edit: false
          @props.handleEditRoom @props.record, result
          return
        ).bind(this)
    handleToggle: (e) ->
      e.preventDefault()
      @setState edit: !@state.edit
    handleDelete: (e) ->
      e.preventDefault()
      $.ajax
        method: 'DELETE'
        url: "/rooms"
        dataType: 'JSON'
        data: {id: @props.record.id}
        success: () =>
          @props.handleDeleteRoom @props.record
    recordForm: ->
      React.DOM.tr null,
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.name
            id: 'room_edit_name'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.lang
            id: 'room_edit_lang'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'file'
            defaultValue: @props.record.map
            id: 'room_edit_map'
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            style: {margin: '5px'}
            onClick: @handleEdit
            'Update'
          React.DOM.a
            className: 'btn btn-danger'
            style: {margin: '5px'}
            onClick: @handleToggle
            'Cancel'
    recordRow: ->
      React.DOM.tr null,
        React.DOM.td null, @props.record.name
        React.DOM.td null, @props.record.lang
        React.DOM.td null,
          React.DOM.a
            href: @props.record.map
            className: 'btn btn-default'
            target: '_blank'
            style: {margin: '5px'}
            'Map'
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            style: {margin: '5px'}
            onClick: @handleToggle
            'Edit'
          React.DOM.a
            className: 'btn btn-danger'
            style: {margin: '5px'}
            onClick: @handleDelete
            'Delete'
    render: ->
      if @state.edit
        @recordForm()
      else
        @recordRow()


  @Position = React.createClass
    getInitialState: ->
      edit: false
      rooms: @props.rooms
    handleEdit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'id', @props.record.id
      formData.append 'room', $('#position_edit_room').val()
      formData.append 'pname', $('#position_edit_pname').val()
      formData.append 'lang', $('#position_edit_lang').val()
      formData.append 'description', $('#position_edit_description').val()
      formData.append 'file', $('#position_edit_file')[0].files[0]
      $.ajax
        url: '/positions'
        type: 'PUT'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @setState edit: false
          @props.handleEditPosition @props.record, result
          return
        ).bind(this)
    handleToggle: (e) ->
      e.preventDefault()
      @setState edit: !@state.edit
    handleDelete: (e) ->
      e.preventDefault()
      $.ajax
        method: 'DELETE'
        url: "/positions"
        dataType: 'JSON'
        data: {id: @props.record.id}
        success: () =>
          @props.handleDeletePosition @props.record
    recordForm: ->
      React.DOM.tr null,
        React.DOM.td null,
          React.createElement SelectBox, records: @state.rooms, type: 1, id: 'position_edit_room', text: 'Tên phòng'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.pname
            id: 'position_edit_pname'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.lang
            id: 'position_edit_lang'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.description
            id: 'position_edit_description'
        React.DOM.td null,
          React.DOM.input
            className: 'form-control'
            type: 'file'
            defaultValue: @props.record.file
            id: 'position_edit_file'
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            style: {margin: '5px'}
            onClick: @handleEdit
            'Update'
          React.DOM.a
            className: 'btn btn-danger'
            style: {margin: '5px'}
            onClick: @handleToggle
            'Cancel'
    recordRow: ->
      React.DOM.tr null,
        React.DOM.td null,
          for room in @state.rooms
            if room.id == @props.record.room_id
              room.name
        React.DOM.td null, @props.record.pname
        React.DOM.td null, @props.record.lang
        React.DOM.td null, @props.record.description
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            style: {margin: '5px'}
            href: @props.record.file.url
            'File'
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            style: {margin: '5px'}
            onClick: @handleToggle
            'Edit'
          React.DOM.a
            className: 'btn btn-danger'
            style: {margin: '5px'}
            onClick: @handleDelete
            'Delete'
    render: ->
      if @state.edit
        @recordForm()
      else
        @recordRow()
