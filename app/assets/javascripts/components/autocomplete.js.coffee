@AutoComplete = React.createClass
    getInitialState: ->
      type: 0
    trigger: (e) ->
      e.preventDefault()
      @props.trigger @props.record
    autoCompleteMedicineSupplier: ->
      React.DOM.div
        onClick: @trigger
        @props.text
    render: ->
      @autoCompleteMedicineSupplier()

@AutoCompleteTable = React.createClass
    getInitialState: ->
      type: 0
    trigger: (record) ->
      @props.trigger record
    autoCompleteTableGeneral: ->
      React.DOM.div className: 'card-body table-responsive',
        React.DOM.table className: 'table table-hover table-condensed',
          React.DOM.thead null,
            React.DOM.tr null,
              for header in @props.header
                React.DOM.th key: header.id, header.name
          React.DOM.tbody null,
            for record in @props.records
              React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @trigger
    autoCompleteTableSample: ->
      React.DOM.div className: 'card-body table-responsive',
        React.DOM.table className: 'table table-hover table-condensed',
          React.DOM.thead null,
            React.DOM.tr null,
              for header in @props.header
                React.DOM.th key: header.id, header.name
          React.DOM.tbody null,
            for record in @props.records
              React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @trigger, grouplist: @props.grouplist, typelist: @props.typelist
    autoCompleteTableCustomer: ->
      React.DOM.div className: 'card-body table-responsive',
        React.DOM.table className: 'table table-hover table-condensed',
          React.DOM.thead null,
            React.DOM.tr null,
              for header in @props.header
                React.DOM.th key: header.id, header.name
          React.DOM.tbody null,
            for record in @props.records
              React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @trigger, gender: @props.extra
    render: ->
      if @props.datatype == "customer_record_mini"
        @autoCompleteTableCustomer()
      else if @props.datatype == 'medicine_sample_mini'
        @autoCompleteTableSample()
      else
        @autoCompleteTableGeneral()
      