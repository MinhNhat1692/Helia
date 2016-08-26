@MainApp = React.createClass
    getInitialState: ->
      data: @props.data
      task: 1
    change: (data) ->
      @setState task: data
    handleGetdata: (data) ->
      $.ajax
        url: data.link
        type: 'POST'
        dataType: 'JSON'
        success: ((result) ->
          @setState
            data: result
            task: data.task
          return
        ).bind(this)
    componentWillMount: ->
      $(APP).on 'employee', ((e) ->
        @change(1)
      ).bind(this)
      $(APP).on 'position', ((e) ->
        data =
          task: 2
          link: '/positions/list'
        @handleGetdata(data)
      ).bind(this)
      $(APP).on 'room', ((e) ->
        data =
          task: 3
          link: '/rooms/list'
        @handleGetdata(data)
      ).bind(this)
      $(APP).on 'linkep', ((e) ->
        data =
          task: 4
          link: '/position_mapping/list'
        @handleGetdata(data)
      ).bind(this)
      $(APP).on 'service', ((e) ->
        data =
          task: 5
          link: '/services/list'
        @handleGetdata(data)
      ).bind(this)
      $(APP).on 'servicemap', ((e) ->
        data =
          task: 6
          link: '/service_mapping/list'
        @handleGetdata(data)
      ).bind(this)
    Employee: ->
      React.createElement Records, records: @state.data 
    Position: ->
      React.createElement Positions, data: @state.data
    Room: ->
      React.createElement Rooms, records: @state.data 
    AppViewEmployee: ->
      React.createElement AppViewsEmployees, data: @state.data
    Service: ->
      React.createElement Services, records: @state.data
    ServiceMap: ->
      React.createElement AppViewsServices, records: @state.data
    render: ->
      if @state.task == 1
        @Employee()
      else if @state.task == 2
        @Position()
      else if @state.task == 3
        @Room()
      else if @state.task == 4
        @AppViewEmployee()
      else if @state.task == 5
        @Service()
      else if @state.task == 6
        @ServiceMap()