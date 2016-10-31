@MenuAside = React.createClass
    getInitialState: ->
      # type = 1 -> no submenu
      # type = 2 -> has submenu
      # type = 0 -> profile submenu
      type : @props.submenu.type
      toggled: false
    Trigger: (e) ->
      @props.Trigger @props.submenu.code
    TriggerCode: (code) ->
      @props.Trigger code
    Toggled: (e) ->
      @setState toggled: !@state.toggled
    NoSubmenu: ->
      if @props.submenu.active
        React.DOM.li className: 'active', onClick: @Trigger,
          React.DOM.a null,
            React.DOM.i className: @props.submenu.className
          React.DOM.span className: 'hidden-xs', @props.submenu.name
      else
        React.DOM.li onClick: @Trigger,
          React.DOM.a null,
            React.DOM.i className: @props.submenu.className
          React.DOM.span className: 'hidden-xs', @props.submenu.name
    HasSubmenu: ->
      if @props.submenu.active
        if @state.toggled
          classNameAlt = 'submenu toggled active'
        else
          classNameAlt = 'submenu active'
      else
        if @state.toggled
          classNameAlt = 'submenu toggled'
        else
          classNameAlt = 'submenu'
      React.DOM.li
        className: classNameAlt
        React.DOM.a
          onClick: @Toggled
          React.DOM.span
            className: 'submenu-plus'
            React.DOM.i
              className: 'zmdi zmdi-plus'
          React.DOM.span
            className: 'submenu-minus'
            React.DOM.i
              className: 'zmdi zmdi-minus'
          React.DOM.i
            className: @props.submenu.className
          @props.submenu.name
        React.DOM.ul null,
          for submenu in @props.submenu.records
            React.createElement SubMenu, key: submenu.code, submenu: submenu, Trigger: @TriggerCode  
    ProfileSubmenu: ->
      if @props.submenu.active
        if @state.toggled
          classNameAlt = 'mm-profile submenu toggled active'
        else
          classNameAlt = 'mm-profile submenu active'
      else
        if @state.toggled
          classNameAlt = 'mm-profile submenu toggled'
        else
          classNameAlt = 'mm-profile submenu'
      React.DOM.li
        className: classNameAlt
        React.DOM.a
          className: 'media'
          onClick: @Toggled
          React.DOM.span
            className: 'submenu-plus'
            React.DOM.i
              className: 'zmdi zmdi-plus'
          React.DOM.span
            className: 'submenu-minus'
            React.DOM.i
              className: 'zmdi zmdi-minus'
          React.DOM.img
            src:
              if @props.submenu.logo == "/avatars/original/missing.png"
                'https://www.twomargins.com/images/noavatar.jpg'
              else
                @props.submenu.logo
          React.DOM.div
            className: 'media-body'
            @props.submenu.sname
            React.DOM.small null, @props.submenu.username
        React.DOM.ul null,
          for submenu in @props.submenu.records
            React.createElement SubMenu, key: submenu.code, submenu: submenu, Trigger: @TriggerCode
    render: ->
      if @state.type == 1
        @NoSubmenu()
      else if @state.type == 2
        @HasSubmenu()
      else if @state.type == 0
        @ProfileSubmenu()
        
@SubMenu = React.createClass
    Trigger: (e) ->
      @props.Trigger @props.submenu.code
    SubMenuRender: ->
      if @props.submenu.active
        React.DOM.li className: 'active', onClick: @Trigger,
          React.DOM.a null, @props.submenu.name
      else
        React.DOM.li onClick: @Trigger,
          React.DOM.a null, @props.submenu.name
    render: ->
      @SubMenuRender()
      
@MainHeader = React.createClass
    getInitialState: ->
      type: 1
    Trigger: (e) ->
      @props.Trigger @props.submenu.code
    TriggerCode: (code) ->
      @props.Trigger code
    Toggled: (e) ->
      @setState toggled: !@state.toggled
    HasSubmenu: ->
      React.DOM.div className: 'dashboard-header',
        React.DOM.h1 null, @props.data.name
        React.DOM.div className: 'tabbable',
          React.DOM.ul className: "nav nav-tabs",
            for submenu in @props.data.records
              React.createElement SubMenuHeader, key: submenu.code, task: @props.task, submenu: submenu, Trigger: @TriggerCode  
    render: ->
      @HasSubmenu()

@SubMenuHeader = React.createClass
    Trigger: (e) ->
      @props.Trigger @props.submenu.code
    SubMenuRender: ->
      if @props.submenu.code == @props.task
        React.DOM.li className: 'active', onClick: @Trigger,
          React.DOM.a null,
            React.DOM.i className: @props.submenu.icon
            @props.submenu.name
      else
        React.DOM.li className: '', onClick: @Trigger,
          React.DOM.a null,
            React.DOM.i className: @props.submenu.icon
            @props.submenu.name
    render: ->
      @SubMenuRender()