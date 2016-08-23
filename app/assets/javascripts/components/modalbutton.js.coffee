@ModalButton = React.createClass
    getInitialState: ->
        view: {showModal: false }
    handleHideModal: ->
        @setState view: {showModal: false}
    handleShowModal: ->
        @setState view: {showModal: true}
    addRecordEmployee: (record) ->
        @props.handleEmployeeRecord record
    render: ->
        React.DOM.div
            className: 'row'
            React.DOM.button
                className: 'btn btn-default btn-block'
                style: {margin: '10px'}
                onClick: @handleShowModal
                'Open Modal'
            if @state.view.showModal
                React.createElement Modal, handleHideModal: @handleHideModal, handleEmployeeRecord: @addRecordEmployee, data: {type: @props.data.type}
            else
                null