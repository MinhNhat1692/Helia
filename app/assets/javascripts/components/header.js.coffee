@Header = React.createClass
    getInitialState: ->
      station: @props.station
      headerClassName: 'clearfix'
      docClassName : "dropdown hidden-xs"
      accountClassName : "dropdown hidden-xs"
    toggleSearchBar: ->
      if @state.headerClassName == 'clearfix'
        @setState headerClassName: 'clearfix search-toggled'
      else
        @setState headerClassName: 'clearfix'
    toggleAside: ->
      $(APP).trigger('toggle')  
    toggleDoc: (e) ->
      if @state.docClassName == "dropdown hidden-xs"
        @setState
          docClassName: "dropdown hidden-xs open"
          accountClassName: "dropdown"
      else
        @setState
          docClassName: "dropdown hidden-xs"
          accountClassName: "dropdown"
    toggleAccount: (e) ->
      if @state.accountClassName == "dropdown"
        @setState
          accountClassName: "dropdown open"
          docClassName: "dropdown hidden-xs"
      else
        @setState
          accountClassName: "dropdown"
          docClassName: "dropdown hidden-xs"
    NormalRender: ->
      React.DOM.header id: 'header', className: @state.headerClassName,
        React.DOM.ul className: 'h-inner',
          React.DOM.li className: 'hi-trigger ma-trigger', onClick: @toggleAside,
            React.DOM.div className: "line-wrap",
              React.DOM.div className: "line top"
              React.DOM.div className: "line center"
              React.DOM.div className: "line bottom"
          React.DOM.li className: "hi-logo hidden-xs",          
            React.DOM.a href: '/station', className: 'logo',
              React.DOM.img width: '140', height: '48', src: '/assets/aligosa256x80_dark.png', alt: 'logo-dark'
          React.DOM.li className: "pull-right right-menu",
            React.DOM.ul className: "hi-menu",
              React.DOM.li null,
                React.DOM.a onClick: @toggleSearchBar,
                  React.DOM.i className: "him-icon zmdi zmdi-search",
              React.DOM.li className: @state.docClassName, onClick: @toggleDoc,
                React.DOM.a null, "Thư viện",
                  React.DOM.i className: 'fa fa-caret-down icon-fw'
                React.DOM.ul className: 'dropdown-menu',
                  React.DOM.li null,
                    React.DOM.a href: '/documentation', "Hướng dẫn"
                  React.DOM.li null,
                    React.DOM.a href: '/documentation/faq', "Câu hỏi thường gặp"
                  React.DOM.li null,
                    React.DOM.a href: '#', "Trợ giúp"
              React.DOM.li className: @state.accountClassName, onClick: @toggleAccount,
                React.DOM.a null, "Tài khoản",
                  React.DOM.i className: 'fa fa-caret-down icon-fw'
                React.DOM.ul className: 'dropdown-menu',
                  React.DOM.li null,
                    React.DOM.a href: '/settings', "Cài đặt"
                  React.DOM.li null,
                    React.DOM.a href: '/logout', "Đăng xuất"
              React.DOM.li className: 'header-sign-out',
                React.DOM.a href: '/logout',
                  React.DOM.i className: "him-icon fa fa-power-off",
        React.DOM.div className: "h-search-wrap",
          React.DOM.div className: "hsw-inner",
            React.DOM.i className: "hsw-close zmdi zmdi-arrow-left", onClick: @toggleSearchBar
            React.DOM.input type: "text"
    render: ->
      @NormalRender()
      
@Footer = React.createClass
    getInitialState: ->
      headerClassName: 'clearfix'
    NormalRender: ->
      React.DOM.footer id: 'footer', 'Copyright © 2016 Yarosa',
        React.DOM.ul className: 'f-menu',
          React.DOM.li null,
            React.DOM.a href: '', 'Home'
          React.DOM.li null,
            React.DOM.a href: '', 'Dashboard'
          React.DOM.li null,
            React.DOM.a href: '', 'Report'
          React.DOM.li null,
            React.DOM.a href: '', 'Support'
          React.DOM.li null,
            React.DOM.a href: '', 'Contact'
    render: ->
      @NormalRender()