@MainApp = React.createClass
    Support: ->
      React.createElement Support, data: @props.data
    Employee: ->
      React.createElement MainPart, data: @props.data, datatype: 'employee' 
    Position: ->
      React.createElement MainPart, data: @props.data, datatype: 'position'
    Room: ->
      React.createElement MainPart, data: @props.data, datatype: 'room'
    Service: ->
      React.createElement MainPart, data: @props.data, datatype: 'service'
    PosMap: ->
      React.createElement MainPart, data: @props.data, datatype: 'posmap'
    SerMap: ->
      React.createElement MainPart, data: @props.data, datatype: 'sermap'
    CustomerRecord: ->
      React.createElement MainPart, data: @props.data, datatype: 'customer_record' #31
    OrderMap: ->
      React.createElement MainPart, data: @props.data, datatype: 'order_map' #32
    CheckInfo: ->
      React.createElement MainPart, data: @props.data, datatype: 'check_info'
    DoctorCheckInfo: ->
      React.createElement MainPart, data: @props.data, datatype: 'doctor_check_info'
    BillInfo: ->
      React.createElement MainPart, data: @props.data, datatype: 'bill_info'
    MedicineSupplier: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_supplier' #task = code = 41
    MedicineCompany: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_company' #task = code = 42
    MedicineSample: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_sample' #task = code = 43
    MedicineBillIn: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_bill_in' #task = code = 44
    MedicineBillRecord: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_bill_record' #task = code = 45
    MedicinePrice: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_price' #task = code = 46
    MedicinePrescriptExternal: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_prescript_external' #task = code = 47
    MedicineExternalRecord: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_external_record' #task = code = 48
    MedicinePrescriptInternal: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_prescript_internal' #task = code = 49
    MedicineInternalRecord: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_internal_record' #task = code = 50
    MedicineStockRecord: ->
      React.createElement MainPart, data: @props.data, datatype: 'medicine_stock_record' #task = code = 51
    RoomManager: ->
      React.createElement RoomManager, data: @props.data #task = code = 60
    DoctorRoom: ->
      React.createElement MainPart, data: @props.data, datatype: 'doctor_room' #task = code = 63
    render: ->
      switch @props.task
        when 5
          @Support()
        when 11
          @Employee()
        when 12
          @Room()
        when 13
          @Position()
        when 14
          @Service()
        when 15
          @PosMap()
        when 16
          @SerMap()
        when 21
          @AppViewEmployee()
        when 22
          @ServiceMap()
        when 31
          @CustomerRecord()
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
        when 60
          @RoomManager()
        when 61
          @RoomManager()
        when 62
          @RoomManager()
        when 63
          @DoctorRoom()
            