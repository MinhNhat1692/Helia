
  @AppViewsEmployee = React.createClass
    getInitialState: ->
      type: 0
      record: @props.record
      rooms: @props.rooms
      positions: @props.positions
      positionmap: @props.positionmap
      station: @props.station
      positionName: 'Chưa có chức vụ'
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
            return
          ).bind(this)
    handleToggleName: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 1
    handleToggleAddress: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 2
    handleToggleAvatar: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 3
    handleToggleNoid: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 4
    handleTogglePnumber: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 5
    handleTogglePosMap: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 10
    recordBlock: ->
      React.DOM.div
        className: @props.className
        for map in @props.positionmap
          if map.employee_id == @props.record.id
            for pos in @props.positions
              if pos.id == map.position_id
                @state.positionName = pos.pname
                break
            break
        React.DOM.div
          className: "c-item animated flipInY"
          React.DOM.a
            className: "ci-avatar"
            if @state.type == 3
              React.DOM.input
                className: 'form-control'
                type: 'file'
                onBlur: @handleEdit
                placeholder: 'Avatar'
                id: 'quick_edit_avatar'
            else
              React.DOM.img
                alt: ''
                onClick: @handleToggleAvatar
                src:
                  if @props.record.avatar != "/avatars/original/missing.png"
                    @props.record.avatar
                  else
                    'https://www.twomargins.com/images/noavatar.jpg'
          React.DOM.div
            className: "c-info"
            if @state.type == 1  
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.ename
                onBlur: @handleEdit
                placeholder: 'Type name'
                id: 'quick_edit_ename'
            else
              React.DOM.strong
                onClick: @handleToggleName
                @props.record.ename
            if @state.type == 10
              React.createElement SelectBox, records: @props.positions, type: 2, id: 'quick_edit_posmap', text: 'Tên Position', blurOut: @handleEdit
            else
              React.DOM.small
                onClick: @handleTogglePosMap
                @state.positionName
            React.DOM.small null, @calAge(@props.record.created_at,2).years + " Năm " + @calAge(@props.record.created_at,2).months + " Tháng " + @calAge(@props.record.created_at,2).days + " Ngày" 
            if @state.type == 2
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.address
                onBlur: @handleEdit
                placeholder: 'Type address'
                id: 'quick_edit_address'
            else
              React.DOM.small
                onClick: @handleToggleAddress
                @props.record.address
            if @state.type == 4
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.noid
                onBlur: @handleEdit
                placeholder: 'Type noid'
                id: 'quick_edit_noid'
            else
              React.DOM.small
                onClick: @handleToggleNoid
                @props.record.noid 
            if @state.type == 5
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.pnumber
                onBlur: @handleEdit
                placeholder: 'Type pnumber'
                id: 'quick_edit_pnumber'
            else  
              React.DOM.small
                onClick: @handleTogglePnumber
                @props.record.pnumber
          React.DOM.div
            className: "c-footer"
            React.DOM.button null, " LIÊN LẠC"
    render: ->
      @recordBlock()
    
        
  @AppViewsService = React.createClass
    getInitialState: ->
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
            return
          ).bind(this)
    handleToggleName: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 1
    handleToggleDescription: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 2
    handleTogglePrice: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 4
    handleToggleSerMap: (e) ->
      e.preventDefault()
      if @props.ownerMode
        @setState
          type: 10
    recordBlock: ->
      React.DOM.div
        className: @props.className
        React.DOM.div
          className: 'card text-center pt-inner'
          React.DOM.div
            className: 'pti-header'
            if @state.type == 4 
              React.DOM.input
                className: 'form-control'
                type: 'number'
                defaultValue: @props.record.price
                onBlur: @handleEdit
                placeholder: 'Type price'
                id: 'quick_edit_price'
            else
              React.DOM.h2
                onClick: @handleTogglePrice
                @props.record.price
                React.DOM.small null,
                  @props.record.currency
            if @state.type == 1
              React.DOM.input
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.sname
                onBlur: @handleEdit
                placeholder: 'Type name'
                id: 'quick_edit_sname'
            else
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
            if @state.type == 2
              React.DOM.textarea
                className: 'form-control'
                type: 'text'
                defaultValue: @props.record.description
                onBlur: @handleEdit
                placeholder: 'Type description'
                id: 'quick_edit_description'
            else
              React.DOM.div
                className: 'ptib-item'
                onClick: @handleToggleDescription
                @props.record.description
            if @state.type == 10
              React.createElement SelectBox, records: @props.rooms, type: 3, id: 'quick_edit_room', text: 'Tên phòng', blurOut: @handleEdit
            else
              React.DOM.div
                className: 'ptib-item'
                onClick: @handleToggleSerMap
                @state.roomName
          React.DOM.div
            className: "pti-footer"
    render: ->
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
      for gender in @state.genderlist
        if @props.record.gender == gender.id
          @state.gender = gender.name
          break
      React.DOM.tr
        onClick: @handleSelect
        React.DOM.td null, @props.record.cname
        React.DOM.td null,
          if @props.record.dob != null
            @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
          else
            ""
        React.DOM.td null, @calAge(@props.record.dob,2).years  
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
      for gender in @state.genderlist
        if @props.record.gender == gender.id
          @state.gender = gender.name
          break
      React.DOM.tr
        style: {'backgroundColor': '#494b54'}
        onClick: @handleSelect
        React.DOM.td null, @props.record.cname
        React.DOM.td null, 
          if @props.record.dob != null
            @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
          else
            ""
        React.DOM.td null, @calAge(@props.record.dob,2).years
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
              if @props.record.dob != null
                @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
              else
                ""
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
              React.DOM.i className: 'fa fa-birthday-cake'
              if @props.record.dob != null
                @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
              else
                ""
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
        
        
  @RecordGeneral = React.createClass
    getInitialState: ->
      type: 0
      typeName: null
      groupName: null
    selectRecord: (e) ->
      @props.selectRecord @props.record
    MedicineSupplier: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.contactname
          React.DOM.td null, @props.record.spnumber
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.address1
          React.DOM.td null, @props.record.address2
          React.DOM.td null, @props.record.address3
          React.DOM.td null, @props.record.email
          React.DOM.td null, @props.record.facebook
          React.DOM.td null, @props.record.twitter
          React.DOM.td null, @props.record.fax
          React.DOM.td null, @props.record.taxcode
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.contactname
          React.DOM.td null, @props.record.spnumber
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.address1
          React.DOM.td null, @props.record.address2
          React.DOM.td null, @props.record.address3
          React.DOM.td null, @props.record.email
          React.DOM.td null, @props.record.facebook
          React.DOM.td null, @props.record.twitter
          React.DOM.td null, @props.record.fax
          React.DOM.td null, @props.record.taxcode
    MedicineCompany: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.email
          React.DOM.td null, @props.record.website
          React.DOM.td null, @props.record.taxcode
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.email
          React.DOM.td null, @props.record.website
          React.DOM.td null, @props.record.taxcode
    MedicineSample: ->
      for typemedicine in @props.typelist
        if @props.record.typemedicine == typemedicine.id
          @state.typeName = typemedicine.name
          break
      for group in @props.grouplist
        if @props.record.groupmedicine == group.id
          @state.groupName = group.name
          break
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @state.typeName
          React.DOM.td null, @state.groupName
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.weight
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.expire
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @state.typeName
          React.DOM.td null, @state.groupName
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.weight
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.expire
    MedicineBillIn: ->
      switch Number(@props.record.pmethod)
        when 1
          @state.typeName = "Tiền mặt"
        when 2
          @state.typeName = "Chuyển khoản"
        when 3
          @state.typeName = "Khác"
      switch Number(@props.record.status)
        when 1
          @state.groupName = "Lưu kho"
        when 2
          @state.groupName = "Đang di chuyển"
        when 3
          @state.groupName = "Trả lại"
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.billcode
          React.DOM.td null,
            if @props.record.dayin != null
              @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null,
            if @props.record.daybook != null
              @props.record.daybook.substring(8, 10) + "/" + @props.record.daybook.substring(5, 7) + "/" + @props.record.daybook.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @state.groupName
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.billcode
          React.DOM.td null, 
            if @props.record.dayin != null
              @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null,
            if @props.record.daybook != null
              @props.record.daybook.substring(8, 10) + "/" + @props.record.daybook.substring(5, 7) + "/" + @props.record.daybook.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @state.groupName
    MedicineBillRecord: ->
      switch Number(@props.record.pmethod)
        when 1
          @state.typeName = "Hộp"
        when 2
          @state.typeName = "Lẻ"
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.signid
          React.DOM.td null, @props.record.name
          React.DOM.td null,
            if @props.record.expire != null
              @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.qty
          React.DOM.td null, @props.record.taxrate
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @state.typeName
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.signid
          React.DOM.td null, @props.record.name
          React.DOM.td null,
            if @props.record.expire != null
              @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.qty
          React.DOM.td null, @props.record.taxrate
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @state.typeName
    MedicinePrice: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.minam
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.remark
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.minam
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.remark
    MedicinePrescriptExternal: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.result_id
          React.DOM.td null, @props.record.number_id
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.remark
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.result_id
          React.DOM.td null, @props.record.number_id
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.remark
    MedicineExternalRecord: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.script_code
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.amount
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.total
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.script_code
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.amount
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.total
    MedicinePrescriptInternal: ->
      switch Number(@props.record.pmethod)
        when 1
          @state.typeName = "Tiền mặt"
        when 2
          @state.typeName = "Chuyển khoản"
        when 3
          @state.typeName = "Khác"
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.preparer
          React.DOM.td null, @props.record.payer
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.result_id
          React.DOM.td null, @props.record.number_id
          React.DOM.td null, @props.record.remark
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.preparer
          React.DOM.td null, @props.record.payer
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.result_id
          React.DOM.td null, @props.record.number_id
          React.DOM.td null, @props.record.remark
    MedicineInternalRecord: ->
      switch Number(@props.record.status)
        when 1
          @state.typeName = "Đã chuyển hàng"
        when 2
          @state.typeName = "Chưa chuyển hàng"
        when 3
          @state.typeName = "Hàng trả lại"
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.script_code
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.amount
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.signid
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.script_code
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.amount
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.signid
    MedicineStockRecord: ->
      switch Number(@props.record.typerecord)
        when 1
          @state.typeName = "Nhập"
        when 2
          @state.typeName = "Xuất"
        when 3
          @state.typeName = "Vô hiệu"
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.signid
          React.DOM.td null, @props.record.amount
          React.DOM.td null,
            if @props.record.expire != null
              @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.bill_in_code
          React.DOM.td null, @props.record.internal_record_code
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.signid
          React.DOM.td null, @props.record.amount
          React.DOM.td null,
            if @props.record.expire != null
              @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @props.record.bill_in_code
          React.DOM.td null, @props.record.internal_record_code
    SupportRecord: ->
      switch Number(@props.record.status)
        when 1
          @state.typeName = "lgi-img bg-deep-orange"
          @state.groupName = "zmdi zmdi-lock-open"
        when 2
          @state.typeName = "lgi-img bg-green"
          @state.groupName = "zmdi zmdi-lock-open"
        when 3
          @state.typeName = "lgi-img bg-pink"
          @state.groupName = "zmdi zmdi-lock"
      if @props.selected
        React.DOM.a className: "list-group-item media active", onClick: @selectRecord,
          React.DOM.div className: 'pull-left',
            React.DOM.div className: @state.typeName,
              React.DOM.i className: @state.groupName,
          React.DOM.div className: 'media-body',
            React.DOM.div className: 'lgi-heading', @props.record.title
            React.DOM.small className: 'lgi-text', @props.record.infomation
            React.DOM.small className: 'ms-time',  @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7)
      else
        React.DOM.a className: "list-group-item media", onClick: @selectRecord,
          React.DOM.div className: 'pull-left',
            React.DOM.div className: @state.typeName,
              React.DOM.i className: @state.groupName,
          React.DOM.div className: 'media-body',
            React.DOM.div className: 'lgi-heading', @props.record.title
            React.DOM.small className: 'lgi-text', @props.record.infomation
            React.DOM.small className: 'ms-time',  @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7)
    TicketRecord: ->
      React.DOM.div className: 'col-sm-12',
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-body card-padding',
            if @props.record.attachment != "/attachments/original/missing.png"
              React.DOM.a href: @props.record.attachment, target: '_blank', 'Tệp đính kèm - '    
            @props.record.infomation
    TicketCommentRecord: ->
      if @props.selected
        React.DOM.div className: 'mblm-item mblm-item-left',
          React.DOM.div null,
            if @props.record.attachment != "/attachments/original/missing.png"
              React.DOM.a href: @props.record.attachment, target: '_blank', 'Tệp đính kèm - '
            @props.record.comment
          React.DOM.small null, @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7) + ' - ' + @props.record.created_at.substring(11, 16)
      else
        React.DOM.div className: 'mblm-item mblm-item-right',
          React.DOM.div null,
            if @props.record.attachment != "/attachments/original/missing.png"
              React.DOM.a href: @props.record.attachment, target: '_blank', 'Tệp đính kèm - '
            @props.record.comment
          React.DOM.small null, @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7) + ' - ' + @props.record.created_at.substring(11, 16)
    Service: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.sname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.currency
          React.DOM.td null, @props.record.description
          React.DOM.td null,
          React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.file, 'Logo'
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.sname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.currency
          React.DOM.td null, @props.record.description
          React.DOM.td null,
          React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.file, 'Logo'
    Employee: ->
      for gender in @props.gender
        if @props.record.gender == gender.id
          @state.typeName = gender.name
          break
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @state.typeName
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.avatar, 'AVATAR'
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @state.typeName
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.avatar, 'AVATAR'  
    Room: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.lang
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs',style: {margin: '5px'}, href: @props.record.map, 'Bản đồ'
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.lang
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs',style: {margin: '5px'}, href: @props.record.map, 'Bản đồ'
    Position: ->
      for room in @props.room
        if room.id == @props.record.room_id
          @state.typeName = room.name
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.pname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.description
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.file, 'File'
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.pname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.description
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.file, 'File'
    render: ->
      if @props.datatype == "medicine_supplier"
        @MedicineSupplier()
      else if @props.datatype == "medicine_company"
        @MedicineCompany()
      else if @props.datatype == "medicine_sample"
        @MedicineSample()
      else if @props.datatype == "medicine_bill_in"
        @MedicineBillIn()
      else if @props.datatype == "medicine_bill_record"
        @MedicineBillRecord()
      else if @props.datatype == 'medicine_price'
        @MedicinePrice()
      else if @props.datatype == 'medicine_prescript_external'
        @MedicinePrescriptExternal()
      else if @props.datatype == 'medicine_external_record'
        @MedicineExternalRecord()
      else if @props.datatype == 'medicine_prescript_internal'
        @MedicinePrescriptInternal()
      else if @props.datatype == 'medicine_internal_record'
        @MedicineInternalRecord()
      else if @props.datatype == 'medicine_stock_record'
        @MedicineStockRecord()
      else if @props.datatype == 'support_record'
        @SupportRecord()
      else if @props.datatype == 'ticket_record'
        @TicketRecord()
      else if @props.datatype == 'ticket_comment_record'
        @TicketCommentRecord()
      else if @props.datatype == 'service'
        @Service()
      else if @props.datatype == 'employee'
        @Employee()
      else if @props.datatype == 'room'
        @Room()
      else if @props.datatype == 'position'
        @Position()