@ModalButton = React.createClass
    getInitialState: ->
        view: {showModal: false }
    handleHideModal: ->
        @setState view: {showModal: false}
    handleShowModal: ->
        @setState view: {showModal: true}
    render: ->
        React.DOM.div
            className: 'row'
            React.DOM.button
                className: 'btn btn-default btn-block'
                onClick: @handleShowModal
                'Open Modal'
            if @state.view.showModal
                React.createElement Modal, handleHideModal: @handleHideModal
            else
                null