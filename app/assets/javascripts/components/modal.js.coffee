@Modal = React.createClass
    getInitialState: ->
      type: 'employee'
    componentDidMount: ->
      $(ReactDOM.findDOMNode(this)).modal 'show'
      $(ReactDOM.findDOMNode(this)).on 'hidden.bs.modal', @props.handleHideModal
    employeeForm: ->
      React.DOM.div
        className: 'modal fade'
        React.DOM.div
          className: 'modal-dialog modal-lg'
          React.DOM.div
            className: 'modal-content'
            React.DOM.div
              className: 'modal-header text-center'
              React.DOM.h4
                className: 'modal-title'
                'Employee Form'
              React.DOM.small
                'Description'
            React.DOM.div
              className: 'modal-body'
              React.DOM.p null, 'Lorem Ipsum is simply dummy text.'
            React.DOM.div
              className: 'modal-footer'
              React.DOM.button
                className: 'btn btn-default'
                'data-dismiss': 'modal'
                type: 'button'
                'Close'
              React.DOM.button
                className: 'btn btn-accent'
                type: 'button'
                'Save changes'
    propTypes: handleHideModal: React.PropTypes.func.isRequired
    render: ->
      if @state.type == 'employee'
        @employeeForm()