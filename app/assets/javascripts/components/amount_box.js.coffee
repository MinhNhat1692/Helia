@AmountBox = React.createClass
    render: ->
      React.DOM.div
        className: 'col-lg-3 col-xs-6'
        React.DOM.div
          className: "panel panel-filled"
          React.DOM.div
            className: 'panel-body'
            React.DOM.h2
              className: 'm-b-none'
              @props.amount
            React.DOM.div
              className: 'small'
              @props.text