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
        pmpm: 0
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
        autoComplete: null
        code: null
        customerRecordTask: [{id:1, name: 'Bệnh nhân', icon: '/assets/patient.png', text: 'Sử dụng để quản lý và thêm bớt danh sách bệnh nhân trong hệ thông', code: 1},{id: 2, name: 'Phiếu khám', icon: '/assets/choice.png', text: 'Sử dụng để quản lý và thêm bớt danh sách phiếu khám trong hệ thông', code: 2}, {id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        customerRecordMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm bệnh nhân vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách bệnh nhân trong ngày', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
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
    triggersafe: ->
    generateRandom: (length) ->
        text = ''
        possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        i = 0
        while i < length
            text += possible.charAt(Math.floor(Math.random() * possible.length))
            i++
        return text
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
                        formData = new FormData
                        formData.append 'id_station', @state.currentstation.station.id
                        message = "danh sách bệnh nhân trong ngày"
                        link = "/customer_record/list"
                        @showtoast("Bắt đầu tải " + message,2)
                        $.ajax
                            url: link
                            type: 'POST'
                            data: formData
                            async: false
                            cache: false
                            contentType: false
                            processData: false
                            error: ((result) ->
                                @showtoast("Tải " + message + " thất bại",3)
                                return
                            ).bind(this)
                            success: ((result) ->
                                @showtoast("Tải " + message + " thành công",1)
                                @setState
                                    customer: null
                                    customerlist: null
                                    ordermap: null
                                    ordermaplist: null
                                    pmtask: 2
                                    pmphase: null
                                    pmpm: null
                                setTimeout (->
                                    $(APP).trigger('reloadData')
                                ), 500
                                return
                            ).bind(this)
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
                                formData = new FormData
                                formData.append 'id_station', @state.currentstation.station.id
                                message = "danh sách bệnh nhân trong ngày"
                                link = "/customer_record/list"
                                @showtoast("Bắt đầu tải " + message,2)
                                $.ajax
                                    url: link
                                    type: 'POST'
                                    data: formData
                                    async: false
                                    cache: false
                                    contentType: false
                                    processData: false
                                    error: ((result) ->
                                        @showtoast("Tải " + message + " thất bại",3)
                                        return
                                    ).bind(this)
                                    success: ((result) ->
                                        @showtoast("Tải " + message + " thành công",1)
                                        @setState
                                            customer: null
                                            customerlist: result[0]
                                            ordermap: null
                                            ordermaplist: null
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                        return
                                    ).bind(this)
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
                                    switch @state.pmphase
                                        when 1
                                            switch record.code
                                                when 3
                                                    @setState pmphase: null
                                        when 2
                                            switch record.code
                                                when 3
                                                    @setState pmphase: null
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
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            console.log 1
                                        when 2
                                            console.log 2
                                        else
                                            switch record.code
                                                when 1 # create ordermap form
                                                    @setState
                                                        pmphase: 2
                                                        ordermap: null
                                                when 2
                                                    formData = new FormData
                                                    formData.append 'customer_id', @state.customer.id
                                                    formData.append 'id_station', @state.currentstation.station.id
                                                    message = "thông tin phiếu khám"
                                                    link = "/order_map/find"
                                                    $.ajax
                                                        url: link
                                                        type: 'POST'
                                                        data: formData
                                                        async: false
                                                        cache: false
                                                        contentType: false
                                                        processData: false
                                                        error: ((result) ->
                                                            @showtoast("Tải " + message + " thất bại",3)
                                                            return
                                                        ).bind(this)
                                                        success: ((result) ->
                                                            @showtoast("Tải " + message + " thành công",1)
                                                            if result.length > 0
                                                                @setState
                                                                    ordermaplist: result
                                                                    ordermap: null
                                                                $(APP).trigger('reloadData')
                                                            else
                                                                @showtoast("Không có " + message, 2)
                                                            return
                                                        ).bind(this)
                                                when 3
                                                    @setState pmphase: 1 #edit
                                                when 5
                                                    console.log 5
                                                when 6
                                                    @setState pmphase: 3 #edit ordermap
    triggerButtonAtpmtask: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                else
                                    switch record.code
                                        when 1#submit
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
                                        when 2#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Bệnh nhân'
                                                currentptaskview: 0
                                                currentpmtaskview: 0
                                                currentpmphase: 0
                                                customer: null
                                                ordermap: null                    
    triggerButtonAtpmphase: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            switch record.code
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
                                                when 2
                                                    @setState pmphase: null
                                        when 2
                                            switch record.code
                                                when 1#submit
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.station.id
                                                    formData.append 'status', $('#form_status').val()
                                                    formData.append 'remark', $('#form_remark').val()
                                                    formData.append 'customer_id', @state.customer.id
                                                    formData.append 'cname', @state.customer.cname
                                                    formData.append 'service_id', $('#form_s_id').val()
                                                    formData.append 'sername', $('#form_sname').val()
                                                    formData.append 'tpayment', $('#form_tpayment').val()
                                                    formData.append 'discount', $('#form_discount').val()
                                                    formData.append 'tpayout', $('#form_tpayout').val()
                                                    formData.append 'code', @generateRandom(5)
                                                    message = "thông tin phiếu khám"
                                                    link = "/order_map"
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
                                                            if @state.ordermaplist == null
                                                                arraynew = []
                                                                arraynew.push result
                                                                @setState
                                                                    ordermap: result
                                                                    ordermaplist: arraynew
                                                                    pmphase: null
                                                                setTimeout (->
                                                                    $(APP).trigger('reloadData')
                                                                ), 500
                                                            else
                                                                records = React.addons.update(@state.ordermaplist, { $unshift: [result] })
                                                                @setState
                                                                    ordermap: result
                                                                    ordermaplist: records
                                                                    pmphase: null
                                                                setTimeout (->
                                                                    $(APP).trigger('reloadData')
                                                                ), 500
                                                            return
                                                        ).bind(this)
                                                when 2#back
                                                    @setState pmphase: null
                                        else
                                            switch record.code
                                                when 1 # create ordermap form
                                                    @setState
                                                        pmphase: 2
                                                        ordermap: null
                                                when 2 #find list ordermap
                                                    formData = new FormData
                                                    formData.append 'customer_id', @state.customer.id
                                                    formData.append 'id_station', @state.currentstation.station.id
                                                    message = "thông tin phiếu khám"
                                                    link = "/order_map/find"
                                                    $.ajax
                                                        url: link
                                                        type: 'POST'
                                                        data: formData
                                                        async: false
                                                        cache: false
                                                        contentType: false
                                                        processData: false
                                                        error: ((result) ->
                                                            @showtoast("Tải " + message + " thất bại",3)
                                                            return
                                                        ).bind(this)
                                                        success: ((result) ->
                                                            @showtoast("Tải " + message + " thành công",1)
                                                            if result.length > 0
                                                                @setState
                                                                    ordermaplist: result
                                                                    ordermap: null
                                                                $(APP).trigger('reloadData')
                                                            else
                                                                @showtoast("Không có " + message, 2)
                                                            return
                                                        ).bind(this)
                                                when 3 # edit customer info
                                                    @setState pmphase: 1 #edit
                                                when 4 #del
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.station.id
                                                    formData.append 'id', @state.customer.id
                                                    message = "thông tin bệnh nhân"
                                                    link = "/customer_record"
                                                    $.ajax
                                                        url: link
                                                        type: 'DELETE'
                                                        data: formData
                                                        async: false
                                                        cache: false
                                                        contentType: false
                                                        processData: false
                                                        error: ((result) ->
                                                            @showtoast("Xóa " + message + " thất bại",3)
                                                            return
                                                        ).bind(this)
                                                        success: ((result) ->
                                                            @showtoast("Xóa " + message + " thành công",1)
                                                            @setState
                                                                ordermap: null
                                                                ordermaplist: null
                                                                pmphase: null
                                                                pmpm: null
                                                                customer: null
                                                                pmtask: null
                                                            return
                                                        ).bind(this)
                                                when 5#back
                                                    @setState
                                                        pmphase: null
                                                        customer: null
                                                        pmtask: null
                                                        ordermap: null
                                                        ordermaplist: null
                                                        pmpm: null
                                                when 6#view ordermap
                                                    @setState pmphase: 3 #edit ordermap                                            
    triggerButtonAtpmpm: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            console.log 1
                                        when 2
                                            console.log 2
                                        when 3
                                            if @state.ordermap != null
                                                switch @state.pmpm
                                                    when 1
                                                        switch record.code
                                                            when 1#luu
                                                                formData = new FormData
                                                                formData.append 'id_station', @state.currentstation.station.id
                                                                formData.append 'id', @state.ordermap.id
                                                                if $('#form_status').val() == 'Tình trạng'
                                                                    formData.append 'status', @state.ordermap.status
                                                                else
                                                                    formData.append 'status', $('#form_status').val()
                                                                formData.append 'remark', $('#form_remark').val()
                                                                formData.append 'customer_id', @state.customer.id
                                                                formData.append 'cname', @state.customer.cname
                                                                formData.append 'service_id', $('#form_s_id').val()
                                                                formData.append 'sername', $('#form_sname').val()
                                                                formData.append 'tpayment', $('#form_tpayment').val()
                                                                formData.append 'discount', $('#form_discount').val()
                                                                formData.append 'tpayout', $('#form_tpayout').val()
                                                                formData.append 'code', @generateRandom(5)
                                                                message = "thông tin phiếu khám"
                                                                link = "/order_map"
                                                                $.ajax
                                                                    url: link
                                                                    type: 'PUT'
                                                                    data: formData
                                                                    async: false
                                                                    cache: false
                                                                    contentType: false
                                                                    processData: false
                                                                    error: ((result) ->
                                                                        @showtoast("Thay đổi " + message + " thất bại",3)
                                                                        return
                                                                    ).bind(this)
                                                                    success: ((result) ->
                                                                        @showtoast("Thay đổi " + message + " thành công",1)
                                                                        for record in @state.ordermaplist
                                                                            if record.id == result.id
                                                                                index = @state.ordermaplist.indexOf record
                                                                                records = React.addons.update(@state.ordermaplist, { $splice: [[index, 1, result]] })
                                                                                @setState
                                                                                    ordermap: result
                                                                                    ordermaplist: records
                                                                                    pmphase: null
                                                                                    pmpm: null
                                                                                break
                                                                        setTimeout (->
                                                                            $(APP).trigger('reloadData')
                                                                        ), 500
                                                                        return
                                                                    ).bind(this)
                                                            when 2#back
                                                                @setState pmpm: null
                                                    else
                                                        switch record.code
                                                            when 1#edit
                                                                @setState pmpm: 1
                                                            when 2#xoa
                                                                formData = new FormData
                                                                formData.append 'id_station', @state.currentstation.station.id
                                                                formData.append 'id', @state.ordermap.id
                                                                message = "thông tin phiếu khám"
                                                                link = "/order_map"
                                                                $.ajax
                                                                    url: link
                                                                    type: 'DELETE'
                                                                    data: formData
                                                                    async: false
                                                                    cache: false
                                                                    contentType: false
                                                                    processData: false
                                                                    error: ((result) ->
                                                                        @showtoast("Xóa " + message + " thất bại",3)
                                                                        return
                                                                    ).bind(this)
                                                                    success: ((result) ->
                                                                        @showtoast("Xóa " + message + " thành công",1)
                                                                        if @state.ordermaplist.length == 1
                                                                            @setState
                                                                                ordermap: null
                                                                                ordermaplist: null
                                                                                pmphase: null
                                                                                pmpm: null
                                                                            setTimeout (->
                                                                                $(APP).trigger('reloadData')
                                                                            ), 500
                                                                        else
                                                                            index = @state.records.indexOf @state.ordermap
                                                                            records = React.addons.update(@state.ordermaplist, { $splice: [[index, 1]] })
                                                                            @setState
                                                                                ordermap: null
                                                                                ordermaplist: records
                                                                                pmphase: null
                                                                                pmpm: null
                                                                            setTimeout (->
                                                                                $(APP).trigger('reloadData')
                                                                            ), 500
                                                                        return
                                                                    ).bind(this)
                                                            when 3#back
                                                                @setState pmphase: null
                                        else
                                            console.log 'else'
    triggerRecord: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            console.log 1
                                        else
                                            @setState ordermap: record
    triggerAutoCompleteInputAlt: (code) ->
        if code == 'cname'
            if $('#form_cname').val().length > 3
                formData = new FormData
                formData.append 'cname', $('#form_cname').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/customer_record/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'ename'
            if $('#form_ename').val().length > 1
                formData = new FormData
                formData.append 'ename', $('#form_ename').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/employee/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'epname'
            if $('#form_epname').val().length > 1
                formData = new FormData
                formData.append 'ename', $('#form_epname').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/employee/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'sname'
            if $('#form_sname').val().length > 1
                formData = new FormData
                formData.append 'sname', $('#form_sname').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/service/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'pname'
            if $('#form_pname').val().length > 1
                formData = new FormData
                formData.append 'pname', $('#form_pname').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/position/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'rname'
            if $('#form_rname').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_rname').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/room/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'company'
            if $('#form_company').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_company').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/medicine_company/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'supplier'
            if $('#form_supplier').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_supplier').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/medicine_supplier/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'sample'
            if $('#form_sample').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_sample').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/medicine_sample/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'billcode'
            if $('#form_billcode').val().length > 1
                formData = new FormData
                formData.append 'billcode', $('#form_billcode').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/medicine_bill_in/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'sample_sell'
            if $('#form_sample').val().length > 1
                formData = new FormData
                formData.append 'name_sell', $('#form_sample').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/medicine_sample/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'script_ex'
            if $('#form_script_code').val().length > 1
                formData = new FormData
                formData.append 'code', $('#form_script_code').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/medicine_prescript_external/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'script_in'
            if $('#form_script_code').val().length > 1
                formData = new FormData
                formData.append 'code', $('#form_script_code').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.station.id
                $.ajax
                    url: '/medicine_prescript_internal/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)                       
    triggerAutoComplete: (record) ->
        if @state.code == 'cname'
            $('#form_cname').val(record.cname)
            $('#form_c_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'ename'
            $('#form_ename').val(record.ename)
            $('#form_e_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'epname'
            $('#form_epname').val(record.ename)
            $('#form_e_p_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'sname'
            $('#form_sname').val(record.sname)
            $('#form_tpayment').val(record.price)
            $('#form_tpayout').val(record.price)
            $('#form_s_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'pname'
            $('#form_pname').val(record.pname)
            $('#form_p_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'rname'
            $('#form_rname').val(record.name)
            $('#form_r_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'company'
            $('#form_company').val(record.name)
            $('#form_company_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'supplier'
            $('#form_supplier').val(record.name)
            $('#form_supplier_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'sample'
            $('#form_sample').val(record.name)
            $('#form_sample_id').val(record.id)
            $('#form_company').val(record.company)
            $('#form_company_id').val(record.company_id)
            $('#form_price').val(record.price)
            @setState autoComplete: null
        else if @state.code == 'sample_sell'
            $('#form_sample').val(record.name)
            $('#form_sample_id').val(record.id)
            $('#form_company').val(record.company)
            $('#form_company_id').val(record.company_id)
            $('#form_price').val(record.price)
            @setState autoComplete: null
        else if @state.code == 'billcode'
            $('#form_billcode').val(record.billcode)
            $('#form_billcode_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'script_ex'
            $('#form_script_code').val(record.code)
            $('#form_script_id').val(record.id)
            $('#form_c_id').val(record.customer_id)
            $('#form_cname').val(record.cname)
            @setState autoComplete: null
        else if @state.code == 'script_in'
            $('#form_script_code').val(record.code)
            $('#form_script_id').val(record.id)
            $('#form_c_id').val(record.customer_id)
            $('#form_cname').val(record.cname)
            @setState autoComplete: null
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
    triggerRecalPayment: (e) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 2
                                            if $('#form_tpayment').val() > 0
                                                if $('#form_discount').val() > 0
                                                    $('#form_discount_percent').val(Math.round(Number($('#form_discount').val())/Number($('#form_tpayment').val())*100))
                                                    $('#form_tpayout').val(Number($('#form_tpayment').val()) - Number($('#form_discount').val()))
                                                else
                                                    if $('#form_discount_percent').val() > 0
                                                        $('#form_discount').val(Math.round(Number($('#form_discount_percent').val()) * Number($('#form_tpayment').val()) / 100))
                                                        $('#form_tpayout').val(Number($('#form_tpayment').val()) - Number($('#form_discount').val()))
                                                    else
                                                        $('#form_tpayout').val(Number($('#form_tpayment').val()) - Number($('#form_discount').val()))
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
                                                                            when 1 #edit form customer record
                                                                                React.createElement StationContentApp, customer: @state.customer, datatype: 7, trigger: @triggerButtonAtpmphase
                                                                            when 2 # add ordermap form
                                                                                React.createElement StationContentApp, ordermap: null, customer: @state.customer, station: @state.currentstation.station, datatype: 5, trigger: @triggerButtonAtpmphase
                                                                            when 3 # vew form with 
                                                                                if @state.ordermap != null
                                                                                    switch @state.pmpm
                                                                                        when 1#edit form
                                                                                            React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, station: @state.currentstation.station, datatype: 5, trigger: @triggerButtonAtpmpm
                                                                                        else #view form
                                                                                            React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, className: 'col-md-12', datatype: 6, trigger: @triggerButtonAtpmpm
                                                                            else #customer view
                                                                                React.createElement StationContentApp, record: @state.customer, order: @state.ordermap, orderlist: @state.ordermaplist, datatype: 4, trigger: @triggerButtonAtpmphase, triggerRecord: @triggerRecord
                                                                    else#add customer form
                                                                        React.createElement StationContentApp, customer: null, datatype: 7, trigger: @triggerButtonAtpmtask
                                                                when 2#Chose to go customer list
                                                                    if @state.customerlist != null
                                                                        switch @state.pmphase
                                                                            when 1#add record
                                                                                console.log 1
                                                                            when 2#view record
                                                                                console.log 2
                                                                            else# view list
                                                                                console.log 3
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
        autoComplete: null
        code: null
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
    componentWillMount: ->
        $(APP).on 'reloadData', ((e) ->
            if @props.orderlist != null and @props.orderlist != undefined and @props.datatype == 4
                try
                    @setState
                        records: @props.orderlist
                        filteredRecord: null
                        record: null
                        lastsorted: null
                        viewperpage: 10
                        currentpage: 1
                        firstcount: 0
                        lastcount:
                            if @props.orderlist.length < 10
                                @props.orderlist.length
                            else
                                10
                catch error
                    console.log error
            else if @props.orderlist == null and @props.datatype == 4
                try
                    @setState
                        records: null
                        filteredRecord: null
                        record: null
                        lastsorted: null
                        viewperpage: 10
                        currentpage: 1
                        firstcount: 0
                        lastcount: 0
                catch error
                    console.log error
        ).bind(this)
    componentWillUnmount: ->
        $(APP).off 'reloadData'
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
    triggerRecordOut: (record) ->
        @props.triggerRecord record
    triggercode: (code) ->
        @props.trigger code
    trigger: ->
    triggersafe: ->
    triggerbutton: (e) ->
        @props.trigger e
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
    triggerAutoCompleteInputAlt: (code) ->
        if code == 'cname'
            if $('#form_cname').val().length > 3
                formData = new FormData
                formData.append 'cname', $('#form_cname').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/customer_record/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'ename'
            if $('#form_ename').val().length > 1
                formData = new FormData
                formData.append 'ename', $('#form_ename').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/employee/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'epname'
            if $('#form_epname').val().length > 1
                formData = new FormData
                formData.append 'ename', $('#form_epname').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/employee/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'sname'
            if $('#form_sname').val().length > 1
                formData = new FormData
                formData.append 'sname', $('#form_sname').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/service/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'pname'
            if $('#form_pname').val().length > 1
                formData = new FormData
                formData.append 'pname', $('#form_pname').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/position/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'rname'
            if $('#form_rname').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_rname').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/room/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'company'
            if $('#form_company').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_company').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/medicine_company/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'supplier'
            if $('#form_supplier').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_supplier').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/medicine_supplier/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'sample'
            if $('#form_sample').val().length > 1
                formData = new FormData
                formData.append 'name', $('#form_sample').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/medicine_sample/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'billcode'
            if $('#form_billcode').val().length > 1
                formData = new FormData
                formData.append 'billcode', $('#form_billcode').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/medicine_bill_in/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'sample_sell'
            if $('#form_sample').val().length > 1
                formData = new FormData
                formData.append 'name_sell', $('#form_sample').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/medicine_sample/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'script_ex'
            if $('#form_script_code').val().length > 1
                formData = new FormData
                formData.append 'code', $('#form_script_code').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/medicine_prescript_external/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)
        else if code == 'script_in'
            if $('#form_script_code').val().length > 1
                formData = new FormData
                formData.append 'code', $('#form_script_code').val().toLowerCase()
                formData.append 'id_station', @props.station.id
                $.ajax
                    url: '/medicine_prescript_internal/find'
                    type: 'POST'
                    data: formData
                    async: false
                    cache: false
                    contentType: false
                    processData: false
                    success: ((result) ->
                        @setState
                            autoComplete: result
                            code: code
                        return
                    ).bind(this)                       
    triggerAutoComplete: (record) ->
        if @state.code == 'cname'
            $('#form_cname').val(record.cname)
            $('#form_c_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'ename'
            $('#form_ename').val(record.ename)
            $('#form_e_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'epname'
            $('#form_epname').val(record.ename)
            $('#form_e_p_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'sname'
            $('#form_sname').val(record.sname)
            $('#form_tpayment').val(record.price)
            $('#form_tpayout').val(record.price)
            $('#form_s_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'pname'
            $('#form_pname').val(record.pname)
            $('#form_p_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'rname'
            $('#form_rname').val(record.name)
            $('#form_r_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'company'
            $('#form_company').val(record.name)
            $('#form_company_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'supplier'
            $('#form_supplier').val(record.name)
            $('#form_supplier_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'sample'
            $('#form_sample').val(record.name)
            $('#form_sample_id').val(record.id)
            $('#form_company').val(record.company)
            $('#form_company_id').val(record.company_id)
            $('#form_price').val(record.price)
            @setState autoComplete: null
        else if @state.code == 'sample_sell'
            $('#form_sample').val(record.name)
            $('#form_sample_id').val(record.id)
            $('#form_company').val(record.company)
            $('#form_company_id').val(record.company_id)
            $('#form_price').val(record.price)
            @setState autoComplete: null
        else if @state.code == 'billcode'
            $('#form_billcode').val(record.billcode)
            $('#form_billcode_id').val(record.id)
            @setState autoComplete: null
        else if @state.code == 'script_ex'
            $('#form_script_code').val(record.code)
            $('#form_script_id').val(record.id)
            $('#form_c_id').val(record.customer_id)
            $('#form_cname').val(record.cname)
            @setState autoComplete: null
        else if @state.code == 'script_in'
            $('#form_script_code').val(record.code)
            $('#form_script_id').val(record.id)
            $('#form_c_id').val(record.customer_id)
            $('#form_cname').val(record.cname)
            @setState autoComplete: null
    triggerRecalPayment: (e) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 2
                                            if $('#form_tpayment').val() > 0
                                                if $('#form_discount').val() > 0
                                                    $('#form_discount_percent').val(Math.round(Number($('#form_discount').val())/Number($('#form_tpayment').val())*100))
                                                    $('#form_tpayout').val(Number($('#form_tpayment').val()) - Number($('#form_discount').val()))
                                                else
                                                    if $('#form_discount_percent').val() > 0
                                                        $('#form_discount').val(Math.round(Number($('#form_discount_percent').val()) * Number($('#form_tpayment').val()) / 100))
                                                        $('#form_tpayout').val(Number($('#form_tpayment').val()) - Number($('#form_discount').val()))
                                                    else
                                                        $('#form_tpayout').val(Number($('#form_tpayment').val()) - Number($('#form_discount').val()))
    stationRender: ->
        if @props.hidden    
            React.DOM.div className: @props.className + ' hidden-xs',
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    #React.DOM.h4 null, @props.record.station.sname
                    #React.DOM.img alt: 'pic1', src: @props.record.station.logo , className: 'img-responsive'
                    React.DOM.h4 null, @props.record.sname
                    React.DOM.img alt: 'pic1', src: @props.record.logo , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        #React.DOM.p null, @props.record.station.address
                        #React.DOM.p null, @props.record.station.pnumber
                        #React.DOM.p null, @props.record.station.hpage
                        React.DOM.p null, @props.record.address
                        React.DOM.p null, @props.record.pnumber
                        React.DOM.p null, @props.record.hpage
        else
            React.DOM.div className: @props.className,
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    #React.DOM.h4 null, @props.record.station.sname
                    #React.DOM.img alt: 'pic1', src: @props.record.station.logo , className: 'img-responsive'
                    React.DOM.h4 null, @props.record.sname
                    React.DOM.img alt: 'pic1', src: @props.record.logo , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        #React.DOM.p null, @props.record.station.address
                        #React.DOM.p null, @props.record.station.pnumber
                        #React.DOM.p null, @props.record.station.hpage
                        React.DOM.p null, @props.record.address
                        React.DOM.p null, @props.record.pnumber
                        React.DOM.p null, @props.record.hpage
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
                            React.DOM.i className: 'fa fa-map', style: {'marginRight' : '10px'}
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
                if @state.records != null
                    React.DOM.div className: 'row hidden-xs', style:{'paddingRight':'35px','overflow': 'auto'},
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
                        React.DOM.table className: 'table table-hover table-condensed', style: {'backgroundColor':'#fff'},
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
                                        if @props.order != null
                                            if @props.order.id == record.id
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: true, selectRecord: @triggerRecordOut
                                            else
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: false, selectRecord: @triggerRecordOut
                                        else
                                            React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: false, selectRecord: @triggerRecordOut
                                else
                                    for record in @state.records[@state.firstcount...@state.lastcount]
                                        if @props.order != null
                                            if @props.order.id == record.id
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: true, selectRecord: @triggerRecordOut
                                            else
                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: false, selectRecord: @triggerRecordOut
                                        else
                                            React.createElement RecordGeneral, key: record.id, record: record, datatype: 'order_map', selected: false, selectRecord: @triggerRecordOut
                        React.DOM.div className: 'spacer10'
                        if @state.filteredRecord != null
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                        else
                            React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                    React.DOM.div className: 'spacer10'
                    React.DOM.div className: 'row',
                        if @props.order != null
                            React.createElement ButtonGeneral, className: 'btn btn-primary-docapp col-md-3 pull-right', icon: 'fa fa-eye', type: 3, text: ' Xem phiếu khám', code: {code: 6}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp col-md-3 pull-right', icon: 'zmdi zmdi-plus', type: 3, text: ' Tạo phiếu khám', code: {code: 1}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp col-md-3 pull-right', icon: 'zmdi zmdi-accounts-list', type: 3, text: ' Tải phiếu khám', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp col-md-3 pull-right', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa thông tin', code: {code: 3}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về ', code: {code: 5}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa bệnh nhân', code: {code: 4}, Clicked: @triggercode                       
    editCustomerForm: ->
        if @props.customer != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-7',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Họ và Tên'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Họ và tên', defaultValue: @props.customer.cname
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Ngày sinh'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_dob', type: 'text', className: 'form-control', placeholder: '31/01/1990', defaultValue:
                                        try
                                            @props.customer.dob.substring(8, 10) + "/" + @props.customer.dob.substring(5, 7) + "/" + @props.customer.dob.substring(0, 4)
                                        catch error
                                            ""
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Địa chỉ'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ', defaultValue: @props.customer.address
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Số ĐT'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_pnumber', type: 'number', className: 'form-control', placeholder: 'Số ĐT', defaultValue: @props.customer.pnumber
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'CMTND'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_noid', type: 'number', className: 'form-control', placeholder: 'Số CMTND', defaultValue: @props.customer.noid
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Ngày cấp'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_issue_date', type: 'text', className: 'form-control', placeholder: '31/01/2016', defaultValue:
                                        try
                                            @props.customer.issue_date.substring(8, 10) + "/" + @props.customer.issue_date.substring(5, 7) + "/" + @props.customer.issue_date.substring(0, 4)
                                        catch error
                                            ""
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Nơi cấp'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_issue_place', type: 'text', className: 'form-control', placeholder: 'Nơi cấp', defaultValue: @props.customer.issue_place
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Nơi làm việc'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_work_place', type: 'text', className: 'form-control', placeholder: 'Nơi làm việc', defaultValue: @props.customer.work_place
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử bệnh bản thân'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.textarea id: 'form_self_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh bản thân', defaultValue: @props.customer.self_history
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử bệnh gia đình'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.textarea id: 'form_family_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử bệnh gia đình', defaultValue: @props.customer.family_history
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-4 hidden-xs control-label', 'Tiền sử dị ứng thuốc'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.textarea id: 'form_drug_history', type: 'text', className: 'form-control', placeholder: 'Tiền sử dị ứng thuốc', defaultValue: @props.customer.drug_history
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-3 hidden-xs control-label', 'Giới tính'
                                React.DOM.div className: 'col-sm-3',
                                    switch @props.customer.gender
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
                                React.DOM.img id: 'sample_avatar', style: {'maxWidth': '100%', 'maxHeight': '240px'}, src: @props.customer.avatar
                            React.DOM.div id: 'my_camera'
                            React.DOM.div className: 'spacer20'
                            React.DOM.button type: 'button', className: 'btn btn-secondary-docapp', onClick: @setup_webcam, 'Khởi tạo'
                            React.DOM.button type: 'button', className: 'btn btn-primary-docapp', value: 'take Large Snapshot', onClick: @take_snapshot, 'Chụp'
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
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
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    editOrderMapForm: ->
        if @props.customer != null and @props.ordermap != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.div className: 'spacer20'
                        React.DOM.form className: 'form-horizontal content-app-alt', style: {'paddingLeft': '40px', 'paddingRight': '40px'}, autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tình trạng hóa đơn dịch vụ'
                                React.DOM.div className: 'col-sm-8',
                                    React.createElement SelectBox, id: 'form_status', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Chưa thanh toán, chưa khám bệnh'},{id: 2, name: 'Đã thanh toán, đang chờ khám'},{id: 3, name: 'Đã thanh toán, đã khám bệnh'},{id: 4, name: 'Chưa thanh toán, đã khám bệnh'}], text: 'Tình trạng'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên dịch vụ'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_s_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'sid', defaultValue: @props.ordermap.service_id
                                    React.createElement InputField, id: 'form_sname', className: 'form-control', type: 'text', code: 'sname', placeholder: 'Tên dịch vụ', style: '', defaultValue: @props.ordermap.sername, trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete", id: "sname_autocomplete",
                                        if @state.autoComplete != null and @state.code == 'sname'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'service_mini', header: [{id: 1,name: "Tên dịch vụ"},{id: 2, name: "Giá"},{id: 3, name: "Đơn vị"}], trigger: @triggerAutoComplete
                            React.DOM.div className: 'form-group',
                                React.DOM.div className: 'col-md-8',
                                    React.DOM.label className: 'col-sm-4 control-label hidden-xs', 'Ghi chú'
                                    React.DOM.div className: 'col-sm-8',
                                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue: @props.ordermap.remark
                                React.DOM.div className: 'col-md-4',
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng giá trị'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_tpayment', className: 'form-control', type: 'number', placeholder: 'Tổng giá trị', defaultValue: @props.ordermap.tpayment, trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggersafe
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Giảm giá'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_discount', className: 'form-control', type: 'number', placeholder: 'Giảm giá', defaultValue: @props.ordermap.discount, trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', '% Giảm giá'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_discount_percent', className: 'form-control', type: 'number', step: 'any', placeholder: '% Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng thanh toán'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_tpayout', className: 'form-control', type: 'number', placeholder: 'Tổng thanh toán', defaultValue: @props.ordermap.tpayout, trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                        React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                            React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else if @props.customer != null and @props.ordermap == null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.div className: 'spacer20'
                        React.DOM.form className: 'form-horizontal content-app-alt', style: {'paddingLeft': '40px', 'paddingRight': '40px'}, autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tình trạng hóa đơn dịch vụ'
                                React.DOM.div className: 'col-sm-8',
                                    React.createElement SelectBox, id: 'form_status', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Chưa thanh toán, chưa khám bệnh'},{id: 2, name: 'Đã thanh toán, đang chờ khám'},{id: 3, name: 'Đã thanh toán, đã khám bệnh'},{id: 4, name: 'Chưa thanh toán, đã khám bệnh'}], text: 'Tình trạng'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên dịch vụ'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_s_id', className: 'form-control', type: 'text', style: {'display': 'none'}, placeholder: 'sid'
                                    React.createElement InputField, id: 'form_sname', className: 'form-control', type: 'text', code: 'sname', placeholder: 'Tên dịch vụ', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete", id: "sname_autocomplete",
                                        if @state.autoComplete != null and @state.code == 'sname'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'service_mini', header: [{id: 1,name: "Tên dịch vụ"},{id: 2, name: "Giá"},{id: 3, name: "Đơn vị"}], trigger: @triggerAutoComplete
                            React.DOM.div className: 'form-group',
                                React.DOM.div className: 'col-md-8',
                                    React.DOM.label className: 'col-sm-4 control-label hidden-xs', 'Ghi chú'
                                    React.DOM.div className: 'col-sm-8',
                                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                                React.DOM.div className: 'col-md-4',
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng giá trị'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_tpayment', className: 'form-control', type: 'number', placeholder: 'Tổng giá trị', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggersafe
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Giảm giá'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_discount', className: 'form-control', type: 'number', placeholder: 'Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', '% Giảm giá'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_discount_percent', className: 'form-control', type: 'number', step: 'any', placeholder: '% Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng thanh toán'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_tpayout', className: 'form-control', type: 'number', placeholder: 'Tổng thanh toán', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                        React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                            React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewOrderMap: ->
        if @props.customer != null and @props.ordermap != null
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-4',
                    React.DOM.div className: 'content-app-alt',
                        React.DOM.h4 style: {'color': '#fff'}, @props.customer.cname
                        React.DOM.img alt: 'pic1', src: @props.customer.avatar , className: 'img-responsive'
                        React.DOM.div className: 'content-info-block',
                            React.DOM.p null,
                                React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                try
                                    @props.customer.dob.substring(8, 10) + "/" + @props.customer.dob.substring(5, 7) + "/" + @props.customer.dob.substring(0, 4)
                                catch error
                                    console.log error
                            React.DOM.p null,
                                React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                try
                                    @calAge(@props.customer.dob,2).years + " Tuổi " + @calAge(@props.customer.dob,2).months + "Tháng"
                                catch error
                                    console.log error
                            React.DOM.p null,
                                React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                switch @props.customer.gender
                                    when 1
                                        "Nam"
                                    when 2
                                        "Nữ"
                                    else
                                        "Chưa định"
                            React.DOM.p null,
                                React.DOM.i className: 'fa fa-map', style: {'marginRight' : '10px'}
                                @props.customer.address
                            React.DOM.p null,
                                React.DOM.i className: 'fa fa-barcode', style: {'marginRight' : '10px'}
                                @props.customer.noid
                            React.DOM.p null,
                                React.DOM.i className: 'fa fa-phone', style: {'marginRight' : '10px'}
                                @props.customer.pnumber
                React.DOM.div className: 'col-md-8',
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'content-app-alt',
                            React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số khám bệnh'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.ordermap.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã bệnh án'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.ordermap.code
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Dịch vụ đăng ký'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.ordermap.sername
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Ghi chú'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.ordermap.remark
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Thanh toán'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.ordermap.tpayout
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tình trạng'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null,
                                            switch @props.ordermap.status
                                                when 1
                                                    'Chưa thanh toán, chưa khám bệnh'
                                                when 2
                                                    'Đã thanh toán, đang chờ khám'
                                                when 3
                                                    'Đã thanh toán, đã khám bệnh'
                                                when 4
                                                    'Chưa thanh toán, đã khám bệnh'
                    React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'row',
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
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
            when 5
                @editOrderMapForm()
            when 6
                @viewOrderMap()
            when 7
                @editCustomerForm()
                
                

@StationRollMenu = React.createClass
    getInitialState: ->
        style: 1
        curentview: 0
    getData: ->
        dataSet = []
        switch @props.datatype
            when 1#station list
                for record in @props.record
                    dataSet.push record.station
        return dataSet
    moveup: ->
        dataSet = @getData
        newview = @state.curentview + 1
        try
            if newview >= dataSet.length
                newview = newview - dataSet.length
        catch error
            console.log error
        @setState curentview: newview
    movedown: ->
        dataSet = @getData
        newview = @state.curentview - 1
        try
            if newview < 0
                newview = dataSet.length - 1
        catch error
            console.log error
        @setState curentview: newview
    triggerCode: (record) ->
        @props.trigger record
    normalRender: ->
        dataSet = @getData()
        switch dataSet.length
            when 0
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-sm-12',
                        React.DOM.div className: 'content-app', style: {'display':'table', 'color': '#fff', 'width': '100%'},
                            React.DOM.p style: {'display': 'table-cell', 'verticalAlign': 'middle', 'textAlign': 'center'}, "Không có mục lựa chọn nào"
            when 1
                React.DOM.div className: 'row',
                    React.createElement StationContentApp, datatype: 1, record: dataSet[0], className: 'col-sm-12 animated fadeIn', hidden: false, trigger: @triggerCode
            when 2
                count = 0
                i = @state.curentview - 1
                React.DOM.div className: 'row',    
                    while count < 2
                        count = count + 1
                        i = i + 1
                        if i >= dataSet.length
                            i = i - dataSet.length
                        if i == @state.curentview
                            React.createElement StationContentApp, key: dataSet[i].id, datatype: 1, record: dataSet[i], className: 'col-sm-6 animated fadeIn', hidden: false, trigger: @triggerCode
                        else
                            React.createElement StationContentApp, key: dataSet[i].id, datatype: 1, record: dataSet[i], className: 'col-sm-6 animated fadeIn', hidden: true, trigger: @triggerCode
                    React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedown,
                        React.DOM.i className: 'zmdi zmdi-chevron-left'
                    React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveup,
                        React.DOM.i className: 'zmdi zmdi-chevron-right'
            when 3
                count = 0
                i = @state.curentview - 1
                React.DOM.div className: 'row',
                    while count < 3
                        count = count + 1
                        i = i + 1
                        if i >= dataSet.length
                            i = i - dataSet.length
                        if i == @state.curentview
                            React.createElement StationContentApp, key: dataSet[i].id, datatype: 1, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerCode
                        else
                            React.createElement StationContentApp, key: dataSet[i].id, datatype: 1, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerCode
                    React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedown,
                        React.DOM.i className: 'zmdi zmdi-chevron-left'
                    React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveup,
                        React.DOM.i className: 'zmdi zmdi-chevron-right'
            else
                count = 0
                i = @state.curentview - 1
                React.DOM.div className: 'row',    
                    while count < 3
                        count = count + 1
                        i = i + 1
                        if i >= dataSet.length
                            i = i - dataSet.length
                        if i == @state.curentview
                            React.createElement StationContentApp, key: dataSet[i].id, datatype: 1, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerCode
                        else
                            React.createElement StationContentApp, key: dataSet[i].id, datatype: 1, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerCode
                    React.DOM.div className: 'side-left-button', onClick: @movedown,
                        React.DOM.i className: 'zmdi zmdi-chevron-left'
                    React.DOM.div className: 'side-right-button', onClick: @moveup,
                        React.DOM.i className: 'zmdi zmdi-chevron-right'
    render: ->
        switch @props.datatype
            when 1
                @normalRander()