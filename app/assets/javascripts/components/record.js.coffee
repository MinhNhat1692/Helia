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
          React.createElement SelectBox, records: @props.rooms, type: 1, id: 'position_edit_room', text: 'Tên phòng'
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


  @AppViewsEmployee = React.createClass
    getInitialState: ->
      edit: false
      type: 0
      record: @props.record
      rooms: @props.rooms
      positions: @props.positions
      positionmap: @props.positionmap
      station: @props.station
      positionName: 'Chua co chuc vu'
    handleEdit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'id', @props.record.id
      if @state.type == 1
        formData.append 'ename', $('#quick_edit_ename').val()
      else if @state.type == 2
        formData.append 'address', $('#quick_edit_address').val()
      else if @state.type == 3
        formData.append 'avatar', $('#quick_edit_avatar')[0].files[0]
      else if @state.type == 4
        formData.append 'noid', $('#quick_edit_noid').val()
      else if @state.type == 5
        formData.append 'pnumber', $('#quick_edit_pnumber').val() 
      else if @state.type == 10
        formData.append 'posmap', $('#quick_edit_posmap').val() 
      if @state.type != 10
        $.ajax
          url: '/position_mapping'
          type: 'PUT'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.handleEditAppMap @props.record, result
            @setState
              type: 0
              edit: false
            return
          ).bind(this)
      else
        $.ajax
          url: '/position_mapping'
          type: 'PUT'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.handleEditPosMap result
            @setState
              type: 0
              edit: false
            return
          ).bind(this)
    handleToggleName: (e) ->
      e.preventDefault()
      @setState
        type: 1
        edit: !@state.edit
    handleToggleAddress: (e) ->
      e.preventDefault()
      @setState
        type: 2
        edit: !@state.edit
    handleToggleAvatar: (e) ->
      e.preventDefault()
      @setState
        type: 3
        edit: !@state.edit
    handleToggleNoid: (e) ->
      e.preventDefault()
      @setState
        type: 4
        edit: !@state.edit
    handleTogglePnumber: (e) ->
      e.preventDefault()
      @setState
        type: 5
        edit: !@state.edits
    handleTogglePosMap: (e) ->
      e.preventDefault()
      @setState
        type: 10
        edit: !@state.edits
    recordForm: ->
      React.DOM.div
        className: 'col-lg-3'
        React.DOM.div
          className: 'contact-box center-version'
          React.DOM.div
            className: 'over'
            if @state.type == 3
              React.DOM.input
                className: 'form-control'
                type: 'file'
                onBlur: @handleEdit
                placeholder: 'Avatar'
                id: 'quick_edit_avatar'
            else
              React.DOM.img
                alt: 'image'
                className: 'img-circle'
                src: @props.record.avatar
            if @state.type == 1  
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.ename
                onBlur: @handleEdit
                placeholder: 'Type name'
                id: 'quick_edit_ename'
            else
              React.DOM.h3
                className: 'm-b-xs'
                React.DOM.strong
                  @props.record.ename  
            check = false
            if @state.type == 10
              React.createElement SelectBox, records: @props.positions, type: 2, id: 'quick_edit_posmap', text: 'Tên Position', blurOut: @handleEdit
            else
              for map in @state.positionmap
                if map.employee_id == @props.record.id
                  React.DOM.div
                    className: 'font-bold'
                    for pos in @props.positions
                      if pos.id == map.position_id
                        pos.pname
                        break
                  check = true
                  break
              if check == false
                React.DOM.div
                  className: 'font-bold'
                  'Chua co chuc vu'
            React.DOM.address
              className: 'm-t-md'
              React.DOM.strong null, @state.station.sname
                React.DOM.br null,
              if @state.type == 2
                React.DOM.input
                  className: 'form-control'
                  type: 'text'
                  defaultValue: @props.record.address
                  onBlur: @handleEdit
                  placeholder: 'Type address'
                  id: 'quick_edit_address'
              else
                React.DOM.p null,
                  @state.record.address
                    React.DOM.br null,
              if @state.type == 4
                React.DOM.input
                  className: 'form-control'
                  type: 'text'
                  defaultValue: @props.record.noid
                  onBlur: @handleEdit
                  placeholder: 'Type noid'
                  id: 'quick_edit_noid'
              else
                React.DOM.p null,
                  @state.record.noid
                    React.DOM.br null,
              if @state.type == 5
                React.DOM.input
                  className: 'form-control'
                  type: 'text'
                  defaultValue: @props.record.pnumber
                  onBlur: @handleEdit
                  placeholder: 'Type pnumber'
                  id: 'quick_edit_pnumber'
              else
                React.DOM.abbr
                  title: 'Phone'
                  'SDT: '
                React.DOM.i null,
                  @props.record.pnumber
          React.DOM.div
            className: 'contact-box-footer'
            React.DOM.div
              className: 'm-t-xs btn-group'
              React.DOM.a
                className: 'btn btn-default btn-xs'
                React.DOM.i
                  className: 'fa fa-pencil-square-o'
                ' Edit'
    recordBlock: ->
      React.DOM.div
        className: 'col-lg-3'
        React.DOM.div
          className: 'contact-box center-version'
          React.DOM.div
            className: 'over'
            React.DOM.img
              alt: 'image'
              className: 'img-circle'
              onClick: @handleToggleAvatar
              src: @props.record.avatar
            React.DOM.h3
              className: 'm-b-xs'
              React.DOM.strong
                onClick: @handleToggleName
                @props.record.ename
            for map in @props.positionmap
              if map.employee_id == @props.record.id
                for pos in @props.positions
                  if pos.id == map.position_id
                    @state.positionName = pos.pname
                    break
                break
            React.DOM.div
              onClick: @handleTogglePosMap
              className: 'font-bold'
              @state.positionName
            React.DOM.address
              className: 'm-t-md'
              React.DOM.strong null, @state.station.sname
                React.DOM.br null,
              React.DOM.p
                onClick: @handleToggleAddress
                @props.record.address
                React.DOM.br null,
              React.DOM.p
                onClick: @handleToggleNoid
                @props.record.noid
                React.DOM.br null,
              React.DOM.abbr
                title: 'Phone'
                'SDT: '
              React.DOM.p
                style: {display: 'inline-block'}
                onClick: @handleTogglePnumber
                @props.record.pnumber
          React.DOM.div
            className: 'contact-box-footer'
            React.DOM.div
              className: 'm-t-xs btn-group'
              React.DOM.a
                className: 'btn btn-default btn-xs'
                React.DOM.i
                  className: 'fa fa-pencil-square-o'
                ' Edit'
    render: ->
      if @state.edit
        @recordForm()
      else
        @recordBlock()