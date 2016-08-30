@ButtonGeneral = React.createClass
    getInitialState: ->
      className: @props.className
      text: @props.text
      icon: @props.icon
      type: @props.type
    buttonNormal: ->
      React.DOM.button
        className: @props.className
        style: {'marginRight': '5px', 'borderRadius' : '0px'}
        type: 'button'
        onClick: @props.Clicked
        React.DOM.i
          className: @props.icon
        if @state.text.length > 0
          React.DOM.span
            className: 'bold'
            @state.text
    render: ->
      if @state.type == 1
        @buttonNormal()