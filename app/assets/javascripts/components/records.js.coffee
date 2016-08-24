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
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Tên phòng'
              React.DOM.th null, 'Ngôn ngữ'
              React.DOM.th null, 'Bản đồ'
              React.DOM.th null, 'Hành động'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Room, key: record.id, record: record, handleDeleteRoom: @deleteRecord, handleEditRoom: @updateRecord