@ModalButton = React.createClass
    getInitialState: ->
        view: {showModal: false }
    handleHideModal: ->
        @setState view: {showModal: false}
    handleShowModal: ->
        @setState view: {showModal: true}
    addRecordEmployee: (record) ->
        @props.handleEmployeeRecord record
    addRoom: (record) ->
        @props.handleRoomAdd record
    render: ->
        React.DOM.div
            className: 'row'
            React.DOM.button
                className: 'btn btn-default btn-block'
                style: {margin: '10px'}
                onClick: @handleShowModal
                'Open Modal'
            if @state.view.showModal
                React.createElement Modal, handleHideModal: @handleHideModal, handleEmployeeRecord: @addRecordEmployee, handleRoomAdd: @addRoom, data: {type: @props.data.type}
            else
                null