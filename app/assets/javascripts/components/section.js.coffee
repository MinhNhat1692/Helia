@Section = React.createClass
    getInitialState: ->
      type: 1
      data: @props.data
      task: 1 #1 - employee
      toggled: false
      profile:
        type: 0
        active: false
        logo: @props.station.logo
        sname: @props.station.sname
        username: @props.username
        records: [
          {
            code: 5
            active: false
            name: 'Messages'
          }
          {
            code: 6
            active: false
            name: 'Settings'
          }
          {
            code: 7
            active: false
            name: 'Log Out'
          }
        ]
      homeMenu: 
        type: 1
        className: 'zmdi zmdi-home'
        active: false
        name: "Home"
        code: 1
      Header:
        type: 2
        className: 'zmdi zmdi-view-compact'
        active: false
        name: "Header"
        records: [
          {
            code: 2
            active: false
            name: 'Top'
          }
          {
            code: 3
            active: false
            name: 'Middle'
          }
          {
            code: 4
            active: false
            name: 'Bottom'
          }
        ]
      DataInput:
        type: 2
        className: 'zmdi zmdi-view-list'
        active: true
        name: "Nhập dữ liệu gốc"
        records: [
          {
            code: 11 #employee
            active: true
            name: 'Danh sách nhân viên'
          }
          {
            code: 12 #room
            active: false
            name: 'Danh sách phòng'
          }
          {
            code: 13 #position
            active: false
            name: 'Danh sách chức vụ'
          }
          {
            code: 14 #service
            active: false
            name: 'Danh sách dịch vụ'
          }
        ]
      DataLink:
        type: 2
        className: 'fa fa-link'
        active: false
        name: "Liên kết dữ liệu"
        records: [
          {
            code: 21 #employee link
            active: false
            name: 'Liên kết chức vụ'
          }
          {
            code: 22 #service link
            active: false
            name: 'Liên kết dịch vụ'
          }
        ]
    Trigger: (code) ->
      if code == 1
        @setState homeMenu:
          type: 1
          className: 'zmdi zmdi-home'
          active: true
          name: "Home"
          code: 1
      else
        @setState homeMenu:
          type: 1
          className: 'zmdi zmdi-home'
          active: false
          name: "Home"
          code: 1
      if code == 2
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          active: true
          name: "Header"
          records: [
            {
              code: 2
              active: true
              name: 'Top'
            }
            {
              code: 3
              active: false
              name: 'Middle'
            }
            {
              code: 4
              active: false
              name: 'Bottom'
            }
          ]  
      else if code == 3
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          active: true
          name: "Header"
          records: [
            {
              code: 2
              active: false
              name: 'Top'
            }
            {
              code: 3
              active: true
              name: 'Middle'
            }
            {
              code: 4
              active: false
              name: 'Bottom'
            }
          ]
      else if code == 4
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          active: true
          name: "Header"
          records: [
            {
              code: 2
              active: false
              name: 'Top'
            }
            {
              code: 3
              active: false
              name: 'Middle'
            }
            {
              code: 4
              active: true
              name: 'Bottom'
            }
          ]
      else
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          name: "Header"  
          active: false
          records: [
            {
              code: 2
              active: false
              name: 'Top'
            }
            {
              code: 3
              active: false
              name: 'Middle'
            }
            {
              code: 4
              active: false
              name: 'Bottom'
            }
          ]
      if code == 5
        @setState profile:
          type: 0
          active: true
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: true
              name: 'Messages'
            }
            {
              code: 6
              active: false
              name: 'Settings'
            }
            {
              code: 7
              active: false
              name: 'Log Out'
            }
          ]
      else if code == 6
        @setState profile:
          type: 0
          active: true
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: false
              name: 'Messages'
            }
            {
              code: 6
              active: true
              name: 'Settings'
            }
            {
              code: 7
              active: false
              name: 'Log Out'
            }
          ]
      else if code == 7
        @setState profile:
          type: 0
          active: true
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: false
              name: 'Messages'
            }
            {
              code: 6
              active: false
              name: 'Settings'
            }
            {
              code: 7
              active: true
              name: 'Log Out'
            }
          ]
      else
        @setState profile:
          type: 0
          active: false
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: false
              name: 'Messages'
            }
            {
              code: 6
              active: false
              name: 'Settings'
            }
            {
              code: 7
              active: false
              name: 'Log Out'
            }
          ]
      if code == 11 #employee
        data =
          task: 1
          link: '/employees/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: true
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      else if code == 12 #room
        data =
          task: 3
          link: '/rooms/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: true
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      else if code == 13 #position
        data =
          task: 2
          link: '/positions/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: true
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      else if code == 14 #service
        data =
          task: 5
          link: '/services/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: true
              name: 'Danh sách dịch vụ'
            }
          ]
      else
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: false
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      if code == 21 #employee link
        data =
          task: 4
          link: '/position_mapping/list'
        @handleGetdata(data)
        @setState DataLink:
          type: 2
          className: 'fa fa-link'
          active: true
          name: "Liên kết dữ liệu"
          records: [
            {
              code: 21 #employee link
              active: true
              name: 'Liên kết chức vụ'
            }
            {
              code: 22 #service link
              active: false
              name: 'Liên kết dịch vụ'
            }
          ]
      else if code == 22 #service link
        data =
          task: 6
          link: '/service_mapping/list'
        @handleGetdata(data)
        @setState DataLink:
          type: 2
          className: 'fa fa-link'
          active: true
          name: "Liên kết dữ liệu"
          records: [
            {
              code: 21 #employee link
              active: false
              name: 'Liên kết chức vụ'
            }
            {
              code: 22 #service link
              active: true
              name: 'Liên kết dịch vụ'
            }
          ]
      else
        @setState DataLink:
          type: 2
          className: 'fa fa-link'
          active: false
          name: "Liên kết dữ liệu"
          records: [
            {
              code: 21 #employee link
              active: false
              name: 'Liên kết chức vụ'
            }
            {
              code: 22 #service link
              active: false
              name: 'Liên kết dịch vụ'
            }
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
          return
        ).bind(this)
    componentWillMount: ->
      $(APP).on 'toggle', ((e) ->
        @setState toggled: !@state.toggled
      ).bind(this)
    normalRender: ->
      React.DOM.section
        id: 'main'
        React.DOM.aside
          id: 'sidebar'
          className:
            if @state.toggled
              'sidebar'
            else
              'sidebar toggled'
          React.DOM.ul
            className: 'main-menu'
            React.createElement MenuAside, submenu: @state.profile, Trigger: @Trigger      
            React.createElement MenuAside, submenu: @state.homeMenu, Trigger: @Trigger 
            React.createElement MenuAside, submenu: @state.Header, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.DataInput, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.DataLink, Trigger: @Trigger
        React.DOM.section
          id: 'content'
          React.createElement MainApp, data: @state.data, task: @state.task
    render: ->
      @normalRender()