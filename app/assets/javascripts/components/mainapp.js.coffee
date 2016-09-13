@MainApp = React.createClass
    Employee: ->
      React.createElement Records, data: @props.data 
    Position: ->
      React.createElement Positions, data: @props.data
    Room: ->
      React.createElement Rooms, records: @props.data
    AppViewEmployee: ->
      React.createElement AppViewsEmployees, data: @props.data
    Service: ->
      React.createElement Services, records: @props.data
    ServiceMap: ->
      React.createElement AppViewsServices, data: @props.data
    PatientGeneral: ->
      React.createElement PatientGeneral, data: @props.data
    MedicineSupplier: ->
      React.createElement MedicineSupplier, data: @props.data #task = code = 41
    MedicineCompany: ->
      React.createElement MedicineCompany, data: @props.data #task = code = 42
    render: ->
      if @props.task == 1
        @Employee()
      else if @props.task == 2
        @Position()
      else if @props.task == 3
        @Room()
      else if @props.task == 4
        @AppViewEmployee()
      else if @props.task == 5
        @Service()
      else if @props.task == 6
        @ServiceMap()
      else if @props.task == 7
        @PatientGeneral()
      else if @props.task == 41
        @MedicineSupplier()
      else if @props.task == 42
        @MedicineCompany()