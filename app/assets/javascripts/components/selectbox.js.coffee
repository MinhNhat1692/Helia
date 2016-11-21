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
      React.DOM.select className: 'form-control', id: @state.id,
        React.DOM.option
          defaultValue:
            if @props.defaultValue != null
              @props.defaultValue
            else
              ""
          @state.text
        for record in @state.records
          React.createElement OptionSelect, key: record.id, value: record.id, text: record.name
    roomListSelectBox2: ->
      React.DOM.select className: 'form-control', id: @state.id, onBlur: @props.blurOut,
        React.DOM.option
          defaultValue: ""
          @state.text
        for record in @state.records
          React.createElement OptionSelect, key: record.id, value: record.id, text: record.name
    positionListSelectBox: ->
      React.DOM.select className: 'form-control', id: @state.id, onBlur: @props.blurOut,
        React.DOM.option
          defaultValue: ""
          @state.text
        for record in @state.records
          React.createElement OptionSelect, key: record.id, value: record.id, text: record.pname
    selectBoxGeneral: ->
      React.DOM.select className: @props.className, id: @props.id, onChange: @props.Change, onBlur: @props.blurOut,
        React.DOM.option
          defaultValue: ""
          @state.text
        for record in @props.records
          React.createElement OptionSelect, key: record.id, value: record.id, text: record.name
    render: ->
      if @state.type == 1
        @roomListSelectBox()
      else if @state.type == 2
        @positionListSelectBox()
      else if @state.type == 3
        @roomListSelectBox2()
      else if @state.type == 4
        @selectBoxGeneral()
        
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