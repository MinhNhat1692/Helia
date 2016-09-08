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
      