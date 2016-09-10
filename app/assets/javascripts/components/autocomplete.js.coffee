@AutoComplete = React.createClass
    getInitialState: ->
      type: 0
    trigger: (e) ->
      e.preventDefault()
      @props.trigger @props.record
    autoCompleteMedicineSupplier: ->
      React.DOM.p
        onClick: @trigger
        @props.text
    render: ->
      @autoCompleteMedicineSupplier()