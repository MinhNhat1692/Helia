  @Record = React.createClass
    getInitialState: ->
      genderlist: @props.gender
      gender: "Not set"
    selectRecord: (e) ->
      @props.selectRecord @props.record
    recordRow: ->
      React.DOM.tr
        onClick: @selectRecord
        React.DOM.td null, @props.record.ename
        React.DOM.td null, @props.record.address
        React.DOM.td null, @props.record.pnumber
        React.DOM.td null, @props.record.noid
        for gender in @state.genderlist
            if @props.record.gender == gender.id
              @state.gender = gender.name
              break
        React.DOM.td null, @state.gender
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.avatar
            'AVATAR'
    SelectedRecordRow: ->
      React.DOM.tr
        className: "toggled"
        React.DOM.td null, @props.record.ename
        React.DOM.td null, @props.record.address
        React.DOM.td null, @props.record.pnumber
        React.DOM.td null, @props.record.noid
        for gender in @state.genderlist
            if @props.record.gender == gender.id
              @state.gender = gender.name
              break
        React.DOM.td null, @state.gender
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.avatar
            'AVATAR'
    render: ->
      if @props.selected
        @SelectedRecordRow()
      else
        @recordRow()


  @Room = React.createClass
    getInitialState: ->
      type: 1
    selectRecord: (e) ->
      @props.selectRecord @props.record
    recordRow: ->
      React.DOM.tr
        onClick: @selectRecord
        React.DOM.td null, @props.record.name
        React.DOM.td null, @props.record.lang
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.map
            'Bản đồ'
    SelectedRecordRow: ->
      React.DOM.tr
        className: "toggled"
        React.DOM.td null, @props.record.name
        React.DOM.td null, @props.record.lang
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.map
            'Bản đồ'
    render: ->
      if @props.selected
        @SelectedRecordRow()
      else
        @recordRow()


  @Service = React.createClass
    getInitialState: ->
      type: 1
    selectRecord: (e) ->
      @props.selectRecord @props.record
    recordRow: ->
      React.DOM.tr
        onClick: @selectRecord
        React.DOM.td null, @props.record.sname
        React.DOM.td null, @props.record.lang
        React.DOM.td null, @props.record.price
        React.DOM.td null, @props.record.currency
        React.DOM.td null, @props.record.description
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.file
            'Logo'
    SelectedRecordRow: ->
      React.DOM.tr
        className: "toggled"
        React.DOM.td null, @props.record.sname
        React.DOM.td null, @props.record.lang
        React.DOM.td null, @props.record.price
        React.DOM.td null, @props.record.currency
        React.DOM.td null, @props.record.description
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.file
            'Logo'
    render: ->
      if @props.selected
        @SelectedRecordRow()
      else
        @recordRow()


  @Position = React.createClass
    getInitialState: ->
      rooms: @props.rooms
    selectRecord: (e) ->
      @props.selectRecord @props.record
    recordRow: ->
      React.DOM.tr
        onClick: @selectRecord
        React.DOM.td null,
          for room in @state.rooms
            if room.id == @props.record.room_id
              room.name
        React.DOM.td null, @props.record.pname
        React.DOM.td null, @props.record.lang
        React.DOM.td null, @props.record.description
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.file
            'File'
    SelectedRecordRow: ->
      React.DOM.tr
        className: "toggled"
        React.DOM.td null,
          for room in @state.rooms
            if room.id == @props.record.room_id
              room.name
        React.DOM.td null, @props.record.pname
        React.DOM.td null, @props.record.lang
        React.DOM.td null, @props.record.description
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default btn-xs'
            style: {margin: '5px'}
            href: @props.record.file
            'File'
    render: ->
      if @props.selected
        @SelectedRecordRow()
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
        if $('#quick_edit_avatar')[0].files[0] != undefined
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
    
        
  @AppViewsService = React.createClass
    getInitialState: ->
      edit: false
      type: 0
      record: @props.record
      rooms: @props.rooms
      servicemap: @props.servicemap
      roomName: 'Chưa định phòng khám'
    handleEdit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'id', @props.record.id
      if @state.type == 1
        formData.append 'sname', $('#quick_edit_sname').val()
      else if @state.type == 2
        formData.append 'description', $('#quick_edit_description').val()
      else if @state.type == 3
        if $('#quick_edit_file')[0].files[0] != undefined
          formData.append 'file', $('#quick_edit_file')[0].files[0]
      else if @state.type == 4
        formData.append 'price', $('#quick_edit_price').val()
      else if @state.type == 10
        formData.append 'sermap', $('#quick_edit_room').val() 
      if @state.type != 10
        $.ajax
          url: '/service_mapping'
          type: 'PUT'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.handleEditSer @props.record, result
            @setState
              type: 0
              edit: false
            return
          ).bind(this)
      else
        $.ajax
          url: '/service_mapping'
          type: 'PUT'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.handleEditSerMap result
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
    handleToggleDescription: (e) ->
      e.preventDefault()
      @setState
        type: 2
        edit: !@state.edit
    handleToggleLogo: (e) ->
      e.preventDefault()
      @setState
        type: 3
        edit: !@state.edit
    handleTogglePrice: (e) ->
      e.preventDefault()
      @setState
        type: 4
        edit: !@state.edit
    handleToggleSerMap: (e) ->
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
                placeholder: 'File'
                id: 'quick_edit_file'
            else
              React.DOM.img
                alt: 'image'
                className: 'img-circle'
                src: @props.record.file
            if @state.type == 1  
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.sname
                onBlur: @handleEdit
                placeholder: 'Type name'
                id: 'quick_edit_sname'
            else
              React.DOM.h3
                className: 'm-b-xs'
                React.DOM.strong
                  @props.record.sname  
            check = false
            if @state.type == 10
              React.createElement SelectBox, records: @props.rooms, type: 3, id: 'quick_edit_room', text: 'Tên Room', blurOut: @handleEdit
            else
              for map in @props.servicemap
                if map.service_id == @props.record.id
                  for room in @props.rooms
                    if room.id == map.room_id
                      @state.roomName = room.name
                      break
                  break
              React.DOM.div
                className: 'font-bold'
                @state.roomName
            React.DOM.address
              if @state.type == 2
                React.DOM.input
                  className: 'form-control'
                  type: 'text'
                  defaultValue: @props.record.description
                  onBlur: @handleEdit
                  placeholder: 'Type description'
                  id: 'quick_edit_description'
              else
                React.DOM.p null,
                  @state.record.description
                    React.DOM.br null,
              if @state.type == 4
                React.DOM.input
                  className: 'form-control'
                  type: 'number'
                  defaultValue: @props.record.price
                  onBlur: @handleEdit
                  placeholder: 'Type price'
                  id: 'quick_edit_price'
              else
                React.DOM.p null,
                  @props.record.price + ' ' + @props.record.currency
                    React.DOM.br null,
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
        className: @props.className
        React.DOM.div
          className: 'card text-center pt-inner'
          React.DOM.div
            className: 'pti-header'
            React.DOM.h2
              onClick: @handleTogglePrice
              @props.record.price
              React.DOM.small null,
                @props.record.currency
            React.DOM.div
              className: "ptih-title"
              onClick: @handleToggleName
              @props.record.sname
            for map in @props.servicemap
              if map.service_id == @props.record.id
                for room in @props.rooms
                  if room.id == map.room_id
                    @state.roomName = room.name
                    break
                break
          React.DOM.div
            className: "pti-body"
            React.DOM.div
              className: 'ptib-item'
              onClick: @handleToggleDescription
              @props.record.description
            React.DOM.div
              className: 'ptib-item'
              onClick: @handleToggleSerMap
              @state.roomName
          React.DOM.div
            className: "pti-footer"
            React.DOM.a
              className: 'btn btn-default'
              React.DOM.i
                className: 'fa fa-pencil-square-o'
                ' Check'
    render: ->
      if @state.edit
        @recordForm()
      else
        @recordBlock()
       
        
  @PatientRecord = React.createClass
    getInitialState: ->
      genderlist: @props.gender
      gender: "Not set"
    handleEdit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'id', @props.record.id
      formData.append 'name', $('#room_edit_name').val()
      formData.append 'lang', $('#room_edit_lang').val()
      if $('#room_edit_map')[0].files[0] != undefined
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
    calAge: (dob, style) ->
      now = new Date
      today = new Date(now.getYear(), now.getMonth(), now.getDate())
      yearNow = now.getYear()
      monthNow = now.getMonth()
      dateNow = now.getDate()
      if style == 1
        dob = new Date(dob.substring(6, 10), dob.substring(3, 5) - 1, dob.substring(0, 2))
      else
        dob = new Date(dob.substring(0, 4), dob.substring(5, 7) - 1, dob.substring(8, 10))
      yearDob = dob.getYear()
      monthDob = dob.getMonth()
      dateDob = dob.getDate()
      yearAge = yearNow - yearDob
      if monthNow >= monthDob
        monthAge = monthNow - monthDob
      else
        yearAge--
        monthAge = 12 + monthNow - monthDob
      if dateNow >= dateDob
        dateAge = dateNow - dateDob
      else
        monthAge--
        dateAge = 31 + dateNow - dateDob
        if monthAge < 0
          monthAge = 11
          yearAge--
      age =
        years: yearAge
        months: monthAge
        days: dateAge
      return age
    handleSelect: (e) ->
      @props.TriggerSelect @props.record
    recordRow: ->
      React.DOM.tr
        onClick: @handleSelect
        React.DOM.td null, @props.record.cname
        React.DOM.td null, @props.record.dob
        React.DOM.td null, @calAge(@props.record.dob,2).years
        for gender in @state.genderlist
            if @props.record.gender == gender.id
              @state.gender = gender.name
              break
        React.DOM.td null, @state.gender
        React.DOM.td null, @props.record.address
        React.DOM.td null, @props.record.pnumber
        React.DOM.td null, @props.record.noid
        React.DOM.td null, @props.record.issue_date
        React.DOM.td null, @props.record.issue_place
        React.DOM.td null,
          React.DOM.a
            href: @props.record.avatar
            className: 'btn btn-default'
            target: '_blank'
            style: {margin: '5px'}
            'Avatar'
        React.DOM.td null, @props.record.created_at
        React.DOM.td null, @props.record.updated_at
    recordRowSelected: ->
      React.DOM.tr
        style: {'backgroundColor': '#494b54'}
        onClick: @handleSelect
        React.DOM.td null, @props.record.cname
        React.DOM.td null, @props.record.dob
        React.DOM.td null, @calAge(@props.record.dob,2).years
        for gender in @state.genderlist
            if @props.record.gender == gender.id
              @state.gender = gender.name
              break
        React.DOM.td null, @state.gender
        React.DOM.td null, @props.record.address
        React.DOM.td null, @props.record.pnumber
        React.DOM.td null, @props.record.noid
        React.DOM.td null, @props.record.issue_date
        React.DOM.td null, @props.record.issue_place
        React.DOM.td null,
          React.DOM.a
            href: @props.record.avatar
            className: 'btn btn-default'
            target: '_blank'
            style: {margin: '5px'}
            'Avatar'
        React.DOM.td null, @props.record.created_at
        React.DOM.td null, @props.record.updated_at
    render: ->
      if !@props.select
        @recordRow()
      else
        @recordRowSelected()
        
  
  @PatientProfile = React.createClass
    getInitialState: ->
      genderlist: @props.gender
      gender: "Not set"
      record: @props.record
    calAge: (dob, style) ->
      now = new Date
      today = new Date(now.getYear(), now.getMonth(), now.getDate())
      yearNow = now.getYear()
      monthNow = now.getMonth()
      dateNow = now.getDate()
      if style == 1
        dob = new Date(dob.substring(6, 10), dob.substring(3, 5) - 1, dob.substring(0, 2))
      else
        dob = new Date(dob.substring(0, 4), dob.substring(5, 7) - 1, dob.substring(8, 10))
      yearDob = dob.getYear()
      monthDob = dob.getMonth()
      dateDob = dob.getDate()
      yearAge = yearNow - yearDob
      if monthNow >= monthDob
        monthAge = monthNow - monthDob
      else
        yearAge--
        monthAge = 12 + monthNow - monthDob
      if dateNow >= dateDob
        dateAge = dateNow - dateDob
      else
        monthAge--
        dateAge = 31 + dateNow - dateDob
        if monthAge < 0
          monthAge = 11
          yearAge--
      age =
        years: yearAge
        months: monthAge
        days: dateAge
      return age
    addListener: (e) ->
      @props.addListener e
    linkListener: (e) ->
      @props.linkListener e
    updateListener: (e) ->
      @props.updateListener e
    clearLinkListener: (e) ->
      @props.clearLinkListener e
    normalStyle: ->
      React.DOM.div
        className: "background1 animated flipInY"
        React.DOM.div
          className: "pmo-pic"
          React.DOM.div
            className: 'p-relative'
            React.DOM.a null,
              React.DOM.img
                className: 'img-responsive'
                alt: ''
                src:
                  if @props.record.avatar != "/avatars/original/missing.png"
                    @props.record.avatar
                  else
                    'https://www.twomargins.com/images/noavatar.jpg'
            React.DOM.a
              className: 'pmop-edit'
              React.DOM.i
                className: 'fa fa-camera'
              React.DOM.span
                className: 'hidden-xs'
                'Update Picture'
            React.DOM.div
              className: 'pmo-stat'
              React.DOM.h2 null, @props.record.cname
              @calAge(@props.record.dob,2).years + " Tuổi " + @calAge(@props.record.dob,2).months + "Tháng"
        React.DOM.div
          className: 'pmo-block pmo-contact'
          React.DOM.h2 null, "Thông tin cơ bản"
          React.DOM.ul null,
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-birthday-cake'
              @props.record.dob
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-map-marker'
              @props.record.address
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-barcode'
              @props.record.noid
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-phone'
              @props.record.pnumber
          if @props.record.customer_id != null
            React.DOM.div
              className: "pmo-block pmo-contact row"
              React.createElement ButtonGeneral, className: 'btn btn-default col-md-12', icon: 'fa fa-link', text: ' Clear Link Record', type: 1, Clicked: @clearLinkListener
    advanceStyle: ->
      React.DOM.div
        className: "animated flipInY"
        React.DOM.div
          className: "pmo-pic"
          React.DOM.div
            className: 'p-relative'
            React.DOM.a null,
              React.DOM.img
                className: 'img-responsive'
                alt: ''
                src:
                  if @props.record.avatar != "/avatars/original/missing.png"
                    @props.record.avatar
                  else
                    'https://www.twomargins.com/images/noavatar.jpg'
            React.DOM.a
              className: 'pmop-edit'
              React.DOM.i
                className: 'fa fa-camera'
              React.DOM.span
                className: 'hidden-xs'
                'Update Picture'
            React.DOM.div
              className: 'pmo-stat'
              React.DOM.h2 null, @props.record.lname + " " + @props.record.fname
              @calAge(@props.record.dob,2).years + " Tuổi " + @calAge(@props.record.dob,2).months + " Tháng"
        React.DOM.div
          className: 'pmo-block pmo-contact'
          React.DOM.h2 null, "Thông tin cơ bản"
          React.DOM.ul null,
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-birthday-cake'
              @props.record.dob
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-map-marker'
              @props.record.address
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-barcode'
              @props.record.noid
            React.DOM.li null,
              React.DOM.i
                className: 'fa fa-phone'
              @props.record.pnumber
          if @props.existed
            React.DOM.div
              className: "pmo-block pmo-contact row"
              React.createElement ButtonGeneral, className: 'btn btn-default col-md-12', icon: 'fa fa-pencil-square-o', text: ' Update Record', type: 1, Clicked: @updateListener
          else
            React.DOM.div
              className: "pmo-block pmo-contact row"
              React.createElement ButtonGeneral, className: 'btn btn-default col-md-12', icon: 'fa fa-plus', text: ' Add Record', type: 1, Clicked: @addListener
              React.createElement ButtonGeneral, className: 'btn btn-default col-md-12', icon: 'fa fa-link', text: ' Connect to Your Record', type: 1, Clicked: @linkListener
    render: ->
      if @props.style == 'normal'
        @normalStyle()
      else
        @advanceStyle()
        
        
  @AsideMenu = React.createClass
    getInitialState: ->
      genderlist: @props.gender
      gender: "Not set"
    handleSubmit: (e) ->
      if e.keyCode == 13
        $('#customer_record_search_email').blur()
        formData = new FormData
        formData.append 'email', $('#customer_record_search_email').val()
        $.ajax
          url: '/customer_record/find_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.handleCustomerSearch result
            return
          ).bind(this)
    handleSubmitEmployee: (e) ->
      if e.keyCode == 13
        $('#employee_search_email').blur()
        formData = new FormData
        formData.append 'email', $('#employee_search_email').val()
        $.ajax
          url: '/employee/find_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @props.handleSearch result
            return
          ).bind(this)
    addListener: (e) ->
      @props.addListener e
    linkListener: (e) ->
      @props.linkListener e
    updateListener: (e) ->
      @props.updateListener e
    normalStyle: ->
      React.DOM.aside
        id: 'chat'
        className: @props.className
        React.DOM.div
          className: "chat-search"
          React.DOM.div
            className: "fg-line"
            React.DOM.input
              type: "text"
              id: "customer_record_search_email"
              className: "form-control"
              placeholder: "Search People"
              onKeyUp: @handleSubmit
            React.DOM.i
              className: 'fa fa-search'
        React.DOM.hr null
        if @props.record != null
          React.createElement PatientProfile, className: 'btn btn-default col-md-12', existed: @props.existed, record: @props.record, gender: @props.gender, style: "advance", addListener: @addListener, linkListener: @linkListener, updateListener: @updateListener
        else
          if @props.userlink != null
            React.DOM.div
              className: "animated flipInY"
              React.DOM.div
                className: "pmo-block pmo-contact row"
                React.DOM.p
                  style: {'textAlign': 'justify'}
                  "This user havent made thier Patient Profile yet but you still can link your record to thier account. Once they make thier Patient Profile, you will be able to update thier infomation into your record automatically"
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-link', text: ' Connect to Your Record', type: 1, Clicked: @linkListener
    employeeStyle: ->
      React.DOM.aside
        id: 'chat'
        className: @props.className
        React.DOM.div
          className: "chat-search"
          React.DOM.div
            className: "fg-line"
            React.DOM.input
              type: "text"
              id: "employee_search_email"
              className: "form-control"
              placeholder: "Search People"
              onKeyUp: @handleSubmitEmployee
            React.DOM.i
              className: 'fa fa-search'
        if @props.record != null
          React.createElement PatientProfile, className: 'btn btn-default col-md-12', existed: @props.existed, record: @props.record, gender: @props.gender, style: "advance", addListener: @addListener, linkListener: @linkListener, updateListener: @updateListener
        else
          if @props.userlink != null
            React.DOM.div
              className: "animated flipInY"
              React.DOM.div
                className: "pmo-block pmo-contact row"
                React.DOM.p
                  style: {'textAlign': 'justify'}
                  "This user havent made thier Doctor Profile yet but you still can link your record to thier account. Once they make thier Patient Profile, you will be able to update thier infomation into your record automatically"
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-link', text: ' Connect to Your Record', type: 1, Clicked: @linkListener
    render: ->
      if @props.style == 1
        @normalStyle()
      else if @props.style == 2
        @employeeStyle()