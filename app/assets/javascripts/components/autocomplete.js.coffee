@AutoComplete = React.createClass
    getInitialState: ->
      type: 0
    trigger: (e) ->
      e.preventDefault()
      @props.trigger @props.record
    autoCompleteMedicineSupplier: ->
      React.DOM.div key:@props.record.id, className: 'auto-complete-hover', onClick: @trigger, @props.text
    render: ->
      @autoCompleteMedicineSupplier()

@AutoCompleteTable = React.createClass
    getInitialState: ->
      type: 0
    trigger: (record) ->
      @props.trigger record
    autoCompleteTableGeneral: ->
      if @props.records.length > 0
        React.DOM.div className: 'card-body table-responsive',
          React.DOM.table className: 'table table-hover table-condensed',
            React.DOM.thead null,
              React.DOM.tr null,
                for header in @props.header
                  React.DOM.th key: header.id, header.name
            React.DOM.tbody null,
              for record in @props.records
                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @trigger
      else
        React.DOM.div style: {'display':'none'}
    autoCompleteTableSample: ->
      if @props.records.length > 0
        React.DOM.div className: 'card-body table-responsive',
          React.DOM.table className: 'table table-hover table-condensed',
            React.DOM.thead null,
              React.DOM.tr null,
                for header in @props.header
                  React.DOM.th key: header.id, header.name
            React.DOM.tbody null,
              for record in @props.records
                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @trigger, grouplist: @props.grouplist, typelist: @props.typelist
      else
        React.DOM.div style: {'display':'none'}
    autoCompleteTableCustomer: ->
      if @props.records.length > 0
        React.DOM.div className: 'card-body table-responsive',
          React.DOM.table className: 'table table-hover table-condensed',
            React.DOM.thead null,
              React.DOM.tr null,
                for header in @props.header
                  React.DOM.th key: header.id, header.name
            React.DOM.tbody null,
              for record in @props.records
                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @trigger, gender: @props.extra
      else
        React.DOM.div style: {'display':'none'}
    render: ->
      if @props.datatype == "customer_record_mini"
        @autoCompleteTableCustomer()
      else if @props.datatype == 'medicine_sample_mini'
        @autoCompleteTableSample()
      else
        @autoCompleteTableGeneral()
      