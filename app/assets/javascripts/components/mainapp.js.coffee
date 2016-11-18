@MainApp = React.createClass
    getInitialState: ->
      loading: false
      type: 1
      data: @props.data
      task: @props.task #11 - employee
      toggled: false
      timelong: '24h'
      DataMenu:
        name: "Dữ liệu"
        records: [
          {code: 11, icon: 'zmdi zmdi-accounts-alt', name: 'Danh sách nhân viên'}
          {code: 12, icon: 'zmdi zmdi-storage', name: 'Danh sách phòng'}
          {code: 13, icon: 'zmdi zmdi-tag', name: 'Danh sách chức vụ'}
          {code: 14, icon: 'fa fa-trophy', name: 'Danh sách dịch vụ'}
          {code: 15, icon: 'zmdi zmdi-tag-more', name: 'Định chức vụ cho nhân viên'}
          {code: 16, icon: 'fa fa-tags', name: 'Định dịch vụ cho từng phòng'}
        ]
      PatientMenu:
        name: "Bệnh nhân"
        records: [
          {code: 31, icon: 'zmdi zmdi-accounts-alt', name: 'Danh sách bệnh nhân'}
          {code: 32, icon: 'fa fa-id-card-o', name: 'Danh sách phiếu khám'}
          {code: 33, icon: 'fa fa-list-alt', name: 'Thông tin điều trị'}
          {code: 34, icon: 'fa fa-book', name: 'Thông tin khám'}
        ]
      PharmacyMenu:
        name: "Thuốc"
        records: [
          {code: 41, icon: 'fa fa-address-book', name: 'Nguồn cấp thuốc'}
          {code: 42, icon: 'fa fa-building', name: 'Doanh nghiệp sản xuất'}
          {code: 43, icon: 'fa fa-newspaper-o', name: 'Mẫu thuốc'}
          {code: 44, icon: '', name: 'Hóa đơn nhập thuốc'}
          {code: 45, icon: '', name: 'Thông tin thuốc nhập kho'}
          {code: 46, icon: '', name: 'Thông tin giá thuốc'}
          {code: 47, icon: '', name: 'Đơn thuốc ngoài'}
          {code: 48, icon: '', name: 'Thông tin thuốc kê ngoài'}
          {code: 49, icon: '', name: 'Đơn thuốc trong'}
          {code: 50, icon: '', name: 'Thông tin thuốc kê trong'}
          {code: 51, icon: '', name: 'Thống kê kho thuốc'}
        ]
      SummaryMenu:
        name: "Thống kê"
        records: [
          {code: 80, icon: 'fa fa-medkit', name: 'Thuốc'}
          {code: 81, icon: 'fa fa-building', name: 'Khám bệnh'}
          {code: 82, icon: 'fa fa-newspaper-o', name: 'Trung tâm'}
          {code: 83, icon: 'fa fa-diamond', name: 'Tổng quan'}
        ]
      DoctorMenu:  
        name: "Bác sỹ",
        records: [
          {code: 60, active: false, name: 'Thống kê ngày'}
          {code: 61, active: false, name: 'Thống kê tháng'}
          {code: 62, active: false, name: 'Thống kê năm'}
          {code: 63, active: false, name: 'Trình quản lý phòng'}
        ]
      ApiMenu:  
        name: "ApiKey",
        records: [
        ]
      TeamMenu:  
        name: "Phân quyền",
        records: [
        ]
    componentWillMount: ->
      $(APP).on 'rebuilmain', ((e) ->
        @setState
          data: @props.data
          task: @props.task
        $(APP).trigger('rebuild')
      ).bind(this)
    TriggerCode: (code) ->
      switch code
        when 11 #employee
          data =
            task: 11
            link: '/employee/list'
          @handleGetdata(data)
        when 12 #room
          data =
            task: 12
            link: '/room/list'
          @handleGetdata(data)
        when 13 #position
          data =
            task: 13
            link: '/position/list'
          @handleGetdata(data)
        when 14 #service
          data =
            task: 14
            link: '/service/list'
          @handleGetdata(data)
        when 15 #posmap
          data =
            task: 15
            link: '/posmap/list'
          @handleGetdata(data)
        when 16 #sermap
          data =
            task: 16
            link: '/sermap/list'
          @handleGetdata(data)
        when 31 #customer_record
          data =
            task: 31
            link: '/customer_record/list'
          @handleGetdata(data)
        when 32 #order_map
          data =
            task: 32
            link: '/order_map/list'
          @handleGetdata(data)
        when 33 #checkinfo
          data =
            task: 33
            link: '/check_info/list'
          @handleGetdata(data)
        when 34 #doctor_check_info
          data =
            task: 34
            link: '/doctor_check_info/list'
          @handleGetdata(data)
        when 41 #medicine_supplier
          data =
            task: 41
            link: '/medicine_supplier/list'
          @handleGetdata(data)
        when 42 #medicine_company
          data =
            task: 42
            link: '/medicine_company/list'
          @handleGetdata(data)
        when 43 #medicine_sample
          data =
            task: 43
            link: '/medicine_sample/list'
          @handleGetdata(data)
        when 44 #medicine_bill_in
          data =
            task: 44
            link: '/medicine_bill_in/list'
          @handleGetdata(data)
        when 45 #medicine_bill_record
          data =
            task: 45
            link: '/medicine_bill_record/list'
          @handleGetdata(data)
        when 46 #medicine_price
          data =
            task: 46
            link: '/medicine_price/list'
          @handleGetdata(data)
        when 47 #medicine_prescript_external
          data =
            task: 47
            link: '/medicine_prescript_external/list'
          @handleGetdata(data)
        when 48 #medicine_external_record
          data =
            task: 48
            link: '/medicine_external_record/list'
          @handleGetdata(data)
        when 49 #medicine_prescript_internal
          data =
            task: 49
            link: '/medicine_prescript_internal/list'
          @handleGetdata(data)
        when 50 #medicine_internal_record
          data =
            task: 50
            link: '/medicine_internal_record/list'
          @handleGetdata(data)
        when 51 #medicine_stock_record
          data =
            task: 51
            link: '/medicine_stock_record/list'
          @handleGetdata(data)
        when 60
          @state.timelong = '24h'
          data =
            task: 60
            link: '/room_manager/list'
            formData: {length: 1}
          @handleGetdataAlt(data)
        when 61
          @state.timelong = '1 tháng'
          data =
            task: 61
            link: '/room_manager/list'
            formData: {length: 30}
          @handleGetdataAlt(data)
        when 62
          @state.timelong = '1 năm'
          data =
            task: 62
            link: '/room_manager/list'
            formData: {length: 365}
          @handleGetdataAlt(data)
        when 63
          data =
            task: 63
            link: '/order_map/list'
          @handleGetdata(data)
        when 80 #medicine_summary
          data =
            task: 80
            link: '/medicine_summary/all'
          @handleGetdata(data)
    handleGetdata: (data) ->
      @setState loading: true
      $.ajax
        url: data.link
        type: 'POST'
        dataType: 'JSON'
        success: ((result) ->
          @setState
            loading: false
            data: result
            task: data.task
          $(APP).trigger('rebuild')
          return
        ).bind(this)
    handleGetdataAlt: (data) ->
      @setState loading: true
      $.ajax
        url: data.link
        type: 'POST'
        data: data.formData
        dataType: 'JSON'
        success: ((result) ->
          @setState
            loading: false
            data: result
            task: data.task
          $(APP).trigger('rebuild')
          return
        ).bind(this)
    Support: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DataMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.DOM.div className: 'content-wrapper animated fadeIn', style: {'height': '50vh'},
            React.DOM.div className: 'preloader',
              React.DOM.i className: 'fa fa-cog fa-spin fa-3x'
        else
          React.createElement Support, data: @state.data
    Employee: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DataMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'employee' 
    Position: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DataMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'position'
    Room: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DataMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'room'
    Service: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DataMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'service'
    PosMap: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DataMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'posmap'
    SerMap: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DataMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'sermap'
    CustomerRecord: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PatientMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'customer_record' #31
    OrderMap: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PatientMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'order_map' #32
    CheckInfo: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PatientMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'check_info'
    DoctorCheckInfo: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PatientMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'doctor_check_info'
    MedicineSupplier: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_supplier' #task = code = 41
    MedicineCompany: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_company' #task = code = 42
    MedicineSample: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_sample' #task = code = 43
    MedicineBillIn: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_bill_in' #task = code = 44
    MedicineBillRecord: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_bill_record' #task = code = 45
    MedicinePrice: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_price' #task = code = 46
    MedicinePrescriptExternal: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_prescript_external' #task = code = 47
    MedicineExternalRecord: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_external_record' #task = code = 48
    MedicinePrescriptInternal: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_prescript_internal' #task = code = 49
    MedicineInternalRecord: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_internal_record' #task = code = 50
    MedicineStockRecord: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.PharmacyMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_stock_record' #task = code = 51
    RoomManager: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DoctorMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement RoomManager, data: @state.data, timelong: @state.timelong #task = code = 60
    DoctorRoom: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.DoctorMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'doctor_room' #task = code = 63
    ApiKey: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.ApiMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'apikey' #task = code = 101
    TeamControl: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.TeamMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'team_control' #task = code = 101
    SummaryMedicine: ->
      React.DOM.section id: 'content',
        React.createElement MainHeader, data: @state.SummaryMenu, task: @state.task, Trigger: @TriggerCode
        if @state.loading
          React.createElement MainPart, data: @state.data, datatype: 'loading' 
        else
          React.createElement MainPart, data: @state.data, datatype: 'medicine_summary' #task = code = 80
    render: ->
      switch @state.task
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
        when 80
          @SummaryMedicine()
        when 101
          @ApiKey()
        when 102
          @TeamControl()
            