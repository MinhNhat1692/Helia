@Header = React.createClass
    getInitialState: ->
      skin: "Luna"
    LunaNavBar: ->
      React.DOM.nav
        className: 'navbar navbar-default navbar-fixed-top'
        React.DOM.div
          className: 'container-fluid'
          React.DOM.div
            className: 'navbar-header'
            React.DOM.div
              id: 'mobile-menu'
              React.DOM.div
                className: 'left-nav-toggle'
                React.DOM.a
                  href: '#'
                  React.DOM.i
                    className: 'stroke-hamburgermenu'
            React.DOM.a
              className: 'navbar-brand'
              href: '/'
              'HELIA'
              React.DOM.span null, 'v.1.0'
          React.DOM.div
            className: 'navbar-collapse collapse'
            id: 'navbar'
            React.DOM.div
              className: 'left-nav-toggle'
              React.DOM.a
                href: '#'
                React.DOM.i
                  className: 'stroke-hamburgermenu'
            React.DOM.ul
              className: 'nav navbar-nav navbar-right'
              React.DOM.li
                className: 'profile-link'
                React.DOM.a
                  href: '../logout'
                  React.DOM.i
                    className: 'fa fa-sign-out'
              React.DOM.li
                className: 'profile-link'
                React.DOM.a
                  href: '#'
                  React.DOM.span
                    className: 'profile-address'
                    @props.user.name
                  React.DOM.img
                    className: 'img-circle'
                    src: @props.station.logo.url
    render: ->
      if @state.skin == 'Luna'
        @LunaNavBar()
