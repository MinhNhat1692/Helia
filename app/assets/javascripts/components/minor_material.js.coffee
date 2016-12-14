@MinorMaterial = React.createClass
    getInitialState: ->
        type: 1
        filteredRecord: null
        selected: null
        lastsorted: null
        viewperpage: 10
        currentpage: 1
        firstcount: 0
        lastcount:
            if @props.records != null and @props.records != undefined
                if @props.records.length < 10
                    @props.records.length
                else
                    10
            else
                0
        #medicinesummary part using to show metro style summary
    showtoast: (message,toasttype) ->
	    toastr.options =
        closeButton: true
        progressBar: true
        positionClass: 'toast-top-right'
        showMethod: 'slideDown'
        hideMethod: 'fadeOut'
        timeOut: 4000
      if toasttype == 1
        toastr.success message
      else if toasttype == 2
        toastr.info(message)
      else if toasttype == 3
        toastr.error(message)
      return
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
                for record in @props.data
                    sum+= record.r
                return sum
            when 2
                output = {sumex: 0, sumin: 0, sumprice: 0, texrec: 0, texsc: 0, tinrec: 0, tinsc: 0}
                sumex = 0
                sumin = 0
                if @props.data[0] != undefined
                    for record in @props.data[0]
                        sumex += record.s
                if @props.data[1] != undefined
                    for record in @props.data[1]
                        sumin += record.s
                sumprice = 0
                if @props.data[2] != undefined
                    for record in @props.data[2]
                        sumprice += record.price * record.amount
                if @props.data[0].length > 0
                    if new Date(@props.data[0][@props.data[0].length - 1].d).getYear() == new Date().getYear() and new Date(@props.data[0][@props.data[0].length - 1].d).getMonth() == new Date().getMonth() and new Date(@props.data[0][@props.data[0].length - 1].d).getDate() == new Date().getDate()
                        output.texrec = @props.data[0][@props.data[0].length - 1].r
                        output.texsc = @props.data[0][@props.data[0].length - 1].s
                if @props.data[1].length > 0
                    if new Date(@props.data[1][@props.data[1].length - 1].d).getYear() == new Date().getYear() and new Date(@props.data[1][@props.data[1].length - 1].d).getMonth() == new Date().getMonth() and new Date(@props.data[1][@props.data[1].length - 1].d).getDate() == new Date().getDate()
                        output.tinrec = @props.data[1][@props.data[1].length - 1].r
                        output.tinsc = @props.data[1][@props.data[1].length - 1].s
                output.sumex = sumex
                output.sumin = sumin
                output.sumprice = sumprice
                return output
            when 3
                sum = 0
                for record in @props.data
                    sum+= record.s
                return sum
            when 4
                #output = {sumex: 0, sumin: 0, sumprice: 0, texrec: 0, texsc: 0, tinrec: 0, tinsc: 0}
                #sumex = 0
                #sumin = 0
                #if @props.data[0].script_qty != undefined and @props.data[0] != undefined
                #    for record in @props.data[0].script_qty
                #        sumex += record
                #if @props.data[1].script_qty != undefined and @props.data[1] != undefined
                #    for record in @props.data[1].script_qty
                #        sumin += record
                #sumprice = 0
                #if @props.data[2] != undefined
                #    for record in @props.data[2]
                #        sumprice += record.price * record.amount
                #if new Date(@props.data[0].date[@props.data[0].date.length - 1]).getYear() == new Date().getYear() and new Date(@props.data[0].date[@props.data[0].date.length - 1]).getMonth() == new Date().getMonth() and new Date(@props.data[0].date[@props.data[0].date.length - 1]).getDate() == new Date().getDate()
                #    output.texrec = @props.data[0].records_qty[@props.data[0].date.length - 1]
                #    output.texsc = @props.data[0].script_qty[@props.data[0].date.length - 1]
                #if new Date(@props.data[1].date[@props.data[1].date.length - 1]).getYear() == new Date().getYear() and new Date(@props.data[1].date[@props.data[1].date.length - 1]).getMonth() == new Date().getMonth() and new Date(@props.data[1].date[@props.data[1].date.length - 1]).getDate() == new Date().getDate()
                #    output.tinrec = @props.data[1].records_qty[@props.data[1].date.length - 1]
                #    output.tinsc = @props.data[1].script_qty[@props.data[1].date.length - 1]
                #output.sumex = sumex
                #output.sumin = sumin
                #output.sumprice = sumprice
                #return output
            
                output = {sumex: 0, sumin: 0, sumprice: 0, texrec: 0, texsc: 0, tinrec: 0, tinsc: 0}
                sumex = 0
                sumin = 0
                if @props.data[0] != undefined
                    for record in @props.data[0]
                        sumex += record.s
                if @props.data[1] != undefined
                    for record in @props.data[1]
                        sumin += record.s
                sumprice = 0
                if @props.data[2] != undefined
                    for record in @props.data[2]
                        sumprice += record.price * record.amount
                if @props.data[0].length > 0
                    if new Date(@props.data[0][@props.data[0].length - 1].d).getYear() == new Date().getYear() and new Date(@props.data[0][@props.data[0].length - 1].d).getMonth() == new Date().getMonth() and new Date(@props.data[0][@props.data[0].length - 1].d).getDate() == new Date().getDate()
                        output.texrec = @props.data[0][@props.data[0].length - 1].r
                        output.texsc = @props.data[0][@props.data[0].length - 1].s
                if @props.data[1].length > 0
                    if new Date(@props.data[1][@props.data[1].length - 1].d).getYear() == new Date().getYear() and new Date(@props.data[1][@props.data[1].length - 1].d).getMonth() == new Date().getMonth() and new Date(@props.data[1][@props.data[1].length - 1].d).getDate() == new Date().getDate()
                        output.tinrec = @props.data[1][@props.data[1].length - 1].r
                        output.tinsc = @props.data[1][@props.data[1].length - 1].s
                output.sumex = sumex
                output.sumin = sumin
                output.sumprice = sumprice
                return output
            when 5
                sum = 0
                for record in @props.data
                    sum+= record.price
                return sum
            when 6
                sum = 0
                for record in @props.data
                    sum+= record.price
                return sum
            when 7
                try
                    sumin = 0
                    for record in @props.data[0]
                        sumin+= record.price
                    sumout = 0
                    for record in @props.data[1]
                        sumout+= record.price
                    return sumin - sumout
                catch err
                    console.log err
    analyzeDataChart: (chartcode, daystart, dayend, data) ->
        output = []
        switch Number(chartcode)
            when 2
                i = 0
                while i < data.length
                    output.push([@days_between(new Date(data[i].d), daystart),data[i].s])
                    i++
            when 3
                temparr = []
                i = 0
                while i < data[0].length
                    temparr.push({id: @days_between(new Date(data[0][i].d), daystart), amount: data[0][i].s})
                    i++
                i = 0
                while i < data[1].length
                    j = 0
                    check = true
                    while j < temparr.length
                        if temparr[j].id == @days_between(new Date(data[1][i].d), daystart)
                            temparr[j].amount += data[1][i].s
                            check = false
                            break
                        j++
                    if check
                        temparr.push({id: @days_between(new Date(data[1][i].d), daystart), amount: data[1][i].s})
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
    trigger: (e) ->
    triggercode: ->
        @props.trigger @props.code
    triggerRecord: (record) ->
        @setState selected: record.id
        @props.trigger record, @props.datacode
    triggerSort: (code) ->
      if @state.filteredRecord != null
        @setState
          filteredRecord: @state.filteredRecord.sort(@dynamicSort(code))
          lastsorted: code
      else
        @setState
          filteredRecord: @props.records.sort(@dynamicSort(code))
          lastsorted: code
    triggerPage: (page) ->
      @setState
        currentpage: page
        firstcount: (page - 1)*@state.viewperpage
        lastcount:
          if @state.filteredRecord != null
            if @state.filteredRecord.length < page * @state.viewperpage
              @state.filteredRecord.length
            else
              page * @state.viewperpage
          else
            if @props.records.length < page * @state.viewperpage
              @props.records.length
            else
              page * @state.viewperpage
    triggerLeftMax: ->
      @triggerPage(1)
    triggerLeft: ->
      if @state.currentpage > 1
        @triggerPage(@state.currentpage - 1)
    triggerRight: ->
      if @state.filteredRecord != null
        if @state.currentpage < Math.ceil(@state.filteredRecord.length/@state.viewperpage)
          @triggerPage(@state.currentpage + 1)
      else
        if @state.currentpage < Math.ceil(@props.records.length/@state.viewperpage)
          @triggerPage(@state.currentpage + 1)
    triggerRightMax: ->
      if @state.filteredRecord != null
        @triggerPage(Math.ceil(@state.filteredRecord.length/@state.viewperpage))
      else
        @triggerPage(Math.ceil(@props.records.length/@state.viewperpage))
    triggerChangeRPP: ->
      if Number($('#record_per_page' + @props.datatype).val()) > 0
        @setState
          viewperpage: Number($('#record_per_page' + @props.datatype).val())
          currentpage: 1
          firstcount: 0
          lastcount:
            if @state.filteredRecord != null
              if @state.filteredRecord.length < Number($('#record_per_page' + @props.datatype).val())
                @state.filteredRecord.length
              else
                Number($('#record_per_page' + @props.datatype).val())
            else
              if @props.records.length < Number($('#record_per_page' + @props.datatype).val())
                @props.records.length
              else
                Number($('#record_per_page' + @props.datatype).val())
      else
        @showtoast('Số bạn nhập không phù hợp',3)
    triggerChangePage: ->
      if @state.filteredRecord != null
        if Number($('#page_number' + @props.datatype).val()) <= Math.ceil(@state.filteredRecord.length/@state.viewperpage) and Number($('#page_number' + @props.datatype).val()) > 0
          @triggerPage(Number($('#page_number' + @props.datatype).val()))
        else
          @showtoast("Số trang bạn muốn chuyển tới không phù hợp", 3)
      else
        if Number($('#page_number' + @props.datatype).val()) <= Math.ceil(@props.records.length/@state.viewperpage) and Number($('#page_number' + @props.datatype).val()) > 0
          @triggerPage(Number($('#page_number' + @props.datatype).val()))
        else
          @showtoast("Số trang bạn muốn chuyển tới không phù hợp", 3)
    componentWillMount: ->
        $(APP).on 'drawsparkle', ((e) ->
            @drawSparkle()  
        ).bind(this)
        $(APP).on 'drawplot', ((e) ->
            @drawPlot() 
        ).bind(this)
        $(APP).on 'reloadminormaterial', ((e) ->
            @setState lastcount:
                if @props.records != null and @props.records != undefined
                    if @props.records.length < 10
                        @props.records.length
                    else
                        10
                else
                    0
        ).bind(this)
    drawPlot: ->
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
        try
            $.plot $('#' + @props.idflotchart), @outputSparkleData(@props.chartcode).data, chartUsersOptions
        catch err
            console.log err
    outputSparkleData: (chartcode) ->
        switch chartcode
            when 1
                if @props.data != undefined and @props.data != null
                    if @props.data.length > 1
                        output = []
                        d_start = new Date(@props.data[0].d)
                        d_end = new Date(@props.data[@props.data.length - 1].d)
                        while d_start <= d_end
                            check = true
                            i = 0
                            while i < @props.data.length
                                if new Date(@props.data[i].d).getYear() == d_start.getYear() and new Date(@props.data[i].d).getMonth() == d_start.getMonth() and new Date(@props.data[i].d).getDate() == d_start.getDate()
                                    output.push @props.data[i].r
                                    check = false
                                    break
                                i++
                            if check
                                output.push 0
                            d_start.setDate(d_start.getDate() + 1)
                        return output
                    else if @props.data.length == 1
                        return [@props.data[0].r,@props.data[0].r]
                    else
                        return [0,0]
                else
                    return [0,0]
            when 2
                output = {data:[]}
                data1 = []
                data2 = []
                if @props.data != undefined
                    if @props.data[0] != undefined and @props.data[1] != undefined
                        check1 = true
                        check2 = true
                        if @props.data[0].length > 0
                            d_start1 = new Date(@props.data[0][0].d)
                            d_end1 = new Date(@props.data[0][@props.data[0].length - 1].d)
                        else
                            check1 = false
                        if @props.data[1].length > 0
                            d_start2 = new Date(@props.data[1][0].d)
                            d_end2 = new Date(@props.data[1][@props.data[1].length - 1].d)
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
                    else
                        data1.push([0,0])
                        data2.push([0,0])
                output = {data:[]}
                output.data.push(data1)
                output.data.push(data2)
                return output
            when 3
                if @props.data != undefined and @props.data != null
                    if @props.data.length > 1
                        output = []
                        d_start = new Date(@props.data[0].date)
                        d_end = new Date(@props.data[@props.data.length - 1].date)
                        while d_start <= d_end
                            check = true
                            i = 0
                            while i < @props.data.length
                                if new Date(@props.data[i].date).getYear() == d_start.getYear() and new Date(@props.data[i].date).getMonth() == d_start.getMonth() and new Date(@props.data[i].date).getDate() == d_start.getDate()
                                    output.push @props.data[i].amount
                                    check = false
                                    break
                                i++
                            if check
                                output.push 0
                            d_start.setDate(d_start.getDate() + 1)
                        return output
                    else if @props.data.length == 1
                        return [@props.data[0].amount,@props.data[0].amount]
                    else
                        return [0,0]
                else
                    return [0,0]
            when 4
                if @props.data != undefined and @props.data != null
                    if @props.data.length > 1
                        output = []
                        d_start = new Date(@props.data[0].date)
                        d_end = new Date(@props.data[@props.data.length - 1].date)
                        while d_start <= d_end
                            check = true
                            i = 0
                            while i < @props.data.length
                                if new Date(@props.data[i].date).getYear() == d_start.getYear() and new Date(@props.data[i].date).getMonth() == d_start.getMonth() and new Date(@props.data[i].date).getDate() == d_start.getDate()
                                    output.push @props.data[i].amount
                                    check = false
                                    break
                                i++
                            if check
                                output.push 0
                            d_start.setDate(d_start.getDate() + 1)
                        return output
                    else if @props.data.length == 1
                        return [@props.data[0].amount,@props.data[0].amount]
                    else
                        return [0,0]
                else
                    return [0,0]
    outputChartJsData: (chartcode) ->
        switch chartcode
            when 1
                if @props.data != undefined and @props.data != null
                    return null
                else
                    return null
    drawSparkle: ->
        $('#' + @props.idcanvas).sparkline @outputSparkleData(@props.chartcode), type: @props.plotstyle, width: @props.plotwidth, height: @props.plotheight,
    MedicineSummaryPart: ->
        React.DOM.div className: @props.className, onClick: @triggercode,
            React.DOM.div className: 'metro', style: {"cursor":"pointer"},
                React.DOM.h3 null, @props.header_text
                React.DOM.p className: 'text-muted hidden-xs', @props.description
                React.DOM.div className: 'metro-footer', style: {'backgroundColor': @props.color}
                React.DOM.img alt: @props.altitle, className: 'metro-object-img', src: @props.img, width: '110'
    MedicineStockSummaryPart: ->
        React.DOM.div className: @props.className, onClick: @triggercode,
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
    UnfloatLabelProgressIn: ->
        outputinfo = @getDataOut(@props.datacode)
        React.DOM.div className: @props.className,
            React.DOM.div className: 'unfloat-label',
                React.DOM.h4 null, "Thông tin cơ bản - " + @props.header
                    React.DOM.div className: 'col-md-12',
                        React.DOM.h4 null, "Đánh giá chung"
                        React.DOM.p className: "info",
                            if outputinfo.sumex >= outputinfo.sumin / 1.3
                                "Có tới " + Math.round(outputinfo.sumex*100/(outputinfo.sumex + outputinfo.sumin) * 100) / 100 + "% trong tổng số đơn thuốc là đơn thuốc trong phòng khám, doanh thu đạt " + outputinfo.sumprice
                            else
                                "Chỉ có " + Math.round(outputinfo.sumex*100/(outputinfo.sumex + outputinfo.sumin) * 100) / 100 + "% trong tổng số đơn thuốc là đơn thuốc trong phòng khám, doanh thu đạt " + outputinfo.sumprice
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
                React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                    React.createElement InputField, id: 'record_per_page' + @props.datatype, className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                    React.createElement InputField, id: 'page_number' + + @props.datatype, className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
                if @state.filteredRecord != null
                    React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                    React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@props.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                React.DOM.div className: 'spacer10'
                React.DOM.table className: 'table table-hover table-condensed',
                    React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort,  header: @props.theader
                    React.DOM.tbody null,
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                if @state.selected != null
                                    if record.id == @state.selected
                                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: true, selectRecord: @triggerRecord
                                    else
                                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                else
                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                        else
                            for record in @props.records[@state.firstcount...@state.lastcount]
                                if @state.selected != null
                                    if record.id == @state.selected
                                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: true, selectRecord: @triggerRecord
                                    else
                                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                else
                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                    React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                    React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@props.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
    FloatTableChart: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'float-label',
                React.DOM.div className: 'row',
                    React.DOM.div className: @props.className1,
                        React.DOM.h5 null, @props.title
                        React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                            React.createElement InputField, id: 'record_per_page' + @props.datatype, className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                        React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                            React.createElement InputField, id: 'page_number' + @props.datatype, className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
                        if @state.filteredRecord != null
                            React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        else
                            React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@props.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        React.DOM.div className: 'spacer10'
                        React.DOM.table className: 'table table-hover table-condensed',
                            React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort,  header: @props.theader
                            React.DOM.tbody null,
                                if @state.filteredRecord != null
                                    for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                        if @state.selected != null
                                            if record.id == @state.selected
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: true, selectRecord: @triggerRecord
                                            else
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                        else
                                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                else
                                    for record in @props.records[@state.firstcount...@state.lastcount]
                                        if @state.selected != null
                                            if record.id == @state.selected
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: true, selectRecord: @triggerRecord
                                            else
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                        else
                                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                        React.DOM.div className: 'spacer10'
                        if @state.filteredRecord != null
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        else
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@props.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: @props.className2,
                        React.DOM.canvas id: @props.idcanvaschartjs
    UnfloatTableChart: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'unfloat-label',
                React.DOM.div className: 'row',
                    React.DOM.div className: @props.className1,
                        React.DOM.canvas id: @props.idcanvaschartjs
                    React.DOM.div className: @props.className2,
                        React.DOM.h4 null, @props.title
                        React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                            React.createElement InputField, id: 'record_per_page' + @props.datatype, className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                        React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                            React.createElement InputField, id: 'page_number' + @props.datatype, className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
                        if @state.filteredRecord != null
                            React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        else
                            React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@props.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        React.DOM.div className: 'spacer10'
                        React.DOM.table className: 'table table-hover table-condensed',
                            React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort,  header: @props.theader
                            React.DOM.tbody null,
                                if @state.filteredRecord != null
                                    for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                        if @state.selected != null
                                            if record.id == @state.selected
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: true, selectRecord: @triggerRecord
                                            else
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                        else
                                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                else
                                    for record in @props.records[@state.firstcount...@state.lastcount]
                                        if @state.selected != null
                                            if record.id == @state.selected
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: true, selectRecord: @triggerRecord
                                            else
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                                        else
                                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.code, selected: false, selectRecord: @triggerRecord
                        React.DOM.div className: 'spacer10'
                        if @state.filteredRecord != null
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        else
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@props.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    
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
        else if @props.datatype == "unfloat_label_progress_in"            
            @UnfloatLabelProgressIn()
        else if @props.datatype == "unfloat_label_chart"
            @UnfloatLabelChart()
        else if @props.datatype == "unfloat_label_table"
            @UnfloatTable()
        else if @props.datatype == "unfloat_label_progress"
            @UnfloatLabelProgress()
        else if @props.datatype == "color_float_label"
            @ColorFloatLabel()
        else if @props.datatype == "float_table_chart"
            @FloatTableChart()
        else if @props.datatype == "unfloat_table_chart"
            @UnfloatTableChart()