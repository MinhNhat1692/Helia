@Records = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      classSideBar: 'sidebar'
      existed: false
      searchRecord: null
      userlink: null
    changeSearchRecord: (data) ->
      @state.userlink = data[2]
      if data[1] != null
        index = -1
        for record in @state.records
          if data[1].id == record.id
            index = @state.records.indexOf record
            break
        if index < 0
          @addRecord(data[1])
          @selectRecord(data[1])
        else
          @selectRecord(data[1])
        @setState existed: true
      else
        @setState existed: false
      @setState searchRecord: data[0]   
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    addRecordAlt: ->
      if @state.searchRecord != null
        formData = new FormData
        formData.append 'id', @state.searchRecord.user_id
        $.ajax
          url: '/employee/add_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @addRecord(result)
            return
          ).bind(this)
    updateRecordAlt: ->
      if @state.searchRecord != null && @state.record != null
        formData = new FormData
        formData.append 'id', @state.searchRecord.user_id
        formData.append 'idrecord', @state.record.id
        $.ajax
          url: '/employee/update_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @updateRecord(@state.record,result)
            @setState record: result
            return
          ).bind(this)
    linkRecordAlt: ->
      if @state.searchRecord != null && @state.record != null
        formData = new FormData
        formData.append 'id', @state.searchRecord.user_id
        formData.append 'idrecord', @state.record.id
        $.ajax
          url: '/employee/link_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @updateRecord(@state.record,result)
            @setState record: result
            return
          ).bind(this)
    ClearlinkRecordAlt: ->
      if @state.record != null
        formData = new FormData
        formData.append 'idrecord', @state.record.id
        $.ajax
          url: '/employee/clear_link_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @updateRecord(@state.record,result)
            @setState record: result
            return
          ).bind(this)
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/employee"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Nhân viên'
        React.createElement AsideMenu, style: 2, record: @state.searchRecord, gender: @props.data[1], className: @state.classSideBar, existed: @state.existed, userlink: @state.userlink, handleSearch: @changeSearchRecord, addListener: @addRecordAlt, linkListener: @linkRecordAlt, updateListener: @updateRecordAlt
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-link', text: ' Liên kết', type: 1, Clicked: @toggleSideBar
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'employee'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'employee_edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-flash-off', text: ' Bỏ liên kết', type: 1, Clicked: @ClearlinkRecordAlt
            React.DOM.br null
            React.DOM.br null
            React.createElement RecordForm, handleEmployeeRecord: @addRecord
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Name'
                  React.DOM.th null, 'Address'
                  React.DOM.th null, 'Phone Number'
                  React.DOM.th null, 'Ma NV'
                  React.DOM.th null, 'Gioi tinh'
                  React.DOM.th null, 'Anh'
              React.DOM.tbody null,
                for record in @state.records
                  if @state.selected != null
                    if record.id == @state.selected
                      React.createElement Record, key: record.id, gender: @props.data[1], record: record, selected: true, selectRecord: @selectRecord
                    else
                      React.createElement Record, key: record.id, gender: @props.data[1], record: record, selected: false, selectRecord: @selectRecord
                  else
                    React.createElement Record, key: record.id, gender: @props.data[1], record: record, selected: false, selectRecord: @selectRecord


@Rooms = React.createClass
    getInitialState: ->
      records: @props.records
      selected: null
      record: null
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/rooms"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Phòng'
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'room_add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'room_edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement RoomForm, handleRoomAdd: @addRecord
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên phòng'
                  React.DOM.th null, 'Ngôn ngữ'
                  React.DOM.th null, 'Bản đồ'
              React.DOM.tbody null,
                for record in @state.records
                  if @state.selected != null
                    if record.id == @state.selected
                      React.createElement Room, key: record.id, record: record, selected: true, selectRecord: @selectRecord
                    else
                      React.createElement Room, key: record.id, record: record, selected: false, selectRecord: @selectRecord
                  else
                    React.createElement Room, key: record.id, record: record, selected: false, selectRecord: @selectRecord      


