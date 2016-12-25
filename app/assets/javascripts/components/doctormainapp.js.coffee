@DoctorMainApp = React.createClass
    getInitialState: ->
        task: null
        stationlist: null
        currentstation: null
        permissionlist: null
        currentpermission: null
        ptask: null
        currentptaskview: 0
        pmtask: null
        currentpmtaskview: 0
        pmphase: null
        currentpmphase: 0
        customer: null
        ordermap: null
        customerlist: null
        ordermaplist: null
        currentstationview: 0
        currentpermissionview: 0
        tabheader: "Settings"
        headertextcolor: "fff"
        backgroundimg: "http://www.diqiushijie.com/uploads/2015/10/56251_0.jpg"
        listbg: ["red","pink","purple","deep-purple","indigo","blue", "light-blue","cyan", "teal", "green", "light-green", "lime", "yellow", "amber", "orange", "deep-orange", "brown", "gray", "blue-gray", "black"]
        sidebartoggled: false
        sidebarmenu: [{id:1, code: 1, text: "Work station", icon: "fa fa-building fa-3x"},{id:2, code: 2, text: "Settings", icon: "fa fa-wrench fa-3x"},{id:3, code: 3, text: "Logout", icon: "fa fa-power-off fa-3x"}]
        currentsidebarmenu: null
        doctor: @props.doctor
        loading: false
        customerRecordTask: [{id:1, name: 'Bệnh nhân', icon: '/assets/patient.png', text: 'Sử dụng để quản lý và thêm bớt danh sách bệnh nhân trong hệ thông', code: 1},{id: 2, name: 'Phiếu khám', icon: '/assets/choice.png', text: 'Sử dụng để quản lý và thêm bớt danh sách phiếu khám trong hệ thông', code: 2}, {id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        customerRecordMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm bệnh nhân vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách bệnh nhân trong ngày', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
    handleSubmit: (e) ->
        e.preventDefault()
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            formData = new FormData
                                            formData.append 'id', @state.customer.id
                                            formData.append 'gender', $('#form_gender').val()
                                            formData.append 'id_station', @state.currentstation.station.id
                                            formData.append 'gender', $('#form_gender').val()
                                            formData.append 'cname', $('#form_name').val()
                                            formData.append 'dob', $('#form_dob').val()
                                            formData.append 'address', $('#form_address').val()
                                            formData.append 'pnumber', $('#form_pnumber').val()
                                            formData.append 'noid', $('#form_noid').val()
                                            formData.append 'issue_date', $('#form_issue_date').val()
                                            formData.append 'issue_place', $('#form_issue_place').val()
                                            formData.append 'work_place', $('#form_work_place').val()
                                            formData.append 'self_history', $('#form_self_history').val()
                                            formData.append 'family_history', $('#form_family_history').val()
                                            formData.append 'drug_history', $('#form_drug_history').val()
                                            if $('#form_avatar')[0].files[0] != undefined
                                                formData.append 'avatar', $('#form_avatar')[0].files[0]
                                            else if $('#webcamout').attr('src') != undefined
                                                formData.append 'avatar', $('#webcamout').attr('src')
                                            message = "thông tin bệnh nhân"
                                            link = "/customer_record"
                                            $.ajax
                                                url: link
                                                type: 'PUT'
                                                data: formData
                                                async: false
                                                cache: false
                                                contentType: false
                                                processData: false
                                                error: ((result) ->
                                                    @showtoast("Cập nhật " + message + " thất bại",3)
                                                    return
                                                ).bind(this)
                                                success: ((result) ->
                                                    @showtoast("Cập nhật " + message + " thành công",1)
                                                    @setState
                                                        customer: result
                                                        pmphase: null
                                                    return
                                                ).bind(this)
                                else
                                    formData = new FormData
                                    formData.append 'id_station', @state.currentstation.station.id
                                    formData.append 'gender', $('#form_gender').val()
                                    formData.append 'cname', $('#form_name').val()
                                    formData.append 'dob', $('#form_dob').val()
                                    formData.append 'address', $('#form_address').val()
                                    formData.append 'pnumber', $('#form_pnumber').val()
                                    formData.append 'noid', $('#form_noid').val()
                                    formData.append 'issue_date', $('#form_issue_date').val()
                                    formData.append 'issue_place', $('#form_issue_place').val()
                                    formData.append 'work_place', $('#form_work_place').val()
                                    formData.append 'self_history', $('#form_self_history').val()
                                    formData.append 'family_history', $('#form_family_history').val()
                                    formData.append 'drug_history', $('#form_drug_history').val()
                                    if $('#form_avatar')[0].files[0] != undefined
                                        formData.append 'avatar', $('#form_avatar')[0].files[0]
                                    else if $('#webcamout').attr('src') != undefined
                                        formData.append 'avatar', $('#webcamout').attr('src')
                                    message = "thông tin bệnh nhân"
                                    link = "/customer_record"
                                    $.ajax
                                        url: link
                                        type: 'POST'
                                        data: formData
                                        async: false
                                        cache: false
                                        contentType: false
                                        processData: false
                                        error: ((result) ->
                                            @showtoast("Thêm " + message + " thất bại",3)
                                            return
                                        ).bind(this)
                                        success: ((result) ->
                                            @showtoast("Thêm " + message + " thành công",1)
                                            @setState customer: result
                                            return
                                        ).bind(this)
    moveuppmtaskView: ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        newview = @state.currentpmtaskview + 1
                        try
                            if newview >= @state.customerRecordMinorTask.length
                                newview = newview - @state.customerRecordMinorTask.length
                        catch error
                            console.log error
                        @setState currentpmtaskview: newview
    movedownpmtaskView: ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        newview = @state.currentpmtaskview - 1
                        try
                            if newview < 0
                                newview = @state.customerRecordMinorTask.length - 1
                        catch error
                            console.log error
                        @setState currentpmtaskview: newview
    moveupptaskView: ->
        switch @state.currentpermission.table_id
            when 1
                newview = @state.currentptaskview + 1
                try
                    if newview >= @state.customerRecordTask.length
                        newview = newview - @state.customerRecordTask.length
                catch error
                    console.log error
                @setState currentptaskview: newview
    movedownptaskView: ->
        switch @state.currentpermission.table_id
            when 1
                newview = @state.currentptaskview - 1
                try
                    if newview < 0
                        newview = @state.customerRecordTask.length - 1
                catch error
                    console.log error
                @setState currentptaskview: newview
    moveupStationView: ->
        newview = @state.currentstationview + 1
        try
            if newview >= @state.stationlist.length
                newview = newview - @state.stationlist.length
        catch error
            console.log error
        @setState currentstationview: newview
    movedownStationView: ->
        newview = @state.currentstationview - 1
        try
            if newview < 0
                newview = @state.stationlist.length - 1
        catch error
            console.log error
        @setState currentstationview: newview
    moveupPermissionView: ->
        newview = @state.currentpermissionview + 1
        try
            if newview >= @state.permissionlist.length
                newview = newview - @state.permissionlist.length
        catch error
            console.log error
        @setState currentpermissionview: newview
    movedownPermissionView: ->
        newview = @state.currentpermissionview - 1
        try
            if newview < 0
                newview = @state.permissionlist.length - 1
        catch error
            console.log error
        @setState currentpermissionview: newview
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
    setup_webcam: ->
        $('#webcamout').remove()
        Webcam.set
            width: 320
            height: 240
            dest_width: 320
            dest_height: 240
            crop_width: 320
            crop_height: 240
            image_format: 'jpeg'
            jpeg_quality: 100
        Webcam.attach '#my_camera'
    take_snapshot: ->
        Webcam.snap (data_uri) ->
            document.getElementById('results').innerHTML = '<img id="webcamout" class="" src="' + data_uri + '"/>'
            Webcam.reset()
            $('#my_camera').css('height':'0px')
            return
        return
    selectStation: (station) ->
        permissionarray = []
        for permiss in @state.permissionlist
            if permiss.station_id == station.station.id
                permissionarray.push permiss
        @setState
            currentstation: station
            permissionlist: permissionarray
    selectPermission: (permission) ->
        console.log @state.currentstation
        switch permission.table_id
            when 3
                @setState currentpermission: permission
            else
                @setState
                    currentpermission: permission
                    ptask: null
                    pmtask: null
                    pmphase: null
    trigger: ->
    triggerbycode: (code) ->
        switch code
            when 1
                @setState
                    tabheader: "Work"
                    task: 1
                    loading: true
                $.ajax
                    url: '/doctor/permission'
                    type: 'POST'
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    error: ((result) ->
                        @showtoast("Tải thông tin quyền truy cập thất bại",3)
                        return
                    ).bind(this)
                    success: ((result) ->
                        @showtoast("Tải thông tin quyền truy cập thành công",1)
                        @setState
                            loading: false
                            currentstation: null
                            stationlist: result[1]
                            permissionlist: result[0]
                            currentpermission: null
                            currentpermissionview: 0
                            currentstationview: 0
                    ).bind(this)
            when 2
                @setState
                    task: 2
                    tabheader: "Cài đặt"
                    currentsidebarmenu: 2
            when 3
                window.location.href = "/logout"
    triggerptask: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch record.code
                    when 1
                        @setState
                            ptask: 1
                            tabheader: 'Bệnh nhân'
                            currentptaskview: 0
                            currentpmtaskview: 0
                            currentpmphase: 0
                            customer: null
                            ordermap: null
                    when 2
                        console.log 2
                    when 3
                        @setState
                            currentpermission: null
                            currentptaskview: 0
    triggerpmtask: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch record.code
                            when 1    
                                @setState
                                    pmtask: 1
                                    tabheader: 'Bệnh nhân'
                                    currentptaskview: 0
                                    currentpmtaskview: 0
                                    currentpmphase: 0
                                    customer: null
                                    ordermap: null
                    when 2
                        console.log 2
                    when 3
                        console.log 3
    triggerpmphase: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                else
                                    switch record.code
                                        when 3
                                            @setState
                                                pmtask: null
                                                tabheader: 'Bệnh nhân'
                                                currentptaskview: 0
                                                currentpmtaskview: 0
                                                currentpmphase: 0
                                                customer: null
                                                ordermap: null
                    when 2
                        console.log 2
                    when 3
                        console.log 3
    triggerpmphaseminor: (record) ->
        switch record.code
            when 3
                @setState pmphase: 1 #edit
    triggerspecialphase: (code) ->
        switch code.code
            when 1 # back from update form
                @setState pmphase: null
    requestData: (code) ->
        switch code
            when 1
                formData = new FormData
                formData.append 'fname', $('#settings-panel #form_fname').val()
                formData.append 'lname', $('#settings-panel #form_lname').val()
                formData.append 'dob', $('#settings-panel #form_dob').val()
                formData.append 'address', $('#settings-panel #form_address').val()
                formData.append 'pnumber', $('#settings-panel #form_pnumber').val()
                formData.append 'noid', $('#settings-panel #form_noid').val()
                formData.append 'issue_date', $('#settings-panel #form_issue_date').val()
                formData.append 'issue_place', $('#settings-panel #form_issue_place').val()
                if $('#settings-panel #form_avatar')[0].files[0] != undefined
                    formData.append 'avatar', $('#settings-panel #form_avatar')[0].files[0]
                $.ajax
                    url: '/dprofile/update'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    error: ((result) ->
                        @showtoast("Lưu thông tin thất bại",3)
                        return
                    ).bind(this)
                    success: ((result) ->
                        @showtoast("Lưu thông tin thành công",1)
                        @setState backgroundimg: $('#settings-panel #form_background').val()
                        if result != null
                            @setState doctor: result
                        return
                    ).bind(this)
            when 2
                $('#settings-panel #form_background').val(@state.backgroundimg)
                $('#settings-panel #form_fname').val(@state.doctor.fname)
                $('#settings-panel #form_lname').val(@state.doctor.lname)
                try
                    $('#settings-panel #form_dob').val(@state.doctor.dob.substring(8, 10) + "/" + @state.doctor.dob.substring(5, 7) + "/" + @state.doctor.dob.substring(0, 4))
                catch error
                    console.log error
                $('#settings-panel #form_address').val(@state.doctor.address)
                $('#settings-panel #form_pnumber').val(@state.doctor.pnumber)
                $('#settings-panel #form_noid').val(@state.doctor.noid)
                try
                    $('#settings-panel #form_issue_date').val(@state.doctor.issue_date.substring(8, 10) + "/" + @state.doctor.issue_date.substring(5, 7) + "/" + @state.doctor.issue_date.substring(0, 4))
                catch error
                    console.log error
                $('#settings-panel #form_issue_place').val(@state.doctor.issue_place)
                $('#settings-panel #form_avatar').val("")
    componentWillMount: ->
      #$(APP).on 'toggle', ((e) ->
      #  @setState toggled: !@state.toggled
      #).bind(this)
    togglesidebar: ->
        @setState sidebartoggled: !@state.sidebartoggled
    normalRender: ->
        React.DOM.div className: 'body-controller',
            React.DOM.div className: 'fixed-background', style: {"backgroundImage": "url(" + @state.backgroundimg + ")"}
            React.DOM.div className: 'spacer20'
            React.DOM.div className: 'container',
                React.DOM.p className: "container-header-text", style: {"color": "#" + @state.headertextcolor}, "Aligosa Manager"
                React.DOM.div className: 'spacer20'
                React.DOM.div className: "tabcontainer-app",
                    React.DOM.div className: "tabcontainer-header",
                        React.DOM.p null, @state.tabheader
                    switch @state.task
                        when null
                            React.DOM.div className: "tabcontainer-content",
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-sm-12',
                                        React.DOM.div className: 'content-app', style: {'display':'table', 'color': '#fff', 'width': '100%'},
                                            React.DOM.p style: {'display': 'table-cell', 'verticalAlign': 'middle', 'textAlign': 'center'}, "Bạn không có quyền truy cập vào dữ liệu làm việc của bất kỳ phòng khám nào. Bạn nên liên lạc với chủ cơ sở để được cấp quyền truy cập"
                        when 1
                            if @state.loading
                                React.DOM.div className: "tabcontainer-content",
                                    React.DOM.div className: 'row',
                                        React.DOM.div className: 'col-sm-12',
                                            React.DOM.div className: 'content-app', style: {'display':'table', 'color': '#fff', 'width': '100%'},
                                                React.DOM.i className: 'fa fa-cog fa-spin fa-3x fa-fw', style: {'display': 'table-cell', 'verticalAlign': 'middle', 'textAlign': 'center'}
                            else
                                React.DOM.div className: "tabcontainer-content",
                                    if @state.currentstation == null
                                        try
                                            switch @state.stationlist.length
                                                when 0
                                                    React.DOM.div className: 'row',
                                                        React.DOM.div className: 'col-sm-12',
                                                            React.DOM.div className: 'content-app', style: {'display':'table', 'color': '#fff', 'width': '100%'},
                                                                React.DOM.p style: {'display': 'table-cell', 'verticalAlign': 'middle', 'textAlign': 'center'}, "Bạn không có quyền truy cập vào dữ liệu làm việc của bất kỳ phòng khám nào. Bạn nên liên lạc với chủ cơ sở để được cấp quyền truy cập"
                                                when 1
                                                    React.DOM.div className: 'row',
                                                        React.createElement StationContentApp, datatype: 1, record: @state.stationlist[0], className: 'col-sm-12 animated fadeIn', hidden: false, trigger: @selectStation
                                                when 2
                                                    count = 0
                                                    i = @state.currentstationview - 1
                                                    React.DOM.div className: 'row',    
                                                        while count < 2
                                                            count = count + 1
                                                            i = i + 1
                                                            if i >= @state.stationlist.length
                                                                i = i - @state.stationlist.length
                                                            if i == @state.currentstationview
                                                                React.createElement StationContentApp, key: @state.stationlist[i].station.id, datatype: 1, record: @state.stationlist[i], className: 'col-sm-6 animated fadeIn', hidden: false, trigger: @selectStation
                                                            else
                                                                React.createElement StationContentApp, key: @state.stationlist[i].station.id, datatype: 1, record: @state.stationlist[i], className: 'col-sm-6 animated fadeIn', hidden: true, trigger: @selectStation
                                                        React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedownStationView,
                                                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                        React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveupStationView,
                                                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                                                when 3
                                                    count = 0
                                                    i = @state.currentstationview - 1
                                                    React.DOM.div className: 'row',    
                                                        while count < 3
                                                            count = count + 1
                                                            i = i + 1
                                                            if i >= @state.stationlist.length
                                                                i = i - @state.stationlist.length
                                                            if i == @state.currentstationview
                                                                React.createElement StationContentApp, key: @state.stationlist[i].station.id, datatype: 1, record: @state.stationlist[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @selectStation
                                                            else
                                                                React.createElement StationContentApp, key: @state.stationlist[i].station.id, datatype: 1, record: @state.stationlist[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @selectStation
                                                        React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedownStationView,
                                                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                        React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveupStationView,
                                                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                                                else
                                                    count = 0
                                                    i = @state.currentstationview - 1
                                                    React.DOM.div className: 'row',    
                                                        while count < 3
                                                            count = count + 1
                                                            i = i + 1
                                                            if i >= @state.stationlist.length
                                                                i = i - @state.stationlist.length
                                                            if i == @state.currentstationview
                                                                React.createElement StationContentApp, key: @state.stationlist[i].station.id, datatype: 1, record: @state.stationlist[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @selectStation
                                                            else
                                                                React.createElement StationContentApp, key: @state.stationlist[i].station.id, datatype: 1, record: @state.stationlist[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @selectStation
                                                        React.DOM.div className: 'side-left-button', onClick: @movedownStationView,
                                                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                        React.DOM.div className: 'side-right-button', onClick: @moveupStationView,
                                                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                                        catch error
                                            console.log error
                                    else
                                        if @state.currentpermission != null
                                            switch @state.currentpermission.table_id
                                                when 1
                                                    switch @state.ptask
                                                        when 1#chose to go in customer Record
                                                            switch @state.pmtask
                                                                when 1#Chose to go add customer
                                                                    if @state.customer != null
                                                                        switch @state.pmphase
                                                                            when 1
                                                                                React.DOM.div className: 'row',
                                                                                    React.DOM.div className: 'row',
                                                                                        React.DOM.div className: 'col-md-7',
                                                                                            React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Họ và Tên'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Họ và tên', defaultValue: @state.customer.cname
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Ngày sinh'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_dob', type: 'text', className: 'form-control', placeholder: '31/01/1990', defaultValue:
                                                                                                            try
                                                                                                                @state.customer.dob.substring(8, 10) + "/" + @state.customer.dob.substring(5, 7) + "/" + @state.customer.dob.substring(0, 4)
                                                                                                            catch error
                                                                                                                ""
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Địa chỉ'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ', defaultValue: @state.customer.address
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Số ĐT'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_pnumber', type: 'number', className: 'form-control', placeholder: 'Số ĐT', defaultValue: @state.customer.pnumber
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'CMTND'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_noid', type: 'number', className: 'form-control', placeholder: 'Số CMTND', defaultValue: @state.customer.noid
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Ngày cấp'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_issue_date', type: 'text', className: 'form-control', placeholder: '31/01/2016', defaultValue:
                                                                                                            try
                                                                                                                @state.customer.issue_date.substring(8, 10) + "/" + @state.customer.issue_date.substring(5, 7) + "/" + @state.customer.issue_date.substring(0, 4)
                                                                                                            catch error
                                                                                                                ""
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Nơi cấp'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_issue_place', type: 'text', className: 'form-control', placeholder: 'Nơi cấp', defaultValue: @state.customer.issue_place
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Nơi làm việc'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.input id: 'form_work_place', type: 'text', className: 'form-control', placeholder: 'Nơi làm việc', defaultValue: @state.customer.work_place
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử bệnh bản thân'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.textarea id: 'form_self_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh bản thân', defaultValue: @state.customer.self_history
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử bệnh gia đình'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.textarea id: 'form_family_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh gia đình', defaultValue: @state.customer.family_history
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử dị ứng thuốc'
                                                                                                    React.DOM.div className: 'col-sm-8',
                                                                                                        React.DOM.textarea id: 'form_drug_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử dị ứng thuốc', defaultValue: @state.customer.drug_history
                                                                                                React.DOM.div className: 'form-group',
                                                                                                    React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Giới tính'
                                                                                                    React.DOM.div className: 'col-sm-3',
                                                                                                        switch @state.customer.gender
                                                                                                            when 2
                                                                                                                React.DOM.select id: 'form_gender', className: 'form-control',
                                                                                                                    React.DOM.option value: '2', 'Nữ'
                                                                                                                    React.DOM.option value: '1', 'Nam'
                                                                                                            else
                                                                                                                React.DOM.select id: 'form_gender', className: 'form-control',
                                                                                                                    React.DOM.option value: '1', 'Nam'
                                                                                                                    React.DOM.option value: '2', 'Nữ'
                                                                                                    React.DOM.label className: 'col-sm-2 hidden-xs control-label', 'Ảnh đại diện'
                                                                                                    React.DOM.div className: 'col-sm-4',
                                                                                                        React.DOM.input id: 'form_avatar', type: 'file', className: 'form-control'
                                                                                        React.DOM.div className: 'col-md-5 hidden-xs', style: {'alignContent': 'center'},
                                                                                            React.DOM.div className: 'content-app-alt',
                                                                                                React.DOM.div id: 'results',
                                                                                                    React.DOM.img id: 'sample_avatar', style: {'maxWidth': '100%', 'maxHeight': '240px'}, src: @state.customer.avatar
                                                                                                React.DOM.div id: 'my_camera'
                                                                                                React.DOM.div className: 'spacer20'
                                                                                                React.DOM.button type: 'button', className: 'btn btn-secondary-docapp', onClick: @setup_webcam, 'Khởi tạo'
                                                                                                React.DOM.button type: 'button', className: 'btn btn-primary-docapp', value: 'take Large Snapshot', onClick: @take_snapshot, 'Chụp'
                                                                                        React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                                                                                            React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 1}, Clicked: @triggerspecialphase
                                                                                            React.DOM.button onClick: @handleSubmit, className: 'btn btn-secondary-docapp pull-right', 'Lưu'    
                                                                            when 2
                                                                                if @state.ordermap != null
                                                                                    console.log 1
                                                                                    #print info form
                                                                                else
                                                                                    console.log 1
                                                                                    #print add form
                                                                            when 3
                                                                                if @state.ordermap != null
                                                                                    #print edit form with filled in
                                                                                else
                                                                                    #print addform
                                                                            else
                                                                                React.createElement StationContentApp, record: @state.customer, datatype: 4, trigger: @triggerpmphaseminor
                                                                    else
                                                                        React.DOM.div className: 'row',
                                                                            React.DOM.div className: 'row',
                                                                                React.DOM.div className: 'col-md-7',
                                                                                    React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Họ và Tên'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Họ và tên'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Ngày sinh'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_dob', type: 'text', className: 'form-control', placeholder: '31/01/1990'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Địa chỉ'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Số ĐT'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_pnumber', type: 'number', className: 'form-control', placeholder: 'Số ĐT'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'CMTND'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_noid', type: 'number', className: 'form-control', placeholder: 'Số CMTND'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Ngày cấp'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_issue_date', type: 'text', className: 'form-control', placeholder: '31/01/2016'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Nơi cấp'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_issue_place', type: 'text', className: 'form-control', placeholder: 'Nơi cấp'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Nơi làm việc'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.input id: 'form_work_place', type: 'text', className: 'form-control', placeholder: 'Nơi làm việc'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử bệnh bản thân'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.textarea id: 'form_self_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh bản thân'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử bệnh gia đình'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.textarea id: 'form_family_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh gia đình'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử dị ứng thuốc'
                                                                                            React.DOM.div className: 'col-sm-8',
                                                                                                React.DOM.textarea id: 'form_drug_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử dị ứng thuốc'
                                                                                        React.DOM.div className: 'form-group',
                                                                                            React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Giới tính'
                                                                                            React.DOM.div className: 'col-sm-3',
                                                                                                React.DOM.select id: 'form_gender', className: 'form-control',
                                                                                                    React.DOM.option value: '1', 'Nam'
                                                                                                    React.DOM.option value: '2', 'Nữ'
                                                                                            React.DOM.label className: 'col-sm-2 hidden-xs control-label', 'Ảnh đại diện'
                                                                                            React.DOM.div className: 'col-sm-4',
                                                                                                React.DOM.input id: 'form_avatar', type: 'file', className: 'form-control'
                                                                                React.DOM.div className: 'col-md-5 hidden-xs', style: {'alignContent': 'center'},
                                                                                    React.DOM.div className: 'content-app-alt',
                                                                                        React.DOM.div id: 'results',
                                                                                            React.DOM.img id: 'sample_avatar', style: {'maxWidth': '100%', 'maxHeight': '240px'}, src: '/assets/avatar_missing.png'
                                                                                        React.DOM.div id: 'my_camera'
                                                                                        React.DOM.div className: 'spacer20'
                                                                                        React.DOM.button type: 'button', className: 'btn btn-secondary-docapp', onClick: @setup_webcam, 'Khởi tạo'
                                                                                        React.DOM.button type: 'button', className: 'btn btn-primary-docapp', value: 'take Large Snapshot', onClick: @take_snapshot, 'Chụp'
                                                                                React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                                                                                    React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 3}, Clicked: @triggerpmphase
                                                                                    React.DOM.button onClick: @handleSubmit, className: 'btn btn-secondary-docapp pull-right', 'Lưu'    
                                                                when 2
                                                                    console.log 1
                                                                else
                                                                    count = 0
                                                                    i = @state.currentpmtaskview - 1
                                                                    React.DOM.div className: 'row',    
                                                                        while count < 3
                                                                            count = count + 1
                                                                            i = i + 1
                                                                            if i >= @state.customerRecordMinorTask.length
                                                                                i = i - @state.customerRecordMinorTask.length
                                                                            if i == @state.currentpmtaskview
                                                                                React.createElement StationContentApp, key: @state.customerRecordMinorTask[i].id, datatype: 3, record: @state.customerRecordMinorTask[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerpmtask
                                                                            else
                                                                                React.createElement StationContentApp, key: @state.customerRecordMinorTask[i].id, datatype: 3, record: @state.customerRecordMinorTask[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerpmtask
                                                                        React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedownpmtaskView,
                                                                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                                        React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveuppmtaskView,
                                                                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                                                        when 2
                                                            console.log 1
                                                        else
                                                            count = 0
                                                            i = @state.currentptaskview - 1
                                                            React.DOM.div className: 'row',    
                                                                while count < 3
                                                                    count = count + 1
                                                                    i = i + 1
                                                                    if i >= @state.customerRecordTask.length
                                                                        i = i - @state.customerRecordTask.length
                                                                    if i == @state.currentptaskview
                                                                        React.createElement StationContentApp, key: @state.customerRecordTask[i].id, datatype: 3, record: @state.customerRecordTask[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerptask
                                                                    else
                                                                        React.createElement StationContentApp, key: @state.customerRecordTask[i].id, datatype: 3, record: @state.customerRecordTask[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerptask
                                                                React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedownptaskView,
                                                                    React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                                React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveupptaskView,
                                                                    React.DOM.i className: 'zmdi zmdi-chevron-right'
                                                when 2
                                                    console.log 1
                                                when 3
                                                    console.log 1
                                        else
                                            try
                                                switch @state.permissionlist.length
                                                    when 0
                                                        React.DOM.div className: 'row',
                                                            React.DOM.div className: 'col-sm-12',
                                                                React.DOM.div className: 'content-app', style: {'display':'table', 'color': '#fff', 'width': '100%'},
                                                                    React.DOM.p style: {'display': 'table-cell', 'verticalAlign': 'middle', 'textAlign': 'center'}, "Bạn không có quyền truy cập vào dữ liệu làm việc nào của phòng khám này. Bạn nên liên lạc với chủ cơ sở để được cấp quyền truy cập"
                                                    when 1
                                                        React.DOM.div className: 'row',
                                                            React.createElement StationContentApp, datatype: 2, record: @state.permissionlist[0], className: 'col-sm-12 animated fadeIn', hidden: false, trigger: @selectPermission
                                                    when 2
                                                        count = 0
                                                        i = @state.currentpermissionview - 1
                                                        React.DOM.div className: 'row',    
                                                            while count < 2
                                                                count = count + 1
                                                                i = i + 1
                                                                if i >= @state.permissionlist.length
                                                                    i = i - @state.permissionlist.length
                                                                if i == @state.currentpermissionview
                                                                    React.createElement StationContentApp, key: @state.permissionlist[i].id, datatype: 2, record: @state.permissionlist[i], className: 'col-sm-6 animated fadeIn', hidden: false, trigger: @selectPermission
                                                                else
                                                                    React.createElement StationContentApp, key: @state.permissionlist[i].id, datatype: 2, record: @state.permissionlist[i], className: 'col-sm-6 animated fadeIn', hidden: true, trigger: @selectPermission
                                                            React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedownPermissionView,
                                                                React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                            React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveupPermissionView,
                                                                React.DOM.i className: 'zmdi zmdi-chevron-right'
                                                    when 3
                                                        count = 0
                                                        i = @state.currentpermissionview - 1
                                                        React.DOM.div className: 'row',    
                                                            while count < 3
                                                                count = count + 1
                                                                i = i + 1
                                                                if i >= @state.permissionlist.length
                                                                    i = i - @state.permissionlist.length
                                                                if i == @state.currentpermissionview
                                                                    React.createElement StationContentApp, key: @state.permissionlist[i].id, datatype: 2, record: @state.permissionlist[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @selectPermission
                                                                else
                                                                    React.createElement StationContentApp, key: @state.permissionlist[i].id, datatype: 2, record: @state.permissionlist[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @selectPermission
                                                            React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedownPermissionView,
                                                                React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                            React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveupPermissionView,
                                                                React.DOM.i className: 'zmdi zmdi-chevron-right'
                                                    else
                                                        count = 0
                                                        i = @state.currentpermissionview - 1
                                                        React.DOM.div className: 'row',    
                                                            while count < 3
                                                                count = count + 1
                                                                i = i + 1
                                                                if i >= @state.permissionlist.length
                                                                    i = i - @state.permissionlist.length
                                                                if i == Number(@state.currentpermissionview)
                                                                    React.createElement StationContentApp, key: @state.permissionlist[i].id, datatype: 2, record: @state.permissionlist[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @selectPermission
                                                                else
                                                                    React.createElement StationContentApp, key: @state.permissionlist[i].id, datatype: 2, record: @state.permissionlist[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @selectPermission
                                                            React.DOM.div className: 'side-left-button', onClick: @movedownPermissionView,
                                                                React.DOM.i className: 'zmdi zmdi-chevron-left'
                                                            React.DOM.div className: 'side-right-button', onClick: @moveupPermissionView,
                                                                React.DOM.i className: 'zmdi zmdi-chevron-right'
                                            catch error
                                                console.log error
                        when 2
                            React.DOM.div className: "tabcontainer-content",
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-sm-8',
                                        React.DOM.div className: 'content-app', id: 'settings-panel',
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Background"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_background', defaultValue: @state.backgroundimg, placeholder: 'Background Image URL'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Họ và đệm"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_fname', defaultValue: @state.doctor.fname, placeholder: 'Họ và đệm'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Tên"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_lname', defaultValue: @state.doctor.lname, placeholder: 'Tên'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Ngày sinh"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_dob', placeholder: 'Ngày sinh - 30/01/1990', defaultValue:
                                                        try
                                                            @state.doctor.dob.substring(8, 10) + "/" + @state.doctor.dob.substring(5, 7) + "/" + @state.doctor.dob.substring(0, 4)
                                                        catch error
                                                            console.log error
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Địa chỉ"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_address', defaultValue: @state.doctor.address, placeholder: 'Địa chỉ'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Số điện thoại"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_pnumber', defaultValue: @state.doctor.pnumber, placeholder: 'Số điện thoại'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Số CMTND"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_noid', defaultValue: @state.doctor.noid, placeholder: 'Số CMTND'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Ngày cấp"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_issue_date', placeholder: 'Ngày cấp - 30/01/1990', defaultValue:
                                                        try
                                                            @state.doctor.issue_date.substring(8, 10) + "/" + @state.doctor.issue_date.substring(5, 7) + "/" + @state.doctor.issue_date.substring(0, 4)
                                                        catch error
                                                            console.log error
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Nơi cấp"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'text', id: 'form_issue_place', defaultValue: @state.doctor.issue_place, placeholder: 'Nơi cấp'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'col-sm-4',    
                                                    React.DOM.p className: 'label-content', "Ảnh đại diện"
                                                React.DOM.div className: 'col-sm-8',
                                                    React.DOM.input className: 'form-control', type: 'file', id: 'form_avatar'
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'spacer20'
                                                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: "fa fa-repeat", text: ' Reset', type: 3, code: 2, Clicked: @requestData
                                                React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: "fa fa-floppy-o", text: ' Lưu', type: 3, code: 1, Clicked: @requestData
                                            React.DOM.div className: 'row',
                                                React.DOM.div className: 'spacer20'
                                    React.DOM.div className: 'col-sm-4 hidden-xs',
                                        React.DOM.div className: 'content-app',
                                            React.DOM.h4 null, @state.doctor.fname + " " + @state.doctor.lname
                                            React.DOM.img alt: 'pic1', src: @state.doctor.avatar, className: 'img-responsive'
                                            React.DOM.div className: 'content-info-block',
                                                try
                                                    React.DOM.p null, @state.doctor.dob.substring(8, 10) + "/" + @state.doctor.dob.substring(5, 7) + "/" + @state.doctor.dob.substring(0, 4)
                                                catch error
                                                    console.log error
                                                React.DOM.p null,
                                                    switch @state.doctor.gender
                                                        when 1
                                                            "Nam"
                                                        when 2
                                                            "Nữ"
                                                React.DOM.p null, @state.doctor.address
                                                React.DOM.p null, @state.doctor.pnumber
                                                React.DOM.p null, @state.doctor.noid
            if @state.sidebartoggled
                React.DOM.div className: 'sidemenu animated fadeIn',
                    React.DOM.div className: 'sidemenu-outbutton',
                        React.DOM.i className: 'zmdi zmdi-chevron-left'
                    React.DOM.div className: 'sidemenu-container active',
                        React.DOM.div className: 'close-sidemenu-button', style: {"cursor":"pointer"}, onClick: @togglesidebar,
                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                        React.DOM.div className: 'list-sidemenu-button',
                            for menu in @state.sidebarmenu
                                if @state.currentsidebarmenu == menu.id
                                    React.createElement ButtonGeneral, type: 6, key: menu.id, code: menu.code, text: menu.text, icon: menu.icon, selected: true, Clicked: @triggerbycode
                                else
                                    React.createElement ButtonGeneral, type: 6, key: menu.id, code: menu.code, text: menu.text, icon: menu.icon, selected: false, Clicked: @triggerbycode
            else
                React.DOM.div className: 'sidemenu animated fadeIn',
                    React.DOM.div className: 'sidemenu-outbutton active', style: {"cursor":"pointer"}, onClick: @togglesidebar,
                        React.DOM.i className: 'zmdi zmdi-chevron-left'
                    React.DOM.div className: 'sidemenu-container',
                        React.DOM.div className: 'close-sidemenu-button',
                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                        React.DOM.div className: 'list-sidemenu-button',
                            for menu in @state.sidebarmenu
                                if @state.currentsidebarmenu == menu.id
                                    React.createElement ButtonGeneral, type: 6, key: menu.id, code: menu.code, text: menu.text, icon: menu.icon, selected: true, Clicked: @triggerbycode
                                else
                                    React.createElement ButtonGeneral, type: 6, key: menu.id, code: menu.code, text: menu.text, icon: menu.icon, selected: false, Clicked: @triggerbycode        
    render: ->
      @normalRender()
      
      
@StationContentApp = React.createClass
    getInitialState: ->
        style: 1
        filteredRecord: null
        records: null
        lastsorted: null
        viewperpage: 10
        currentpage: 1
        firstcount: 0
        lastcount: 0
    componentWillMount: ->
        $(APP).on 'reloadData', ((e) ->
            if @props.orderlist != null
                @setState
                    records: @props.orderlist
                    filteredRecord: null
                    record: null
                    lastsorted: null
                    viewperpage: 10
                    currentpage: 1
                    firstcount: 0
                    lastcount:
                        if @props.orderlist[0].length < 10
                            @props.data[0].length
                        else
                            10
        ).bind(this)
    calAge: (dob, style) ->
        now = new Date
        today = new Date(now.getYear(), now.getMonth(), now.getDate())
        yearNow = now.getYear()
        monthNow = now.getMonth()
        dateNow = now.getDate()
        if style == 1
            dob = new Date(dob.substring(6, 10), dob.substring(3, 5) - 1, dob.substring(0, 2))
        else
            dob = new Date(dob.substring(0, 4), dob.substring(5, 7) - 1, dob.substring(8, 10))
        yearDob = dob.getYear()
        monthDob = dob.getMonth()
        dateDob = dob.getDate()
        yearAge = yearNow - yearDob
        if monthNow >= monthDob
            monthAge = monthNow - monthDob
        else
            yearAge--
            monthAge = 12 + monthNow - monthDob
        if dateNow >= dateDob
            dateAge = dateNow - dateDob
        else
            monthAge--
            dateAge = 31 + dateNow - dateDob
            if monthAge < 0
                monthAge = 11
                yearAge--
        age =
            years: yearAge
            months: monthAge
            days: dateAge
        return age
    triggerRecord: ->
        @props.trigger @props.record
    triggercode: (code) ->
        @props.trigger code
    trigger: ->
    dynamicSort: (property) ->
        sortOrder = 1
        if property[0] == '-'
            sortOrder = -1
            property = property.substr(1)
        (a, b) ->
            result = if a[property] < b[property] then -1 else if a[property] > b[property] then 1 else 0
            result * sortOrder
    triggerSort: (code) ->
        if @state.filteredRecord != null
            @setState
                filteredRecord: @state.filteredRecord.sort(@dynamicSort(code))
                lastsorted: code
        else
            @setState
                filteredRecord: @state.records.sort(@dynamicSort(code))
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
                    if @state.records.length < page * @state.viewperpage
                        @state.records.length
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
            if @state.currentpage < Math.ceil(@state.records.length/@state.viewperpage)
                @triggerPage(@state.currentpage + 1)
    triggerRightMax: ->
        if @state.filteredRecord != null
            @triggerPage(Math.ceil(@state.filteredRecord.length/@state.viewperpage))
        else
            @triggerPage(Math.ceil(@state.records.length/@state.viewperpage))
    triggerChangeRPP: ->
        if Number($('#record_per_page').val()) > 0
            @setState
                viewperpage: Number($('#record_per_page').val())
                currentpage: 1
                firstcount: 0
                lastcount:
                    if @state.filteredRecord != null
                        if @state.filteredRecord.length < Number($('#record_per_page').val())
                            @state.filteredRecord.length
                        else
                            Number($('#record_per_page').val())
                    else
                        if @state.records.length < Number($('#record_per_page').val())
                            @state.records.length
                        else
                            Number($('#record_per_page').val())
        else
            @showtoast('Số bạn nhập không phù hợp',3)
    triggerChangePage: ->
        if @state.filteredRecord != null
            if Number($('#page_number').val()) <= Math.ceil(@state.filteredRecord.length/@state.viewperpage) and Number($('#page_number').val()) > 0
                @triggerPage(Number($('#page_number').val()))
            else
                @showtoast("Số trang bạn muốn chuyển tới không phù hợp", 3)
        else
            if Number($('#page_number').val()) <= Math.ceil(@state.records.length/@state.viewperpage) and Number($('#page_number').val()) > 0
                @triggerPage(Number($('#page_number').val()))
            else
                @showtoast("Số trang bạn muốn chuyển tới không phù hợp", 3)
    stationRender: ->
        if @props.hidden    
            React.DOM.div className: @props.className + ' hidden-xs',
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, @props.record.station.sname
                    React.DOM.img alt: 'pic1', src: @props.record.station.logo , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null, @props.record.station.address
                        React.DOM.p null, @props.record.station.pnumber
                        React.DOM.p null, @props.record.station.hpage
        else
            React.DOM.div className: @props.className,
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, @props.record.station.sname
                    React.DOM.img alt: 'pic1', src: @props.record.station.logo , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null, @props.record.station.address
                        React.DOM.p null, @props.record.station.pnumber
                        React.DOM.p null, @props.record.station.hpage
    permissionRender: ->
        switch Number(@props.record.table_id)
            when 1
                textline = "Truy cập danh sách bệnh nhân"
                logo_icon = "/assets/list.png"
                guideline = "Được sử dụng để đọc danh sách bệnh nhân và đăng ký bệnh nhân vào danh sách"
            when 2
                textline = "Truy cập kho thuốc"
                logo_icon = "/assets/medical-kit.png"
                guideline = "Được sử dụng để quản lý kho thuốc trong việc nhập xuất thuốc theo hóa đơn và đơn thuốc"
            when 3
                textline = "Khám bệnh"
                logo_icon = "/assets/medical-stethoscope-variant.png"
                guideline = "Cho phép thực hiện thay đổi các kết quả khám bệnh cho các bệnh nhân đến khám"
        if @props.hidden    
            React.DOM.div className: @props.className + ' hidden-xs',
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, textline
                    React.DOM.img alt: 'pic1', src: logo_icon , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null, guideline
        else
            React.DOM.div className: @props.className,
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, textline
                    React.DOM.img alt: 'pic1', src: logo_icon , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null, guideline
    PtaskBlockRender: ->
        if @props.hidden    
            React.DOM.div className: @props.className + ' hidden-xs',
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, @props.record.name
                    React.DOM.img alt: 'pic1', src: @props.record.icon , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null, @props.record.text
        else
            React.DOM.div className: @props.className,
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, @props.record.name
                    React.DOM.img alt: 'pic1', src: @props.record.icon , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null, @props.record.text
    customerInfoShow: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'col-md-4',
                React.DOM.div className: 'content-app-alt',
                    React.DOM.h4 style: {'color': '#fff'}, @props.record.cname
                    React.DOM.img alt: 'pic1', src: @props.record.avatar , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null,
                            React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                            try
                                @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
                            catch error
                                console.log error
                        React.DOM.p null,
                            React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                            try
                                @calAge(@props.record.dob,2).years + " Tuổi " + @calAge(@props.record.dob,2).months + "Tháng"
                            catch error
                                console.log error
                        React.DOM.p null,
                            React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                            switch @props.record.gender
                                when 1
                                    "Nam"
                                when 2
                                    "Nữ"
                                else
                                    "Chưa định"
                        React.DOM.p null,
                            React.DOM.i className: 'fa fa-map-marker', style: {'marginRight' : '10px'}
                            @props.record.address
                        React.DOM.p null,
                            React.DOM.i className: 'fa fa-barcode', style: {'marginRight' : '10px'}
                            @props.record.noid
                        React.DOM.p null,
                            React.DOM.i className: 'fa fa-phone', style: {'marginRight' : '10px'}
                            @props.record.pnumber
            React.DOM.div className: 'col-md-8',
                React.DOM.div className: 'row hidden-xs',
                    React.DOM.div className: 'content-app-alt',
                        React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                            React.DOM.div className: 'row',
                                React.DOM.div className: 'col-md-4 hidden-xs',
                                    React.DOM.p null, 'Nơi làm việc'
                                React.DOM.div className: 'col-md-8',
                                    React.DOM.p null, @props.record.work_place
                            React.DOM.div className: 'row',
                                React.DOM.div className: 'col-md-4 hidden-xs',
                                    React.DOM.p null, 'Tiền sử'
                                React.DOM.div className: 'col-md-8',
                                    React.DOM.p null, @props.record.self_history
                            React.DOM.div className: 'row',
                                React.DOM.div className: 'col-md-4 hidden-xs',
                                    React.DOM.p null, 'Gia đình'
                                React.DOM.div className: 'col-md-8',
                                    React.DOM.p null, @props.record.family_history
                            React.DOM.div className: 'row',
                                React.DOM.div className: 'col-md-4 hidden-xs',
                                    React.DOM.p null, 'Dị ứng thuốc'
                                React.DOM.div className: 'col-md-8',
                                    React.DOM.p null, @props.record.drug_history
                if @props.records != null
                    React.DOM.div className: 'row hidden-xs', style:{'paddingRight':'35px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                            React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                        React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                            React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
                        if @state.filteredRecord != null
                            React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        else
                            React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        React.DOM.div className: 'spacer10'
                        React.DOM.table className: 'table table-hover table-condensed',
                            React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort,  header: [
                                {id: 1, name: 'Tên dịch vụ', code: 'sername'}
                                {id: 2, name: 'Tên khách hàng', code: 'cname'}
                                {id: 3, name: 'Tình trạng', code: 'status'}
                                {id: 4, name: 'Tổng đơn giá', code: 'tpayment'}
                                {id: 5, name: 'Giảm giá', code: 'discount'}
                                {id: 6, name: 'Tổng thanh toán', code: 'tpayout'}
                                {id: 7, name: 'Ghi chú', code: 'remark'}
                            ]
                            React.DOM.tbody null,
                                if @state.filteredRecord != null
                                    for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                        React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: false, selectRecord: @trigger
                                else
                                    for record in @state.records[@state.firstcount...@state.lastcount]
                                        React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: false, selectRecord: @trigger
                        React.DOM.div className: 'spacer10'
                        if @state.filteredRecord != null
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        else
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                    React.DOM.div className: 'spacer10'
                    React.DOM.div className: 'row',
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp col-md-3 pull-right', icon: 'zmdi zmdi-plus', type: 3, text: ' Tạo phiếu khám', code: {code: 1}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp col-md-3 pull-right', icon: 'zmdi zmdi-accounts-list', type: 3, text: ' Tải phiếu khám', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp col-md-3 pull-right', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa thông tin', code: {code: 3}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về ', code: {code: 5}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 4}, Clicked: @triggercode
                        
    render: ->
        switch @props.datatype
            when 1
                @stationRender()
            when 2
                @permissionRender()
            when 3
                @PtaskBlockRender()
            when 4
                @customerInfoShow()