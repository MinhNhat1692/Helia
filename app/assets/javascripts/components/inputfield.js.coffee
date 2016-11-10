#Input field
#input id, type, className, placeholder, defaultValue, step - for number
# out put:
# trigger: onChange
# trigger2: onBlur
# trigger3: onFocus
@InputField = React.createClass
    getInitialState: ->
      type: 1
    trigger: (e) ->
      @props.trigger @props.code
    trigger2: (e) ->
      @props.trigger2 @props.code
    trigger3: (e) ->
      @props.trigger3 @props.code
    render: ->
      React.DOM.input id: @props.id, type: @props.type, className: @props.className, placeholder: @props.placeholder, onChange: @trigger, onBlur: @trigger2, onFocus: @trigger3, defaultValue: @props.defaultValue, step: @props.step, min: @props.min
    
#IconClick
#input code, className
#output triggerClick
@IconClick = React.createClass
    getInitialState: ->
      type: 1
    triggerClick: (e) ->
      @props.triggerClick @props.code
    render: ->
      React.DOM.i className: @props.className, style: {'cursor':'pointer'}, onClick: @triggerClick
