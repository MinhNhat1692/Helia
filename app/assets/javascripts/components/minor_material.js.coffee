@MinorMaterial = React.createClass
    getInitialState: ->
        type: 1
        #medicinesummary part using to show metro style summary
    MedicineSummaryPart: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'metro',
                React.DOM.h3 null, @props.header_text
                React.DOM.p className: 'text-muted', @props.description
                React.DOM.div className: 'metro-footer', style: {'backgroundColor': @props.color}
                React.DOM.img alt: @props.altitle, className: 'metro-object-img', src: @props.img, width: '110'
    MedicineStockSummaryPart: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'collecting-data-spinner', style: {'backgroundColor': @props.color, 'minHeight': @props.minheight, 'color': @props.textcolor},
                React.DOM.div className: 'text-center',
                    React.DOM.i className: 'fa fa-clock-o fa-3x'
                    React.DOM.p className: 'lead text-center', @props.text
    render: ->
        if @props.datatype == "medicine_summary_part"
            @MedicineSummaryPart()
        else if @props.datatype == "medicine_stock_summary_part"
            @MedicineStockSummaryPart()