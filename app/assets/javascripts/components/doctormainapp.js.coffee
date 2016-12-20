@DoctorMainApp = React.createClass
    getInitialState: ->
        task: null
        stationlist: null
        currentstation: null
        permissionlist: null
        currentpermission: null
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
    selectStation: (station) ->
        permissionarray = []
        for permiss in @state.permissionlist
            if permiss.station_id == station.station.id
                permissionarray.push permiss
        @setState
            currentstation: station
            permissionlist: permissionarray
    selectPermission: (permission) ->
        
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
    requestData: (code) ->
        console.log code
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
    triggerRecord: ->
        @props.trigger @props.record
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
            when 4
                textline = "Viết đơn thuốc"
                logo_icon = "/assets/script.png"
                guideline = "Cho phép viết đơn thuốc ứng với từng kết quả khám bệnh"
            when 5
                textline = "Truy vấn kho thuốc"
                logo_icon = "/assets/database.png"
                guideline = "Cho phép xem kho thuốc để biết số lượng còn lại của từng loại thuốc, từ đó ra quyết định kê đơn phù hợp"
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
    render: ->
        switch @props.datatype
            when 1
                @stationRender()
            when 2
                @permissionRender()