@Services = React.createClass
    getInitialState: ->
      records: @props.records
      selected: null
      record: null
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/services"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Dịch vụ'
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'service_add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'service_edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement ServiceForm, handleServiceAdd: @addRecord
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên dịch vụ'
                  React.DOM.th null, 'Ngôn ngữ'
                  React.DOM.th null, 'Giá'
                  React.DOM.th null, 'Đơn vị tiền'
                  React.DOM.th null, 'Mô tả dịch vụ'
                  React.DOM.th null, 'Logo dịch vụ'
              React.DOM.tbody null,
                for record in @state.records
                  if @state.selected != null
                    if record.id == @state.selected
                      React.createElement Service, key: record.id, record: record, selected: true, selectRecord: @selectRecord
                    else
                      React.createElement Service, key: record.id, record: record, selected: false, selectRecord: @selectRecord
                  else
                    React.createElement Service, key: record.id, record: record, selected: false, selectRecord: @selectRecord
      
      
@Positions = React.createClass
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
      selected: null
      record: null
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/positions"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Chức vụ'
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'position_add', extra: @state.rooms
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'position_edit', extra: @state.rooms, record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement PositionForm, rooms: @state.rooms, handlePositionAdd: @addRecord
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên phòng'
                  React.DOM.th null, 'Tên vị trí'
                  React.DOM.th null, 'Ngôn ngữ'
                  React.DOM.th null, 'Miêu tả ngắn'
                  React.DOM.th null, 'File đính kèm'
              React.DOM.tbody null,
                for record in @state.records
                  if @state.selected != null
                    if record.id == @state.selected
                      React.createElement Position, key: record.id, record: record, rooms: @state.rooms, selected: true, selectRecord: @selectRecord
                    else
                      React.createElement Position, key: record.id, record: record, rooms: @state.rooms, selected: false, selectRecord: @selectRecord
                  else
                    React.createElement Position, key: record.id, record: record, rooms: @state.rooms, selected: false, selectRecord: @selectRecord


@AppViewsEmployees = React.createClass
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
      positions: @props.data[2]
      positionmap: @props.data[3]
      station: @props.data[4]
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    updateMap: (data) ->
      check = true
      for map in @state.positionmap
        if map.id == data.id
          index = @state.positionmap.indexOf map
          listposmap = React.addons.update(@state.positionmap, { $splice: [[index, 1, data]] })
          @setState positionmap: listposmap
          check = false
          break
      if check
        listposmap = React.addons.update(@state.positionmap, { $push: [data] })
        @setState positionmap: listposmap
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: "text-center"
          React.DOM.h2
            className: "f-400"
            "DANH SÁCH NHÂN VIÊN"
          React.DOM.p
            className: "c-gray m-t-20 m-b-20"
            "Click vào thông tin chức vụ của nhân viên để định chức vụ cho từng nhân viên. Tùy vào chức vụ được phân công mà nhân viên sẽ có quyền truy cập thông tin của từng dịch vụ khác nhau"
        React.DOM.div
          className: "row m-t-25 card"
          React.DOM.div
            className: "card-body card-padding"
            for record in @state.records
              React.createElement AppViewsEmployee, key: record.id, record: record, rooms: @state.rooms, positions: @state.positions, positionmap: @state.positionmap, station: @state.station, ownerMode: true, className: "col-md-2 col-sm-4 col-xs-6", handleEditAppMap: @updateRecord, handleEditPosMap: @updateMap
          

@AppViewsServices = React.createClass
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
      servicemap: @props.data[2]
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    updateMap: (data) ->
      check = true
      for map in @state.servicemap
        if map.id == data.id
          index = @state.servicemap.indexOf map
          listsermap = React.addons.update(@state.servicemap, { $splice: [[index, 1, data]] })
          @setState servicemap: listsermap
          check = false
          break
      if check
        listsermap = React.addons.update(@state.servicemap, { $push: [data] })
        @setState servicemap: listsermap
    render: ->
      React.DOM.div
        className: 'container container-alt'
        React.DOM.div
          className: "text-center"
          React.DOM.h2
            className: "f-400"
            "DANH SÁCH DỊCH VỤ"
          React.DOM.p
            className: "c-gray m-t-20 m-b-20"
            "Click vào thông tin phòng để định phòng cho từng dịch vụ"
        React.DOM.div
          className: "row m-t-25"
          for record in @state.records
            React.createElement AppViewsService, key: record.id, record: record, rooms: @state.rooms, ownerMode: true, className: "col-sm-4", servicemap: @state.servicemap, handleEditSerMap: @updateMap, handleEditSer: @updateRecord


