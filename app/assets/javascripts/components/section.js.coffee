@Section = React.createClass
    getInitialState: ->
      type: 1
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
    normalRender: ->
      React.DOM.section
        id: 'main'
        React.DOM.aside
          id: 'sidebar'
          className: 'sidebar'
          React.DOM.ul
            className: 'main-menu'
            React.createElement MenuAside, submenu: @state.profile, Trigger: @Trigger      
            React.createElement MenuAside, submenu: @state.homeMenu, Trigger: @Trigger 
            React.createElement MenuAside, submenu: @state.Header, Trigger: @Trigger
    render: ->
      @normalRender()