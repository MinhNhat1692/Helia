@Header = React.createClass
    getInitialState: ->
      station: @props.station
      headerClassName: 'clearfix'
    toggleSearchBar: ->
      if @state.headerClassName == 'clearfix'
        @setState headerClassName: 'clearfix search-toggled'
      else
        @setState headerClassName: 'clearfix'
    NormalRender: ->
      React.DOM.header
        id: 'header'
        className: @state.headerClassName
        React.DOM.ul
          className: 'h-inner'
          React.DOM.li
            className: 'hi-trigger ma-trigger'
            React.DOM.div
              className: "line-wrap"
              React.DOM.div
                className: "line top"
              React.DOM.div
                className: "line center"
              React.DOM.div
                className: "line bottom"
          React.DOM.li
            className: "hi-logo hidden-xs"
            React.DOM.a
              href: ''
              "Helia"
          React.DOM.li
            className: "pull-right right-menu"
            React.DOM.ul
              className: "hi-menu"
              React.DOM.li null,
                React.DOM.a
                  onClick: @toggleSearchBar
                  React.DOM.i
                    className: "him-icon zmdi zmdi-search"
              React.DOM.li
                className: "dropdown"
                React.DOM.a
                  href: ""
                  React.DOM.span
                    className: "him-label"
                    "Account"
        React.DOM.div
          className: "h-search-wrap"
          React.DOM.div
            className: "hsw-inner"
            React.DOM.i
              className: "hsw-close zmdi zmdi-arrow-left"
              onClick: @toggleSearchBar
            React.DOM.input
              type: "text"
    render: ->
      @NormalRender()