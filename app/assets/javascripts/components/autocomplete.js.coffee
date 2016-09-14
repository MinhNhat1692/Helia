@AutoComplete = React.createClass
    getInitialState: ->
      type: 0
    trigger: (e) ->
      e.preventDefault()
      @props.trigger @props.record
    autoCompleteMedicineSupplier: ->
      React.DOM.div
        onClick: @trigger
        @props.text
    render: ->
      @autoCompleteMedicineSupplier()