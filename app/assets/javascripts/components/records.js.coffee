@Records = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.data[0]
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'records'
        React.DOM.h2
          className: 'title'
          'Employee'
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 2, trigger: @addRecord, datatype: 'employee'
        React.DOM.hr null
        React.createElement RecordForm, handleEmployeeRecord: @addRecord
        React.DOM.hr null
        React.DOM.div
          className: 'table-responsive'
          React.DOM.table
            className: 'table table-bordered'
            React.DOM.thead null,
              React.DOM.tr null,
                React.DOM.th null, 'Name'
                React.DOM.th null, 'Address'
                React.DOM.th null, 'Phone Number'
                React.DOM.th null, 'Ma NV'
                React.DOM.th null, 'Gioi tinh'
                React.DOM.th null, 'Anh'
                React.DOM.th null, 'Hanh dong'
            React.DOM.tbody null,
              for record in @state.records
                React.createElement Record, key: record.id, gender: @props.data[1], record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord


@Rooms = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @replaceState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @replaceState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.records
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'rooms'
        React.DOM.h2
          className: 'title'
          'Room'
        React.createElement RoomForm, handleRoomAdd: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Tên phòng'
              React.DOM.th null, 'Ngôn ngữ'
              React.DOM.th null, 'Bản đồ'
              React.DOM.th null, 'Hành động'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Room, key: record.id, record: record, handleDeleteRoom: @deleteRecord, handleEditRoom: @updateRecord
      

@Services = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.records
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'services'
        React.DOM.h2
          className: 'title'
          'Service'
        React.createElement ServiceForm, handleServiceAdd: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Tên dịch vụ'
              React.DOM.th null, 'Ngôn ngữ'
              React.DOM.th null, 'Giá'
              React.DOM.th null, 'Đơn vị tiền'
              React.DOM.th null, 'Mô tả dịch vụ'
              React.DOM.th null, 'Logo dịch vụ'
              React.DOM.th null, 'Hành động'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Service, key: record.id, record: record, handleDeleteService: @deleteRecord, handleEditService: @updateRecord

              
@Positions = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @replaceState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @replaceState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
    getDefaultProps: ->
      records: []
      rooms: []
    render: ->
      React.DOM.div
        className: 'position'
        React.DOM.h2
          className: 'title'
          'Position'
        React.createElement PositionForm, rooms: @state.rooms, handlePositionAdd: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Room'
              React.DOM.th null, 'name'
              React.DOM.th null, 'lang'
              React.DOM.th null, 'description'
              React.DOM.th null, 'file'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Position, key: record.id, record: record, rooms: @state.rooms, handleDeletePosition: @deleteRecord, handleEditPosition: @updateRecord


@AppViewsEmployees = React.createClass
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
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
      positions: @props.data[2]
      positionmap: @props.data[3]
      station: @props.data[4]
    getDefaultProps: ->
      records: []
      rooms: []
    render: ->
      React.DOM.div
        className: 'row'
        for record in @state.records
          React.createElement AppViewsEmployee, key: record.id, record: record, rooms: @state.rooms, positions: @state.positions, positionmap: @state.positionmap, station: @state.station, handleEditAppMap: @updateRecord, handleEditPosMap: @updateMap
          

@AppViewsServices = React.createClass
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
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
      servicemap: @props.data[2]
    getDefaultProps: ->
      records: []
      rooms: []
      servicemap: []
    render: ->
      React.DOM.div
        className: 'row'
        for record in @state.records
          React.createElement AppViewsService, key: record.id, record: record, rooms: @state.rooms, servicemap: @state.servicemap, handleEditSerMap: @updateMap, handleEditSer: @updateRecord

@PatientGeneral = React.createClass
    getInitialState: ->
      records: @props.data[0]
    getDefaultProps: ->
      records: []
    trigger: ->
      console.log(1)
    buttonRender: ->
      React.DOM.div
        className: 'row'
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 2, trigger: @trigger, datatype: 'customer_record'
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 1, Clicked: @trigger
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 1, Clicked: @trigger
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 1, Clicked: @trigger
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 1, Clicked: @trigger
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 1, Clicked: @trigger
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 1, Clicked: @trigger
        React.DOM.hr null
        React.DOM.div
          className: 'row'
          style: {'padding': '10px'}
          React.createElement PatientForm, handleOnchange: @checkrecord, handleRecordAdd: @addRecord
        React.DOM.hr null
        React.DOM.div
          className: 'row'
          React.DOM.div
            className: 'table-responsive col-md-9'
            React.DOM.table
              className: 'table table-bordered'
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Name'
                  React.DOM.th null, 'DOB'
                  React.DOM.th null, 'Age'
                  React.DOM.th null, 'Gender'
                  React.DOM.th null, 'Address'
                  React.DOM.th null, 'Pnumber'
                  React.DOM.th null, 'Noid'
                  React.DOM.th null, 'datei'
                  React.DOM.th null, 'placei'
                  React.DOM.th null, 'avatar'
                  React.DOM.th null, 'created_at'
                  React.DOM.th null, 'updated_at'
              React.DOM.tbody null,
                for record in @state.records
                  React.createElement PatientRecord, key: record.id, gender: @props.data[1], record: record
    render: ->
      @buttonRender()
      