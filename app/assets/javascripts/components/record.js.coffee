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
            if @props.record.expire != null and @props.record.expire != undefined
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
            if @props.record.expire != null and @props.record.expire != undefined
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
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs',style: {margin: '5px'}, href: @props.record.map, 'Bản đồ'
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.name
          React.DOM.td null, @props.record.lang
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs',style: {margin: '5px'}, href: @props.record.map, 'Bản đồ'
    RoomMini: ->
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
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.file, 'File'
      else
        React.DOM.tr onClick: @selectRecord,
          React.DOM.td null, @props.record.rname
          React.DOM.td null, @props.record.pname
          React.DOM.td null, @props.record.lang
          React.DOM.td null, @props.record.description
          React.DOM.td null,
            React.DOM.a className: 'btn btn-default btn-xs', style: {margin: '5px'}, href: @props.record.file, 'File'
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
          React.DOM.td null,
            React.DOM.a href: @props.record.avatar, className: 'btn btn-default', target: '_blank', style: {margin: '5px'}, 'Avatar'
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
          React.DOM.td null,
            React.DOM.a href: @props.record.avatar, className: 'btn btn-default', target: '_blank', style: {margin: '5px'}, 'Avatar'
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
      else if @props.datatype == 'room_mini'
        @RoomMini()
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