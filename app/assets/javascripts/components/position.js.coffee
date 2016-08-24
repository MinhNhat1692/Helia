@PositionRecords = React.createClass
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
        className: 'position'
        React.DOM.h2
          className: 'title'
          'Position'
        React.createElement PositionRecordForm, handlePositionRecord: @addRecord
        React.createElement ModalButton, data: {type: 'position'}, handlePositionRecord: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'name'
              React.DOM.th null, 'lang'
              React.DOM.th null, 'description'
              React.DOM.th null, 'file'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement PositionRecord, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord