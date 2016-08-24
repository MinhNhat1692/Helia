@MainApp = React.createClass
    getInitialState: ->
      task: 1
    change: (data) ->
      @setState task: data
    componentWillMount: ->
      $(APP).on 'employee', ((e) ->
        @change(1)
      ).bind(this)
      $(APP).on 'position', ((e) ->
        @change(2)
      ).bind(this)
    Employee: ->
      React.createElement Records, records: @props.data 
    Position: ->
      React.createElement PositionRecords, records: @props.data
    render: ->
      if @state.task == 1
        @Employee()
      else if @state.task == 2
        @Position()
      