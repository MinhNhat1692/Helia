@Section = React.createClass
    getInitialState: ->
      type: 1
      data: @props.data
      task: 11 #11 - employee
      toggled: false
      #profile:
      #  type: 0, active: false, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
      #  records: [
      #    {code: 5, active: false, name: 'Hỗ trợ'},
      #    {code: 6, active: false, name: 'Settings'},
      #    {code: 7, active: false, name: 'Log Out'}
      #  ]
      DataMenu: 
        type: 1, className: 'zmdi zmdi-view-list', active: true, name: "Dữ liệu", code: 11
      PatientMenu:
        type: 1, className: 'zmdi zmdi-account', active: false, name: "Bệnh nhân", code: 31
      DoctorMenu:
        type: 1, className: 'fa fa-user-md', active: false, name: "Bác sỹ", code: 60
      PharmacyMenu:
        type: 1, className: 'fa fa-medkit', active: false, name: "Thuốc", code: 41
      SummaryMenu:
        type: 1, className: 'fa fa-area-chart', active: false, name: "Thống kê", code: 80
      ApiMenu:
        type: 1, className: 'fa fa-key', active: false, name: "ApiKey", code: 101
      TeamMenu:
        type: 1, className: 'fa fa-users', active: false, name: "Phân quyền", code: 102
    Trigger: (code) ->
      if code == 11
        data =
          task: 11
          link: '/employee/list'
        @handleGetdata(data)
        @setState DataMenu:
          type: 1, className: 'zmdi zmdi-view-list', active: true, name: "Dữ liệu", code: 11
      else
        @setState DataMenu:
          type: 1, className: 'zmdi zmdi-view-list', active: false, name: "Dữ liệu", code: 11
      if code == 31
        data =
          task: 31
          link: '/customer_record/list'
        @handleGetdata(data)
        @setState PatientMenu:
          type: 1, className: 'zmdi zmdi-account', active: true, name: "Bệnh nhân", code: 31
      else
        @setState PatientMenu:
          type: 1, className: 'zmdi zmdi-account', active: false, name: "Bệnh nhân", code: 31
      if code == 60
        data =
          task: 60
          link: '/room_manager/list'
          formData: {length: 1}
        @handleGetdataAlt(data)
        @setState DoctorMenu:
          type: 1, className: 'fa fa-user-md', active: true, name: "Bác sỹ", code: 60
      else
        @setState DoctorMenu:
          type: 1, className: 'fa fa-user-md', active: false, name: "Bác sỹ", code: 60
      if code == 80
        data =
          task: 80
          link: '/medicine_summary/all'
        @handleGetdata(data)
        @setState SummaryMenu:
          type: 1, className: 'fa fa-area-chart', active: true, name: "Thống kê", code: 80
      else
        @setState SummaryMenu:
          type: 1, className: 'fa fa-area-chart', active: false, name: "Thống kê", code: 80
      if code == 41
        data =
          task: 41
          link: '/medicine_supplier/list'
        @handleGetdata(data)
        @setState PharmacyMenu:
          type: 1, className: 'fa fa-medkit', active: true, name: "Thuốc", code: 41
      else
        @setState PharmacyMenu:
          type: 1, className: 'fa fa-medkit', active: false, name: "Thuốc", code: 41
      if code == 101
        data =
          task: 101
          link: '/apikey/getkey'
        @handleGetdata(data)
        @setState ApiMenu:
            type: 1, className: 'fa fa-key', active: true, name: "ApiKey", code: 101
      else
        @setState ApiMenu:
          type: 1, className: 'fa fa-key', active: false, name: "ApiKey", code: 101
      if code == 102
        data =
          task: 102
          link: '/apikey/getkey'
        @handleGetdata(data)
        @setState TeamMenu:
            type: 1, className: 'fa fa-users', active: true, name: "Phân quyền", code: 102
      else
        @setState TeamMenu:
          type: 1, className: 'fa fa-users', active: false, name: "Phân quyền", code: 102
          
          
      if code == 5
        data =
          task: 5
          link: '/support/list'
        @handleGetdata(data)
        @setState profile:
          type: 0, active: true, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: true, name: 'Hỗ trợ'},
            {code: 6, active: false, name: 'Settings'},
            {code: 7, active: false, name: 'Log Out'}
          ]
      else if code == 6
        @setState profile:
          type: 0, active: true, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: false, name: 'Hỗ trợ'},
            {code: 6, active: true, name: 'Settings'},
            {code: 7, active: false, name: 'Log Out'}
          ]
      else if code == 7
        @setState profile:
          type: 0, active: true, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: false, name: 'Hỗ trợ'},
            {code: 6, active: false, name: 'Settings'},
            {code: 7, active: true, name: 'Log Out'}
          ]
      else
        @setState profile:
          type: 0, active: false, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: false, name: 'Hỗ trợ'},
            {code: 6, active: false, name: 'Settings'},
            {code: 7, active: false, name: 'Log Out'}
          ]
    handleGetdata: (data) ->
      $.ajax
        url: data.link
        type: 'POST'
        dataType: 'JSON'
        success: ((result) ->
          @setState
            data: result
            task: data.task
          $(APP).trigger('rebuilmain')
          return
        ).bind(this)
    handleGetdataAlt: (data) ->
      $.ajax
        url: data.link
        type: 'POST'
        data: data.formData
        dataType: 'JSON'
        success: ((result) ->
          @setState
            data: result
            task: data.task
          $(APP).trigger('rebuilmain')
          return
        ).bind(this)
    componentWillMount: ->
      $(APP).on 'toggle', ((e) ->
        @setState toggled: !@state.toggled
      ).bind(this)
    normalRender: ->
      React.DOM.section id: 'main',
        React.DOM.aside
          id: 'sidebar'
          className:
            if @state.toggled
              'sidebar'
            else
              'sidebar toggled'
          React.DOM.ul className: 'main-menu',
            React.createElement MenuAside, submenu: @state.DataMenu, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.PatientMenu, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.DoctorMenu, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.PharmacyMenu, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.SummaryMenu, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.ApiMenu, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.TeamMenu, Trigger: @Trigger
        React.createElement MainApp, data: @state.data, task: @state.task
    render: ->
      @normalRender()