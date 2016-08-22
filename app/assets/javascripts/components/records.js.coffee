@Records = React.createClass
    addRecord: (record) ->
      records = @state.records.slice()
      records.push record
      @setState records: records
    getInitialState: ->
      records: @props.data
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'records'
        React.DOM.h2
          className: 'title'
          'Records'
        React.createElement RecordForm, handleNewRecord: @addRecord
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'station id'
              React.DOM.th null, 'name'
              React.DOM.th null, 'smt'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Record, key: record.id, record: record