@PatientGeneral = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      classSideBar: 'sidebar'
      existed: false
      searchRecord: null
      userlink: null
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    deleteRecord: (e) ->
      if @state.record != null
        e.preventDefault()
        formData = new FormData
        formData.append 'id', @state.record.id
        $.ajax
          url: '/customer_record'
          type: 'DELETE'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            index = @state.records.indexOf @state.record
            records = React.addons.update(@state.records, { $splice: [[index, 1]] })
            @setState records: records
            return
          ).bind(this)
    addRecord: (record) ->
      records = React.addons.update([record], { $push: @state.records })
      @setState records: records
    trigger: ->
      console.log(6)
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    changeSearchRecord: (data) ->
      @state.userlink = data[2]
      if data[1] != null
        index = -1
        for record in @state.records
          if data[1].id == record.id
            index = @state.records.indexOf record
            break
        if index < 0
          @addRecord(data[1])
          @SelectHandle(data[1])
        else
          @SelectHandle(data[1])
        @setState existed: true
      else
        @setState existed: false
      @setState searchRecord: data[0]   
    SelectHandle: (record) ->
      @setState
        record: record
        selected: record.id
    addRecordAlt: ->
      if @state.searchRecord != null
        formData = new FormData
        formData.append 'id', @state.searchRecord.user_id
        $.ajax
          url: '/customer_record/add_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @addRecord(result)
            return
          ).bind(this)
    updateRecordAlt: ->
      if @state.searchRecord != null && @state.record != null
        formData = new FormData
        formData.append 'id', @state.searchRecord.user_id
        formData.append 'idrecord', @state.record.id
        $.ajax
          url: '/customer_record/update_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            return
          ).bind(this)
    linkRecordAlt: ->
      if @state.searchRecord != null && @state.record != null
        formData = new FormData
        formData.append 'id', @state.searchRecord.user_id
        formData.append 'idrecord', @state.record.id
        $.ajax
          url: '/customer_record/link_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            return
          ).bind(this)
    ClearlinkRecordAlt: ->
      if @state.record != null
        formData = new FormData
        formData.append 'idrecord', @state.record.id
        $.ajax
          url: '/customer_record/clear_link_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            return
          ).bind(this)
    RecordsRender: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Danh sách bệnh nhân'
        React.createElement AsideMenu, key: 'Aside', style: 1, record: @state.searchRecord, gender: @props.data[1], className: @state.classSideBar, existed: @state.existed, userlink: @state.userlink, handleCustomerSearch: @changeSearchRecord, addListener: @addRecordAlt, linkListener: @linkRecordAlt, updateListener: @updateRecordAlt
        React.DOM.div
          className: 'card col-md-9'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-exchange', text: ' Toggle Sidebar', type: 1, Clicked: @toggleSideBar
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Add Record', type: 2, trigger: @addRecord, datatype: 'customer_record'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o', text: ' Edit', type: 2, trigger2: @updateRecord, datatype: 'customer_edit_record', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Delete', type: 1, Clicked: @deleteRecord
            React.DOM.br null
            React.DOM.br null
            React.createElement PatientForm, handleOnchange: @checkrecord, handleRecordAdd: @addRecord
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Họ và tên'
                  React.DOM.th null, 'Ngày sinh'
                  React.DOM.th null, 'Tuổi'
                  React.DOM.th null, 'Giới tính'
                  React.DOM.th null, 'Địa chỉ'
                  React.DOM.th null, 'Số điện thoại'
                  React.DOM.th null, 'CMTND'
                  React.DOM.th null, 'Ngày cấp'
                  React.DOM.th null, 'Nơi cấp'
                  React.DOM.th null, 'Ảnh đại diện'
                  React.DOM.th null, 'created_at'
                  React.DOM.th null, 'updated_at'
              React.DOM.tbody null,
                for record in @state.records
                  if @state.selected != null
                    if record.id == @state.selected
                      React.createElement PatientRecord, key: record.id, gender: @props.data[1], select: true, record: record, TriggerSelect: @SelectHandle
                    else
                      React.createElement PatientRecord, key: record.id, gender: @props.data[1], select: false, record: record, TriggerSelect: @SelectHandle
                  else
                    React.createElement PatientRecord, key: record.id, gender: @props.data[1], select: false, record: record, TriggerSelect: @SelectHandle
        React.DOM.div
          className: 'col-md-3'
          if @state.record != null
            React.createElement PatientProfile, gender: @props.data[1], record: @state.record, style: 'normal', clearLinkListener: @ClearlinkRecordAlt
    render: ->
      @RecordsRender()


@MedicineSupplier = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      autoComplete: null
      filteredRecord: null
    changeSearchRecord: (data) ->
      @state.userlink = data[2]
      if data[1] != null
        index = -1
        for record in @state.records
          if data[1].id == record.id
            index = @state.records.indexOf record
            break
        if index < 0
          @addRecord(data[1])
          @selectRecord(data[1])
        else
          @selectRecord(data[1])
        @setState existed: true
      else
        @setState existed: false
      @setState searchRecord: data[0]   
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState
        records: records
        record: null
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/medicine_supplier"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    trigger: (e) ->
      console.log(1)
    triggerInput: (text,type,check1) ->
      if type != '' && text.length > 1
        if !check1.option1
          filtered = []
          for record in @state.records
            if @checkContain(type,text,record)
              filtered.push record
              @setState filteredRecord: filtered
        else
          formData = new FormData
          switch Number(type)
            when 1
              formData.append 'noid', text.toLowerCase()
            when 2
              formData.append 'name', text.toLowerCase()
            when 3
              formData.append 'contactname', text.toLowerCase()
            when 4
              formData.append 'spnumber', text.toLowerCase()
            when 5
              formData.append 'pnumber', text.toLowerCase()
            when 6
              formData.append 'address1', text.toLowerCase()
            when 7
              formData.append 'address2', text.toLowerCase()
            when 8
              formData.append 'address3', text.toLowerCase()
            when 9
              formData.append 'email', text.toLowerCase()
            when 10
              formData.append 'facebook', text.toLowerCase()
            when 11
              formData.append 'twitter', text.toLowerCase()
            when 12
              formData.append 'fax', text.toLowerCase()
            when 13
              formData.append 'taxcode', text.toLowerCase()
          $.ajax
            url: '/medicine_supplier/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
    checkContain: (type,text,record) ->
      switch Number(type)
        when 1
          if record.noid.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 2
          if record.name.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 3
          if record.contactname.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 4
          if record.spnumber.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 5
          if record.pnumber.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 6
          if record.address1.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 7
          if record.address2.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 8
          if record.address3.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 9
          if record.email.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 10
          if record.facebook.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 11
          if record.twitter.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 12
          if record.fax.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 13
          if record.taxcode.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
    triggerSubmit: (result) ->
      @setState
        autoComplete: null
        filteredRecord: result
    triggerChose: (result) ->
      @setState
        autoComplete: null
    triggerClear: (e) ->
      @setState
        autoComplete: null
        filteredRecord: null
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Nguồn cấp thuốc'
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'medicine_supplier_add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'medicine_supplier_edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: 'medicine_supplier', autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã'
                  React.DOM.th null, 'Tên nguồn'
                  React.DOM.th null, 'Người liên lạc'
                  React.DOM.th null, 'Số ĐT cố định'
                  React.DOM.th null, 'Số ĐT di động'
                  React.DOM.th null, 'Địa chỉ 1'
                  React.DOM.th null, 'Địa chỉ 2'
                  React.DOM.th null, 'Địa chỉ 3'
                  React.DOM.th null, 'Email'
                  React.DOM.th null, 'Link Facebook'
                  React.DOM.th null, 'Twitter'
                  React.DOM.th null, 'Số fax'
                  React.DOM.th null, 'Mã số thuế'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_supplier", selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_supplier", selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_supplier", selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_supplier", selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_supplier", selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_supplier", selected: false, selectRecord: @selectRecord

