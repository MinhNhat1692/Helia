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
    buttonSideBar: ->
        if @props.selected
            React.DOM.div className: 'sidemenu-button active', style: {"cursor":"pointer"}, onClick: @triggerClickedCode,
                React.DOM.span null,
                    React.DOM.i className: @props.icon
                    React.DOM.p null, @props.text
        else
            React.DOM.div className: 'sidemenu-button', style: {"cursor":"pointer"}, onClick: @triggerClickedCode,
                React.DOM.span null,
                    React.DOM.i className: @props.icon
                    React.DOM.p null, @props.text
    render: ->
        switch @props.type
            when 1
                @buttonNormal()
            when 2
                @buttonNormal()
            when 3
                @buttonTriggerCode()
            when 4
                @buttonTriggerModal()
            when 5
                @buttonTriggerModalNocode()
            when 6
                @buttonSideBar()