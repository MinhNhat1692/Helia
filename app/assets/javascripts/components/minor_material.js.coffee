@MinorMaterial = React.createClass
    getInitialState: ->
        type: 1
        #medicinesummary part using to show metro style summary
    trigger: ->
        @props.trigger @props.code
    componentWillMount: ->
        $(APP).on 'drawsparkle', ((e) ->
            @drawSparkle()  
        ).bind(this)
        $(APP).on 'drawplot', ((e) ->
            @drawPlot() 
        ).bind(this)
    drawPlot: ->
        data1 = [ [0, 16], [1, 24], [2, 11], [3, 7], [4, 10], [5, 15], [6, 24], [7, 30] ];
        data2 = [ [0, 26], [1, 44], [2, 31], [3, 27], [4, 36], [5, 46], [6, 56], [7, 66] ];
        chartUsersOptions = {
            series: {
                lines: { show: true, fill: true }
            }
            
            grid: {
                tickColor: "#404652"
                borderWidth: 0
                borderColor: '#404652'
                color: '#404652'
            }
            colors: [ "#2196F3 ","#00BCD4"]
        }
        if @props.idflotchart != undefined
            $.plot $('#' + @props.idflotchart), [data2,data1], chartUsersOptions
    drawSparkle: ->
        $('#' + @props.idcanvas).sparkline @props.plotdata, type: @props.plotstyle, width: @props.plotwidth, height: @props.plotheight,
    MedicineSummaryPart: ->
        React.DOM.div className: @props.className, onClick: @trigger,
            React.DOM.div className: 'metro', style: {"cursor":"pointer"},
                React.DOM.h3 null, @props.header_text
                React.DOM.p className: 'text-muted hidden-xs', @props.description
                React.DOM.div className: 'metro-footer', style: {'backgroundColor': @props.color}
                React.DOM.img alt: @props.altitle, className: 'metro-object-img', src: @props.img, width: '110'
    MedicineStockSummaryPart: ->
        React.DOM.div className: @props.className, onClick: @trigger,
            React.DOM.div className: 'collecting-data-spinner', style: {"cursor":"pointer",'backgroundColor': @props.color, 'minHeight': @props.minheight, 'color': @props.textcolor},
                React.DOM.div className: 'text-center',
                    React.DOM.i className: 'fa fa-clock-o fa-3x'
                    React.DOM.p className: 'lead text-center', @props.text
    FloatLabel: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'float-label text-center',
                React.DOM.div className: 'float-label-header', @props.header
                React.DOM.h4 null, @props.spanText
                React.DOM.p null, @props.pText
    FloatLabelProgressPlot: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'float-label',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-4',
                        React.DOM.h4 null, "Đánh giá"
                        React.DOM.p className: "info", "Chỉ có 20% trong tổng số đơn thuốc là đơn thuốc ngoài phòng khám, con số doanh thu có thể mang lại của số thuốc này có thể đạt xấp xỉ 12500000 nếu tính theo biểu giá thuốc hiện đang có"
                        React.DOM.div className: "progress",
                            React.DOM.div className: "progressbar", style: {"width": "20%"}
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-md-6 text-center",
                                React.DOM.h4 null, "Hôm nay"
                                React.DOM.p null, "120"
                            React.DOM.div className: "col-md-6 text-center",
                                React.DOM.h4 null, "Tỷ lệ"
                                React.DOM.p null, "14%"
                    React.DOM.div className: 'col-md-8',
                        React.DOM.div className: "flot-chart", style: {"height": "290px","marginTop": "5px"},
                            React.DOM.div className: "flot-chart-content", id: @props.idflotchart
                        React.DOM.div className: "small text-center", "Tổng hợp tỷ lệ đơn thuốc ngoài"
    UnfloatLabel: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'unfloat-label',
                React.DOM.h4 null, "Thông tin cơ bản - " + @props.header
                for record in @props.data
                    React.DOM.div className: 'row', key: record.id, style: {"paddingLeft": "30px"},
                        React.DOM.span className: "label", record.label + ":"
                        React.DOM.span className: "info", " " + record.text
    UnfloatLabelChart: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'unfloat-label', style: {"position": "relative", "height":"148.5px", "width": "100%"},
                React.DOM.div style: {'position':"absolute", "bottom": 0, "left": 0, "right": 0},
                    React.DOM.span id: @props.idcanvas
                React.DOM.div className: 'float-label-header', @props.header
                React.DOM.span null, " " + @props.spanText + " - " + @props.pText
    render: ->
        if @props.datatype == "medicine_summary_part"
            @MedicineSummaryPart()
        else if @props.datatype == "medicine_stock_summary_part"
            @MedicineStockSummaryPart()
        else if @props.datatype == "float_label"
            @FloatLabel()
        else if @props.datatype == "float_label_progress_plot"
            @FloatLabelProgressPlot()
        else if @props.datatype == "unfloat_label"
            @UnfloatLabel()
        else if @props.datatype == "unfloat_label_chart"
            @UnfloatLabelChart()