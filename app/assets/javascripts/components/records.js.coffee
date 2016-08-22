@Records = React.createClass
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
        React.DOM.div
          className: 'row'
          React.createElement AmountBox, amount: @credits(), text: 'Total'
          React.createElement AmountBox, amount: @debits(), text: 'Total'
          React.createElement AmountBox, amount: @balance(), text: 'Total - Total'
          React.createElement AmountBox, amount: @debits(), text: 'Total'
        React.createElement RecordForm, handleNewRecord: @addRecord
        React.DOM.hr null
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