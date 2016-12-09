@MinorMaterial = React.createClass
    getInitialState: ->
        type: 1
        #medicinesummary part using to show metro style summary
    dynamicSort: (property) ->
        sortOrder = 1
        if property[0] == '-'
            sortOrder = -1
            property = property.substr(1)
        (a, b) ->
            result = if a[property] < b[property] then -1 else if a[property] > b[property] then 1 else 0
            result * sortOrder
    getDataOut: (datacode) ->
        switch Number(datacode) #total
            when 0
                return data
            when 1
                sum = 0
                if @props.data.records_qty != undefined
                    for record in @props.data.records_qty
                        sum+= record
                return sum
            when 2
                output = {sumex: 0, sumin: 0, sumprice: 0, texrec: 0, texsc: 0, tinrec: 0, tinsc: 0}
                sumex = 0
                sumin = 0
                if @props.data[0].script_qty != undefined and @props.data[0] != undefined
                    for record in @props.data[0].script_qty
                        sumex += record
                if @props.data[1].script_qty != undefined and @props.data[1] != undefined
                    for record in @props.data[1].script_qty
                        sumin += record
                sumprice = 0
                if @props.data[2] != undefined
                    for record in @props.data[2]
                        sumprice += record.price * record.amount
                if new Date(@props.data[0].date[@props.data[0].date.length - 1]).getYear() == new Date().getYear() and new Date(@props.data[0].date[@props.data[0].date.length - 1]).getMonth() == new Date().getMonth() and new Date(@props.data[0].date[@props.data[0].date.length - 1]).getDate() == new Date().getDate()
                    output.texrec = @props.data[0].records_qty[@props.data[0].date.length - 1]
                    output.texsc = @props.data[0].script_qty[@props.data[0].date.length - 1]
                if new Date(@props.data[1].date[@props.data[1].date.length - 1]).getYear() == new Date().getYear() and new Date(@props.data[1].date[@props.data[1].date.length - 1]).getMonth() == new Date().getMonth() and new Date(@props.data[1].date[@props.data[1].date.length - 1]).getDate() == new Date().getDate()
                    output.tinrec = @props.data[1].records_qty[@props.data[1].date.length - 1]
                    output.tinsc = @props.data[1].script_qty[@props.data[1].date.length - 1]
                output.sumex = sumex
                output.sumin = sumin
                output.sumprice = sumprice
                return output
            when 3
                sum = 0
                if @props.data.script_qty != undefined
                    for record in @props.data.script_qty
                        sum+= record
                return sum
    analyzeDataChart: (chartcode, daystart, dayend, data) ->
        output = []
        switch Number(chartcode)
            when 2
                i = 0
                while i < data.date.length
                    output.push([@days_between(new Date(data.date[i]), daystart),data.script_qty[i]])
                    i++
            when 3
                temparr = []
                i = 0
                while i < data[0].date.length
                    temparr.push({id: @days_between(new Date(data[0].date[i]), daystart), amount: data[0].script_qty[i]})
                    i++
                i = 0
                while i < data[1].date.length
                    j = 0
                    check = true
                    while j < temparr.length
                        if temparr[j].id == @days_between(new Date(data[1].date[i]), daystart)
                            temparr[j].amount += data[1].script_qty[i]
                            check = false
                            break
                        j++
                    if check
                        temparr.push({id: @days_between(new Date(data[1].date[i]), daystart), amount: data[1].script_qty[i]})
                    i++
                temparr = temparr.sort(@dynamicSort('id'))
                i = 0
                while i < temparr.length
                    output.push([temparr[i].id,temparr[i].amount])
                    i++
        return output
    days_between: (date1, date2) ->
        ONE_DAY = 1000 * 60 * 60 * 24
        date1_ms = date1.getTime()
        date2_ms = date2.getTime()
        difference_ms = Math.abs(date1_ms - date2_ms)
        Math.round difference_ms / ONE_DAY
    trigger: ->
        @props.trigger @props.code
    triggerRecord: (record) ->
        @props.trigger record
    componentWillMount: ->
        $(APP).on 'drawsparkle', ((e) ->
            @drawSparkle()  
        ).bind(this)
        $(APP).on 'drawplot', ((e) ->
            @drawPlot() 
        ).bind(this)
    drawPlot: ->
        #data1 = [ [0, 16], [1, 24], [2, 11], [3, 7], [4, 10], [5, 15], [6, 24], [7, 30] ]
        #data2 = [ [0, 26], [1, 44], [2, 31], [3, 27], [4, 36], [5, 46], [6, 56], [7, 66] ]
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
            $.plot $('#' + @props.idflotchart), @outputSparkleData(@props.chartcode).data, chartUsersOptions #[data2,data1], chartUsersOptions
        
    outputSparkleData: (chartcode) ->
        switch chartcode
            when 1
                if @props.data.date != undefined
                    if @props.data.date.length > 1
                        output = []
                        d_start = new Date(@props.data.date[0])
                        d_end = new Date(@props.data.date[@props.data.date.length - 1])
                        while d_start <= d_end
                            check = true
                            i = 0
                            while i < @props.data.date.length
                                if new Date(@props.data.date[i]).getYear() == d_start.getYear() and new Date(@props.data.date[i]).getMonth() == d_start.getMonth() and new Date(@props.data.date[i]).getDate() == d_start.getDate()
                                    output.push @props.data.records_qty[i]
                                    check = false
                                    break
                                i++
                            if check
                                output.push 0
                            d_start.setDate(d_start.getDate() + 1)
                        return output
                    else if @props.data.date.length == 1
                        return [@props.data.records_qty,@props.data.records_qty]
                    else
                        return [0,0]
            when 2
                output = {data:[]}
                data1 = []
                data2 = []
                if @props.data[0] != undefined and @props.data[1] != undefined
                    check1 = true
                    check2 = true
                    if @props.data[0].date.length > 0
                        d_start1 = new Date(@props.data[0].date[0])
                        d_end1 = new Date(@props.data[0].date[@props.data[0].date.length - 1])
                    else
                        check1 = false
                    if @props.data[1].date.length > 0
                        d_start2 = new Date(@props.data[1].date[0])
                        d_end2 = new Date(@props.data[1].date[@props.data[1].date.length - 1])
                    else
                        check2 = false
                    if !check1 and check2
                        data1.push([0, 0])
                        data2 = @analyzeDataChart(2,d_start2,d_end2,@props.data[1])
                    else if check1 and !check2
                        data2.push([0, 0])
                        data1 = @analyzeDataChart(2,d_start1,d_end1,@props.data[0])
                    else if check1 and check2
                        if d_start1 < d_start2
                            d_start = d_start1
                        else
                            d_start = d_start2
                        if d_end1 < d_end2
                            d_end = d_end2
                        else
                            d_end = d_end1
                        data1 = @analyzeDataChart(2,d_start,d_end,@props.data[0])
                        data2 = @analyzeDataChart(3,d_start,d_end,@props.data)
                    else
                        data1.push([0, 0])
                        data2.push([0, 0])
                output = {data:[]}
                output.data.push(data1)
                output.data.push(data2)
                return output
    drawSparkle: ->
        $('#' + @props.idcanvas).sparkline @outputSparkleData(@props.datacode), type: @props.plotstyle, width: @props.plotwidth, height: @props.plotheight,
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
                React.DOM.p null, @getDataOut(@props.datacode)
    FloatLabelProgressPlot: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'float-label',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
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
    UnfloatLabelProgress: ->
        outputinfo = @getDataOut(@props.datacode)
        React.DOM.div className: @props.className,
            React.DOM.div className: 'unfloat-label',
                React.DOM.h4 null, "Thông tin cơ bản - " + @props.header
                    React.DOM.div className: 'col-md-12',
                        React.DOM.h4 null, "Đánh giá chung"
                        React.DOM.p className: "info",
                            if outputinfo.sumex >= outputinfo.sumin / 1.3
                                "Có tới " + Math.round(outputinfo.sumex*100/(outputinfo.sumex + outputinfo.sumin) * 100) / 100 + "% trong tổng số đơn thuốc là đơn thuốc ngoài phòng khám, con số doanh thu có thể mang lại của số thuốc này có thể đạt " + outputinfo.sumprice + " nếu tính theo biểu giá thuốc nhập hiện đang có"
                            else
                                "Chỉ có " + Math.round(outputinfo.sumex*100/(outputinfo.sumex + outputinfo.sumin) * 100) / 100 + "% trong tổng số đơn thuốc là đơn thuốc ngoài phòng khám, con số doanh thu có thể mang lại của số thuốc này có thể đạt " + outputinfo.sumprice + " nếu tính theo biểu giá thuốc nhập hiện đang có"
                        React.DOM.div className: "progress",
                            React.DOM.div className: "progressbar", style: {"width": outputinfo.sumex*100/(outputinfo.sumex + outputinfo.sumin) + "%"}
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-md-6 text-center",
                                React.DOM.h4 null, "Hôm nay"
                                React.DOM.p null, outputinfo.texsc
                            React.DOM.div className: "col-md-6 text-center",
                                React.DOM.h4 null, "Tỷ lệ"
                                React.DOM.p null, outputinfo.texsc*100/(outputinfo.texsc + outputinfo.tinsc) + "%"
    UnfloatLabelChart: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'unfloat-label', style: {"position": "relative", "height":"148.5px", "width": "100%"},
                React.DOM.div style: {'position':"absolute", "bottom": 0, "left": 0, "right": 0},
                    React.DOM.span id: @props.idcanvas
                React.DOM.div className: 'float-label-header', @props.header
                React.DOM.span null, " " + @props.spanText + " - " + @getDataOut(@props.chartcode)
    UnfloatTable: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'unfloat-label',
                React.DOM.div className: 'table-responsive',
                    React.DOM.table className: 'table table-hover table-condensed',
                        React.DOM.thead null,
                            React.DOM.tr null,
                                for thead in @props.theader
                                    React.DOM.th key: thead.id, thead.name
                        React.DOM.tbody null,
                            if @props.records != null
                                for record in @props.records
                                    React.createElement RecordGeneral, key: record.id, record: record, trigger: @triggerRecord, datatype: @props.code
    ColorFloatLabel: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'float-label', style: {'height': '200px','backgroundColor': @props.color, 'color': @props.textcolor},
                React.DOM.div style: {'position':"absolute", "bottom": '19px', "left": '15px', "right": '15px'},
                    React.DOM.span id: @props.idcanvas
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
        else if @props.datatype == "unfloat_label_table"
            @UnfloatTable()
        else if @props.datatype == "unfloat_label_progress"
            @UnfloatLabelProgress()
        else if @props.datatype == "color_float_label"
            @ColorFloatLabel()
        