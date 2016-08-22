 @Record = React.createClass
    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.record.station_id
        React.DOM.td null, @props.record.ename
        React.DOM.td null, "Stm"
