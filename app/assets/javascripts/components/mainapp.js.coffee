@MainApp = React.createClass
    Support: ->
      React.createElement Support, data: @props.data
    Employee: ->
      React.createElement MainPart, data: @props.data, datatype: 'employee' 
    Position: ->
      React.createElement MainPart, data: @props.data, datatype: 'position'
    Room: ->
      React.createElement MainPart, data: @props.data, datatype: 'room'
    AppViewEmployee: ->
      React.createElement AppViewsEmployees, data: @props.data
    Service: ->
      React.createElement MainPart, data: @props.data, datatype: 'service'
    ServiceMap: ->
      React.createElement AppViewsServices, data: @props.data
    PatientGeneral: ->
      React.createElement PatientGeneral, data: @props.data #31
    OrderMap: ->
      React.createElement OrderMap, data: @props.data #32
    CheckInfo: ->
      React.createElement CheckInfo, data: @props.data #33
    DoctorCheckInfo: ->
      React.createElement DoctorCheckInfo, data: @props.data #34
    BillInfo: ->
      React.createElement BillInfo, data: @props.data #35
    MedicineSupplier: ->
      React.createElement MedicineSupplier, data: @props.data #task = code = 41
    MedicineCompany: ->
      React.createElement MedicineCompany, data: @props.data #task = code = 42
    MedicineSample: ->
      React.createElement MedicineSample, data: @props.data #task = code = 43
    MedicineBillIn: ->
      React.createElement MedicineBillIn, data: @props.data #task = code = 44
    MedicineBillRecord: ->
      React.createElement MedicineBillRecord, data: @props.data #task = code = 45
    MedicinePrice: ->
      React.createElement MedicinePrice, data: @props.data #task = code = 46
    MedicinePrescriptExternal: ->
      React.createElement MedicinePrescriptExternal, data: @props.data #task = code = 47
    MedicineExternalRecord: ->
      React.createElement MedicineExternalRecord, data: @props.data #task = code = 48
    MedicinePrescriptInternal: ->
      React.createElement MedicinePrescriptInternal, data: @props.data #task = code = 49
    MedicineInternalRecord: ->
      React.createElement MedicineInternalRecord, data: @props.data #task = code = 50
    MedicineStockRecord: ->
      React.createElement MedicineStockRecord, data: @props.data #task = code = 51
    render: ->
      switch @props.task
        when 5
          @Support()
        when 11
          @Employee()
        when 13
          @Position()
        when 12
          @Room()
        when 21
          @AppViewEmployee()
        when 14
          @Service()
        when 22
          @ServiceMap()
        when 31
          @PatientGeneral()
        when 32
          @OrderMap()
        when 33
          @CheckInfo()
        when 34
          @DoctorCheckInfo()
        when 35
          @BillInfo()
        when 41
          @MedicineSupplier()
        when 42
          @MedicineCompany()
        when 43
          @MedicineSample()
        when 44
          @MedicineBillIn()
        when 45
          @MedicineBillRecord()
        when 46
          @MedicinePrice()
        when 47
          @MedicinePrescriptExternal()
        when 48
          @MedicineExternalRecord()
        when 49
          @MedicinePrescriptInternal()
        when 50
          @MedicineInternalRecord()
        when 51
          @MedicineStockRecord()