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
    MedicineSupplierMini: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.contactname
          React.DOM.td null, @props.record.pnumber
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.contactname
          React.DOM.td null, @props.record.pnumber
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
    MedicineCompanyMini: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.name
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
    MedicineSampleMini: ->
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
          React.DOM.td null, @props.record.name
          React.DOM.td null, @state.typeName
          React.DOM.td null, @state.groupName
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.name
          React.DOM.td null, @state.typeName
          React.DOM.td null, @state.groupName
          React.DOM.td null, @props.record.company
          React.DOM.td null, @props.record.price
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
            if @props.record.dayin != null and @props.record.dayin != undefined 
              @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null,
            if @props.record.daybook != null and @props.record.daybook != undefined
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
            if @props.record.dayin != null and @props.record.dayin != undefined 
              @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null,
            if @props.record.daybook != null and @props.record.daybook != undefined
              @props.record.daybook.substring(8, 10) + "/" + @props.record.daybook.substring(5, 7) + "/" + @props.record.daybook.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @state.groupName
    MedicineBillInMini: ->
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
            if @props.record.dayin != null and @props.record.dayin != undefined 
              @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @state.typeName
          React.DOM.td null, @state.groupName
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.billcode
          React.DOM.td null, 
            if @props.record.dayin != null and @props.record.dayin != undefined 
              @props.record.dayin.substring(8, 10) + "/" + @props.record.dayin.substring(5, 7) + "/" + @props.record.dayin.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.supplier
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @state.typeName
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
          React.DOM.td null, @props.record.company
          React.DOM.td null,
            if @props.record.expire != null and @props.record.expire != undefined
              @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
            else
              ""
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
          React.DOM.td null, @props.record.company
          React.DOM.td null,
            if @props.record.expire != null and @props.record.expire != undefined
              @props.record.expire.substring(8, 10) + "/" + @props.record.expire.substring(5, 7) + "/" + @props.record.expire.substring(0, 4)
            else
              ""
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
            if @props.record.date != null and @props.record.date != undefined
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
            if @props.record.date != null and @props.record.date != undefined
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
          React.DOM.td null, @props.record.result_id
          React.DOM.td null, @props.record.number_id
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.remark
    MedicinePrescriptExternalMini: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null and @props.record.date != undefined
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null and @props.record.date != undefined
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
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
            if @props.record.date != null and @props.record.date != undefined
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
            if @props.record.date != null and @props.record.date != undefined
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
    MedicinePrescriptInternalMini: ->
      if @props.selected
        React.DOM.tr
          className: "toggled"
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null and @props.record.date != undefined
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
      else
        React.DOM.tr
          onClick: @selectRecord
          React.DOM.td null, @props.record.code
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @props.record.ename
          React.DOM.td null,
            if @props.record.date != null and @props.record.date != undefined
              @props.record.date.substring(8, 10) + "/" + @props.record.date.substring(5, 7) + "/" + @props.record.date.substring(0, 4)
            else
              ""
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
            if @props.record.expire != null and @props.record.expire != undefined
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
            if @props.record.expire != null and @props.record.expire != undefined
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
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.sname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.currency
          React.DOM.td null, @props.record.description
    ServiceMini: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.sname
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.currency
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.sname
          React.DOM.td null, @props.record.price
          React.DOM.td null, @props.record.currency
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
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @state.typeName
    EmployeeMini: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.pnumber
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.pnumber
    Room: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.lang
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.lang
    Position: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.rname
          React.DOM.td null, @props.record.pname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.description
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.rname
          React.DOM.td null, @props.record.pname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.description
    PositionMini: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.rname
          React.DOM.td null, @props.record.pname
          React.DOM.td null, @props.record.description
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.rname
          React.DOM.td null, @props.record.pname
          React.DOM.td null, @props.record.description
    PosMap: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.pname
          React.DOM.td null, 
            if @props.record.updated_at != null && @props.record.updated_at != undefined
              @props.record.updated_at.substring(8, 10) + "/" + @props.record.updated_at.substring(5, 7) + "/" + @props.record.updated_at.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.created_at != null && @props.record.created_at != undefined
              @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7) + "/" + @props.record.created_at.substring(0, 4)
            else
              ""
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.pname
          React.DOM.td null, 
            if @props.record.updated_at != null && @props.record.updated_at != undefined
              @props.record.updated_at.substring(8, 10) + "/" + @props.record.updated_at.substring(5, 7) + "/" + @props.record.updated_at.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.created_at != null && @props.record.created_at != undefined
              @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7) + "/" + @props.record.created_at.substring(0, 4)
            else
              ""
    SerMap: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.sname
          React.DOM.td null, @props.record.rname
          React.DOM.td null, 
            if @props.record.updated_at != null && @props.record.updated_at != undefined
              @props.record.updated_at.substring(8, 10) + "/" + @props.record.updated_at.substring(5, 7) + "/" + @props.record.updated_at.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.created_at != null && @props.record.created_at != undefined
              @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7) + "/" + @props.record.created_at.substring(0, 4)
            else
              ""
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.sname
          React.DOM.td null, @props.record.rname
          React.DOM.td null, 
            if @props.record.updated_at != null && @props.record.updated_at != undefined
              @props.record.updated_at.substring(8, 10) + "/" + @props.record.updated_at.substring(5, 7) + "/" + @props.record.updated_at.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.created_at != null && @props.record.created_at != undefined
              @props.record.created_at.substring(8, 10) + "/" + @props.record.created_at.substring(5, 7) + "/" + @props.record.created_at.substring(0, 4)
            else
              ""
    CustomerRecord: ->
      for gender in @props.gender
        if @props.record.gender == gender.id
          @state.typeName = gender.name
          break
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.cname
          React.DOM.td null, 
            if @props.record.dob != null && @props.record.dob != undefined
              @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.dob != null and @props.record.dob != undefined
              @calAge(@props.record.dob,2).years
            else
              ""
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.issue_date
          React.DOM.td null, @props.record.issue_place
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.cname
          React.DOM.td null, 
            if @props.record.dob != null && @props.record.dob != undefined 
              @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.dob != null && @props.record.dob != undefined 
              @calAge(@props.record.dob,2).years
            else
              ""
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.noid
          React.DOM.td null, @props.record.issue_date
          React.DOM.td null, @props.record.issue_place
    CustomerRecordMini: ->
      for gender in @props.gender
        if @props.record.gender == gender.id
          @state.typeName = gender.name
          break
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.cname
          React.DOM.td null, 
            if @props.record.dob != null && @props.record.dob != undefined
              @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.dob != null && @props.record.dob != undefined  
              @calAge(@props.record.dob,2).years
            else
              ""
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.noid
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.cname
          React.DOM.td null, 
            if @props.record.dob != null && @props.record.dob != undefined 
              @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
            else
              ""
          React.DOM.td null,
            if @props.record.dob != null && @props.record.dob != undefined 
              @calAge(@props.record.dob,2).years
            else
              ""
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.address
          React.DOM.td null, @props.record.pnumber
          React.DOM.td null, @props.record.noid
    OrderMap: ->
      switch Number(@props.record.status)
        when 1
          @state.typeName = "Chưa thanh toán, chưa khám bệnh"
        when 2
          @state.typeName = "Đã thanh toán, đang chờ khám"
        when 3
          @state.typeName = "Đã thanh toán, đã khám bệnh"
        when 4
          @state.typeName = "Chưa thanh toán, đã khám bệnh"
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.sername
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @props.record.remark
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.sername
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
          React.DOM.td null, @props.record.remark
    DoctorRoom: ->
      switch Number(@props.record.status)
        when 1
          @state.typeName = "Chưa thanh toán, chưa khám bệnh"
        when 2
          @state.typeName = "Đã thanh toán, đang chờ khám"
        when 3
          @state.typeName = "Đã thanh toán, đã khám bệnh"
        when 4
          @state.typeName = "Chưa thanh toán, đã khám bệnh"
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.id
          React.DOM.td null, @props.record.sername
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.remark
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.id
          React.DOM.td null, @props.record.sername
          React.DOM.td null, @props.record.cname
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.remark
    CheckInfo: ->
      switch Number(@props.record.status)
        when 1
          @state.typeName = "Chưa khám"
        when 2
          @state.typeName = "Đang khám"
        when 3
          @state.typeName = "Kết thúc khám"
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.c_name
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.kluan
          React.DOM.td null, @props.record.cdoan
          React.DOM.td null, @props.record.hdieutri
          React.DOM.td null, @state.typeName
          React.DOM.td null, 
            if @props.record.daystart != null && @props.record.daystart != undefined
              @props.record.daystart.substring(8, 10) + "/" + @props.record.daystart.substring(5, 7) + "/" + @props.record.daystart.substring(0, 4)
            else
              ""
          React.DOM.td null, 
            if @props.record.dayend != null && @props.record.dayend != undefined
              @props.record.dayend.substring(8, 10) + "/" + @props.record.dayend.substring(5, 7) + "/" + @props.record.dayend.substring(0, 4)
            else
              ""
      else    
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.c_name
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.kluan
          React.DOM.td null, @props.record.cdoan
          React.DOM.td null, @props.record.hdieutri
          React.DOM.td null, @state.typeName
          React.DOM.td null, 
            if @props.record.daystart != null && @props.record.daystart != undefined
              @props.record.daystart.substring(8, 10) + "/" + @props.record.daystart.substring(5, 7) + "/" + @props.record.daystart.substring(0, 4)
            else
              ""
          React.DOM.td null, 
            if @props.record.dayend != null && @props.record.dayend != undefined
              @props.record.dayend.substring(8, 10) + "/" + @props.record.dayend.substring(5, 7) + "/" + @props.record.dayend.substring(0, 4)
            else
              ""
    DoctorCheckInfo: ->
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.c_name
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.qtbenhly
          React.DOM.td null, @props.record.klamsang
          React.DOM.td null, @props.record.cdbandau
          React.DOM.td null, @props.record.bktheo
          React.DOM.td null, @props.record.cdicd
          React.DOM.td null, @props.record.kluan
          React.DOM.td null, 
            if @props.record.daycheck != null && @props.record.daycheck != undefined
              @props.record.daycheck.substring(8, 10) + "/" + @props.record.daycheck.substring(5, 7) + "/" + @props.record.daycheck.substring(0, 4)
            else
              ""
      else    
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.c_name
          React.DOM.td null, @props.record.ename
          React.DOM.td null, @props.record.qtbenhly
          React.DOM.td null, @props.record.klamsang
          React.DOM.td null, @props.record.cdbandau
          React.DOM.td null, @props.record.bktheo
          React.DOM.td null, @props.record.cdicd
          React.DOM.td null, @props.record.kluan
          React.DOM.td null, 
            if @props.record.daycheck != null && @props.record.daycheck != undefined
              @props.record.daycheck.substring(8, 10) + "/" + @props.record.daycheck.substring(5, 7) + "/" + @props.record.daycheck.substring(0, 4)
            else
              ""
    BillInfo: ->
      for dvi in @props.dvi
        if dvi.id == @props.record.dvi
          @state.typeName = dvi.name
      if @props.selected
        React.DOM.tr className: "toggled",
          React.DOM.td null, @props.record.c_name
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.sluong
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
      else    
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.c_name
          React.DOM.td null, @props.record.remark
          React.DOM.td null, @state.typeName
          React.DOM.td null, @props.record.sluong
          React.DOM.td null, @props.record.tpayment
          React.DOM.td null, @props.record.discount
          React.DOM.td null, @props.record.tpayout
    render: ->
      if @props.datatype == "medicine_supplier"
        @MedicineSupplier()
      else if @props.datatype == "medicine_supplier_mini"
        @MedicineSupplierMini()
      else if @props.datatype == "medicine_company"
        @MedicineCompany()
      else if @props.datatype == "medicine_company_mini"
        @MedicineCompanyMini()
      else if @props.datatype == "medicine_sample"
        @MedicineSample()
      else if @props.datatype == "medicine_sample_mini"
        @MedicineSampleMini()
      else if @props.datatype == "medicine_bill_in"
        @MedicineBillIn()
      else if @props.datatype == "medicine_bill_in_mini"
        @MedicineBillInMini()
      else if @props.datatype == "medicine_bill_record"
        @MedicineBillRecord()
      else if @props.datatype == 'medicine_price'
        @MedicinePrice()
      else if @props.datatype == 'medicine_prescript_external'
        @MedicinePrescriptExternal()
      else if @props.datatype == 'medicine_prescript_external_mini'
        @MedicinePrescriptExternalMini()
      else if @props.datatype == 'medicine_external_record'
        @MedicineExternalRecord()
      else if @props.datatype == 'medicine_prescript_internal'
        @MedicinePrescriptInternal()
      else if @props.datatype == 'medicine_prescript_internal_mini'
        @MedicinePrescriptInternalMini()
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
      else if @props.datatype == 'room' or @props.datatype == 'room_mini'
        @Room()
      else if @props.datatype == 'position'
        @Position()
      else if @props.datatype == 'position_mini'
        @PositionMini()
      else if @props.datatype == 'posmap'
        @PosMap()
      else if @props.datatype == 'sermap'
        @SerMap()
      else if @props.datatype == 'customer_record'
        @CustomerRecord()
      else if @props.datatype == 'order_map'
        @OrderMap()
      else if @props.datatype == 'check_info'
        @CheckInfo()
      else if @props.datatype == 'doctor_check_info'
        @DoctorCheckInfo()
      else if @props.datatype == 'bill_info'
        @BillInfo()
      else if @props.datatype == 'customer_record_mini'
        @CustomerRecordMini()
      else if @props.datatype == 'service_mini'
        @ServiceMini()
      else if @props.datatype == 'employee_mini'
        @EmployeeMini()
      else if @props.datatype == 'doctor_room'
        @DoctorRoom()
        

  @ListgroupSample = React.createClass
    getInitialState: ->
      type: 1
    employeeRender: ->
      React.DOM.ul className: 'list-details list-unstyled',
        for record in @props.records
          if record.room_id == @props.room_id
            for posmap in record.position_mappings
              React.createElement ListgroupDetail, key: record.id + posmap.ename + posmap.pname + posmap.created_at, bigtext: posmap.ename, smalltext: posmap.pname
    serviceRender: ->
      React.DOM.ul className: 'list-details list-unstyled',
        for record in @props.records
          React.createElement ListgroupDetail, key: record.id + record.created_at, bigtext: record.sname, smalltext: ''
    render: ->
      if @props.datatype == 'employee_group'
        @employeeRender()
      else if @props.datatype == 'service_group'
        @serviceRender()

  @ListgroupDetail = React.createClass
    getInitialState: ->
      type: 1
    noImgRender: ->
      React.DOM.li key: null,
        React.DOM.span null, @props.bigtext
        React.DOM.span className: 'count', @props.smalltext
    render: ->
      @noImgRender()

  @RoomSample = React.createClass
    getInitialState: ->
      wait: 0
      customer: 0
      income: 0
    drawDoughnutIncome: ->
      canvas = document.getElementById('roomCanvas' + @props.data.id)
      if canvas != null
        myDoughnutChart = new Chart(canvas, {
          type: 'doughnut',
          data: @getIncomeChartData()
        })  
    drawDoughnutWait: ->
      canvas = document.getElementById('roomCanvas' + @props.data.id)
      if canvas != null
        myDoughnutChart = new Chart(canvas, {
          type: 'doughnut',
          data: @getWaitChartData()
        })
    drawDoughnutCustomer: ->
      canvas = document.getElementById('roomCanvas' + @props.data.id)
      if canvas != null
        myDoughnutChart = new Chart(canvas, {
          type: 'doughnut',
          data: @getCustomerChartData()
        })
    drawLineIncome: ->
      canvas = document.getElementById('roomCanvas' + @props.data.id)
      if canvas != null
        myLineChart = new Chart(canvas, {
          type: 'line',
          data: @getIncomeLineChartData()
          options: { 
            responsive: true
            maintainAspectRatio: true
          }
        })
    getIncomeChartData: ->
      labellist = []
      datanumber = []
      for service in @props.data.service_maps
        labellist.push(service.sname)
        incomesnumber: 0
        for statincome in @props.statincome
          if statincome.service_id == service.service_id
            incomesnumber = statincome.sum
        datanumber.push(incomesnumber)
      dataOut = {
        labels: labellist
        datasets: [{
          data: datanumber
          backgroundColor: ["#673AB7","#00BCD4","#CDDC39","#FF5722","#9C27B0","#03A9F4","#8BC34A","#FF9800","#607D8B"]
          hoverBackgroundColor: ["#673AB7","#00BCD4","#CDDC39","#FF5722","#9C27B0","#03A9F4","#8BC34A","#FF9800","#607D8B"]
        }]
      }
      return dataOut
    getWaitChartData: ->
      labellist = []
      datanumber = []
      for service in @props.data.service_maps
        labellist.push(service.sname)
        incomesnumber: 0
        for statwait in @props.statwait
          if statwait.service_id == service.service_id
            incomesnumber = statwait.count
        datanumber.push(incomesnumber)
      dataOut = {
        labels: labellist
        datasets: [{
          data: datanumber
          backgroundColor: ["#673AB7","#00BCD4","#CDDC39","#FF5722","#9C27B0","#03A9F4","#8BC34A","#FF9800","#607D8B"]
          hoverBackgroundColor: ["#673AB7","#00BCD4","#CDDC39","#FF5722","#9C27B0","#03A9F4","#8BC34A","#FF9800","#607D8B"]
        }]
      }
      return dataOut
    getCustomerChartData: ->
      labellist = []
      datanumber = []
      for service in @props.data.service_maps
        labellist.push(service.sname)
        incomesnumber: 0
        for stattoday in @props.stattoday
          if stattoday.service_id == service.service_id
            incomesnumber = stattoday.count
        datanumber.push(incomesnumber)
      dataOut = {
        labels: labellist
        datasets: [{
          data: datanumber
          backgroundColor: ["#673AB7","#00BCD4","#CDDC39","#FF5722","#9C27B0","#03A9F4","#8BC34A","#FF9800","#607D8B"]
          hoverBackgroundColor: ["#673AB7","#00BCD4","#CDDC39","#FF5722","#9C27B0","#03A9F4","#8BC34A","#FF9800","#607D8B"]
        }]
      }
      return dataOut
    getIncomeLineChartData: ->
      labellist= []
      if @props.timelong == '1 năm'
        for i in [12...0]
          monthnumber = (new Date).getMonth()-i + 2
          if monthnumber <= 0
            monthnumber = monthnumber + 12
          labellist.push('Tháng ' + monthnumber)
      else if @props.timelong == '1 tháng'
        for i in [31...0]
          datenumber = (new Date).getDate()-i + 1
          if datenumber <= 0
            monthnumber = (new Date).getMonth()
            if monthnumber != 0
              datenumber = datenumber + new Date((new Date).getYear(), monthnumber - 1, 0).getDate()
            else
              datenumber += 31
          labellist.push(datenumber)
      else if @props.timelong == '24h'
        for i in [24...0]
          hournumber = (new Date).getHours()-i + 1
          if hournumber <= 0
            hournumber += 24
          labellist.push(hournumber)
      datanumber = []
      incomesnumber = 0
      if @props.timelong == '1 năm'
        for i in [12...0]
          incomesnumber = 0
          for service in @props.data.service_maps
            now = new Date
            thentime = new Date
            for statincome in @props.statincome_detail
              if statincome.service_id == service.service_id and Date.parse(statincome.updated_at) >= now.setMonth((new Date).getMonth()-i) and Date.parse(statincome.updated_at) < thentime.setMonth((new Date).getMonth()-i+1)
                incomesnumber+= statincome.sum
          datanumber.push(incomesnumber)
      else if @props.timelong == '1 tháng'
        for i in [31...0]
          incomesnumber = 0
          for service in @props.data.service_maps
            now = new Date
            thentime = new Date
            for statincome in @props.statincome_detail
              if statincome.service_id == service.service_id and Date.parse(statincome.updated_at) >= now.setDate((new Date).getDate()-i) and Date.parse(statincome.updated_at) < thentime.setDate((new Date).getDate()-i+1)
                incomesnumber+= statincome.sum
          datanumber.push(incomesnumber)
      else if @props.timelong == '24h'
        for i in [24...0]
          incomesnumber = 0
          for service in @props.data.service_maps
            now = new Date
            thentime = new Date
            for statincome in @props.statincome_detail
              if statincome.service_id == service.service_id and Date.parse(statincome.updated_at) >= now.setHours((new Date).getHours()-i) and Date.parse(statincome.updated_at) < thentime.setHours((new Date).getHours()-i+1)
                incomesnumber+= statincome.sum
          datanumber.push(incomesnumber)
      dataOut = {
        labels: labellist
        datasets: [{
          label: "Thu nhập"
          fill: true
          lineTension: 0.1
          backgroundColor: "rgba(75,192,192,0.4)"
          borderColor: "rgba(75,192,192,1)"
          borderCapStyle: 'butt'
          borderDash: []
          borderDashOffset: 0.0
          borderJoinStyle: 'miter'
          pointBorderColor: "rgba(75,192,192,1)"
          pointBackgroundColor: "#fff"
          pointBorderWidth: 1
          pointHoverRadius: 5
          pointHoverBackgroundColor: "rgba(75,192,192,1)"
          pointHoverBorderColor: "rgba(220,220,220,1)"
          pointHoverBorderWidth: 2
          pointRadius: 1
          pointHitRadius: 10
          data: datanumber
          spanGaps: true
        }]
      }
      return dataOut
    getTotalposition: ->
      output = 0
      for record in @props.position
        if record.room_id == @props.data.id
          output+= 1
      return output
    getTotalService: ->
      output = 0
      for record in @props.data
        output+= record.service_maps.length
      return output
    smallModeRender: ->
      @state.wait = 0
      @state.customer = 0
      @state.income = 0
      for wait in @props.statwait
        for service in @props.data.service_maps
          if wait.service_id == service.service_id
            @state.wait+= wait.count
      for stattoday in @props.stattoday
        for service in @props.data.service_maps
          if stattoday.service_id == service.service_id
            @state.customer+= stattoday.count
      for statincome in @props.statincome
        for service in @props.data.service_maps
          if statincome.service_id == service.service_id
            @state.income+= statincome.sum
      React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, @props.data.name
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-3 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', @props.timelong
                      React.DOM.br null
                      "Số người chờ"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.wait
                  React.DOM.div className: 'col-md-3 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', @props.timelong
                      React.DOM.br null
                      "Số khách"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.customer
                  React.DOM.div className: 'col-md-3 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', @props.timelong
                      React.DOM.br null
                      "Doanh thu"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.income
                  React.DOM.div className: 'col-md-3 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', @props.timelong
                      React.DOM.br null
                      "Queries"
                    React.DOM.div className: 'row text-center',
                      React.DOM.span className: 'text-muted', "Under"
                      React.DOM.span className: 'text-response-time number-xxl', style: {'margin':'0px 5px'}, "3"
                      "ms"
                React.DOM.div className: 'row',
                  React.DOM.div className: 'spacer30'
                  React.DOM.div className: 'col-sm-6',
                    React.DOM.div className: 'col-sm-2 text-center',
                      React.DOM.i className: 'fa fa-list fa-3x'
                    React.DOM.div className: 'col-sm-10',
                      React.DOM.h4 null, 'Danh sách nhân viên'
                      React.DOM.span className: 'number-lg text-operation', @getTotalposition()
                      "/"
                      React.DOM.span null, @props.position.length
                      React.DOM.div className: 'progress',
                        React.DOM.div className: 'progress-bar bg-operation', style: {'width': (@getTotalposition() / @props.position.length)*100 + '%'}
                      if @props.position.length > 0 and @getTotalposition() > 0
                        React.createElement ListgroupSample, room_id: @props.data.id, records: @props.position, datatype: 'employee_group'
                      else if @props.position.length > 0 and @getTotalposition() == 0
                        React.DOM.p null, "Không có nhân viên trong phòng"
                      else
                        React.DOM.p null, "Không có nhân viên trong phòng"
                  React.DOM.div className: 'col-sm-6',
                    React.DOM.div className: 'col-sm-2 text-center',
                      React.DOM.i className: 'fa fa-th-list fa-3x'
                    React.DOM.div className: 'col-sm-10',
                      React.DOM.h4 null, 'Danh sách dịch vụ'
                      React.DOM.span className: 'number-lg text-operation', @props.data.service_maps.length
                      "/"
                      React.DOM.span null, @props.data.service_maps.length
                      React.DOM.div className: 'progress',
                        React.DOM.div className: 'progress-bar bg-operation', style: {'width': (@props.data.service_maps.length/ @props.data.service_maps.length)*100 + '%'}
                      if @props.data.service_maps.length > 0
                        React.createElement ListgroupSample, records: @props.data.service_maps, datatype: 'service_group'
                      else
                        React.DOM.p null, "Không có dịch vụ trong phòng"
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê biểu đồ tóm tắt'
                React.DOM.div className: 'panel-toolbar',
                  React.DOM.div className: 'btn-group',
                    React.DOM.button className: 'btn btn-default btn-sm', onClick: @drawLineIncome, 'Thu nhập'
                    React.DOM.button className: 'btn btn-default btn-sm', onClick: @drawDoughnutCustomer, 'Tổng số khách'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row', style: {'overflow':'auto'},
                  React.DOM.canvas id: 'roomCanvas' + @props.data.id
    expandModeRender: ->
    render: ->
      if @props.datatype == 'normal'
        @smallModeRender()
      else if @props.datatype == 'expand'
        @expandModeRender()
  
  
  #Paginate
  #input: className - of container
  # tp: total page, cp: currentpage
  # tr: total record, rpp: record per page, cp: curren page
  #output:
  # triggerLeftMax, triggerLeft, triggerRight, triggerRightMax
  # triggerPage: with page number wanna trigger
  @Paginate = React.createClass
    getInitialState: ->
      datatype: 1
    triggerLeftMax: (e) ->
      @props.triggerLeftMax e
    triggerLeft: (e) ->
      @props.triggerLeft e
    triggerRightMax: (e) ->
      @props.triggerRightMax e
    triggerRight: (e) ->
      @props.triggerRight e
    triggerPage: (page) ->
      @props.triggerPage page
    normalRender: ->
      if @props.tp < 4
        React.DOM.div className: @props.className,
          React.DOM.button className: 'btn btn-default', onClick: @triggerLeftMax,
            React.DOM.i className: 'fa fa-angle-double-left'
          React.DOM.button className: 'btn btn-default', onClick: @triggerLeft,
            React.DOM.i className: 'fa fa-angle-left'
          for i in [1...@props.tp + 1]
            if i == @props.cp
              React.createElement ButtonGeneral, key: i, className: 'btn btn-default bg-green', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
            else
              React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
          React.DOM.button className: 'btn btn-default', onClick: @triggerRight,
            React.DOM.i className: 'fa fa-angle-right'
          React.DOM.button className: 'btn btn-default', onClick: @triggerRightMax,
            React.DOM.i className: 'fa fa-angle-double-right'
      else
        if @props.cp == 1
          React.DOM.div className: @props.className,
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeftMax,
              React.DOM.i className: 'fa fa-angle-double-left'
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeft,
              React.DOM.i className: 'fa fa-angle-left'
            for i in [1...3]
              if i == @props.cp
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default bg-green', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
              else
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default',
              React.DOM.i className: 'zmdi zmdi-more-horiz'
            React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: @props.tp + '', code: @props.tp, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default', onClick: @triggerRight,
              React.DOM.i className: 'fa fa-angle-right'
            React.DOM.button className: 'btn btn-default', onClick: @triggerRightMax,
              React.DOM.i className: 'fa fa-angle-double-right'
        else if @props.cp == 2
          React.DOM.div className: @props.className,
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeftMax,
              React.DOM.i className: 'fa fa-angle-double-left'
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeft,
              React.DOM.i className: 'fa fa-angle-left'
            for i in [1...4]
              if i == @props.cp
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default bg-green', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
              else
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default',
              React.DOM.i className: 'zmdi zmdi-more-horiz'
            React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: @props.tp + '', code: @props.tp, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default', onClick: @triggerRight,
              React.DOM.i className: 'fa fa-angle-right'
            React.DOM.button className: 'btn btn-default', onClick: @triggerRightMax,
              React.DOM.i className: 'fa fa-angle-double-right'
        else if @props.cp == (@props.tp - 1)
          React.DOM.div className: @props.className,
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeftMax,
              React.DOM.i className: 'fa fa-angle-double-left'
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeft,
              React.DOM.i className: 'fa fa-angle-left'
            React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: '1', code: 1, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default',
              React.DOM.i className: 'zmdi zmdi-more-horiz'
            for i in [@props.tp - 2...@props.tp + 1]
              if i == @props.cp
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default bg-green', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
              else
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default', onClick: @triggerRight,
              React.DOM.i className: 'fa fa-angle-right'
            React.DOM.button className: 'btn btn-default', onClick: @triggerRightMax,
              React.DOM.i className: 'fa fa-angle-double-right'
        else if @props.cp == @props.tp
          React.DOM.div className: @props.className,
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeftMax,
              React.DOM.i className: 'fa fa-angle-double-left'
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeft,
              React.DOM.i className: 'fa fa-angle-left'
            React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: '1', code: 1, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default',
              React.DOM.i className: 'zmdi zmdi-more-horiz'
            for i in [@props.tp - 1...@props.tp + 1]
              if i == @props.cp
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default bg-green', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
              else
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default', onClick: @triggerRight,
              React.DOM.i className: 'fa fa-angle-right'
            React.DOM.button className: 'btn btn-default', onClick: @triggerRightMax,
              React.DOM.i className: 'fa fa-angle-double-right'
        else
          React.DOM.div className: @props.className,
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeftMax,
              React.DOM.i className: 'fa fa-angle-double-left'
            React.DOM.button className: 'btn btn-default', onClick: @triggerLeft,
              React.DOM.i className: 'fa fa-angle-left'
            React.DOM.button className: 'btn btn-default',
              React.DOM.i className: 'zmdi zmdi-more-horiz'
            for i in [@props.cp - 1...@props.cp + 2]
              if i == @props.cp
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default bg-green', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
              else
                React.createElement ButtonGeneral, key: i, className: 'btn btn-default', icon: '', text: i + '', code: i, type: 3, Clicked: @triggerPage
            React.DOM.button className: 'btn btn-default',
              React.DOM.i className: 'zmdi zmdi-more-horiz'
            React.DOM.button className: 'btn btn-default', onClick: @triggerRight,
              React.DOM.i className: 'fa fa-angle-right'
            React.DOM.button className: 'btn btn-default', onClick: @triggerRightMax,
              React.DOM.i className: 'fa fa-angle-double-right'
    render: ->
      @normalRender()
      
      
  #Table Header
  #input: header - array of header and var code, csc - current sort code 
  #Ex: [{id: 1, name: 'Mã', code: 'noid'},{id: 2, name: 'Mã', code: 'noid'}]
  #output: triggerClick(code) -> sortcode
  @TableHeader = React.createClass
    getInitialState: ->
      datatype: 1
    triggerClick: (code) ->
      @props.triggerClick code
    normalRender: ->
      React.DOM.thead null,
        React.DOM.tr null,
          for record in @props.header
            if record.code == @props.csc
              React.DOM.th key: record.id,
                React.createElement IconClick, className: 'zmdi zmdi-sort-amount-asc', code: '-' + record.code, triggerClick: @triggerClick
                ' ' + record.name
            else
              React.DOM.th key: record.id,
                React.createElement IconClick, className: 'zmdi zmdi-sort-amount-desc', code: record.code, triggerClick: @triggerClick
                ' ' + record.name
    render: ->
      @normalRender()
          