@MedicineCompany = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      autoComplete: null
      filteredRecord: null
    changeSearchRecord: (data) ->
      @state.userlink = data[2]
      if data[1] != null
        index = -1
        for record in @state.records
          if data[1].id == record.id
            index = @state.records.indexOf record
            break
        if index < 0
          @addRecord(data[1])
          @selectRecord(data[1])
        else
          @selectRecord(data[1])
        @setState existed: true
      else
        @setState existed: false
      @setState searchRecord: data[0]   
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState
        records: records
        record: null
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/medicine_company"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    trigger: (e) ->
      console.log(1)
    triggerInput: (text,type,check1) ->
      if type != '' && text.length > 1
        if !check1.option1
          filtered = []
          for record in @state.records
            if @checkContain(type,text,record)
              filtered.push record
              @setState filteredRecord: filtered
        else
          formData = new FormData
          switch Number(type)
            when 1
              formData.append 'noid', text.toLowerCase()
            when 2
              formData.append 'name', text.toLowerCase()
            when 3
              formData.append 'pnumber', text.toLowerCase()
            when 4
              formData.append 'address', text.toLowerCase()
            when 5
              formData.append 'email', text.toLowerCase()
            when 6
              formData.append 'website', text.toLowerCase()
            when 7
              formData.append 'taxcode', text.toLowerCase()
          $.ajax
            url: '/medicine_company/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
    checkContain: (type,text,record) ->
      switch Number(type)
        when 1
          if record.noid.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 2
          if record.name.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 3
          if record.pnumber.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 4
          if record.address.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 5
          if record.email.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 6
          if record.website.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 7
          if record.taxcode.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
    triggerSubmit: (result) ->
      @setState
        autoComplete: null
        filteredRecord: result
    triggerChose: (result) ->
      @setState
        autoComplete: null
    triggerClear: (e) ->
      @setState
        autoComplete: null
        filteredRecord: null
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Doanh nghiệp sản xuất'
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'medicine_company_add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'medicine_company_edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: 'medicine_company', autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã'
                  React.DOM.th null, 'Tên Doanh Nghiệp'
                  React.DOM.th null, 'Số ĐT'
                  React.DOM.th null, 'Địa chỉ'
                  React.DOM.th null, 'Email'
                  React.DOM.th null, 'Website'
                  React.DOM.th null, 'Mã số thuế'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_company", selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_company", selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_company", selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_company", selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_company", selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_company", selected: false, selectRecord: @selectRecord
                      
@MedicineSample = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      autoComplete: null
      filteredRecord: null
    changeSearchRecord: (data) ->
      @state.userlink = data[2]
      if data[1] != null
        index = -1
        for record in @state.records
          if data[1].id == record.id
            index = @state.records.indexOf record
            break
        if index < 0
          @addRecord(data[1])
          @selectRecord(data[1])
        else
          @selectRecord(data[1])
        @setState existed: true
      else
        @setState existed: false
      @setState searchRecord: data[0]   
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState
        records: records
        record: null
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/medicine_sample"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    trigger: (e) ->
      console.log(1)
    triggerInput: (text,type,check1) ->
      if type != '' && text.length > 1
        if !check1.option1
          filtered = []
          for record in @state.records
            if @checkContain(type,text,record)
              filtered.push record
              @setState filteredRecord: filtered
        else
          formData = new FormData
          switch Number(type)
            when 1
              formData.append 'noid', text.toLowerCase()
            when 2
              formData.append 'name', text.toLowerCase()
            when 3
              formData.append 'typemedicine', text.toLowerCase()
            when 4
              formData.append 'groupmedicine', text.toLowerCase()
            when 5
              formData.append 'company', text.toLowerCase()
            when 6
              formData.append 'price', text.toLowerCase()
            when 7
              formData.append 'weight', text.toLowerCase()
            when 8
              formData.append 'remark', text.toLowerCase()
            when 9
              formData.append 'expire', text.toLowerCase()
          $.ajax
            url: '/medicine_sample/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
    checkContain: (type,text,record) ->
      switch Number(type)
        when 1
          if record.noid.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 2
          if record.name.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 3
          if record.typemedicine.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 4
          if record.groupmedicine.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 5
          if record.company.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 6
          if record.price.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 7
          if record.weight.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 8
          if record.remark.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 9
          if record.expire.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
    triggerSubmit: (result) ->
      @setState
        autoComplete: null
        filteredRecord: result
    triggerChose: (result) ->
      @setState
        autoComplete: null
    triggerClear: (e) ->
      @setState
        autoComplete: null
        filteredRecord: null
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Mẫu thuốc'
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'medicine_sample_add', extra: @props.data
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'medicine_sample_edit', record: @state.record, extra: @props.data
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm công ty sản xuất', type: 2, datatype: 'medicine_company_add'
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: 'medicine_sample', grouplist: @props.data[1], typelist: @props.data[2], autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã'
                  React.DOM.th null, 'Tên thuốc'
                  React.DOM.th null, 'Loại thuốc'
                  React.DOM.th null, 'Nhóm thuốc'
                  React.DOM.th null, 'Công ty sản xuất'
                  React.DOM.th null, 'Giá'
                  React.DOM.th null, 'Khối lượng'
                  React.DOM.th null, 'Ghi chú'
                  React.DOM.th null, 'Hạn sử dụng'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_sample", selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_sample", selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_sample", selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_sample", selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_sample", selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_sample", selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                                         
