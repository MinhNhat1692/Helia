@SelectBox = React.createClass
    getInitialState: ->
      id: @props.id
      text: @props.text
      records: @props.records
      type: @props.type
    getDefaultProps: ->
      records: []
      type: 1
    roomListSelectBox: ->
      React.DOM.select
        className: 'form-control'
        id: @state.id
        React.DOM.option
          value: ""
          @state.text
        for record in @state.records
          React.createElement OptionSelect, value: record.id, text: record.name
    render: ->
      if @state.type == 1
        @roomListSelectBox()
        
@OptionSelect = React.createClass
    getInitialState: ->
        value: @props.value
        text: @props.text
    renderOption: ->
        React.DOM.option
            value: @state.value
            @state.text
    render: ->
        @renderOption()