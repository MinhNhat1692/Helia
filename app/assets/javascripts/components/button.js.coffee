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
    buttonNormal: ->
      React.DOM.button
        className: @props.className
        type: 'button'
        onClick: @props.Clicked
        React.DOM.i
          className: @props.icon
        if @state.text.length > 0
          @state.text
    buttonModal: ->
      React.DOM.div
        style: {'display': 'inline-block'}
        React.DOM.button
          className: @props.className
          type: 'button'
          onClick: @handleToggleModal
          React.DOM.i
            className: @props.icon
          if @state.text.length > 0
            @state.text
        if @state.showModal
          if @props.record != undefined
            if @props.extra != undefined
              React.createElement Modal, trigger: @trigger, trigger2: @trigger2, type: @props.datatype, prefix: @props.prefix, record: @props.record, extra: @props.extra, handleHideModal: @handleHideModal
            else
              React.createElement Modal, trigger: @trigger, trigger2: @trigger2, type: @props.datatype, prefix: @props.prefix, record: @props.record, handleHideModal: @handleHideModal
          else
            if @props.extra != undefined
              React.createElement Modal, trigger: @trigger, trigger2: @trigger2, type: @props.datatype, prefix: @props.prefix, record: null, extra: @props.extra, handleHideModal: @handleHideModal
            else
              React.createElement Modal, trigger: @trigger, trigger2: @trigger2, type: @props.datatype, prefix: @props.prefix, record: null, handleHideModal: @handleHideModal
        else
          null
    render: ->
      if @state.type == 1
        @buttonNormal()
      else if @state.type == 2
        @buttonModal()