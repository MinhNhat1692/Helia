@ButtonGeneral = React.createClass
    getInitialState: ->
      className: @props.className
      text: @props.text
      icon: @props.icon
      type: @props.type
      showModal: false
    handleToggleModal: ->
      @setState showModal: true
    handleHideModal: ->
      @setState showModal: false
    trigger: (record) ->
      @props.trigger record
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
    buttonModal: ->
      React.DOM.div
        style: {'display': 'inline-block'}
        React.DOM.button
          className: @props.className
          style: {'marginRight': '5px', 'borderRadius' : '0px'}
          type: 'button'
          onClick: @handleToggleModal
          React.DOM.i
            className: @props.icon
          if @state.text.length > 0
            React.DOM.span
              className: 'bold'
              @state.text
        if @state.showModal
          if @props.record != undefined
            React.createElement Modal, trigger: @trigger, type: @props.datatype, record: @props.record, handleHideModal: @handleHideModal
          else
            React.createElement Modal, trigger: @trigger, type: @props.datatype, handleHideModal: @handleHideModal
        else
          null
    render: ->
      if @state.type == 1
        @buttonNormal()
      else if @state.type == 2
        @buttonModal()