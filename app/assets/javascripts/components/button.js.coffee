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
    trigger2: (record,data) ->
      @props.trigger2 record, data
    triggerClickedCode: ->
      @props.Clicked @props.code
    buttonNormal: ->
      React.DOM.button className: @props.className, type: 'button', onClick: @props.Clicked,
        React.DOM.i className: @props.icon
        if @props.text.length > 0
          @props.text
    buttonTriggerCode: ->
      React.DOM.button className: @props.className, type: 'button', onClick: @triggerClickedCode,
        React.DOM.i className: @props.icon
        if @props.text.length > 0
          @props.text
    buttonTriggerModal: ->
      React.DOM.button className: @props.className, onClick: @triggerClickedCode, 'data-target':'#' + @props.modalid, 'data-toggle': 'modal', 'data-backdrop':'static', 'data-keyboard':'false', type: 'button',
        React.DOM.i className: @props.icon
        if @props.text.length > 0
          @props.text
    buttonTriggerModalNocode: ->
      React.DOM.button className: @props.className, 'data-target':'#' + @props.modalid, 'data-toggle': 'modal', 'data-backdrop':'static', 'data-keyboard':'false', type: 'button',
        React.DOM.i className: @props.icon
        if @props.text.length > 0
          @props.text
    render: ->
      if @state.type == 1
        @buttonNormal()
      else if @state.type == 2
        @buttonNormal()
      else if @state.type == 3
        @buttonTriggerCode()
      else if @state.type == 4
        @buttonTriggerModal()
      else if @state.type == 5
        @buttonTriggerModalNocode()