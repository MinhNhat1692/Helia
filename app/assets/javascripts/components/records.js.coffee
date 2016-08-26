@Records = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @replaceState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @replaceState records: records
    credits: ->
      credits = @state.records.filter (val) -> val.station_id >= 0
      credits.reduce ((prev, curr) ->
        prev + 1
      ), 0
    debits: ->
      debits = @state.records.filter (val) -> val.station_id >= 0
      debits.reduce ((prev, curr) ->
        prev + 1
      ), 0
    balance: ->
      @debits() - @credits()
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.records
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'records'
        React.DOM.h2
          className: 'title'
          'Records'
        React.DOM.div
          className: 'row'
          React.createElement AmountBox, amount: @credits(), text: 'Total'
          React.createElement AmountBox, amount: @debits(), text: 'Total'
          React.createElement AmountBox, amount: @balance(), text: 'Total - Total'
          React.createElement AmountBox, amount: @debits(), text: 'Total'
        React.createElement RecordForm, handleEmployeeRecord: @addRecord
        React.createElement ModalButton, data: {type: 'employee'}, handleEmployeeRecord: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'station id'
              React.DOM.th null, 'name'
              React.DOM.th null, 'smt'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord


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