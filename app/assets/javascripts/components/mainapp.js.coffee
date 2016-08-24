@MainApp = React.createClass
    getInitialState: ->
      task: 2
    change: (data) ->
      @setState task: data
    componentWillMount: ->
      $(APP).on 'employee', ((e) ->
        @change(1)
      ).bind(this)
    componentWillUnmount: ->
      $(APP).off 'employee'
    Employee: ->
      React.createElement Records, records: @props.data 
    render: ->
      if @state.task == 1
        @Employee()
      else
        null
      