@MedicineBillIn = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      autoComplete: null
      filteredRecord: null
    changeSearchRecord: (data) ->
      @state.userlink = data[2]
      if data[1] != null
        index = -1
        for record in @state.records
          if data[1].id == record.id
            index = @state.records.indexOf record
            break
        if index < 0
          @addRecord(data[1])
          @selectRecord(data[1])
        else
          @selectRecord(data[1])
        @setState existed: true
      else
        @setState existed: false
      @setState searchRecord: data[0]   
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState
        records: records
        record: null
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/medicine_bill_in"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    trigger: (e) ->
      console.log(1)
    triggerInput: (text,type,check1) ->
      if type != '' && text.length > 1
        if !check1.option1
          filtered = []
          for record in @state.records
            if @checkContain(type,text,record)
              filtered.push record
              @setState filteredRecord: filtered
        else
          formData = new FormData
          switch Number(type)
            when 1
              formData.append 'billcode', text.toLowerCase()
            when 2
              formData.append 'supplier', text.toLowerCase()
            when 3
              formData.append 'remark', text.toLowerCase()
          $.ajax
            url: '/medicine_bill_in/search'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
              @setState autoComplete: result
              return
            ).bind(this)
    checkContain: (type,text,record) ->
      switch Number(type)
        when 1
          if record.billcode.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 2
          if record.supplier.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 3
          if record.remark.toLowerCase().search(text.toLowerCase()) > -1
            return true
          else
            return false
        when 4
          if (record.dayin.toLowerCase().substring(8, 10) + "/" + record.dayin.toLowerCase().substring(5, 7) + "/" + record.dayin.toLowerCase().substring(0, 4)) == text.toLowerCase()
            return true
          else
            return false
        when 5
          if (record.daybook.toLowerCase().substring(8, 10) + "/" + record.daybook.toLowerCase().substring(5, 7) + "/" + record.daybook.toLowerCase().substring(0, 4)) == text.toLowerCase()
            return true
          else
            return false
        when 6
          if record.pmethod == Number(text)
            return true
          else
            return false
        when 7
          if record.tpayment == Number(text)
            return true
          else
            return false
        when 8
          if record.discount == Number(text)
            return true
          else
            return false
        when 9
          if record.tpayout == Number(text)
            return true
          else
            return false
        when 10
          if record.status == Number(text)
            return true
          else
            return false
    triggerSubmit: (result) ->
      @setState
        autoComplete: null
        filteredRecord: result
    triggerChose: (result) ->
      @setState
        autoComplete: null
    triggerClear: (e) ->
      @setState
        autoComplete: null
        filteredRecord: null
    render: ->
      React.DOM.div
        className: 'container'
        React.DOM.div
          className: 'block-header'
          React.DOM.h2 null, 'Hóa đơn nhập thuốc'
        React.DOM.div
          className: 'card'
          React.DOM.div
            className: 'card-header'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: 'medicine_bill_in_add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: 'medicine_bill_in_edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm thông tin thuốc nhập kho', type: 2, datatype: 'medicine_bill_record_add', billrecord: @state.record, record: null
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: 'medicine_bill_in', autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div
            className: 'card-body table-responsive'
            React.DOM.table
              className: 'table table-hover table-condensed'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Số hóa đơn'
                  React.DOM.th null, 'Ngày nhập'
                  React.DOM.th null, 'Người cung cấp'
                  React.DOM.th null, 'Ngày đặt hàng'
                  React.DOM.th null, 'Tổng giá hàng hóa'
                  React.DOM.th null, 'Giảm giá'
                  React.DOM.th null, 'Tổng giá thanh toán'
                  React.DOM.th null, 'Cách thanh toán'
                  React.DOM.th null, 'Ghi chú'
                  React.DOM.th null, 'Tình trạng hóa đơn'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_bill_in", selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_bill_in", selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_bill_in", selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_bill_in", selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_bill_in", selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: "medicine_bill_in", selected: false, selectRecord: @selectRecord
