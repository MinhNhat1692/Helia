@DoctorMainApp = React.createClass
    getInitialState: ->
        task: 2
        stationlist: null
        currentstation: null
        permissionlist: null
        currentpermission: null
        ptask: null
        pmtask: null
        pmphase: null
        pmpm: 0
        
        customer: null
        ordermap: null
        customerlist: null
        ordermaplist: null
        recordChild: []
        recordChildSelect: null
        
        sample: null
        company: null
        supplier: null
        price: null
        billin: null
        prescript: null
        stockrecord: null
        
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
        medicineTask: [{id:1, name: 'Mẫu thuốc', icon: '/assets/pill.png', text: 'Quản lý danh mục thuốc của cơ sở y tế', code: 1},{id: 2, name: 'Doanh nghiệp', icon: '/assets/medicine.png', text: 'Danh sách các doanh nghiệp sản xuất các loại thuốc có trong danh mục thuốc của cơ sở y tế', code: 2}, {id: 3, name: 'Nguồn',icon: '/assets/medicine2.png', text: 'Danh mục nguồn cung cấp thuốc và các thông tin cần thiết', code: 3},{id: 4, name: 'Giá thuốc',icon: '/assets/tag.png', text: 'Danh mục giá của từng loại thuốc trong cơ sở y tế', code: 4},{id: 5, name: 'Hóa đơn nhập thuốc',icon: '/assets/receipt.png', text: 'Danh mục hóa đơn và thuốc được nhập', code: 5},{id: 6, name: 'Đơn thuốc',icon: '/assets/invoice.png', text: 'Danh mục đơn thuốc có sử dụng trong cơ sở y tế', code: 6},{id: 7, name: 'Thống kê kho',icon: '/assets/factory-stock-house.png', text: 'Danh mục thống kê thuốc trong kho', code: 7}, {id: 8, name: 'Quay lại',icon: '/assets/back_icon.png', text: 'Trở lại màn hình chọn', code: 8}]
        customerRecordMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm bệnh nhân vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách bệnh nhân trong ngày', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        orderMapMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm yêu cầu khám', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách yêu cầu khám trong ngày', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        medicineSampleMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm thuốc vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách thuốc', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        medicineCompanyMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm doanh nghiệp sản xuất thuốc vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách doanh nghiệp sản xuất thuốc', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        medicineSupplierMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm nguồn cung cấp thuốc vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách nguồn cấp thuốc', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        medicinePriceMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm giá bán thuốc vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách giá bán thuốc', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        medicineBillInMinorTask: [{id: 1, name: 'Thêm', icon: '/assets/add_icon.png', text: 'Thêm hóa đơn nhập thuốc vào danh sách', code: 1},{id: 2, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách hóa đơn nhập thuốc', code: 2},{id: 3, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        medicinePrescriptMinorTask: [{id: 1, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách đơn thuốc', code: 2},{id: 2, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        medicineStockRecordMinorTask: [{id: 1, name: 'Danh sách', icon: '/assets/verification-of-delivery-list-clipboard-symbol.png', text: 'Xem tổng hợp danh sách thuốc còn trong kho', code: 2},{id: 2, name: 'Back',icon: '/assets/back_icon.png', text: 'Quay lại menu trước', code: 3}]
        backupState: null
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
            if permiss.station_id == station.id
                permissionarray.push permiss
        @setState
            currentstation: station
            permissionlist: permissionarray
    selectPermission: (permission) ->
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
                    ).bind(this)
            when 2
                @setState
                    task: 2
                    tabheader: "Cài đặt"
                    currentsidebarmenu: 2
            when 3
                window.location.href = "/logout"
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
                                    customer: null
                                    ordermap: null
                            when 2
                                formData = new FormData
                                formData.append 'id_station', @state.currentstation.id
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
                            when 3
                                @setState ptask: null
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
                                                    formData.append 'id_station', @state.currentstation.id
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
    triggerButtonAtFirst: (record) ->
        switch @state.currentpermission.table_id
            when 1#customer record and ordermap
                switch record.code
                    when 1
                        @setState
                            ptask: 1
                            tabheader: 'Bệnh nhân'
                            customer: null
                            ordermap: null
                    when 2
                        @setState
                            ptask: 2
                            tabheader: 'Phiếu khám'
                            customer: null
                            ordermap: null
                    when 3
                        @setState
                            currentpermission: null
            when 2#medicine
                switch @state.ptask
                    when 1
                        console.log 1
                    else
                        switch record.code
                            when 1
                                @setState
                                    ptask: 1
                                    tabheader: 'Mẫu thuốc'
                                    sample: null
                            when 2
                                @setState
                                    ptask: 2
                                    tabheader: 'Doanh nghiệp SX'
                                    company: null
                            when 3
                                @setState
                                    ptask: 3
                                    tabheader: 'Nguồn'
                                    supplier: null
                            when 4
                                @setState
                                    ptask: 4
                                    tabheader: 'Biểu giá'
                                    price: null
                            when 5
                                @setState
                                    ptask: 5
                                    tabheader: 'Hóa đơn nhập'
                                    billin: null
                            when 6
                                @setState
                                    ptask: 6
                                    tabheader: 'Đơn thuốc xuất'
                                    prescript: null
                            when 7
                                @setState
                                    ptask: 7
                                    tabheader: 'Kho thuốc'
                                    stockrecord: null
                            else
                                @setState
                                    currentpermission: null
    triggerButtonAtptask: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1#customer record
                        switch record.code
                            when 1    
                                @setState
                                    pmtask: 1
                                    tabheader: 'Bệnh nhân'
                                    customer: null
                                    ordermap: null
                            when 2
                                @setState
                                    pmtask: 2
                                    pmphase: null
                                    pmpm: null
                                setTimeout (->
                                    $(APP).trigger('reloadData')
                                ), 500
                            when 3
                                @setState ptask: null
                    when 2#order map
                        switch record.code
                            when 1#add ordermap
                                @setState
                                    pmtask: 1
                                    tabheader: 'Yêu cầu'
                                    customer: null
                                    ordermap: null
                            when 2#list ordermap
                                @setState
                                    pmtask: 2
                                    pmphase: null
                                    pmpm: null
                                setTimeout (->
                                    $(APP).trigger('reloadData')
                                ), 500
                            when 3#back
                                @setState ptask: null
    triggerButtonAtpmtask: (record) ->
        switch @state.currentpermission.table_id
            when 1
                switch @state.ptask
                    when 1#customer
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                else
                                    switch record.code
                                        when 1#submit
                                            formData = new FormData
                                            formData.append 'id_station', @state.currentstation.id
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
                                                customer: null
                                                ordermap: null
                            when 2
                                if @state.customer != null
                                    console.log 1
                                else
                                    switch record.code
                                        when 3#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Bệnh nhân'
                                                customer: null
                                                ordermap: null
                                                backupState: null
                    when 2#ordermap
                        switch @state.pmtask
                            when 1#add ordermap    
                                if @state.ordermap != null#added
                                else#not add yet
                                    switch record.code
                                        when 1#submit
                                            formData = new FormData
                                            formData.append 'id_station', @state.currentstation.id
                                            formData.append 'status', $('#form_status').val()
                                            formData.append 'remark', $('#form_remark').val()
                                            formData.append 'customer_id', $('#form_c_id').val()
                                            formData.append 'cname', $('#form_cname').val()
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
                                                    @setState ordermap: result
                                                    return
                                                ).bind(this)
                                        when 2#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Phiếu khám'
                                                customer: null
                                                ordermap: null
                            when 2#list ordermap
                                switch record.code
                                    when 2
                                        console.log 2
                                    when 3
                                        @setState
                                            pmtask: null
                                            tabheader: 'Phiếu khám'
                                            customer: null
                                            ordermap: null
                                            backupState: null
                                if @state.customer != null
                                    console.log 1
                                else
                                    switch record.code
                                        when 3#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Bệnh nhân'
                                                customer: null
                                                ordermap: null
                                                backupState: null
    triggerButtonAtpmphase: (record) ->
        switch @state.currentpermission.table_id
            when 1#customer record and ordermap
                switch @state.ptask
                    when 1#customer record
                        switch @state.pmtask
                            when 1#add customer record
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            switch record.code
                                                when 1
                                                    formData = new FormData
                                                    formData.append 'id', @state.customer.id
                                                    formData.append 'gender', $('#form_gender').val()
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                                setTimeout (->
                                                                    $(APP).trigger('reloadData')
                                                                ), 500
                                                            else
                                                                @showtoast("Không có " + message, 2)
                                                            return
                                                        ).bind(this)
                                                when 3 # edit customer info
                                                    @setState pmphase: 1 #edit
                                                when 4 #del
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                when 5 #back
                                                    @setState
                                                        pmphase: null
                                                        customer: null
                                                        pmtask: null
                                                        ordermap: null
                                                        ordermaplist: null
                                                        pmpm: null
                                                when 6 #view ordermap
                                                    @setState pmphase: 3 #edit ordermap                                            
                            when 2#customer record list view
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1#edit customer info
                                            switch record.code
                                                when 1#save info
                                                    formData = new FormData
                                                    formData.append 'id', @state.customer.id
                                                    formData.append 'gender', $('#form_gender').val()
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                when 2#back
                                                    @setState pmphase: null
                                        when 2#create ordermap
                                            switch record.code
                                                when 1#submit
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
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
                                        else# view to see which one to change
                                            switch record.code
                                                when 1 # create ordermap form
                                                    @setState
                                                        pmphase: 2
                                                        ordermap: null
                                                when 2 #find list ordermap
                                                    formData = new FormData
                                                    formData.append 'customer_id', @state.customer.id
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                                setTimeout (->
                                                                    $(APP).trigger('reloadData')
                                                                ), 500
                                                            else
                                                                @showtoast("Không có " + message, 2)
                                                            return
                                                        ).bind(this)
                                                when 3 # edit customer info
                                                    @setState pmphase: 1 #edit
                                                when 4 #del
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                            setTimeout (->
                                                                $(APP).trigger('reloadData')
                                                            ), 500
                                                            return
                                                        ).bind(this)
                                                when 5 #back
                                                    @setState
                                                        pmphase: null
                                                        customer: null
                                                        ordermap: null
                                                        ordermaplist: null
                                                        pmpm: null
                                                    setTimeout (->
                                                        $(APP).trigger('reloadData')
                                                    ), 500
                                                when 6 #view ordermap
                                                    @setState pmphase: 3 #edit ordermap
                    when 2#ordermap
                        switch @state.pmtask
                            when 1#add ordermap
                                if @state.ordermap != null #added
                                    switch @state.pmphase
                                        when 1#edit form
                                            switch record.code
                                                when 1#luu
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.ordermap.id
                                                    if $('#form_status').val() == 'Tình trạng'
                                                        formData.append 'status', @state.ordermap.status
                                                    else
                                                        formData.append 'status', $('#form_status').val()
                                                    formData.append 'remark', $('#form_remark').val()
                                                    formData.append 'customer_id', $('#form_c_id').val()
                                                    formData.append 'cname', $('#form_cname').val()
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
                                                            @setState
                                                                ordermap: result
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 2#back
                                                    @setState pmphase: null
                                        else#view form
                                            switch record.code
                                                when 1#edit
                                                    @setState pmphase: 1
                                                when 2#xoa
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
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
                                                            @setState
                                                                ordermap: null
                                                                pmtask: null
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 3#back
                                                    @setState
                                                        pmtask: null
                                                        ordermap: null
                            when 2#listordermap
                                switch @state.pmphase
                                    when 1#ordermap view
                                        switch @state.pmpm
                                            when 1#edit form
                                                switch record.code
                                                    when 1#luu
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
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
                                                                stateBackup = @state.backupState
                                                                for recordlife in stateBackup.records
                                                                    if recordlife.id == result.id
                                                                        index = stateBackup.records.indexOf recordlife
                                                                        records = React.addons.update(stateBackup.records, { $splice: [[index, 1, result]] })
                                                                        break
                                                                stateBackup.records = records
                                                                stateBackup.record = result
                                                                @setState
                                                                    backupState: stateBackup
                                                                    ordermap: result
                                                                    pmpm: null
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
                                                        formData.append 'id_station', @state.currentstation.id
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
                                                                if @state.backupState.records.length == 1
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = null
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        ordermap: null
                                                                        ordermaplist: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                else
                                                                    index = @state.backupState.records.indexOf @state.ordermap
                                                                    records = React.addons.update(@state.backupState.records, { $splice: [[index, 1]] })
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = records
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        ordermap: null
                                                                        ordermaplist: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                return
                                                            ).bind(this)
                                                    when 3#back
                                                        @setState
                                                            customer: null
                                                            pmphase: null
                                                        setTimeout (->
                                                            $(APP).trigger('reloadData')
                                                        ), 500
                                        
                                    else#ordermap list view
                                        switch record.code
                                            when 2#view
                                                formData = new FormData
                                                formData.append 'id', @state.ordermap.customer_record_id
                                                formData.append 'id_station', @state.currentstation.id
                                                link = "/customer_record/find"
                                                $.ajax
                                                    url: link
                                                    type: 'POST'
                                                    data: formData
                                                    async: false
                                                    cache: false
                                                    contentType: false
                                                    processData: false
                                                    success: ((result) ->
                                                        if result.length > 0
                                                            @setState
                                                                customer: result[0]
                                                                pmphase: 1
                                                        return
                                                    ).bind(this)
                                            when 3#back
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Bệnh nhân'
                                                    customer: null
                                                    ordermap: null
                                                    backupState: null                              
            when 2# medicine
                switch @state.ptask
                    when 1#sample
                        switch @state.pmtask
                            when 1#add sample
                                if @state.sample != null
                                    switch @state.pmphase
                                        when 1#edit form
                                            switch record.code
                                                when 1#luu
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.sample.id
                                                    if $('#form_typemedicine').val() == 'Loại thuốc'
                                                        formData.append 'typemedicine', @state.sample.typemedicine
                                                    else
                                                        formData.append 'typemedicine', $('#form_typemedicine').val()
                                                    if $('#form_groupmedicine').val() == 'Nhóm thuốc'
                                                        formData.append 'groupmedicine', @state.sample.groupmedicine
                                                    else
                                                        formData.append 'groupmedicine', $('#form_groupmedicine').val()
                                                    formData.append 'noid', $('#form_noid').val()
                                                    formData.append 'name', $('#form_name').val()
                                                    formData.append 'company_id', $('#form_company_id').val()
                                                    formData.append 'company', $('#form_company').val()
                                                    formData.append 'price', $('#form_price').val()
                                                    formData.append 'weight', $('#form_weight').val()
                                                    formData.append 'remark', $('#form_remark').val()
                                                    formData.append 'expire', $('#form_expire').val()
                                                    message = "thông tin mẫu thuốc"
                                                    link = "/medicine_sample"
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
                                                            @setState
                                                                sample: result
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 2#back
                                                    @setState pmphase: null
                                        else#view form
                                            switch record.code
                                                when 1#edit
                                                    @setState pmphase: 1
                                                when 2#xoa
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.sample.id
                                                    message = "thông tin mẫu thuốc"
                                                    link = "/medicine_sample"
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
                                                                sample: null
                                                                pmtask: null
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 3#back
                                                    @setState
                                                        pmtask: null
                                                        sample: null
                                else
                                    switch record.code
                                        when 1#save
                                            formData = new FormData
                                            formData.append 'id_station', @state.currentstation.id
                                            formData.append 'typemedicine', $('#form_typemedicine').val()
                                            formData.append 'groupmedicine', $('#form_groupmedicine').val()
                                            formData.append 'noid', $('#form_noid').val()
                                            formData.append 'name', $('#form_name').val()
                                            formData.append 'company_id', $('#form_company_id').val()
                                            formData.append 'company', $('#form_company').val()
                                            formData.append 'price', $('#form_price').val()
                                            formData.append 'weight', $('#form_weight').val()
                                            formData.append 'remark', $('#form_remark').val()
                                            formData.append 'expire', $('#form_expire').val()
                                            message = "thông tin mẫu thuốc"
                                            link = "/medicine_sample"
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
                                                    @setState sample: result
                                                    return
                                                ).bind(this)
                                        when 2#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Mẫu thuốc'
                                                sample: null
                            when 2#sample list
                                switch @state.pmphase
                                    when 1#view mode
                                        switch @state.pmpm
                                            when 1#editmode
                                                switch record.code
                                                    when 1#luu
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.sample.id
                                                        if $('#form_typemedicine').val() == 'Loại thuốc'
                                                            formData.append 'typemedicine', @state.sample.typemedicine
                                                        else
                                                            formData.append 'typemedicine', $('#form_typemedicine').val()
                                                        if $('#form_groupmedicine').val() == 'Nhóm thuốc'
                                                            formData.append 'groupmedicine', @state.sample.groupmedicine
                                                        else
                                                            formData.append 'groupmedicine', $('#form_groupmedicine').val()
                                                        formData.append 'noid', $('#form_noid').val()
                                                        formData.append 'name', $('#form_name').val()
                                                        formData.append 'company_id', $('#form_company_id').val()
                                                        formData.append 'company', $('#form_company').val()
                                                        formData.append 'price', $('#form_price').val()
                                                        formData.append 'weight', $('#form_weight').val()
                                                        formData.append 'remark', $('#form_remark').val()
                                                        formData.append 'expire', $('#form_expire').val()
                                                        message = "thông tin mẫu thuốc"
                                                        link = "/medicine_sample"
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
                                                                stateBackup = @state.backupState
                                                                for recordlife in stateBackup.records
                                                                    if recordlife.id == result.id
                                                                        index = stateBackup.records.indexOf recordlife
                                                                        records = React.addons.update(stateBackup.records, { $splice: [[index, 1, result]] })
                                                                        break
                                                                stateBackup.records = records
                                                                stateBackup.record = result
                                                                @setState
                                                                    backupState: stateBackup
                                                                    sample: result
                                                                    pmpm: null
                                                                return
                                                            ).bind(this)
                                                    when 2#back
                                                        @setState pmpm: null
                                            else#view mode
                                                switch record.code
                                                    when 1#edit
                                                        @setState pmpm: 1
                                                    when 2#xoa
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.sample.id
                                                        message = "thông tin mẫu thuốc"
                                                        link = "/medicine_sample"
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
                                                                if @state.backupState.records.length == 1
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = null
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        sample: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                else
                                                                    index = @state.backupState.records.indexOf @state.sample
                                                                    records = React.addons.update(@state.backupState.records, { $splice: [[index, 1]] })
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = records
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        sample: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                return
                                                            ).bind(this)
                                                    when 3#back
                                                        @setState
                                                            sample: null
                                                            pmphase: null
                                                        setTimeout (->
                                                            $(APP).trigger('reloadData')
                                                        ), 500
                                    else#list view
                                        switch record.code
                                            when 2
                                                @setState
                                                    pmphase: 1
                                            when 3
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Mẫu thuốc'
                                                    sample: null
                                                    backupState: null
                            else#menu to chose
                                switch record.code
                                    when 1#add
                                        @setState
                                            pmtask: 1
                                            tabheader: 'Mẫu thuốc'
                                            sample: null
                                    when 2#list
                                        @setState
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                    else#back
                                        @setState ptask: null
                    when 2#company
                        switch @state.pmtask
                            when 1#add company
                                if @state.company != null
                                    switch @state.pmphase
                                        when 1#edit form
                                            switch record.code
                                                when 1#luu
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.company.id
                                                    formData.append 'noid', $('#form_noid').val()
                                                    formData.append 'name', $('#form_name').val()
                                                    formData.append 'pnumber', $('#form_pnumber').val()
                                                    formData.append 'address', $('#form_address').val()
                                                    formData.append 'email', $('#form_email').val()
                                                    formData.append 'website', $('#form_website').val()
                                                    formData.append 'taxcode', $('#form_taxcode').val()
                                                    message = "thông tin doanh nghiệp SX"
                                                    link = "/medicine_company"
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
                                                            @setState
                                                                company: result
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 2#back
                                                    @setState pmphase: null
                                        else#view form
                                            switch record.code
                                                when 1#edit
                                                    @setState pmphase: 1
                                                when 2#xoa
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.company.id
                                                    message = "thông tin doanh nghiệp SX"
                                                    link = "/medicine_company"
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
                                                                company: null
                                                                pmtask: null
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 3#back
                                                    @setState
                                                        pmtask: null
                                                        company: null
                                else
                                    switch record.code
                                        when 1#save
                                            formData = new FormData
                                            formData.append 'id_station', @state.currentstation.id
                                            formData.append 'noid', $('#form_noid').val()
                                            formData.append 'name', $('#form_name').val()
                                            formData.append 'pnumber', $('#form_pnumber').val()
                                            formData.append 'address', $('#form_address').val()
                                            formData.append 'email', $('#form_email').val()
                                            formData.append 'website', $('#form_website').val()
                                            formData.append 'taxcode', $('#form_taxcode').val()
                                            message = "thông tin doanh nghiệp SX"
                                            link = "/medicine_company"
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
                                                    @setState company: result
                                                    return
                                                ).bind(this)
                                        when 2#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Doanh nghiệp SX'
                                                company: null
                            when 2#company list
                                switch @state.pmphase
                                    when 1#view mode
                                        switch @state.pmpm
                                            when 1#editmode
                                                switch record.code
                                                    when 1#luu
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.company.id
                                                        formData.append 'noid', $('#form_noid').val()
                                                        formData.append 'name', $('#form_name').val()
                                                        formData.append 'pnumber', $('#form_pnumber').val()
                                                        formData.append 'address', $('#form_address').val()
                                                        formData.append 'email', $('#form_email').val()
                                                        formData.append 'website', $('#form_website').val()
                                                        formData.append 'taxcode', $('#form_taxcode').val()
                                                        message = "thông tin doanh nghiệp SX"
                                                        link = "/medicine_company"
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
                                                                stateBackup = @state.backupState
                                                                for recordlife in stateBackup.records
                                                                    if recordlife.id == result.id
                                                                        index = stateBackup.records.indexOf recordlife
                                                                        records = React.addons.update(stateBackup.records, { $splice: [[index, 1, result]] })
                                                                        break
                                                                stateBackup.records = records
                                                                stateBackup.record = result
                                                                @setState
                                                                    backupState: stateBackup
                                                                    company: result
                                                                    pmpm: null
                                                                return
                                                            ).bind(this)
                                                    when 2#back
                                                        @setState pmpm: null
                                            else#view mode
                                                switch record.code
                                                    when 1#edit
                                                        @setState pmpm: 1
                                                    when 2#xoa
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.company.id
                                                        message = "thông tin doanh nghiệp SX"
                                                        link = "/medicine_company"
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
                                                                if @state.backupState.records.length == 1
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = null
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        company: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                else
                                                                    index = @state.backupState.records.indexOf @state.company
                                                                    records = React.addons.update(@state.backupState.records, { $splice: [[index, 1]] })
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = records
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        company: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                return
                                                            ).bind(this)
                                                    when 3#back
                                                        @setState
                                                            company: null
                                                            pmphase: null
                                                        setTimeout (->
                                                            $(APP).trigger('reloadData')
                                                        ), 500
                                    else#list view
                                        switch record.code
                                            when 2
                                                @setState
                                                    pmphase: 1
                                            when 3
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Doanh nghiệp SX'
                                                    company: null
                                                    backupState: null
                            else#menu to chose
                                switch record.code
                                    when 1#add
                                        @setState
                                            pmtask: 1
                                            tabheader: 'Doanh nghiệp SX'
                                            company: null
                                    when 2#list
                                        @setState
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                    else#back
                                        @setState ptask: null
                    when 3#supplier
                        switch @state.pmtask
                            when 1#add supplier
                                if @state.supplier != null
                                    switch @state.pmphase
                                        when 1#edit form
                                            switch record.code
                                                when 1#luu
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.supplier.id
                                                    formData.append 'noid', $('#form_noid').val()
                                                    formData.append 'name', $('#form_name').val()
                                                    formData.append 'contactname', $('#form_contact_name').val()
                                                    formData.append 'spnumber', $('#form_spnumber').val()
                                                    formData.append 'pnumber', $('#form_pnumber').val()
                                                    formData.append 'address1', $('#form_address1').val()
                                                    formData.append 'address2', $('#form_address2').val()
                                                    formData.append 'address3', $('#form_address3').val()
                                                    formData.append 'email', $('#form_email').val()
                                                    formData.append 'facebook', $('#form_facebook').val()
                                                    formData.append 'twitter', $('#form_twitter').val()
                                                    formData.append 'fax', $('#form_fax').val()
                                                    formData.append 'taxcode', $('#form_taxcode').val()
                                                    message = "thông tin nguồn cung cấp"
                                                    link = "/medicine_supplier"
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
                                                            @setState
                                                                supplier: result
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 2#back
                                                    @setState pmphase: null
                                        else#view form
                                            switch record.code
                                                when 1#edit
                                                    @setState pmphase: 1
                                                when 2#xoa
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.supplier.id
                                                    message = "thông tin nguồn cung cấp"
                                                    link = "/medicine_supplier"
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
                                                                supplier: null
                                                                pmtask: null
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 3#back
                                                    @setState
                                                        pmtask: null
                                                        supplier: null
                                else
                                    switch record.code
                                        when 1#save
                                            formData = new FormData
                                            formData.append 'id_station', @state.currentstation.id
                                            formData.append 'noid', $('#form_noid').val()
                                            formData.append 'name', $('#form_name').val()
                                            formData.append 'contactname', $('#form_contact_name').val()
                                            formData.append 'spnumber', $('#form_spnumber').val()
                                            formData.append 'pnumber', $('#form_pnumber').val()
                                            formData.append 'address1', $('#form_address1').val()
                                            formData.append 'address2', $('#form_address2').val()
                                            formData.append 'address3', $('#form_address3').val()
                                            formData.append 'email', $('#form_email').val()
                                            formData.append 'facebook', $('#form_facebook').val()
                                            formData.append 'twitter', $('#form_twitter').val()
                                            formData.append 'fax', $('#form_fax').val()
                                            formData.append 'taxcode', $('#form_taxcode').val()
                                            message = "thông tin nguồn cung cấp"
                                            link = "/medicine_supplier"
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
                                                    @setState supplier: result
                                                    return
                                                ).bind(this)
                                        when 2#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Nguồn cung cấp'
                                                supplier: null
                            when 2#supplier list
                                switch @state.pmphase
                                    when 1#view mode
                                        switch @state.pmpm
                                            when 1#editmode
                                                switch record.code
                                                    when 1#luu
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.supplier.id
                                                        formData.append 'noid', $('#form_noid').val()
                                                        formData.append 'name', $('#form_name').val()
                                                        formData.append 'contactname', $('#form_contact_name').val()
                                                        formData.append 'spnumber', $('#form_spnumber').val()
                                                        formData.append 'pnumber', $('#form_pnumber').val()
                                                        formData.append 'address1', $('#form_address1').val()
                                                        formData.append 'address2', $('#form_address2').val()
                                                        formData.append 'address3', $('#form_address3').val()
                                                        formData.append 'email', $('#form_email').val()
                                                        formData.append 'facebook', $('#form_facebook').val()
                                                        formData.append 'twitter', $('#form_twitter').val()
                                                        formData.append 'fax', $('#form_fax').val()
                                                        formData.append 'taxcode', $('#form_taxcode').val()
                                                        message = "thông tin nguồn cung cấp"
                                                        link = "/medicine_supplier"
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
                                                                stateBackup = @state.backupState
                                                                for recordlife in stateBackup.records
                                                                    if recordlife.id == result.id
                                                                        index = stateBackup.records.indexOf recordlife
                                                                        records = React.addons.update(stateBackup.records, { $splice: [[index, 1, result]] })
                                                                        break
                                                                stateBackup.records = records
                                                                stateBackup.record = result
                                                                @setState
                                                                    backupState: stateBackup
                                                                    supplier: result
                                                                    pmpm: null
                                                                return
                                                            ).bind(this)
                                                    when 2#back
                                                        @setState pmpm: null
                                            else#view mode
                                                switch record.code
                                                    when 1#edit
                                                        @setState pmpm: 1
                                                    when 2#xoa
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.supplier.id
                                                        message = "thông tin nguồn cung cấp"
                                                        link = "/medicine_supplier"
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
                                                                if @state.backupState.records.length == 1
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = null
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        supplier: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                else
                                                                    index = @state.backupState.records.indexOf @state.supplier
                                                                    records = React.addons.update(@state.backupState.records, { $splice: [[index, 1]] })
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = records
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        supplier: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                return
                                                            ).bind(this)
                                                    when 3#back
                                                        @setState
                                                            supplier: null
                                                            pmphase: null
                                                        setTimeout (->
                                                            $(APP).trigger('reloadData')
                                                        ), 500
                                    else#list view
                                        switch record.code
                                            when 2
                                                @setState
                                                    pmphase: 1
                                            when 3
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Nguồn cung cấp'
                                                    supplier: null
                                                    backupState: null
                            else#menu to chose
                                switch record.code
                                    when 1#add
                                        @setState
                                            pmtask: 1
                                            tabheader: 'Nguồn cung cấp'
                                            supplier: null
                                    when 2#list
                                        @setState
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                    else#back
                                        @setState ptask: null    
                    when 4#price
                        switch @state.pmtask
                            when 1#add price
                                if @state.price != null
                                    switch @state.pmphase
                                        when 1#edit form
                                            switch record.code
                                                when 1#luu
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.price.id
                                                    formData.append 'sample_id', $('#form_sample_id').val()
                                                    formData.append 'name', $('#form_sample').val()
                                                    formData.append 'minam', $('#form_minam').val()
                                                    formData.append 'price', $('#form_price').val()
                                                    formData.append 'remark', $('#form_remark').val()
                                                    message = "thông tin giá"
                                                    link = "/medicine_price"
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
                                                            @setState
                                                                price: result
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 2#back
                                                    @setState pmphase: null
                                        else#view form
                                            switch record.code
                                                when 1#edit
                                                    @setState pmphase: 1
                                                when 2#xoa
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.price.id
                                                    message = "thông tin giá"
                                                    link = "/medicine_price"
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
                                                                price: null
                                                                pmtask: null
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 3#back
                                                    @setState
                                                        pmtask: null
                                                        price: null
                                else
                                    switch record.code
                                        when 1#save
                                            formData = new FormData
                                            formData.append 'id_station', @state.currentstation.id
                                            formData.append 'sample_id', $('#form_sample_id').val()
                                            formData.append 'name', $('#form_sample').val()
                                            formData.append 'minam', $('#form_minam').val()
                                            formData.append 'price', $('#form_price').val()
                                            formData.append 'remark', $('#form_remark').val()
                                            message = "thông tin giá"
                                            link = "/medicine_price"
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
                                                    @setState price: result
                                                    return
                                                ).bind(this)
                                        when 2#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Giá'
                                                price: null
                            when 2#price list
                                switch @state.pmphase
                                    when 1#view mode
                                        switch @state.pmpm
                                            when 1#editmode
                                                switch record.code
                                                    when 1#luu
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.price.id
                                                        formData.append 'sample_id', $('#form_sample_id').val()
                                                        formData.append 'name', $('#form_sample').val()
                                                        formData.append 'minam', $('#form_minam').val()
                                                        formData.append 'price', $('#form_price').val()
                                                        formData.append 'remark', $('#form_remark').val()
                                                        message = "thông tin giá"
                                                        link = "/medicine_price"
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
                                                                stateBackup = @state.backupState
                                                                for recordlife in stateBackup.records
                                                                    if recordlife.id == result.id
                                                                        index = stateBackup.records.indexOf recordlife
                                                                        records = React.addons.update(stateBackup.records, { $splice: [[index, 1, result]] })
                                                                        break
                                                                stateBackup.records = records
                                                                stateBackup.record = result
                                                                @setState
                                                                    backupState: stateBackup
                                                                    price: result
                                                                    pmpm: null
                                                                return
                                                            ).bind(this)
                                                    when 2#back
                                                        @setState pmpm: null
                                            else#view mode
                                                switch record.code
                                                    when 1#edit
                                                        @setState pmpm: 1
                                                    when 2#xoa
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.price.id
                                                        message = "thông tin giá"
                                                        link = "/medicine_price"
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
                                                                if @state.backupState.records.length == 1
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = null
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        price: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                else
                                                                    index = @state.backupState.records.indexOf @state.price
                                                                    records = React.addons.update(@state.backupState.records, { $splice: [[index, 1]] })
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = records
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        price: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                return
                                                            ).bind(this)
                                                    when 3#back
                                                        @setState
                                                            price: null
                                                            pmphase: null
                                                        setTimeout (->
                                                            $(APP).trigger('reloadData')
                                                        ), 500
                                    else#list view
                                        switch record.code
                                            when 2
                                                @setState
                                                    pmphase: 1
                                            when 3
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Giá'
                                                    price: null
                                                    backupState: null
                            else#menu to chose
                                switch record.code
                                    when 1#add
                                        @setState
                                            pmtask: 1
                                            tabheader: 'Giá'
                                            price: null
                                    when 2#list
                                        @setState
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                    else#back
                                        @setState ptask: null
                    when 5#billin
                        switch @state.pmtask
                            when 1#add billin
                                if @state.billin != null
                                    switch @state.pmphase
                                        when 1#edit form
                                            switch record.code
                                                when 1#luu
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.billin.id
                                                    if $('#bill_in_form #form_pmethod').val() == "Cách thanh toán"
                                                        formData.append 'pmethod', @state.billin.pmethod
                                                    else
                                                        formData.append 'pmethod', $('#bill_in_form #form_pmethod').val()
                                                    if $('#bill_in_form #form_status').val() == "Tình trạng hóa đơn"
                                                        formData.append 'status', @state.billin.status
                                                    else
                                                        formData.append 'status', $('#bill_in_form #form_status').val()
                                                    formData.append 'billcode', $('#bill_in_form #form_billcode').val()
                                                    formData.append 'supplier_id', $('#bill_in_form #form_supplier_id').val()
                                                    formData.append 'supplier', $('#bill_in_form #form_supplier').val()
                                                    formData.append 'dayin', $('#bill_in_form #form_dayin').val()
                                                    formData.append 'daybook', $('#bill_in_form #form_daybook').val()
                                                    formData.append 'tpayment', $('#bill_in_form #form_tpayment').val()
                                                    formData.append 'discount', $('#bill_in_form #form_discount').val()
                                                    formData.append 'tpayout', $('#bill_in_form #form_tpayout').val()
                                                    formData.append 'remark', $('#bill_in_form #form_remark').val()
                                                    formData.append 'list_bill_record', JSON.stringify(@state.recordChild)
                                                    message = "thông tin hóa đơn nhập thuốc"
                                                    link = "/medicine_bill_in"
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
                                                            recordChild = @state.recordChild
                                                            for recordlife in recordChild
                                                                if recordlife.created_at == undefined
                                                                    index = recordChild.indexOf recordlife
                                                                    recordlife["created_at"] = "12"
                                                                    recordChild = React.addons.update(recordChild, { $splice: [[index, 1, recordlife]] })
                                                            @setState
                                                                billin: result
                                                                recordChild: recordChild
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 2#back
                                                    @setState pmphase: null
                                                when 3#trigger delete selected record (still in fake list but we need a fomal here for sample)
                                                    if @state.recordChildSelect != null
                                                        if @state.recordChildSelect.created_at != undefined#have created at -> delete from DB
                                                            formData = new FormData
                                                            formData.append 'id_station', @state.currentstation.id
                                                            formData.append 'id', @state.recordChildSelect.id
                                                            message = "thông tin thuốc nhập"
                                                            link = "/medicine_bill_record"
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
                                                                    @triggerDeleteRecordChild @state.recordChildSelect
                                                                    return
                                                                ).bind(this)
                                                        else#delete in fake list only
                                                            @triggerDeleteRecordChild @state.recordChildSelect
                                                    else
                                                        @showtoast("Bạn phải chọn đối tượng cần xóa",3)
                                                when 4#trigger load list childRecord
                                                    if @props.billin != null
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'bill_id', @state.billin.id
                                                        message = "thông tin thuốc nhập"
                                                        link = "/medicine_bill_record/find"
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
                                                                @setState recordChild: result
                                                                return
                                                            ).bind(this)
                                                    else
                                                        @showtoast("Hiện tại không có hóa đơn được lựa chọn",3)
                                        else#view form
                                            switch record.code
                                                when 1#edit
                                                    @setState pmphase: 1
                                                when 2#xoa
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.billin.id
                                                    message = "thông tin hóa đơn nhập thuốc"
                                                    link = "/medicine_bill_in"
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
                                                                billin: null
                                                                recordChild: []
                                                                recordChildSelect: null
                                                                pmtask: null
                                                                pmphase: null
                                                                pmpm: null
                                                            return
                                                        ).bind(this)
                                                when 3#back
                                                    @setState
                                                        pmtask: null
                                                        billin: null
                                                        recordChild: []
                                                        recordChildSelect: null
                                else
                                    switch record.code
                                        when 1#save
                                            formData = new FormData
                                            formData.append 'id_station', @state.currentstation.id
                                            formData.append 'pmethod', $('#bill_in_form #form_pmethod').val()
                                            formData.append 'status', $('#bill_in_form #form_status').val()
                                            formData.append 'billcode', $('#bill_in_form #form_billcode').val()
                                            formData.append 'supplier_id', $('#bill_in_form #form_supplier_id').val()
                                            formData.append 'supplier', $('#bill_in_form #form_supplier').val()
                                            formData.append 'dayin', $('#bill_in_form #form_dayin').val()
                                            formData.append 'daybook', $('#bill_in_form #form_daybook').val()
                                            formData.append 'tpayment', $('#bill_in_form #form_tpayment').val()
                                            formData.append 'discount', $('#bill_in_form #form_discount').val()
                                            formData.append 'tpayout', $('#bill_in_form #form_tpayout').val()
                                            formData.append 'remark', $('#bill_in_form #form_remark').val()
                                            formData.append 'list_bill_record', JSON.stringify(@state.recordChild)
                                            message = "thông tin hóa đơn nhập thuốc"
                                            link = "/medicine_bill_in"
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
                                                    recordChild = @state.recordChild
                                                    for recordlife in recordChild
                                                        if recordlife.created_at == undefined
                                                            index = recordChild.indexOf recordlife
                                                            recordlife["created_at"] = "12"
                                                            recordChild = React.addons.update(recordChild, { $splice: [[index, 1, recordlife]] })
                                                    @setState
                                                        billin: result
                                                        recordChild: recordChild
                                                    return
                                                ).bind(this)
                                        when 2#back
                                            @setState
                                                pmtask: null
                                                tabheader: 'Hóa đơn nhập thuốc'
                                                billin: null
                                                recordChild: []
                                                recordChildSelect: null
                                        when 3#trigger delete selected record (still in fake list but we need a fomal here for sample)
                                            if @state.recordChildSelect != null
                                                if @state.recordChildSelect.created_at != undefined#have created at -> delete from DB
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'id', @state.recordChildSelect.id
                                                    message = "thông tin thuốc nhập"
                                                    link = "/medicine_bill_record"
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
                                                            @triggerDeleteRecordChild @state.recordChildSelect
                                                            return
                                                        ).bind(this)
                                                else#delete in fake list only
                                                    @triggerDeleteRecordChild @state.recordChildSelect
                                            else
                                                @showtoast("Bạn phải chọn đối tượng cần xóa",3)
                                        when 4#trigger load list childRecord
                                            if @props.billin != null
                                                formData = new FormData
                                                formData.append 'id_station', @state.currentstation.id
                                                formData.append 'bill_id', @state.billin.id
                                                message = "thông tin thuốc nhập"
                                                link = "/medicine_bill_record/find"
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
                                                        @setState recordChild: result
                                                        return
                                                    ).bind(this)
                                            else
                                                @showtoast("Hiện tại không có hóa đơn được lựa chọn",3)
                            when 2#billin list
                                switch @state.pmphase
                                    when 1#view mode
                                        switch @state.pmpm
                                            when 1#editmode
                                                switch record.code
                                                    when 1#luu
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.billin.id
                                                        if $('#bill_in_form #form_pmethod').val() == "Cách thanh toán"
                                                            formData.append 'pmethod', @state.billin.pmethod
                                                        else
                                                            formData.append 'pmethod', $('#bill_in_form #form_pmethod').val()
                                                        if $('#bill_in_form #form_status').val() == "Tình trạng hóa đơn"
                                                            formData.append 'status', @state.billin.status
                                                        else
                                                            formData.append 'status', $('#bill_in_form #form_status').val()
                                                        formData.append 'billcode', $('#bill_in_form #form_billcode').val()
                                                        formData.append 'supplier_id', $('#bill_in_form #form_supplier_id').val()
                                                        formData.append 'supplier', $('#bill_in_form #form_supplier').val()
                                                        formData.append 'dayin', $('#bill_in_form #form_dayin').val()
                                                        formData.append 'daybook', $('#bill_in_form #form_daybook').val()
                                                        formData.append 'tpayment', $('#bill_in_form #form_tpayment').val()
                                                        formData.append 'discount', $('#bill_in_form #form_discount').val()
                                                        formData.append 'tpayout', $('#bill_in_form #form_tpayout').val()
                                                        formData.append 'remark', $('#bill_in_form #form_remark').val()
                                                        formData.append 'list_bill_record', JSON.stringify(@state.recordChild)
                                                        message = "thông tin hóa đơn nhập thuốc"
                                                        link = "/medicine_bill_in"
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
                                                                stateBackup = @state.backupState
                                                                for recordlife in stateBackup.records
                                                                    if recordlife.id == result.id
                                                                        index = stateBackup.records.indexOf recordlife
                                                                        records = React.addons.update(stateBackup.records, { $splice: [[index, 1, result]] })
                                                                        break
                                                                stateBackup.records = records
                                                                stateBackup.record = result
                                                                recordChild = @state.recordChild
                                                                for recordlife in recordChild
                                                                    if recordlife.created_at == undefined
                                                                        index = recordChild.indexOf recordlife
                                                                        recordlife["created_at"] = "12"
                                                                        recordChild = React.addons.update(recordChild, { $splice: [[index, 1, recordlife]] })
                                                                @setState
                                                                    backupState: stateBackup
                                                                    recordChild: recordChild
                                                                    billin: result
                                                                    pmpm: null
                                                                return
                                                            ).bind(this)
                                                    when 2#back
                                                        @setState pmpm: null
                                                    when 3#trigger delete selected record (still in fake list but we need a fomal here for sample)
                                                        if @state.recordChildSelect != null
                                                            if @state.recordChildSelect.created_at != undefined#have created at -> delete from DB
                                                                formData = new FormData
                                                                formData.append 'id_station', @state.currentstation.id
                                                                formData.append 'id', @state.recordChildSelect.id
                                                                message = "thông tin thuốc nhập"
                                                                link = "/medicine_bill_record"
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
                                                                        @triggerDeleteRecordChild @state.recordChildSelect
                                                                        return
                                                                    ).bind(this)
                                                            else#delete in fake list only
                                                                @triggerDeleteRecordChild @state.recordChildSelect
                                                        else
                                                            @showtoast("Bạn phải chọn đối tượng cần xóa",3)
                                                    when 4#trigger load list childRecord
                                                        if @props.billin != null
                                                            formData = new FormData
                                                            formData.append 'id_station', @state.currentstation.id
                                                            formData.append 'bill_id', @state.billin.id
                                                            message = "thông tin thuốc nhập"
                                                            link = "/medicine_bill_record/find"
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
                                                                    @setState recordChild: result
                                                                    return
                                                                ).bind(this)
                                                        else
                                                            @showtoast("Hiện tại không có hóa đơn được lựa chọn",3)   
                                            else#view mode
                                                switch record.code
                                                    when 1#edit
                                                        @setState pmpm: 1
                                                    when 2#xoa
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.billin.id
                                                        message = "thông tin hóa đơn nhập thuốc"
                                                        link = "/medicine_bill_in"
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
                                                                if @state.backupState.records.length == 1
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = null
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        billin: null
                                                                        recordChild: []
                                                                        recordChildSelect: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                else
                                                                    index = @state.backupState.records.indexOf @state.billin
                                                                    records = React.addons.update(@state.backupState.records, { $splice: [[index, 1]] })
                                                                    stateBackup = @state.backupState
                                                                    stateBackup.records = records
                                                                    stateBackup.record = null
                                                                    @setState
                                                                        backupState: stateBackup
                                                                        billin: null
                                                                        recordChild: []
                                                                        recordChildSelect: null
                                                                        pmphase: null
                                                                        pmpm: null
                                                                    setTimeout (->
                                                                        $(APP).trigger('reloadData')
                                                                    ), 500
                                                                return
                                                            ).bind(this)
                                                    when 3#back
                                                        @setState
                                                            billin: null
                                                            recordChild: []
                                                            recordChildSelect: null
                                                            pmphase: null
                                                        setTimeout (->
                                                            $(APP).trigger('reloadData')
                                                        ), 500
                                    else#list view
                                        switch record.code
                                            when 2#move to view
                                                @setState
                                                    pmphase: 1
                                                if @props.billin != null
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'bill_id', @state.billin.id
                                                    message = "thông tin thuốc nhập"
                                                    link = "/medicine_bill_record/find"
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
                                                            @setState recordChild: result
                                                            return
                                                        ).bind(this)
                                            when 3#back
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Hóa đơn nhập thuốc'
                                                    billin: null
                                                    backupState: null
                            else#menu to chose
                                switch record.code
                                    when 1#add
                                        @setState
                                            pmtask: 1
                                            tabheader: 'Hóa đơn nhập thuốc'
                                            billin: null
                                            recordChild: []
                                            recordChildSelect: null
                                    when 2#list
                                        @setState
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                    else#back
                                        @setState ptask: null      
                    when 6#prescript
                        switch @state.pmtask
                            when 2#prescript list
                                switch @state.pmphase
                                    when 1#view mode
                                        switch @state.pmpm
                                            when 1#editmode
                                                switch record.code
                                                    when 1#luu
                                                        formData = new FormData
                                                        formData.append 'id_station', @state.currentstation.id
                                                        formData.append 'id', @state.prescript.id
                                                        formData.append 'prep', 1#mean preparer update -> gonna search for that employee name in list any auto fillin
                                                        if $('#prescript_form #form_pmethod').val() == "Cách thanh toán"
                                                            formData.append 'pmethod', @state.prescript.pmethod
                                                        else
                                                            formData.append 'pmethod', $('#bill_in_form #form_pmethod').val()
                                                        formData.append 'remark', $('#prescript_form #form_remark').val()
                                                        formData.append 'payer', $('#prescript_form #form_payer').val()
                                                        formData.append 'tpayment', $('#prescript_form #form_tpayment').val()
                                                        formData.append 'discount', $('#prescript_form #form_discount').val()
                                                        formData.append 'tpayout', $('#prescript_form #form_tpayout').val()
                                                        formData.append 'list_internal_record', JSON.stringify(@state.recordChild)
                                                        message = "thông tin đơn thuốc"
                                                        link = "/medicine_prescript_internal"
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
                                                                stateBackup = @state.backupState
                                                                for recordlife in stateBackup.records
                                                                    if recordlife.id == result.id
                                                                        index = stateBackup.records.indexOf recordlife
                                                                        records = React.addons.update(stateBackup.records, { $splice: [[index, 1, result]] })
                                                                        break
                                                                stateBackup.records = records
                                                                stateBackup.record = result
                                                                @setState
                                                                    backupState: stateBackup
                                                                    prescript: result
                                                                    pmpm: null
                                                                return
                                                            ).bind(this)
                                                    when 2#back
                                                        @setState pmpm: null
                                                    when 4#trigger load list childRecord
                                                        if @props.prescript != null
                                                            formData = new FormData
                                                            formData.append 'id_station', @state.currentstation.id
                                                            formData.append 'script_id', @state.prescript.id
                                                            message = "thông tin thuốc trong đơn"
                                                            link = "/medicine_internal_record/find"
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
                                                                    @setState recordChild: result
                                                                    return
                                                                ).bind(this)
                                                        else
                                                            @showtoast("Hiện tại không có đơn thuốc được lựa chọn",3)   
                                                    when 5#move to internal record edit
                                                        @setState pmpm: 2
                                            when 2#internalrecord edit
                                                switch record.code
                                                    when 1#save
                                                        tmp = @state.recordChildSelect
                                                        tmp.noid = $('#form_noid').val()
                                                        tmp.signid = $('#form_signid').val()
                                                        tmp.amount = $('#form_amount').val()
                                                        tmp.price = $('#form_price').val()
                                                        tmp.tpayment = $('#form_tpayment').val()
                                                        if $('#form_status').val() != "Tình trạng"
                                                            tmp.status = $('#form_status').val()
                                                        tmp.remark = $('#form_remark').val()
                                                        recordChild = @state.recordChild
                                                        for recordlife in recordChild
                                                            if recordlife.id == tmp.id
                                                                index = recordChild.indexOf recordlife
                                                                recordChild = React.addons.update(recordChild, { $splice: [[index, 1, tmp]] })
                                                                break
                                                        @setState
                                                            recordChildSelect: tmp
                                                            recordChild: recordChild
                                                            pmpm: 1
                                                    when 2#back
                                                        @setState pmpm: 1
                                            else#view mode
                                                switch record.code
                                                    when 1#edit
                                                        @setState pmpm: 1
                                                    when 3#back
                                                        @setState
                                                            prescript: null
                                                            recordChild: []
                                                            recordChildSelect: null
                                                            pmphase: null
                                                        setTimeout (->
                                                            $(APP).trigger('reloadData')
                                                        ), 500
                                    else#list view
                                        switch record.code
                                            when 2#move to view
                                                @setState
                                                    pmphase: 1
                                                if @props.prescript != null
                                                    formData = new FormData
                                                    formData.append 'id_station', @state.currentstation.id
                                                    formData.append 'script_id', @state.prescript.id
                                                    message = "thông tin thuốc trong đơn"
                                                    link = "/medicine_internal_record/find"
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
                                                            @setState recordChild: result
                                                            return
                                                        ).bind(this)
                                            when 3#back
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Đơn thuốc'
                                                    prescript: null
                                                    backupState: null
                            else#menu to chose
                                switch record.code
                                    when 1#add
                                        @setState
                                            pmtask: 1
                                            tabheader: 'Đơn thuốc'
                                            prescript: null
                                            recordChild: []
                                            recordChildSelect: null
                                    when 2#list
                                        @setState
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                    else#back
                                        @setState ptask: null     
                    when 7#stockrecord
                        switch @state.pmtask
                            when 2#stockrecord list
                                switch @state.pmphase
                                    when 1#view mode
                                        switch record.code
                                            when 3#back
                                                @setState
                                                    stockrecord: null
                                                    recordChild: []
                                                    recordChildSelect: null
                                                    pmphase: null
                                                setTimeout (->
                                                    $(APP).trigger('reloadData')
                                                ), 500
                                    else#list view
                                        switch record.code
                                            when 2#move to view
                                                if @props.stockrecord != null
                                                    @setState
                                                        pmphase: 1
                                                    setTimeout (->
                                                        $(APP).trigger('reloadData')
                                                    ), 500
                                            when 3#back
                                                @setState
                                                    pmtask: null
                                                    tabheader: 'Kho thuốc'
                                                    stockrecord: null
                                                    backupState: null
                            else#menu to chose
                                switch record.code
                                    when 1#add
                                        @setState
                                            pmtask: 1
                                            tabheader: 'Kho thuốc'
                                            stockrecord: null
                                            recordChild: []
                                            recordChildSelect: null
                                    when 2#list
                                        @setState
                                            pmtask: 2
                                            pmphase: null
                                            pmpm: null
                                        setTimeout (->
                                            $(APP).trigger('reloadData')
                                        ), 500
                                    else#back
                                        @setState ptask: null
    triggerButtonAtpmpm: (record) ->
        switch @state.currentpermission.table_id
            when 1#customer record and ordermap
                switch @state.ptask
                    when 1#customer Record
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
                                                                formData.append 'id_station', @state.currentstation.id
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
                                                                formData.append 'id_station', @state.currentstation.id
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
                                                                            index = @state.ordermaplist.indexOf @state.ordermap
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
                            when 2
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
                                                                formData.append 'id_station', @state.currentstation.id
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
                                                                formData.append 'id_station', @state.currentstation.id
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
                                                                            index = @state.ordermaplist.indexOf @state.ordermap
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
            when 1#customer record and ordermap
                switch @state.ptask
                    when 1#customer record
                        switch @state.pmtask
                            when 1    
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            console.log 1
                                        else
                                            @setState ordermap: record
                            when 2
                                if @state.customer != null
                                    switch @state.pmphase
                                        when 1
                                            console.log 1
                                        else
                                            @setState ordermap: record
                                else
                                    @setState customer: record
                                    setTimeout (->
                                        $(APP).trigger('reloadData')
                                    ), 500
                    when 2#ordermap
                        switch @state.pmtask
                            when 1
                                console.log 1
                            when 2
                                switch @state.pmphase
                                    when 1
                                        console.log 1
                                    else
                                        @setState ordermap: record
                            else
                                console.log 3
            when 2#medicine
                switch @state.ptask
                    when 1#medicine sample
                        switch @state.pmtask
                            when 2#list view
                                switch @state.pmphase
                                    when 1
                                        console.log 1
                                    else
                                        @setState sample: record
                    when 2#medicine company
                        switch @state.pmtask
                            when 2#list view
                                switch @state.pmphase
                                    when 1
                                        console.log 1
                                    else
                                        @setState company: record
                    when 3#medicine supplier
                        switch @state.pmtask
                            when 2#list view
                                switch @state.pmphase
                                    when 1
                                        console.log 1
                                    else
                                        @setState supplier: record
                    when 4#medicine price
                        switch @state.pmtask
                            when 2#list view
                                switch @state.pmphase
                                    when 1
                                        console.log 1
                                    else
                                        @setState price: record
                    when 5#medicine billin
                        switch @state.pmtask
                            when 2#list view
                                switch @state.pmphase
                                    when 1
                                        console.log 1
                                    else
                                        @setState billin: record
                    when 6#medicine prescript
                        switch @state.pmtask
                            when 2#list view
                                switch @state.pmphase
                                    when 1
                                        console.log 1
                                    else
                                        @setState prescript: record
                    when 7#medicine stockrecord
                        switch @state.pmtask
                            when 2#list view
                                switch @state.pmphase
                                    when 1
                                        @setState recordChildSelect: record
                                    else
                                        @setState stockrecord: record
    
    triggerRecordChild: (record) ->
        records = React.addons.update(@state.recordChild, { $push: [record] })
        @setState recordChild: records
    triggerSelectRecordChild: (result) ->
        @setState recordChildSelect: result
    triggerDeleteRecordChild: (record) ->
        index = @state.recordChild.indexOf record
        records = React.addons.update(@state.recordChild, { $splice: [[index, 1]] })
        @setState
            recordChild: records
            recordChildSelect: null
    refreshChildRecord: (code) ->#can put in trigger at pmpmphase
        if code == 'medicine_bill_record' and @props.record != null
            formData = new FormData
            formData.append 'bill_id', @props.record.id
        if code == 'medicine_external_record' and @props.record != null
            formData = new FormData
            formData.append 'script_id', @props.record.id
        if code == 'medicine_internal_record' and @props.record != null
            formData = new FormData
            formData.append 'script_id', @props.record.id
        if formData != undefined
            $.ajax
                url: '/' + code + '/find'
                type: 'POST'
                data: formData
                async: false
                cache: false
                contentType: false
                processData: false
                success: ((result) ->
                    @props.triggerChildRefresh result
                    return
                ).bind(this)
    triggerBackup: (state) ->
        @setState backupState: state
    triggerAutoCompleteInputAlt: (code) ->
        if code == 'cname'
            if $('#form_cname').val().length > 3
                formData = new FormData
                formData.append 'cname', $('#form_cname').val().toLowerCase()
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
                formData.append 'id_station', @state.currentstation.id
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
            when 1#ordermap and customer record
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
            when 2#medicine
                switch @state.ptask
                    when 1#sample
                        console.log 1
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
                                            React.createElement StationRollMenu, datatype: 1, trigger: @selectStation, record: @state.stationlist
                                        catch error
                                            console.log error
                                    else
                                        if @state.currentpermission != null
                                            switch @state.currentpermission.table_id
                                                when 1#customer record and ordermap
                                                    switch @state.ptask
                                                        when 1#chose to go in customer Record
                                                            switch @state.pmtask
                                                                when 1#Chose to go add customer
                                                                    if @state.customer != null
                                                                        switch @state.pmphase
                                                                            when 1 #edit form customer record
                                                                                React.createElement StationContentApp, customer: @state.customer, datatype: 7, trigger: @triggerButtonAtpmphase
                                                                            when 2 # add ordermap form
                                                                                React.createElement StationContentApp, ordermap: null, customer: @state.customer, station: @state.currentstation, datatype: 5, trigger: @triggerButtonAtpmphase
                                                                            when 3 # view form with 
                                                                                if @state.ordermap != null
                                                                                    switch @state.pmpm
                                                                                        when 1#edit form
                                                                                            React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, station: @state.currentstation, datatype: 5, trigger: @triggerButtonAtpmpm
                                                                                        else #view form
                                                                                            React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, className: 'col-md-12', datatype: 6, trigger: @triggerButtonAtpmpm
                                                                            else #customer view
                                                                                React.createElement StationContentApp, record: @state.customer, order: @state.ordermap, orderlist: @state.ordermaplist, datatype: 4, trigger: @triggerButtonAtpmphase, triggerRecord: @triggerRecord
                                                                    else#add customer form
                                                                        React.createElement StationContentApp, customer: null, datatype: 7, trigger: @triggerButtonAtpmtask
                                                                when 2#Chose to go customer list
                                                                    if @state.customer != null
                                                                        switch @state.pmphase
                                                                            when 1#edit form customer record
                                                                                React.createElement StationContentApp, customer: @state.customer, datatype: 7, trigger: @triggerButtonAtpmphase
                                                                            when 2#add ordermap form
                                                                                React.createElement StationContentApp, ordermap: null, customer: @state.customer, station: @state.currentstation, datatype: 5, trigger: @triggerButtonAtpmphase
                                                                            when 3#ordermap
                                                                                if @state.ordermap != null
                                                                                    switch @state.pmpm
                                                                                        when 1#edit form
                                                                                            React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, station: @state.currentstation, datatype: 5, trigger: @triggerButtonAtpmpm
                                                                                        else #view form
                                                                                            React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, className: 'col-md-12', datatype: 6, trigger: @triggerButtonAtpmpm
                                                                            else#customer view
                                                                                React.createElement StationContentApp, record: @state.customer, order: @state.ordermap, orderlist: @state.ordermaplist, datatype: 4, trigger: @triggerButtonAtpmphase, triggerRecord: @triggerRecord
                                                                    else
                                                                        React.createElement StationContentApp, datatype: 8, backup: @state.backupState, station: @state.currentstation, triggerRecord: @triggerRecord, trigger: @triggerButtonAtpmtask, triggerbackup: @triggerBackup
                                                                else
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtptask, record: @state.customerRecordMinorTask
                                                        when 2#chose to go to ordermap
                                                            switch @state.pmtask
                                                                when 1#chose to go add ordermap - finished
                                                                    if @state.ordermap != null
                                                                        switch @state.pmphase
                                                                            when 1 #edit form ordermap
                                                                                React.createElement StationContentApp, ordermap: @state.ordermap, customer: null, station: @state.currentstation, datatype: 5, trigger: @triggerButtonAtpmphase
                                                                            else #ordermap view
                                                                                React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, className: 'col-md-12', datatype: 6, trigger: @triggerButtonAtpmphase
                                                                    else#add ordermap form
                                                                        React.createElement StationContentApp, ordermap: null, customer: null, station: @state.currentstation, datatype: 5, trigger: @triggerButtonAtpmtask
                                                                when 2#chose to go ordermap list
                                                                    switch @state.pmphase
                                                                        when 1 #ordermap view
                                                                            switch @state.pmpm
                                                                                when 1#ordermap edit
                                                                                    React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, station: @state.currentstation, datatype: 5, trigger: @triggerButtonAtpmphase
                                                                                else#ordermap view
                                                                                    React.createElement StationContentApp, ordermap: @state.ordermap, customer: @state.customer, className: 'col-md-12', datatype: 6, trigger: @triggerButtonAtpmphase
                                                                        else #ordermap list view
                                                                            React.createElement StationContentApp, datatype: 9, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord
                                                                else
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtptask, record: @state.orderMapMinorTask
                                                        else
                                                            React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtFirst, record: @state.customerRecordTask
                                                when 2#medicine
                                                    switch @state.ptask
                                                        when 1#sample
                                                            switch @state.pmtask
                                                                when 1#chose to go add sample
                                                                    if @state.sample != null
                                                                        switch @state.pmphase
                                                                            when 1 #edit form sample
                                                                                React.createElement StationContentApp, sample: @state.sample, datatype: 10, trigger: @triggerButtonAtpmphase, typemedicine: @props.medicinetype, groupmedicine: @props.medicinegroup, station: @state.currentstation
                                                                            else #sample view (make it simple)
                                                                                React.createElement StationContentApp, sample: @state.sample, datatype: 11, trigger: @triggerButtonAtpmphase, typemedicine: @props.medicinetype, groupmedicine: @props.medicinegroup
                                                                    else#add customer form
                                                                        React.createElement StationContentApp, sample: null, datatype: 10, trigger: @triggerButtonAtpmphase, typemedicine: @props.medicinetype, groupmedicine: @props.medicinegroup, station: @state.currentstation
                                                                when 2#chose to go to sample list
                                                                    switch @state.pmphase
                                                                        when 1 #sample view
                                                                            switch @state.pmpm
                                                                                when 1#sample edit
                                                                                    React.createElement StationContentApp, sample: @state.sample, datatype: 10, trigger: @triggerButtonAtpmphase, typemedicine: @props.medicinetype, groupmedicine: @props.medicinegroup, station: @state.currentstation
                                                                                else#sample view
                                                                                    React.createElement StationContentApp, sample: @state.sample, datatype: 11, trigger: @triggerButtonAtpmphase, typemedicine: @props.medicinetype, groupmedicine: @props.medicinegroup
                                                                        else #sample list view
                                                                            React.createElement StationContentApp, datatype: 12, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord, medicinetype: @props.medicinetype, medicinegroup: @props.medicinegroup
                                                                else#menu to chose
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtpmphase, record: @state.medicineSampleMinorTask
                                                        when 2#company
                                                            switch @state.pmtask
                                                                when 1#chose to go add company
                                                                    if @state.company != null
                                                                        switch @state.pmphase
                                                                            when 1 #edit form company
                                                                                React.createElement StationContentApp, company: @state.company, datatype: 13, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                            else #company view (make it simple)
                                                                                React.createElement StationContentApp, company: @state.company, datatype: 14, trigger: @triggerButtonAtpmphase
                                                                    else#add company form
                                                                        React.createElement StationContentApp, company: null, datatype: 13, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                when 2#chose to go to company list
                                                                    switch @state.pmphase
                                                                        when 1 #company view
                                                                            switch @state.pmpm
                                                                                when 1#company edit
                                                                                    React.createElement StationContentApp, company: @state.company, datatype: 13, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                                else#company view
                                                                                    React.createElement StationContentApp, company: @state.company, datatype: 14, trigger: @triggerButtonAtpmphase
                                                                        else #company list view
                                                                            React.createElement StationContentApp, datatype: 15, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord
                                                                else#menu to chose
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtpmphase, record: @state.medicineCompanyMinorTask
                                                        when 3#supplier
                                                            switch @state.pmtask
                                                                when 1#chose to go add supplier
                                                                    if @state.supplier != null
                                                                        switch @state.pmphase
                                                                            when 1 #edit form supplier
                                                                                React.createElement StationContentApp, supplier: @state.supplier, datatype: 16, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                            else #supplier view (make it simple)
                                                                                React.createElement StationContentApp, supplier: @state.supplier, datatype: 17, trigger: @triggerButtonAtpmphase
                                                                    else#add supplier form
                                                                        React.createElement StationContentApp, supplier: null, datatype: 16, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                when 2#chose to go to supplier list
                                                                    switch @state.pmphase
                                                                        when 1 #supplier view
                                                                            switch @state.pmpm
                                                                                when 1#supplier edit
                                                                                    React.createElement StationContentApp, supplier: @state.supplier, datatype: 16, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                                else#supplier view
                                                                                    React.createElement StationContentApp, supplier: @state.supplier, datatype: 17, trigger: @triggerButtonAtpmphase
                                                                        else #supplier list view
                                                                            React.createElement StationContentApp, datatype: 18, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord
                                                                else#menu to chose
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtpmphase, record: @state.medicineSupplierMinorTask
                                                        when 4#price
                                                            switch @state.pmtask
                                                                when 1#chose to go add price
                                                                    if @state.price != null
                                                                        switch @state.pmphase
                                                                            when 1 #edit form price
                                                                                React.createElement StationContentApp, price: @state.price, datatype: 19, trigger: @triggerButtonAtpmphase, station: @state.currentstation, typelist: @props.medicinetype, grouplist: @props.medicinegroup
                                                                            else #price view (make it simple)
                                                                                React.createElement StationContentApp, price: @state.price, datatype: 20, trigger: @triggerButtonAtpmphase
                                                                    else#add price form
                                                                        React.createElement StationContentApp, price: null, datatype: 19, trigger: @triggerButtonAtpmphase, station: @state.currentstation, typelist: @props.medicinetype, grouplist: @props.medicinegroup
                                                                when 2#chose to go to price list
                                                                    switch @state.pmphase
                                                                        when 1 #price view
                                                                            switch @state.pmpm
                                                                                when 1#price edit
                                                                                    React.createElement StationContentApp, price: @state.price, datatype: 19, trigger: @triggerButtonAtpmphase, station: @state.currentstation, typelist: @props.medicinetype, grouplist: @props.medicinegroup
                                                                                else#price view
                                                                                    React.createElement StationContentApp, price: @state.price, datatype: 20, trigger: @triggerButtonAtpmphase
                                                                        else #price list view
                                                                            React.createElement StationContentApp, datatype: 21, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord
                                                                else#menu to chose
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtpmphase, record: @state.medicinePriceMinorTask
                                                        when 5#billin
                                                            switch @state.pmtask
                                                                when 1#chose to go add billin
                                                                    if @state.billin != null
                                                                        switch @state.pmphase
                                                                            when 1 #edit form billin
                                                                                React.createElement StationContentApp, billin: @state.billin, grouplist: @props.medicinegroup, typelist: @props.medicinetype, datatype: 22, trigger: @triggerButtonAtpmphase, station: @state.currentstation, triggerAddRecordChild: @triggerRecordChild, selectRecordChild: @triggerSelectRecordChild, RecordChild: @state.recordChild, selectRecord: @state.recordChildSelect, id: "bill_in_form"
                                                                                #React.createElement StationContentApp, billin: @state.billin, datatype: 22, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                            else #billin view (make it simple)
                                                                                React.createElement StationContentApp, billin: @state.billin, datatype: 23, trigger: @triggerButtonAtpmphase
                                                                    else#add billin form
                                                                        React.createElement StationContentApp, billin: null, grouplist: @props.medicinegroup, typelist: @props.medicinetype, datatype: 22, trigger: @triggerButtonAtpmphase, station: @state.currentstation, triggerAddRecordChild: @triggerRecordChild, selectRecordChild: @triggerSelectRecordChild, RecordChild: @state.recordChild, selectRecord: @state.recordChildSelect, id: "bill_in_form"
                                                                when 2#chose to go to billin list
                                                                    switch @state.pmphase
                                                                        when 1 #billin view
                                                                            switch @state.pmpm
                                                                                when 1#billin edit
                                                                                    React.createElement StationContentApp, billin: @state.billin, grouplist: @props.medicinegroup, typelist: @props.medicinetype, datatype: 22, trigger: @triggerButtonAtpmphase, station: @state.currentstation, triggerAddRecordChild: @triggerRecordChild, selectRecordChild: @triggerSelectRecordChild, RecordChild: @state.recordChild, selectRecord: @state.recordChildSelect, id: "bill_in_form"
                                                                                    #React.createElement StationContentApp, billin: @state.billin, datatype: 22, trigger: @triggerButtonAtpmphase, station: @state.currentstation
                                                                                else#billin view
                                                                                    React.createElement StationContentApp, billin: @state.billin, datatype: 23, trigger: @triggerButtonAtpmphase
                                                                        else #billin list view
                                                                            React.createElement StationContentApp, datatype: 24, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord
                                                                else#menu to chose
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtpmphase, record: @state.medicineBillInMinorTask
                                                        when 6#prescript
                                                            switch @state.pmtask
                                                                when 2#chose to go to prescript list
                                                                    switch @state.pmphase
                                                                        when 1 #prescript view
                                                                            switch @state.pmpm
                                                                                when 1#prescript edit
                                                                                    React.createElement StationContentApp, prescript: @state.prescript, grouplist: @props.medicinegroup, typelist: @props.medicinetype, datatype: 25, trigger: @triggerButtonAtpmphase, station: @state.currentstation, triggerAddRecordChild: @triggerRecordChild, selectRecordChild: @triggerSelectRecordChild, RecordChild: @state.recordChild, selectRecord: @state.recordChildSelect, id: "prescript_form"
                                                                                when 2#internalrecord edit
                                                                                    React.createElement StationContentApp, internalrecord: @state.recordChildSelect, datatype: 31, trigger: @triggerButtonAtpmphase
                                                                                else#prescript view
                                                                                    React.createElement StationContentApp, prescript: @state.prescript, datatype: 26, trigger: @triggerButtonAtpmphase
                                                                        else #prescript list view
                                                                            React.createElement StationContentApp, datatype: 27, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord
                                                                else#menu to chose
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtpmphase, record: @state.medicinePrescriptMinorTask
                                                        when 7#stockRecord
                                                            switch @state.pmtask
                                                                when 2#chose to go to stockrecord list
                                                                    switch @state.pmphase
                                                                        when 1 #stockrecord view
                                                                            React.createElement StationContentApp, stockrecord: @state.stockrecord, datatype: 29, station: @state.currentstation, trigger: @triggerButtonAtpmphase, triggerRecord: @triggerRecord
                                                                        else #stockrecord list view
                                                                            React.createElement StationContentApp, datatype: 30, station: @state.currentstation, backup: @state.backupState, trigger: @triggerButtonAtpmphase, triggerbackup: @triggerBackup, triggerRecord: @triggerRecord
                                                                else#menu to chose
                                                                    React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtpmphase, record: @state.medicineStockRecordMinorTask
                                                        else#list chose
                                                            React.createElement StationRollMenu, datatype: 3, trigger: @triggerButtonAtFirst, record: @state.medicineTask
                                                when 3#patient check
                                                    console.log 1
                                        else
                                            try
                                                React.createElement StationRollMenu, datatype: 2, trigger: @selectPermission, record: @state.permissionlist
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
        record: null
        filteredRecord: null
        records: null
        lastsorted: null
        viewperpage: 10
        currentpage: 1
        firstcount: 0
        lastcount: 0
        autoComplete: null
        code: null
        selectList: null
        storeRecords: null
        minorRecord: null
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
            switch @props.datatype
                when 4
                    if @props.orderlist != null and @props.orderlist != undefined
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
                    else if @props.orderlist == null
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
                when 8
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 9
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 12
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 15
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 18
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 21
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 24
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 27
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
                when 29
                    @loadData()
                when 30
                    if @props.backup == null
                        @loadData()
                    else if @props.backup != null and @props.backup != undefined
                        @setState @props.backup
        ).bind(this)
    componentWillUnmount: ->
        $(APP).off 'reloadData'
    loadData: ->
        switch @props.datatype
            when 8
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin bệnh nhân"
                link = "/customer_record/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 9
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin phiếu khám"
                link = "/order_map/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 12
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin mẫu thuốc"
                link = "/medicine_sample/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 15
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin doanh nghiệp SX"
                link = "/medicine_company/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 18
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin nguồn cung cấp"
                link = "/medicine_supplier/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 21
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin giá thuốc"
                link = "/medicine_price/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 24
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin hóa đơn nhập"
                link = "/medicine_bill_in/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 27
                formData = new FormData
                formData.append 'id_station', @props.station.id
                message = "thông tin đơn thuốc"
                link = "/medicine_prescript_internal/list"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 29
                @setState record: null
                formData = new FormData
                formData.append 'id_station', @props.station.id
                formData.append 'date', 100
                formData.append 'name', @props.stockrecord.name
                formData.append 'sample_id', @props.stockrecord.sam_id
                message = "thông tin"
                link = "/medicine_summary/stock_record/detail1"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
                    ).bind(this)
            when 30
                @setState record: null
                formData = new FormData
                formData.append 'id_station', @props.station.id
                formData.append 'date', 100
                message = "thông tin đơn thuốc"
                link = "/medicine_summary/stock_record"
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
                            records: result[0]
                            filteredRecord: null
                            lastcount:
                                if result[0].length < 10
                                    result[0].length
                                else
                                    10
                        return
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
    triggerRecordOut: (record) ->
        @props.triggerRecord record
    triggerRecordOutAndBackUp: (record) ->
        @triggerRecordOut record
        @props.triggerbackup @state    
    triggercode: (code) ->
        @props.trigger code
    triggerCodeAndBackUp: (code) ->
        @triggercode code
        @props.triggerbackup @state
    trigger: ->
    triggersafe: ->
    triggerAddRecordChildOut: (record) ->
        @props.triggerAddRecordChild record
    selectRecordChildOut: (record) ->
        @props.selectRecordChild record
    triggerSumChild: (code) ->
        if code == 'bill_record'
            sumout = 0
            for record in @props.RecordChild
                sumout += record.price * record.qty
            $('#' + @props.id + ' #form_tpayment').val(sumout)
        else if code == 'internal_record'
            sumout = 0
            for record in @props.RecordChild
                sumout += Number(record.tpayment)
            $('#' + @props.id + ' #form_tpayment').val(Number(sumout))
    triggerSelectRecord: (record) ->
        @triggerRecordOut record
        @setState record: record
    triggerSortAltUp: ->
        switch @props.datatype
            when 8
                switch Number($('#filter_type_select').val())
                    when 1
                        @triggerSort('cname')
                    when 2
                        @triggerSort('dob')
                    when 3
                        @triggerSort('gender')
                    when 4
                        @triggerSort('address')
                    when 5
                        @triggerSort('pnumber')
                    when 6
                        @triggerSort('noid')
    triggerSortAltDown: ->
        switch @props.datatype
            when 8
                switch Number($('#filter_type_select').val())
                    when 1
                        @triggerSort('-cname')
                    when 2
                        @triggerSort('-dob')
                    when 3
                        @triggerSort('-gender')
                    when 4
                        @triggerSort('-address')
                    when 5
                        @triggerSort('-pnumber')
                    when 6
                        @triggerSort('-noid')
    triggerSortAltUpNext: (option) ->
        if option.id != 0
            @triggerSort(option.code)
    triggerSortAltDownNext: (option) ->
        if option.id != 0
            @triggerSort("-" + option.code)
    triggerStoreRecord: ->
        if @state.storeRecords == null
            if @state.filteredRecord != null
                @setState storeRecords: @state.filteredRecord
            else
                @setState storeRecords: @state.records
        else
            @setState storeRecords: null
    triggerStoreRecordNext: (boo) ->
        if boo
            if @state.filteredRecord != null
                @setState storeRecords: @state.filteredRecord
            else
                @setState storeRecords: @state.records
        else
            @setState storeRecords: null
    triggerbackup: ->
        @props.triggerbackup @state
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
        if @state.storeRecords != null
            @setState
                filteredRecord: @state.storeRecords.sort(@dynamicSort(code))
                lastsorted: code
        else
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
            @setState
                autoComplete: null
                minorRecord: record
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
        switch @props.datatype
            when 5
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
            when 22
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
            when 25
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
            when 31
                if Number($('#form_price').val()) > 0 and Number($('#form_amount').val()) > 0
                    $('#form_tpayment').val(Number($('#form_price').val()) * Number($('#form_amount').val()))
    triggerAutoCompleteInput: ->
        if $('#filter_type_select').val() != '' && $('#filter_text').val().length > 1
            if !$('#checkbox_db').is(':checked')
                if @state.storeRecords != null
                    filtered = []
                    for record in @state.storeRecords
                        if @checkContain($('#filter_type_select').val(),$('#filter_text').val(),record)
                            filtered.push record
                    @setState
                        filteredRecord: filtered
                        lastcount:
                            if filtered.length < 10
                                filtered.length
                            else
                                10
                else
                    filtered = []
                    for record in @state.records
                        if @checkContain($('#filter_type_select').val(),$('#filter_text').val(),record)
                            filtered.push record
                    @setState
                        filteredRecord: filtered
                        lastcount:
                            if filtered.length < 10
                                filtered.length
                            else
                                10
            else
                switch @props.datatype
                    when 8
                        formData = new FormData
                        link = 'customer_record'
                        formData.append 'id_station', @props.station.id
                        switch Number($('#filter_type_select').val())
                            when 1
                                formData.append 'namestring', $('#filter_text').val().toLowerCase()
                            when 2
                                formData.append 'dob', $('#filter_text').val().toLowerCase()
                            when 3
                                formData.append 'gender', Number($('#filter_text').val())
                            when 4
                                formData.append 'address', $('#filter_text').val().toLowerCase()
                            when 5
                                formData.append 'pnumber', $('#filter_text').val().toLowerCase()
                            when 6
                                formData.append 'noid', $('#filter_text').val().toLowerCase()
                if formData != undefined
                    $.ajax
                        url: '/' + link + '/search'
                        type: 'POST'
                        data: formData
                        async: false
                        cache: false
                        contentType: false
                        processData: false
                        success: ((result) ->
                            @setState autoComplete: result
                            return
                        ).bind(this)
    checkContain: (type,text,record) ->
        switch @props.datatype
            when 8
                switch Number(type)
                    when 1
                        if record.cname.toLowerCase().search(text.toLowerCase()) > -1
                            return true
                        else
                            return false
                    when 2
                        if (record.dob.substring(8, 10) + "/" + record.dob.substring(5, 7) + "/" + record.dob.substring(0, 4)).search(text.toLowerCase()) > -1
                            return true
                        else
                            return false
                    when 3
                        if record.gender == Number(text)
                            return true
                        else
                            return false
                    when 4
                        if record.address.toLowerCase().search(text.toLowerCase()) > -1
                            return true
                        else
                            return false
                    when 5
                        if record.pnumber.toLowerCase().search(text.toLowerCase()) > -1
                            return true
                        else
                            return false
                    when 6
                        if record.noid.toLowerCase().search(text.toLowerCase()) > -1
                            return true
                        else
                            return false
    triggerAutoCompleteAlt: (record) ->
        switch @props.datatype
            when 8
                switch Number($('#filter_type_select').val())
                    when 1
                        $('#filter_text').val(record.cname)
                    when 2
                        try
                            $('#filter_text').val(record.dob.substring(8, 10) + "/" + record.dob.substring(5, 7) + "/" + record.dob.substring(0, 4))
                        catch error
                            console.log error
                    when 4
                        $('#filter_text').val(record.address)
                    when 5
                        $('#filter_text').val(record.pnumber)
                    when 6
                        $('#filter_text').val(record.noid)
        @setState autoComplete: null
    triggerChangeType: ->
        switch @props.datatype
            when 8
                switch Number($('#filter_type_select').val())
                    when 3
                        @setState selectList:[{id: 1, name: "Nam"},{id: 2, name: "Nữ"}]
                    else
                        @setState selectList: null
    triggerSubmitSearch: ->
        formData = new FormData
        switch @props.datatype
            when 8
                link = "customer_record"
                formData.append 'date', 30
                formData.append 'id_station', @props.station.id
                switch Number($('#filter_type_select').val())
                    when 1
                        formData.append 'namestring', $('#filter_text').val().toLowerCase()
                    when 2
                        formData.append 'dob', $('#filter_text').val()
                    when 3
                        formData.append 'gender', $('#filter_text').val()
                    when 4
                        formData.append 'address', $('#filter_text').val().toLowerCase()
                    when 5
                        formData.append 'pnumber', $('#filter_text').val().toLowerCase()
                    when 6
                        formData.append 'noid', $('#filter_text').val().toLowerCase()
        $.ajax
            url: '/' + link + '/find'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            success: ((result) ->
                @setState
                    filteredRecord: result
                    lastcount:
                        if result.length < 10
                            result.length
                        else
                            10
                return
            ).bind(this)
    triggerSubmitSearchAlt: (option, searchtext) ->
        if option.id != 0
            formData = new FormData
            formData.append 'date', 30
            formData.append 'id_station', @props.station.id
            formData.append option.code, searchtext
            $.ajax
                url: '/' + option.linkfind
                type: 'POST'
                data: formData
                async: false
                cache: false
                contentType: false
                processData: false
                success: ((result) ->
                    @setState
                        filteredRecord: result
                        lastcount:
                            if result.length < 10
                                result.length
                            else
                                10
                    return
                ).bind(this)
    triggerAutoCompleteFast: (optionRecord, textsearch) ->
        if @state.storeRecords != null
            filtered = []
            for record in @state.storeRecords
                if @checkContainFast(optionRecord,textsearch,record)
                    filtered.push record
            @setState
                filteredRecord: filtered
                lastcount:
                    if filtered.length < 10
                        filtered.length
                    else
                        10
        else
            filtered = []
            for record in @state.records
                if @checkContainFast(optionRecord,textsearch,record)
                    filtered.push record
            @setState
                filteredRecord: filtered
                lastcount:
                    if filtered.length < 10
                        filtered.length
                    else
                        10        
    checkContainFast: (optionRecord, textsearch, record) ->
        switch optionRecord.type
            when 1#text
                if record[optionRecord.code].toLowerCase().search(textsearch.toLowerCase()) > -1
                    return true
                else
                    return false
            when 2#number
                if record[optionRecord.code] == Number(textsearch)
                    return true
                else
                    return false
            when 3#date
                try
                    if (record[optionRecord.code].substring(8, 10) + "/" + record[optionRecord.code].substring(5, 7) + "/" + record[optionRecord.code].substring(0, 4)).search(textsearch) > -1
                        return true
                    else
                        return false
                catch error
                    return false
    triggerClear: ->
        $('#filter_text').val("")
        @setState
            filteredRecord: null
            storeRecords: null
            lastcount:
                if @state.records.length < 10
                    @state.records.length
                else
                    10
    triggerClearAlt: (option) ->
        $('#filter_text').val("")
        @setState
            filteredRecord: null
            storeRecords: null
            lastcount:
                if @state.records.length < 10
                    @state.records.length
                else
                    10
    stationRender: ->
        if @props.hidden    
            React.DOM.div className: @props.className + ' hidden-xs',
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, @props.record.sname
                    React.DOM.img alt: 'pic1', src: @props.record.logo , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
                        React.DOM.p null, @props.record.address
                        React.DOM.p null, @props.record.pnumber
                        React.DOM.p null, @props.record.hpage
        else
            React.DOM.div className: @props.className,
                React.DOM.div className: 'content-app', style: {'cursor':'pointer'}, onClick: @triggerRecord,
                    React.DOM.h4 null, @props.record.sname
                    React.DOM.img alt: 'pic1', src: @props.record.logo , className: 'img-responsive'
                    React.DOM.div className: 'content-info-block',
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
                                @calAge(@props.record.dob,2).years + " Tuổi " + @calAge(@props.record.dob,2).months + " Tháng"
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
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
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
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    editOrderMapForm: ->
        if @props.customer != null and @props.ordermap != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'col-sm-12',
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
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else if @props.customer != null and @props.ordermap == null
            React.DOM.div className: 'row',
                React.DOM.div className: 'col-sm-12',
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
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else if @props.customer == null and @props.ordermap == null
            React.DOM.div className: 'row',
                React.DOM.div className: 'col-sm-12',
                    React.DOM.div className: 'col-md-4',
                        if @state.minorRecord != null
                            React.DOM.div className: 'content-app-alt animated fadeIn hidden-xs', style: {'paddingLeft':'50px'},
                                React.DOM.h4 style: {'color': '#fff'}, @state.minorRecord.cname
                                React.DOM.img alt: 'pic1', src: @state.minorRecord.avatar , className: 'img-responsive'
                                React.DOM.div className: 'content-info-block',
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        try
                                            @state.minorRecord.dob.substring(8, 10) + "/" + @state.minorRecord.dob.substring(5, 7) + "/" + @state.minorRecord.dob.substring(0, 4)
                                        catch error
                                            "Chưa nhập"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        try
                                            @calAge(@state.minorRecord.dob,2).years + " Tuổi " + @calAge(@state.minorRecord.dob,2).months + " Tháng"
                                        catch error
                                            "Không tính được"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        switch @state.minorRecord.gender
                                            when 1
                                                "Nam"
                                            when 2
                                                "Nữ"
                                            else
                                                "Chưa định"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-map', style: {'marginRight' : '10px'}
                                        @state.minorRecord.address
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-barcode', style: {'marginRight' : '10px'}
                                        @state.minorRecord.noid
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-phone', style: {'marginRight' : '10px'}
                                        @state.minorRecord.pnumber
                    React.DOM.div className: 'col-md-8',
                        React.DOM.div className: 'spacer20'
                        React.DOM.form className: 'form-horizontal content-app-alt', style: {'paddingLeft': '40px', 'paddingRight': '40px'}, autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên bệnh nhân'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                                    React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                                        if @state.autoComplete != null and @state.code == 'cname'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
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
                                React.DOM.div className: 'col-md-6',
                                    React.DOM.label className: 'col-sm-4 control-label hidden-xs', 'Ghi chú'
                                    React.DOM.div className: 'col-sm-8',
                                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú'
                                React.DOM.div className: 'col-md-6',
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
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else if @props.customer == null and @props.ordermap != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'col-sm-12',
                    React.DOM.div className: 'col-md-4',
                        if @state.minorRecord != null
                            React.DOM.div className: 'content-app-alt animated fadeIn hidden-xs', style: {'paddingLeft':'50px'},
                                React.DOM.h4 style: {'color': '#fff'}, @state.minorRecord.cname
                                React.DOM.img alt: 'pic1', src: @state.minorRecord.avatar , className: 'img-responsive'
                                React.DOM.div className: 'content-info-block',
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        try
                                            @state.minorRecord.dob.substring(8, 10) + "/" + @state.minorRecord.dob.substring(5, 7) + "/" + @state.minorRecord.dob.substring(0, 4)
                                        catch error
                                            "Chưa nhập"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        try
                                            @calAge(@state.minorRecord.dob,2).years + " Tuổi " + @calAge(@state.minorRecord.dob,2).months + " Tháng"
                                        catch error
                                            "Không tính được"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        switch @state.minorRecord.gender
                                            when 1
                                                "Nam"
                                            when 2
                                                "Nữ"
                                            else
                                                "Chưa định"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-map', style: {'marginRight' : '10px'}
                                        @state.minorRecord.address
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-barcode', style: {'marginRight' : '10px'}
                                        @state.minorRecord.noid
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-phone', style: {'marginRight' : '10px'}
                                        @state.minorRecord.pnumber
                    React.DOM.div className: 'col-md-8',
                        React.DOM.div className: 'spacer20'
                        React.DOM.form className: 'form-horizontal content-app-alt', style: {'paddingLeft': '40px', 'paddingRight': '40px'}, autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tên bệnh nhân'
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.input id: 'form_c_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue: @props.ordermap.customer_record_id
                                    React.createElement InputField, id: 'form_cname', className: 'form-control', type: 'text', code: 'cname', placeholder: 'Tên bệnh nhân', style: '', defaultValue: @props.ordermap.cname, trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete", id: "cname_autocomplete",
                                        if @state.autoComplete != null and @state.code == 'cname'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'customer_record_mini', header: [{id: 1,name: "Họ và tên"},{id: 2,name: "Ngày sinh"},{id: 3, name: "Tuổi"},{id: 4, name: "Giới tính"},{id: 5, name: "Địa chỉ"},{id: 6, name: "SĐT"},{id: 7, name: "CMTND"}], extra: [{id:1, name: "Nam"},{id:2,name: "Nữ"}], trigger: @triggerAutoComplete
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
                                React.DOM.div className: 'col-md-6',
                                    React.DOM.label className: 'col-sm-4 control-label hidden-xs', 'Ghi chú'
                                    React.DOM.div className: 'col-sm-8',
                                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue: @props.ordermap.remark
                                React.DOM.div className: 'col-md-6',
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
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewOrderMap: ->
        if @props.ordermap != null
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-4',
                    if @props.customer != null
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
                    else if @state.minorRecord != null
                        try
                            React.DOM.div className: 'content-app-alt animated fadeIn hidden-xs',
                                React.DOM.h4 style: {'color': '#fff'}, @state.minorRecord.cname
                                React.DOM.img alt: 'pic1', src: @state.minorRecord.avatar , className: 'img-responsive'
                                React.DOM.div className: 'content-info-block',
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        try
                                            @state.minorRecord.dob.substring(8, 10) + "/" + @state.minorRecord.dob.substring(5, 7) + "/" + @state.minorRecord.dob.substring(0, 4)
                                        catch error
                                            "Chưa nhập"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        try
                                            @calAge(@state.minorRecord.dob,2).years + " Tuổi " + @calAge(@state.minorRecord.dob,2).months + " Tháng"
                                        catch error
                                            "Không tính được"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-birthday-cake', style: {'marginRight' : '10px'}
                                        switch @state.minorRecord.gender
                                            when 1
                                                "Nam"
                                            when 2
                                                "Nữ"
                                            else
                                                "Chưa định"
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-map', style: {'marginRight' : '10px'}
                                        @state.minorRecord.address
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-barcode', style: {'marginRight' : '10px'}
                                        @state.minorRecord.noid
                                    React.DOM.p null,
                                        React.DOM.i className: 'fa fa-phone', style: {'marginRight' : '10px'}
                                        @state.minorRecord.pnumber
                        catch error
                            console.log error
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
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
    viewListCustomer: ->
        React.DOM.div className: 'row',
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form',
                React.DOM.form className: 'form-horizontal row', autoComplete: 'off',
                    React.DOM.div className: 'form-group col-lg-6 col-sm-12',
                        React.DOM.div className: 'col-sm-4', style: {'marginBottom': '15px'},
                            React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
                                React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
                                React.DOM.option value: 1, 'Tên bệnh nhân'
                                React.DOM.option value: 2, 'Ngày sinh'
                                React.DOM.option value: 3, 'Giới tính'
                                React.DOM.option value: 4, 'Địa chỉ'
                                React.DOM.option value: 5, 'Số điện thoại'
                                React.DOM.option value: 6, 'CMTND'
                        React.DOM.div className: 'col-sm-8',
                            if @state.selectList == null
                                React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Type here ...'
                            else
                                React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
                            React.DOM.div className: "auto-complete",
                                if @state.autoComplete != null
                                    for record in @state.autoComplete
                                        switch Number($('#filter_type_select').val())
                                            when 1
                                                React.createElement AutoComplete, key: record.id, text: record.cname, record: record, trigger: @triggerAutoCompleteAlt
                                            when 2
                                                React.createElement AutoComplete, key: record.id, record: record, trigger: @triggerAutoCompleteAlt, text:
                                                    try
                                                        record.dob.substring(8, 10) + "/" + record.dob.substring(5, 7) + "/" + record.dob.substring(0, 4)
                                                    catch error
                                                        ""
                                            when 4
                                                React.createElement AutoComplete, key: record.id, text: record.address, record: record, trigger: @triggerAutoCompleteAlt
                                            when 5
                                                React.createElement AutoComplete, key: record.id, text: record.pnumber, record: record, trigger: @triggerAutoCompleteAlt
                                            when 6
                                                React.createElement AutoComplete, key: record.id, text: record.noid, record: record, trigger: @triggerAutoCompleteAlt
                    React.DOM.div className: 'col-lg-6 text-center',
                        React.DOM.div className: 'btn-group col-sm-6 text-center', style: {'marginBottom': '10px'},
                            React.DOM.button type: 'button', className: 'btn btn-group-left', onClick: @triggerSubmitSearch,
                                React.DOM.i className: 'zmdi zmdi-search'
                                ' Tìm kiếm'
                            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerClear,
                                React.DOM.i className: 'zmdi zmdi-close'
                                ' Về ban đầu'
                        React.DOM.div className: 'btn-group col-sm-6 text-center', style: {'marginBottom': '10px'},
                            React.DOM.button type: 'button', className: 'btn btn-group-left', onClick: @triggerSortAltDown,
                                React.DOM.i className: 'zmdi zmdi-sort-amount-desc'
                                ' Giảm dần'
                            React.DOM.button type: 'button', className: 'btn btn-group-right', onClick: @triggerSortAltUp,
                                React.DOM.i className: 'zmdi zmdi-sort-amount-asc'
                                ' Tăng dần'
                        React.DOM.div className: 'form-group col-sm-3',
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db', type: 'checkbox'  
                                "Gợi ý"
                        React.DOM.div className: 'form-group col-sm-6',
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db_2', type: 'checkbox', onChange: @triggerStoreRecord
                                "Dữ liệu hiện tại"
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form',
                React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                    React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                    React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
                if @state.filteredRecord != null
                    React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                    React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 customer-list-block',
                if @state.filteredRecord != null
                    for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        React.createElement CustomerRecordBlock, key: record.id, record: record, trigger: @triggerRecordOutAndBackUp        
                else
                    for record in @state.records[@state.firstcount...@state.lastcount]
                        React.createElement CustomerRecordBlock, key: record.id, record: record, trigger: @triggerRecordOutAndBackUp
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode
    listRecordRender: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Tên dịch vụ', linksearch: 'order_map/search', linkfind: 'order_map/find', code: 'sername',type: 1}
                {id: 2, text: 'Tên khách hàng', linksearch: 'order_map/search', linkfind: 'order_map/find', code: 'cname', type: 1}
                {id: 3, text: 'Tình trạng', linksearch: 'order_map/search', linkfind: 'order_map/find', code: 'status', type: 2, list: [
                    {id: 1, name: "Chưa thanh toán, chưa khám bệnh"}
                    {id: 2, name: "Đã thanh toán, đang chờ khám"}
                    {id: 3, name: "Đã thanh toán, đã khám bệnh"}
                    {id: 4, name: "Chưa thanh toán, đã khám bệnh"}
                ]}
                {id: 4, text: 'Tổng đơn giá', linksearch: 'order_map/search', linkfind: 'order_map/find', code: 'tpayment', type: 2}
                {id: 5, text: 'Giảm giá', linksearch: 'order_map/search', linkfind: 'order_map/find', code: 'discount', type: 2}
                {id: 6, text: 'Tổng thanh toán', linksearch: 'order_map/search', linkfind: 'order_map/find', code: 'tpayout', type: 2}
                {id: 7, text: 'Ghi chú', linksearch: 'order_map/search', linkfind: 'order_map/find', code: 'remark', type: 1}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                status = ""
                                expand = ""
                                switch Number(record.status)
                                    when 1
                                        status = "Chưa thanh toán, chưa khám bệnh"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt1"
                                    when 2
                                        status = "Đã thanh toán, đang chờ khám"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt2"
                                    when 3
                                        status = "Đã thanh toán, đã khám bệnh"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt3"
                                    when 4
                                        status = "Chưa thanh toán, đã khám bệnh"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt4"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.cname + " - " + record.sername, textline2: record.tpayout + " - " + status , datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                status = ""
                                expand = ""
                                switch Number(record.status)
                                    when 1
                                        status = "Chưa thanh toán, chưa khám bệnh"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt1"
                                    when 2
                                        status = "Đã thanh toán, đang chờ khám"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt2"
                                    when 3
                                        status = "Đã thanh toán, đã khám bệnh"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt3"
                                    when 4
                                        status = "Chưa thanh toán, đã khám bệnh"
                                        if @state.record != null
                                            if record.id == @state.record.id
                                                expand = "activeselt4"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.cname + " - " + record.sername, textline2: record.tpayout + " - " + status , datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25 hidden-xs', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số khám bệnh'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Mã bệnh án'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.code
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Dịch vụ đăng ký'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.sername
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Thanh toán'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.tpayout
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tình trạng'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null,
                                            switch @state.record.status
                                                when 1
                                                    'Chưa thanh toán, chưa khám bệnh'
                                                when 2
                                                    'Đã thanh toán, đang chờ khám'
                                                when 3
                                                    'Đã thanh toán, đã khám bệnh'
                                                when 4
                                                    'Chưa thanh toán, đã khám bệnh'
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode
    editMedicineSampleForm: ->
        if @props.sample != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số', defaultValue: @props.sample.noid
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                                React.DOM.div className: 'col-sm-10',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên thuốc', defaultValue: @props.sample.name
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Loại thuốc'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement SelectBox, id: 'form_typemedicine', records: @props.typemedicine, className: 'form-control', type: 4, text: 'Loại thuốc'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhóm thuốc'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement SelectBox, id: 'form_groupmedicine', records: @props.groupmedicine, className: 'form-control', type: 4, text: 'Nhóm thuốc'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá thuốc'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_price', type: 'number', className: 'form-control', placeholder: 'Giá thuốc', defaultValue: @props.sample.price
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', "Ghi chú"
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.textarea id: 'form_remark', type: 'text', className: 'form-control', placeholder: 'Ghi chú', defaultValue: @props.sample.remark
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Khối lượng'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_weight', type: 'number', className: 'form-control', placeholder: 'Khối lượng', defaultValue: @props.sample.weight
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hạn sử dụng'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_expire', type: 'number', className: 'form-control', placeholder: 'Hạn sử dụng (số ngày)', defaultValue: @props.sample.expire
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue: @props.sample.company_id
                                    React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Tên nhà sản xuất', style: '', defaultValue: @props.sample.company, trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete",
                                        if @state.autoComplete != null and @state.code == 'company'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                                React.DOM.div className: 'col-sm-10',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên thuốc'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Loại thuốc'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement SelectBox, id: 'form_typemedicine', records: @props.typemedicine, className: 'form-control', type: 4, text: "Loại thuốc"
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nhóm thuốc'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement SelectBox, id: 'form_groupmedicine', records: @props.groupmedicine, className: 'form-control', type: 4, text: "Nhóm thuốc"
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá thuốc'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_price', type: 'number', className: 'form-control', placeholder: 'Giá thuốc'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', "Ghi chú"
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.textarea id: 'form_remark', type: 'text', className: 'form-control', placeholder: 'Ghi chú'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Khối lượng'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_weight', type: 'number', className: 'form-control', placeholder: 'Khối lượng'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Hạn sử dụng'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_expire', type: 'number', className: 'form-control', placeholder: 'Hạn sử dụng (số ngày)'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Công ty sản xuất'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_company_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                                    React.createElement InputField, id: 'form_company', className: 'form-control', type: 'text', code: 'company', placeholder: 'Tên nhà sản xuất', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete",
                                        if @state.autoComplete != null and @state.code == 'company'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_company_mini', header: [{id: 1,name: "Mã công ty"},{id: 2, name: "Tên công ty"}], trigger: @triggerAutoComplete
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewMedicineSampleForm: ->
        if @props.sample != null
            typemedicinename = ""
            groupmedicinename = ""
            for record in @props.typemedicine
                if record.id == @props.sample.typemedicine
                    typemedicinename = record.name
                    break
            for record in @props.groupmedicine
                if record.id == @props.sample.groupmedicine
                    groupmedicinename = record.name
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-12',
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'content-app-alt',
                            React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số thứ tự'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã thuốc'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.noid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tên thuốc'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Doanh nghiệp sản xuất'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.company
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Ghi chú'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.remark
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Khối lượng (mg)'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.weight
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Hạn sử dụng (số ngày)'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.expire
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Giá nhập'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.sample.price
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Loại thuốc'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, typemedicinename
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Loại thuốc'
                                    React.DOM.div className: 'col-md-8',                    
                                        React.DOM.p null, groupmedicinename
                    React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'row',
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
    listMedicineSample: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Mã thuốc', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'noid', type: 1}
                {id: 2, text: 'Tên thuốc', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'name', type: 1}
                {id: 3, text: 'Loại thuốc', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'typemedicine', type: 2, list: @props.medicinetype}
                {id: 4, text: 'Nhóm thuốc', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'groupmedicine', type: 2, list: @props.medicinegroup}
                {id: 5, text: 'Doanh nghiệp SX', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'company', type: 1}
                {id: 6, text: 'Giá nhập', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'price', type: 2}
                {id: 7, text: 'Khối lượng', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'weight', type: 2}
                {id: 8, text: 'Ghi chú', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'remark', type: 1}
                {id: 9, text: 'Hạn sử dụng', linksearch: 'medicine_sample/search', linkfind: 'medicine_sample/find', code: 'expire', type: 2}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name + " - " + record.noid, textline2: record.company , datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name + " - " + record.noid, textline2: record.company , datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên thuốc'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Mã thuốc'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.noid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Doanh nghiệp SX'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.company
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode    
    editMedicineCompanyForm: ->
        if @props.company != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số', defaultValue: @props.company.noid
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên doanh nghiệp'
                                React.DOM.div className: 'col-sm-10',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên doanh nghiệp sản xuất', defaultValue: @props.company.name
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT', defaultValue: @props.company.pnumber
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Email'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email', defaultValue: @props.company.email
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ', defaultValue: @props.company.email
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-link"
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_website', type: 'text', className: 'form-control', placeholder: 'Website', defaultValue: @props.company.website
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế', defaultValue: @props.company.taxcode
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên doanh nghiệp'
                                React.DOM.div className: 'col-sm-10',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên doanh nghiệp sản xuất'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Email'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-link"
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_website', type: 'text', className: 'form-control', placeholder: 'Website'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế'
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewMedicineCompanyForm: ->
        if @props.company != null
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-12',
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'content-app-alt',
                            React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số thứ tự'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã DN'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.noid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tên doanh nghiệp SX'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Địa chỉ'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.address
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số ĐT'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.pnumber
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Email'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.email
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Website'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.website
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã số thuêts'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.company.taxcode
                    React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'row',
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
    listMedicineCompany: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Mã DN', linksearch: 'medicine_company/search', linkfind: 'medicine_company/find', code: 'noid', type: 1}
                {id: 2, text: 'Tên doanh nghiệp', linksearch: 'medicine_company/search', linkfind: 'medicine_company/find', code: 'name', type: 1}
                {id: 3, text: 'Số điện thoại', linksearch: 'medicine_company/search', linkfind: 'medicine_company/find', code: 'pnumber', type: 1}
                {id: 4, text: 'Địa chỉ', linksearch: 'medicine_company/search', linkfind: 'medicine_company/find', code: 'address', type: 1}
                {id: 5, text: 'Email', linksearch: 'medicine_company/search', linkfind: 'medicine_company/find', code: 'email', type: 1}
                {id: 6, text: 'Website', linksearch: 'medicine_company/search', linkfind: 'medicine_company/find', code: 'website', type: 1}
                {id: 7, text: 'Mã số thuế', linksearch: 'medicine_company/search', linkfind: 'medicine_company/find', code: 'taxcode', type: 1}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name + " - " + record.noid, textline2: record.address + " - " + record.pnumber, datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name + " - " + record.noid, textline2: record.address + " - " + record.pnumber, datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'ID'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Mã DN'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.noid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên doanh nghiệp'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số điện thoại'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.pnumber
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode    
    editMedicineSupplierForm: ->
        if @props.supplier != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số', defaultValue: @props.supplier.noid
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên nguồn'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên nguồn', defaultValue: @props.supplier.name
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người liên lạc'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_contact_name', type: 'text', className: 'form-control', placeholder: 'Tên người liên lạc', defaultValue: @props.supplier.contactname
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT cố định'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_spnumber', type: 'number', className: 'form-control', placeholder: 'SĐT cố định', defaultValue: @props.supplier.spnumber
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT di động'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT di động', defaultValue: @props.supplier.pnumber
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 1'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address1', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 1', defaultValue: @props.supplier.address1
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 2'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address2', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 2', defaultValue: @props.supplier.address2
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 3'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address3', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 3', defaultValue: @props.supplier.address3
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-email"
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email', defaultValue: @props.supplier.email
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-facebook-box"
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_facebook', type: 'text', className: 'form-control', placeholder: 'Facebook Link', defaultValue: @props.supplier.facebook
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-twitter-box"
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_twitter', type: 'text', className: 'form-control', placeholder: 'Twitter Link', defaultValue: @props.supplier.twitter
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số fax'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_fax', type: 'number', className: 'form-control', placeholder: 'Fax', defaultValue: @props.supplier.fax
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế', defaultValue: @props.supplier.taxcode
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên nguồn'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên nguồn'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người liên lạc'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_contact_name', type: 'text', className: 'form-control', placeholder: 'Tên người liên lạc'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT cố định'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_spnumber', type: 'number', className: 'form-control', placeholder: 'SĐT cố định'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT di động'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT di động'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 1'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address1', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 1'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 2'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address2', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 2'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ 3'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address3', type: 'text', className: 'form-control', placeholder: 'Địa chỉ 3'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-email"
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-facebook-box"
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_facebook', type: 'text', className: 'form-control', placeholder: 'Facebook Link'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-twitter-box"
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_twitter', type: 'text', className: 'form-control', placeholder: 'Twitter Link'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số fax'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_fax', type: 'number', className: 'form-control', placeholder: 'Fax'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế'
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewMedicineSupplierForm: ->
        if @props.supplier != null
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-12',
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'content-app-alt',
                            React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số thứ tự'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã số'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.noid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tên nguồn'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Người liên lạc'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.contactname
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Địa chỉ 1'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.address1
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Địa chỉ 2'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.address2
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Địa chỉ 3'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.address3
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số ĐT cố định'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.spnumber
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số ĐT di động'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.pnumber
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Email'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.email
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Facebook'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.facebook
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Twitter'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.twitter
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Fax'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.fax
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã số thuế'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.supplier.taxcode
                    React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'row',
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
    listMedicineSupplier: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Mã nguồn', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'noid', type: 1}
                {id: 2, text: 'Tên nguồn', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'name', type: 1}
                {id: 3, text: 'Người liên lạc', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'contactname', type: 1}
                {id: 4, text: 'Số ĐT cố định', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'spnumber', type: 1}
                {id: 5, text: 'Số ĐT di động', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'pnumber', type: 1}
                {id: 6, text: 'Địa chỉ 1', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'address1', type: 1}
                {id: 7, text: 'Địa chỉ 2', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'address2', type: 1}
                {id: 8, text: 'Địa chỉ 3', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'address3', type: 1}
                {id: 9, text: 'Email', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'email', type: 1}
                {id: 10, text: 'Facebook', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'facebook', type: 1}
                {id: 11, text: 'Twitter', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'twitter', type: 1}
                {id: 12, text: 'Fax', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'fax', type: 1}
                {id: 14, text: 'Mã số thuế', linksearch: 'medicine_supplier/search', linkfind: 'medicine_supplier/find', code: 'taxcode', type: 1}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name + " - " + record.noid, textline2: record.contactname + " - " + record.spnumber + " - " + record.pnumber, datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name + " - " + record.noid, textline2: record.contactname + " - " + record.spnumber + " - " + record.pnumber, datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'ID'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Mã nguồn'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.noid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên nguồn'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Người liên lạc'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.contactname
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số ĐT cố định'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.spnumber
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số ĐT di động'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.pnumber
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode    
    editMedicinePriceForm: ->
        if @props.price != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue: @props.price.sample_id
                                    React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample', placeholder: 'Tên thuốc', style: '', defaultValue: @props.price.name, trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete",
                                        if @state.autoComplete != null and @state.code == 'sample'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng ít nhất'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_minam', type: 'number', className: 'form-control', placeholder: 'Số lượng ít nhất', defaultValue: @props.price.minam
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                                React.DOM.div className: 'col-sm-3',
                                    React.DOM.input id: 'form_price', type: 'text', className: 'form-control', placeholder: 'Giá', defaultValue: @props.price.price
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú', defaultValue: @props.price.remark
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên thuốc'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_sample_id', className: 'form-control', type: 'text', style: {'display': 'none'}                                    
                                    React.createElement InputField, id: 'form_sample', className: 'form-control', type: 'text', code: 'sample', placeholder: 'Tên thuốc', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete",
                                        if @state.autoComplete != null and @state.code == 'sample'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_sample_mini', grouplist: @props.grouplist, typelist: @props.typelist, header: [{id: 1,name: "Tên thuốc"},{id: 2, name: "Loại thuốc"},{id: 3, name: "Nhóm thuốc"},{id: 4, name: "Công ty sản xuất"},{id: 5, name: "Giá"}], trigger: @triggerAutoComplete
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng ít nhất'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_minam', type: 'number', className: 'form-control', placeholder: 'Số lượng ít nhất'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                                React.DOM.div className: 'col-sm-3',
                                    React.DOM.input id: 'form_price', type: 'text', className: 'form-control', placeholder: 'Giá'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú'
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewMedicinePriceForm: ->
        if @props.price != null
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-12',
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'content-app-alt',
                            React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số thứ tự'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.price.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tên thuốc'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.price.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Giá bán'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.price.price
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số lượng ít nhất'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.price.minam
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Diễn giải'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.price.remark
                    React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'row',
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
    listMedicinePrice: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Tên thuốc', linksearch: 'medicine_price/search', linkfind: 'medicine_price/find', code: 'name', type: 1}
                {id: 2, text: 'Diễn giải', linksearch: 'medicine_price/search', linkfind: 'medicine_price/find', code: 'remark', type: 1}
                {id: 3, text: 'Số lượng tối thiểu', linksearch: 'medicine_price/search', linkfind: 'medicine_price/find', code: 'minam', type: 2}
                {id: 4, text: 'Giá', linksearch: 'medicine_price/search', linkfind: 'medicine_price/find', code: 'price', type: 2}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name, textline2: record.price, datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name, textline2: record.price, datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'ID'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên thuốc'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Giá bán'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.price
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số lượng ít nhất'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.minam
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode    
    editMedicineBillInForm: ->
        if @props.billin != null
            React.DOM.div className: 'row',
                try
                    React.createElement ModalOutside, id: 'modalbillrecordmini', datatype: 'medicine_bill_record_mini', record: null, grouplist: @props.grouplist, typelist: @props.typelist, trigger: @triggerAddRecordChildOut, trigger2: @trigger, currentstation: @props.station, record_id:
                        if @props.RecordChild.length == 0
                            1
                        else
                            @props.RecordChild[@props.RecordChild.length - 1].id + 1
                catch error
                    console.log 1
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off', id: @props.id,
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã hóa đơn'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_billcode', type: 'text', className: 'form-control', placeholder: 'Mã hóa đơn', defaultValue: @props.billin.billcode
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày nhập'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_dayin', type: 'text', className: 'form-control', placeholder: '30/01/1990', defaultValue:
                                        try
                                            @props.billin.dayin.substring(8, 10) + "/" + @props.billin.dayin.substring(5, 7) + "/" + @props.billin.dayin.substring(0, 4)
                                        catch error
                                            ""
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày đặt hàng'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_daybook', type: 'text', className: 'form-control', placeholder: '30/01/1990', defaultValue:
                                        try
                                            @props.billin.daybook.substring(8, 10) + "/" + @props.billin.daybook.substring(5, 7) + "/" + @props.billin.daybook.substring(0, 4)
                                        catch error
                                            ""
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nguồn cung cấp'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_supplier_id', className: 'form-control', type: 'text', style: {'display': 'none'}, defaultValue: @props.billin.supplier_id
                                    React.createElement InputField, id: 'form_supplier', className: 'form-control', type: 'text', code: 'supplier', placeholder: 'Nguồn cung cấp', style: '', defaultValue: @props.billin.supplier, trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete",
                                        if @state.autoComplete != null and @state.code == 'supplier'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_supplier_mini', header: [{id: 1,name: "Mã"},{id: 2, name: "Tên nguồn"},{id: 3, name: "Người liên lạc"},{id: 4, name: "Điện thoại"}], trigger: @triggerAutoComplete
                            React.DOM.div className: 'form-group',
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Cách thanh toán'
                                    React.DOM.div className: 'col-sm-3',
                                        React.createElement SelectBox, id: 'form_pmethod', className: 'form-control', text: "Cách thanh toán", type: 4, records: [{id: 1, name: "Tiền mặt"},{id: 2, name: "Chuyển khoản"},{id: 3, name: "Khác"}]
                                    React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tình trạng hóa đơn'
                                    React.DOM.div className: 'col-sm-3',
                                        React.createElement SelectBox, id: 'form_status', className: 'form-control', text: "Tình trạng hóa đơn", type: 4, records: [{id: 1, name: "Lưu kho"},{id: 2, name: "Đang di chuyển"},{id: 3, name: "Trả lại"}]
                                    React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                                    React.DOM.div className: 'col-sm-9',
                                        React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú', defaultValue: @props.billin.remark
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Tổng giá trị'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_tpayment', type: 'number', className: 'form-control', placeholder: 'Tổng giá trị', onBlur: @triggerRecalPayment, defaultValue: @props.billin.tpayment
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Giảm giá'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_discount', type: 'number', className: 'form-control', placeholder: 'Giảm giá', onBlur: @triggerRecalPayment,defaultValue: @props.billin.discount
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', '% Giảm giá'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_discount_percent', type: 'number', className: 'form-control', placeholder: '% Giảm giá', onBlur: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Thanh toán'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_tpayout', type: 'number', className: 'form-control', placeholder: 'Thanh toán', onBlur: @triggerRecalPayment, defaultValue: @props.billin.tpayout
                            React.DOM.div className: 'row',
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.div className: 'card-body table-responsive',
                                        React.DOM.table className: 'table table-hover table-condensed', style: {'backgroundColor': '#414141','color': '#fff'},
                                            React.DOM.thead null,
                                                React.DOM.tr null,
                                                    React.DOM.th null, 'Số hiệu'
                                                    React.DOM.th null, 'Ký hiệu'
                                                    React.DOM.th null, 'Tên thuốc'
                                                    React.DOM.th null, 'Công ty sản xuất'
                                                    React.DOM.th null, 'Hạn sử dụng'
                                                    React.DOM.th null, 'Số lượng'
                                                    React.DOM.th null, '% thuế'
                                                    React.DOM.th null, 'Giá trên đơn vị'
                                                    React.DOM.th null, 'Ghi chú'
                                                    React.DOM.th null, 'Cách mua'
                                            React.DOM.tbody null,
                                                try
                                                    if @props.RecordChild.length > 0
                                                        for record in @props.RecordChild
                                                            if @props.selectRecord != null
                                                                if record.id == @props.selectRecord.id
                                                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: true, selectRecord: @selectRecordChildOut
                                                                else
                                                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: false, selectRecord: @selectRecordChildOut
                                                            else
                                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: false, selectRecord: @selectRecordChildOut
                                                catch error
                                                    console.log error
                                React.DOM.div className: 'col-sm-3',
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-primary-docapp', icon: 'fa fa-plus', text: ' Thêm', modalid: 'modalbillrecordmini', type: 5
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-secondary-docapp', icon: 'fa fa-trash-o', type: 3, text: ' Xóa', code: {code: 3}, Clicked: @triggercode
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-primary-docapp', icon: 'fa fa-plus-square', text: ' Lấy tổng giá', type: 3, code: 'bill_record', Clicked: @triggerSumChild
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-secondary-docapp', icon: 'fa fa-list', type: 3, text: ' Tải danh sach đã nhập', code: {code: 4}, Clicked: @triggercode
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else
            React.DOM.div className: 'row',
                try
                    React.createElement ModalOutside, id: 'modalbillrecordmini', datatype: 'medicine_bill_record_mini', record: null, grouplist: @props.grouplist, typelist: @props.typelist, currentstation: @props.station, trigger: @triggerAddRecordChildOut, trigger2: @trigger, record_id:
                        if @props.RecordChild.length == 0
                            1
                        else
                            @props.RecordChild[@props.RecordChild.length - 1].id + 1
                catch error
                    console.log 1
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off', id: @props.id,
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã hóa đơn'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_billcode', type: 'text', className: 'form-control', placeholder: 'Mã hóa đơn'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày nhập'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_dayin', type: 'text', className: 'form-control', placeholder: '30/01/1990'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ngày đặt hàng'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_daybook', type: 'text', className: 'form-control', placeholder: '30/01/1990'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Nguồn cung cấp'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_supplier_id', className: 'form-control', type: 'text', style: {'display': 'none'}
                                    React.createElement InputField, id: 'form_supplier', className: 'form-control', type: 'text', code: 'supplier', placeholder: 'Nguồn cung cấp', style: '', trigger: @triggerAutoCompleteInputAlt, trigger2: @triggersafe, trigger3: @triggersafe
                                    React.DOM.div className: "auto-complete",
                                        if @state.autoComplete != null and @state.code == 'supplier'
                                            React.createElement AutoCompleteTable, records: @state.autoComplete, datatype: 'medicine_supplier_mini', header: [{id: 1,name: "Mã"},{id: 2, name: "Tên nguồn"},{id: 3, name: "Người liên lạc"},{id: 4, name: "Điện thoại"}], trigger: @triggerAutoComplete
                            React.DOM.div className: 'form-group',
                                React.DOM.div className: 'col-sm-8',
                                    React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Cách thanh toán'
                                    React.DOM.div className: 'col-sm-3',
                                        React.createElement SelectBox, id: 'form_pmethod', className: 'form-control', text: "Cách thanh toán", type: 4, records: [{id: 1, name: "Tiền mặt"},{id: 2, name: "Chuyển khoản"},{id: 3, name: "Khác"}]
                                    React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Tình trạng hóa đơn'
                                    React.DOM.div className: 'col-sm-3',
                                        React.createElement SelectBox, id: 'form_status', className: 'form-control', text: "Tình trạng hóa đơn", type: 4, records: [{id: 1, name: "Lưu kho"},{id: 2, name: "Đang di chuyển"},{id: 3, name: "Trả lại"}]
                                    React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                                    React.DOM.div className: 'col-sm-9',
                                        React.DOM.textarea id: 'form_remark', type: 'text', style: {'marginTop': '10px'}, className: 'form-control', placeholder: 'Ghi chú'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Tổng giá trị'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_tpayment', type: 'number', className: 'form-control', placeholder: 'Tổng giá trị', onBlur: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Giảm giá'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_discount', type: 'number', className: 'form-control', placeholder: 'Giảm giá', onBlur: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', '% Giảm giá'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_discount_percent', type: 'number', className: 'form-control', placeholder: '% Giảm giá', onBlur: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-5 control-label hidden-xs', 'Thanh toán'
                                    React.DOM.div className: 'col-sm-7',
                                        React.DOM.input id: 'form_tpayout', type: 'number', className: 'form-control', placeholder: 'Thanh toán', onBlur: @triggerRecalPayment
                            React.DOM.div className: 'row',
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.div className: 'card-body table-responsive',
                                        React.DOM.table className: 'table table-hover table-condensed', style: {'backgroundColor': '#414141','color': '#fff'},
                                            React.DOM.thead null,
                                                React.DOM.tr null,
                                                    React.DOM.th null, 'Số hiệu'
                                                    React.DOM.th null, 'Ký hiệu'
                                                    React.DOM.th null, 'Tên thuốc'
                                                    React.DOM.th null, 'Công ty sản xuất'
                                                    React.DOM.th null, 'Hạn sử dụng'
                                                    React.DOM.th null, 'Số lượng'
                                                    React.DOM.th null, '% thuế'
                                                    React.DOM.th null, 'Giá trên đơn vị'
                                                    React.DOM.th null, 'Ghi chú'
                                                    React.DOM.th null, 'Cách mua'
                                            React.DOM.tbody null,
                                                try
                                                    if @props.RecordChild.length > 0
                                                        for record in @props.RecordChild
                                                            if @props.selectRecord != null
                                                                if record.id == @props.selectRecord.id
                                                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: true, selectRecord: @selectRecordChildOut
                                                                else
                                                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: false, selectRecord: @selectRecordChildOut
                                                            else
                                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_bill_record', selected: false, selectRecord: @selectRecordChildOut
                                                catch error
                                                    console.log error
                                React.DOM.div className: 'col-sm-3',
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-primary-docapp', icon: 'fa fa-plus', text: ' Thêm', modalid: 'modalbillrecordmini', type: 5
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-secondary-docapp', icon: 'fa fa-trash-o', type: 3, text: ' Xóa', code: {code: 3}, Clicked: @triggercode
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-primary-docapp', icon: 'fa fa-plus-square', text: ' Lấy tổng giá', type: 3, code: 'bill_record', Clicked: @triggerSumChild
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-secondary-docapp', icon: 'fa fa-list', type: 3, text: ' Tải danh sach đã nhập', code: {code: 4}, Clicked: @triggercode
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewMedicineBillInForm: ->
        if @props.billin != null
            thanhtoan = ""
            tinhtrang = ""
            switch @props.billin.pmethod
                when 1
                    thanhtoan = "Tiền mặt"
                when 2
                    thanhtoan = "Chuyển khoản"
                when 3
                    thanhtoan = "Khác"
            switch @props.billin.status
                when 1
                    tinhtrang = "Lưu kho"
                when 2
                    tinhtrang = "Đang di chuyển"
                when 3
                    tinhtrang = "Trả lại"
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-12',
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'content-app-alt',
                            React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số thứ tự'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.billin.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã hóa đơn'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.billin.billcode
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Nguồn cung cấp'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.billin.supplier
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Ngày đặt'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null,
                                            try
                                                @props.billin.daybook.substring(8, 10) + "/" + @props.billin.daybook.substring(5, 7) + "/" + @props.billin.daybook.substring(0, 4)
                                            catch error
                                                console.log error
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Ngày nhận'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null,
                                            try
                                                @props.billin.dayin.substring(8, 10) + "/" + @props.billin.dayin.substring(5, 7) + "/" + @props.billin.dayin.substring(0, 4)
                                            catch error
                                                console.log error
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tổng giá trị'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.billin.tpayment
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Giảm giá'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.billin.discount
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tổng thanh toán'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.billin.tpayout
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Diễn giải'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.billin.remark
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Phương thức thanh toán'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, thanhtoan
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tình trạng hóa đơn'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, tinhtrang
                    React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'row',
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-delete', type: 3, text: ' Xóa', code: {code: 2}, Clicked: @triggercode
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
    listMedicineBillIn: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Số hóa đơn', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'billcode', type: 1}
                {id: 2, text: 'Người cung cấp', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'supplier', type: 1}
                {id: 3, text: 'Diễn giải', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'remark', type: 1}
                {id: 4, text: 'Ngày nhập', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'dayin', type: 3}
                {id: 5, text: 'Ngày đặt hàng', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'daybook', type: 3}
                {id: 6, text: 'Cách thanh toán', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'pmethod', type: 2, list: [
                    {id: 1, name: "Tiền mặt"}
                    {id: 2, name: "Chuyển khoản"}
                    {id: 3, name: "Khác"}
                ]}
                {id: 7, text: 'Tổng giá trị', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'tpayment', type: 2}
                {id: 8, text: 'Giảm giá', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'discount', type: 2}
                {id: 9, text: 'Tổng thanh toán', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'tpayout', type: 2}
                {id: 10, text: 'Tình trạng hóa đơn', linksearch: 'medicine_bill_in/search', linkfind: 'medicine_bill_in/find', code: 'status', type: 2, list: [
                    {id: 1, name: "Lưu kho"}
                    {id: 2, name: "Đang di chuyển"}
                    {id: 3, name: "Trả lại"}
                ]}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.supplier + " - " + record.billcode, textline2: record.tpayout, datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.supplier + " - " + record.billcode, textline2: record.tpayout, datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'ID'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Mã hóa đơn'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.billcode
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên nguồn'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.supplier
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tổng thanh toán'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.tpayout
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode    
    editMedicinePrescriptForm: ->
        if @props.prescript != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off', id: @props.id,
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Người thanh toán'
                                React.DOM.div className: 'col-sm-9',
                                    React.createElement InputField, id: 'form_payer', className: 'form-control', type: 'text', code: '', placeholder: 'Người thanh toán', defaultValue: @props.prescript.payer, trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                            React.DOM.div className: 'form-group',
                                React.DOM.div className: 'col-md-8',
                                    React.DOM.label className: 'col-sm-3 control-label hidden-xs', 'Ghi chú'
                                    React.DOM.div className: 'col-sm-9',
                                        React.DOM.textarea id: 'form_remark', className: 'form-control', placeholder: 'Ghi chú', defaultValue: @props.prescript.remark
                                React.DOM.div className: 'col-md-4',
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Cách thanh toán'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement SelectBox, id: 'form_pmethod', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Tiền mặt'},{id: 2, name: 'Chuyển khoản'},{id: 3, name: 'Khác'}], text: 'Cách thanh toán'
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng giá trị'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_tpayment', className: 'form-control', type: 'number', placeholder: 'Tổng giá trị', defaultValue: @props.prescript.tpayment, trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggersafe
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Giảm giá'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_discount', className: 'form-control', type: 'number', placeholder: 'Giảm giá', defaultValue: @props.prescript.discount, trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', '% Giảm giá'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_discount_percent', className: 'form-control', type: 'number', step: 'any', placeholder: '% Giảm giá', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                                    React.DOM.label className: 'col-sm-6 control-label hidden-xs', 'Tổng thanh toán'
                                    React.DOM.div className: 'col-sm-6',
                                        React.createElement InputField, id: 'form_tpayout', className: 'form-control', type: 'number', placeholder: 'Tổng thanh toán', defaultValue: @props.prescript.tpayout, trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                            React.DOM.div className: 'row',
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.div className: 'card-body table-responsive',
                                        React.DOM.table className: 'table table-hover table-condensed', style: {'backgroundColor': '#414141','color': '#fff'},
                                            React.DOM.thead null,
                                                React.DOM.tr null,
                                                    React.DOM.th null, 'Mã đơn thuốc'
                                                    React.DOM.th null, 'Tên thuốc'
                                                    React.DOM.th null, 'Tên bệnh nhân'
                                                    React.DOM.th null, 'Liều lượng'
                                                    React.DOM.th null, 'Ghi chú'
                                                    React.DOM.th null, 'Công ty sản xuất'
                                                    React.DOM.th null, 'Giá'
                                                    React.DOM.th null, 'Giảm giá'
                                                    React.DOM.th null, 'Tổng giá trị'
                                                    React.DOM.th null, 'Tình trạng'
                                                    React.DOM.th null, 'Số kiệu'
                                                    React.DOM.th null, 'Ký hiệu'
                                            React.DOM.tbody null,
                                                try
                                                    if @props.RecordChild.length > 0
                                                        for record in @props.RecordChild
                                                            if @props.selectRecord != null
                                                                if record.id == @props.selectRecord.id
                                                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_internal_record', selected: true, selectRecord: @selectRecordChildOut
                                                                else
                                                                    React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_internal_record', selected: false, selectRecord: @selectRecordChildOut
                                                            else
                                                                React.createElement RecordGeneral, key: record.id, record: record, datatype: 'medicine_internal_record', selected: false, selectRecord: @selectRecordChildOut
                                                catch error
                                                    ""
                                React.DOM.div className: 'col-sm-3',
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-secondary-docapp', icon: 'fa fa-pencil', type: 3, text: ' Sửa', code: {code: 5}, Clicked: @triggercode
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-primary-docapp', icon: 'fa fa-plus-square', text: ' Lấy tổng giá', type: 3, code: 'internal_record', Clicked: @triggerSumChild
                                    React.createElement ButtonGeneral, className: 'col-sm-12 btn btn-secondary-docapp', icon: 'fa fa-list', type: 3, text: ' Tải danh sach đã nhập', code: {code: 4}, Clicked: @triggercode
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode        
        else
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode        
    viewMedicinePrescriptForm: ->
        if @props.prescript != null
            thanhtoan = ""
            switch @props.prescript.pmethod
                when 1
                    thanhtoan = "Tiền mặt"
                when 2
                    thanhtoan = "Chuyển khoản"
                when 3
                    thanhtoan = "Khác"
            React.DOM.div className: @props.className,
                React.DOM.div className: 'col-md-12',
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'content-app-alt',
                            React.DOM.div className: 'content-info-block', style: {'marginTop':'40px'},
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số thứ tự'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Mã'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.code
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Số khám bệnh'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.result_id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Bệnh nhân'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.cname
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Bác sỹ kê đơn'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.ename
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Người chuẩn bị'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.preparer
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tổng giá trị'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.tpayment
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Giảm giá'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.discount
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Tổng thanh toán'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.tpayout
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Người thanh toán'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.payer
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Phương thức'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, thanhtoan
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-4 hidden-xs',
                                        React.DOM.p null, 'Ghi chú'
                                    React.DOM.div className: 'col-md-8',
                                        React.DOM.p null, @props.prescript.remark
                    React.DOM.div className: 'row', style:{'paddingRight':'35px', 'paddingBottom':'20px'},
                        React.DOM.div className: 'spacer10'
                        React.DOM.div className: 'row',
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode                       
                            React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-edit', type: 3, text: ' Sửa', code: {code: 1}, Clicked: @triggercode                            
    listMedicinePrescript: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Mã đơn thuốc', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'code', type: 1}
                {id: 2, text: 'Tên bệnh nhân', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'cname', type: 1}
                {id: 3, text: 'Người kê đơn', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'ename', type: 1}
                {id: 4, text: 'Mã khám bệnh', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'number_id', type: 1}
                {id: 5, text: 'Ghi chú', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'remark', type: 1}
                {id: 6, text: 'Người chuẩn bị thuốc', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'preparer', type: 1}
                {id: 7, text: 'Người thanh toán', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'payer', type: 1}
                {id: 8, text: 'Số kết quả khám', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'result_id', type: 2}
                {id: 9, text: 'Ngày kê', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'date', type: 3}
                {id: 10, text: 'Tổng giá trị', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'tpayment', type: 2}
                {id: 11, text: 'Giảm giá', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'discount', type: 2}
                {id: 12, text: 'Tổng thanh toán', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'tpayout', type: 2}
                {id: 13, text: 'Cách thanh toán', linksearch: 'medicine_prescript/search', linkfind: 'medicine_prescript/find', code: 'pmethod', type: 2, list: [
                    {id: 1, name: "Tiền mặt"}
                    {id: 2, name: "Chuyển khoản"}
                    {id: 3, name: "Khác"}
                ]}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt5"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.code + " - " + record.cname + " - " + record.ename, textline2: record.tpayout, datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt5"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.code + " - " + record.cname + " - " + record.ename, textline2: record.tpayout, datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'ID'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Mã đơn thuốc'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.code
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên bệnh nhân'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.cname
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên người kê'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.ename
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode    
    editMedicineInternalRecordForm: ->
        if @props.internalrecord != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off', id: @props.id,
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ký hiệu'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement InputField, defaultValue: @props.internalrecord.signid, id: 'form_signid', className: 'form-control', type: 'text', code: '', placeholder: 'Ký hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số hiệu'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement InputField, defaultValue: @props.internalrecord.noid, id: 'form_noid', className: 'form-control', type: 'text', code: '', placeholder: 'Số hiệu', trigger: @triggersafe, trigger2: @triggersafe, trigger3: @triggersafe
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tình trạng thuốc'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement SelectBox, id: 'form_status', className: 'form-control', Change: @triggersafe, blurOut: @triggersafe, records: [{id: 1, name: 'Đã chuyển hàng'},{id: 2, name: 'Chưa chuyển hàng'},{id: 3, name: 'Khác'}], text: 'Tình trạng'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Ghi chú'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.textarea id: 'form_remark', defaultValue: @props.internalrecord.remark, className: 'form-control', placeholder: 'Ghi chú'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Số lượng'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement InputField, defaultValue: @props.internalrecord.amount, id: 'form_amount', className: 'form-control', type: 'number', code: '', placeholder: 'Số lượng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Giá'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement InputField, defaultValue: @props.internalrecord.price, id: 'form_price', className: 'form-control', type: 'number', code: 'form_price', placeholder: 'Tên thuốc', style: '', trigger: @triggersafe, trigger3: @triggersafe, trigger2: @triggerRecalPayment
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tổng'
                                React.DOM.div className: 'col-sm-2',
                                    React.createElement InputField, defaultValue: @props.internalrecord.tpayment, id: 'form_tpayment', className: 'form-control', type: 'number', code: '', placeholder: 'Tổng', trigger: @triggersafe, trigger2: @triggerRecalPayment, trigger3: @triggersafe
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode        
        else
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
    editMedicineStockrecordForm: ->
        if @props.stockrecord != null
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số', defaultValue: @props.stockrecord.noid
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên doanh nghiệp'
                                React.DOM.div className: 'col-sm-10',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên doanh nghiệp sản xuất', defaultValue: @props.stockrecord.name
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT', defaultValue: @props.stockrecord.pnumber
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Email'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email', defaultValue: @props.stockrecord.email
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ', defaultValue: @props.stockrecord.email
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-link"
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_website', type: 'text', className: 'form-control', placeholder: 'Website', defaultValue: @props.stockrecord.website
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế', defaultValue: @props.stockrecord.taxcode
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
        else
            React.DOM.div className: 'row',
                React.DOM.div className: 'row',
                    React.DOM.div className: 'col-md-12',
                        React.DOM.form className: 'form-horizontal content-app-alt', autoComplete: 'off',
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số'
                                React.DOM.div className: 'col-sm-2',
                                    React.DOM.input id: 'form_noid', type: 'text', className: 'form-control', placeholder: 'Mã số'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Tên doanh nghiệp'
                                React.DOM.div className: 'col-sm-10',
                                    React.DOM.input id: 'form_name', type: 'text', className: 'form-control', placeholder: 'Tên doanh nghiệp sản xuất'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'SĐT'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_pnumber', type: 'text', className: 'form-control', placeholder: 'SĐT'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Email'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_email', type: 'text', className: 'form-control', placeholder: 'Email'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Địa chỉ'
                                React.DOM.div className: 'col-sm-9',
                                    React.DOM.input id: 'form_address', type: 'text', className: 'form-control', placeholder: 'Địa chỉ'
                            React.DOM.div className: 'form-group',
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs',
                                    React.DOM.i className: "zmdi zmdi-link"
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_website', type: 'text', className: 'form-control', placeholder: 'Website'
                                React.DOM.label className: 'col-sm-2 control-label hidden-xs', 'Mã số thuế'
                                React.DOM.div className: 'col-sm-4',
                                    React.DOM.input id: 'form_taxcode', type: 'text', className: 'form-control', placeholder: 'Mã số thuế'
                    React.DOM.div className: 'col-md-12', style: {'paddingRight':'50px', 'paddingBottom':'25px'},
                        React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Quay lại', code: {code: 2}, Clicked: @triggercode
                        React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: 'zmdi zmdi-floppy', type: 3, text: ' Lưu', code: {code: 1}, Clicked: @triggercode
    viewMedicineStockrecordForm: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Số hiệu', linksearch: 'medicine_stock_record/search', linkfind: '#', code: 'noid', type: 1}
                {id: 2, text: 'Ký hiệu', linksearch: 'medicine_stock_record/search', linkfind: '#', code: 'signid', type: 1}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt3"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.noid + " - " + record.signid, textline2: record.amount, datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt3"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.noid + " - " + record.signid, textline2: record.amount, datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'ID'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên thuốc'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @props.stockrecord.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số hiệu'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.noid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Ký hiệu'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.signid
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số lượng còn'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.amount
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode
    listMedicineStockrecord: ->
        React.DOM.div className: 'row',
            React.createElement FilterFormAppView, station: @props.station, datatype: 1, triggerStoreRecord: @triggerStoreRecordNext, triggerSortAltUp: @triggerSortAltUpNext, triggerSortAltDown: @triggerSortAltDownNext, triggerClear: @triggerClearAlt, triggerSubmitSearch: @triggerSubmitSearchAlt, triggerAutoCompleteFast: @triggerAutoCompleteFast, options: [
                {id: 1, text: 'Tên thuốc', linksearch: 'medicine_sample/search', linkfind: '#', code: 'name', type: 1}
            ]
            try
                React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form', style: {'paddingTop': '0', 'paddingBottom': '0', 'overflow':'hidden'},
                    if @state.filteredRecord != null
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    else
                        React.createElement Paginate, className: 'col-sm-8', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                    React.DOM.div className: 'col-sm-2', style: {'paddingBottom': '5px'},
                        React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
            catch error
                console.log error
            React.DOM.div className: 'col-sm-8 p-15 p-l-25 p-r-25',
                try
                    React.DOM.div className: 'data-list-container',    
                        if @state.filteredRecord != null
                            for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name, textline2: record.qty, datatype: 2, trigger: @triggerSelectRecord
                        else
                            for record in @state.records[@state.firstcount...@state.lastcount]
                                expand = ""
                                if @state.record != null
                                    if record.id == @state.record.id
                                        expand = "activeselt1"
                                React.createElement CustomerRecordBlock, key: record.id, record: record, selectExpand: expand, textline1: record.name, textline2: record.qty, datatype: 2, trigger: @triggerSelectRecord
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-4',
                try
                    React.DOM.div className: 'row animated flipInY',
                        React.DOM.div className: 'col-sm-12 p-r-25', style: {'paddingLeft':'0', 'marginBottom': '3px'},
                            React.DOM.div className: 'content-info-block',
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'ID'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.id
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Tên thuốc'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.name
                                React.DOM.div className: 'row',
                                    React.DOM.div className: 'col-md-6 hidden-xs',
                                        React.DOM.p null, 'Số lượng còn lại'
                                    React.DOM.div className: 'col-md-6',
                                        React.DOM.p null, @state.record.qty
                        React.DOM.div className: 'col-sm-12 p-l-res-25 p-r-25', 
                            React.createElement ButtonGeneral, className: 'btn btn-newdesign', icon: 'zmdi zmdi-eye', type: 3, text: ' chi tiết', code: {code: 2}, Clicked: @triggerCodeAndBackUp
                catch error
                    console.log error
            React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25',
                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right col-md-3', icon: 'zmdi zmdi-arrow-left', type: 3, text: ' Trở về', code: {code: 3}, Clicked: @triggercode
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
            when 8
                try
                    @viewListCustomer()
                catch error
                    console.log error
                    React.DOM.div className: 'row'
            when 9
                @listRecordRender()
            when 10#medicinesample form
                @editMedicineSampleForm()
            when 11#medicinesample view form
                @viewMedicineSampleForm()
            when 12#medicinesample list view
                @listMedicineSample()
            when 13#medicine company form
                @editMedicineCompanyForm()
            when 14#medicine Company view form
                @viewMedicineCompanyForm()
            when 15#medicine Company list view
                @listMedicineCompany()
            when 16#medicine Supplier form
                @editMedicineSupplierForm()
            when 17#medicine Supplier view form
                @viewMedicineSupplierForm()
            when 18#medicine Supplier list view
                @listMedicineSupplier()
            when 19#medicine Price form
                @editMedicinePriceForm()
            when 20#medicine Price view form
                @viewMedicinePriceForm()
            when 21#medicine Price list view
                @listMedicinePrice()
            when 22#medicine BillIn form
                @editMedicineBillInForm()
            when 23#medicine BillIn view form
                @viewMedicineBillInForm()
            when 24#medicine BillIn list view
                @listMedicineBillIn()
            when 25#medicine Prescript form
                @editMedicinePrescriptForm()
            when 26#medicine Prescript view form
                @viewMedicinePrescriptForm()
            when 27#medicine Prescript list view
                @listMedicinePrescript()
            #when 28#medicine Stockrecord form
            #    @editMedicineStockrecordForm()
            when 29#medicine Stockrecord view form
                @viewMedicineStockrecordForm()
            when 30#medicine Stockrecord list view
                @listMedicineStockrecord()
            when 31#medicine Internal Record Edit view
                @editMedicineInternalRecordForm()
                
@CustomerRecordBlock = React.createClass
    getInitialState: ->
        style: 1
    triggerRecord: ->
        @props.trigger @props.record
    normalRender: ->
        React.DOM.div className: 'customer-block', onClick: @triggerRecord,
            React.DOM.img className: 'customer-block-img', src: @props.record.avatar
            React.DOM.span className: 'customer-info-block',
                React.DOM.p null, @props.record.cname
                React.DOM.p null,
                    try
                        @props.record.dob.substring(8, 10) + "/" + @props.record.dob.substring(5, 7) + "/" + @props.record.dob.substring(0, 4)
                    catch error
                        "Không có"
    headerTabBlockRender: ->
        if @props.current == @props.record.id
            React.DOM.div className: "header-tab-container active", onClick: @triggerRecord,
                React.DOM.i className: @props.record.icon
                React.DOM.p className: 'hidden-xs', @props.record.text
        else
            React.DOM.div className: "header-tab-container", onClick: @triggerRecord,
                React.DOM.i className: @props.record.icon
                React.DOM.p className: 'hidden-xs', @props.record.text
    dataListBlock: ->
        React.DOM.div className: 'data-list-child ' + @props.selectExpand, style: {'cursor': 'pointer'}, onClick: @triggerRecord,
            React.DOM.div className: 'ticketid', @props.record.id
            React.DOM.div className: 'info',
                React.DOM.div className: 'textline1', @props.textline1
                React.DOM.div className: 'textline2', @props.textline2
    render: ->
        switch @props.datatype
            when 1
                @headerTabBlockRender()
            when 2
                @dataListBlock()
            else
                @normalRender()

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
            when 2#permissionlist
                for record in @props.record
                    dataSet.push record
            when 3#list task
                for record in @props.record
                    dataSet.push record
        return dataSet
    moveup: ->
        dataSet = @getData()
        newview = @state.curentview + 1
        try
            if newview >= dataSet.length
                newview = newview - dataSet.length
        catch error
            console.log error
        @setState curentview: newview
    movedown: ->
        dataSet = @getData()
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
        try
            dataSet = @getData()
            switch dataSet.length
                when 0
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'col-sm-12',
                            React.DOM.div className: 'content-app', style: {'display':'table', 'color': '#fff', 'width': '100%'},
                                React.DOM.p style: {'display': 'table-cell', 'verticalAlign': 'middle', 'textAlign': 'center'}, "Không có mục lựa chọn nào"
                when 1
                    React.DOM.div className: 'row',
                        React.createElement StationContentApp, datatype: @props.datatype, record: dataSet[0], className: 'col-sm-12 animated fadeIn', hidden: false, trigger: @triggerCode
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
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-6 animated fadeIn', hidden: false, trigger: @triggerCode
                            else
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-6 animated fadeIn', hidden: true, trigger: @triggerCode
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
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerCode
                            else
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerCode
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
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerCode
                            else
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerCode
                        React.DOM.div className: 'side-left-button', onClick: @movedown,
                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                        React.DOM.div className: 'side-right-button', onClick: @moveup,
                            React.DOM.i className: 'zmdi zmdi-chevron-right'
        catch error
            dataSet = @getData()
            switch dataSet.length
                when 0
                    React.DOM.div className: 'row',
                        React.DOM.div className: 'col-sm-12',
                            React.DOM.div className: 'content-app', style: {'display':'table', 'color': '#fff', 'width': '100%'},
                                React.DOM.p style: {'display': 'table-cell', 'verticalAlign': 'middle', 'textAlign': 'center'}, "Không có mục lựa chọn nào"
                when 1
                    React.DOM.div className: 'row',
                        React.createElement StationContentApp, datatype: @props.datatype, record: dataSet[0], className: 'col-sm-12 animated fadeIn', hidden: false, trigger: @triggerCode
                when 2
                    count = 0
                    i = 0 - 1
                    React.DOM.div className: 'row',    
                        while count < 2
                            count = count + 1
                            i = i + 1
                            if i >= dataSet.length
                                i = i - dataSet.length
                            if i == 0
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-6 animated fadeIn', hidden: false, trigger: @triggerCode
                            else
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-6 animated fadeIn', hidden: true, trigger: @triggerCode
                        React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedown,
                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                        React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveup,
                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                when 3
                    count = 0
                    i = 0 - 1
                    React.DOM.div className: 'row',
                        while count < 3
                            count = count + 1
                            i = i + 1
                            if i >= dataSet.length
                                i = i - dataSet.length
                            if i == 0
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerCode
                            else
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerCode
                        React.DOM.div className: 'side-left-button visible-table-xs', onClick: @movedown,
                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                        React.DOM.div className: 'side-right-button visible-table-xs', onClick: @moveup,
                            React.DOM.i className: 'zmdi zmdi-chevron-right'
                else
                    count = 0
                    i = 0 - 1
                    React.DOM.div className: 'row',    
                        while count < 3
                            count = count + 1
                            i = i + 1
                            if i >= dataSet.length
                                i = i - dataSet.length
                            if i == 0
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: false, trigger: @triggerCode
                            else
                                React.createElement StationContentApp, key: dataSet[i].id, datatype: @props.datatype, record: dataSet[i], className: 'col-sm-4 animated fadeIn', hidden: true, trigger: @triggerCode
                        React.DOM.div className: 'side-left-button', onClick: @movedown,
                            React.DOM.i className: 'zmdi zmdi-chevron-left'
                        React.DOM.div className: 'side-right-button', onClick: @moveup,
                            React.DOM.i className: 'zmdi zmdi-chevron-right'
    render: ->
        switch @props.datatype
            when 1# station
                @normalRender()
            when 2# permission
                @normalRender()
            when 3#list task
                @normalRender()
                
@FilterFormAppView = React.createClass
    getInitialState: ->
        style: 1
        task: 1
        storeRecords: null
        selectList: null
        autoComplete: null
        normalTask: [{id: 1, icon: "zmdi zmdi-search", code: 1, text: "Tìm kiếm"},{id: 2, icon: "fa fa-cogs", code: 2, text: "Tùy chọn"},{id: 3, icon: "fa fa-sort", code: 3, text: "Sắp xếp"}]
    changeTask: (record) ->
        @setState task: record.code
    triggerChangeType: ->
        option = @getOption()
        if option.id != 0
            if option.list != undefined
                console.log option.list
                @setState selectList: option.list
            else
                @setState selectList: null
    triggerAutoCompleteInput: ->
        optionRecord = @getOption()
        if optionRecord.list != undefined
            valueSearch = Number($('#filter_text').val())
        else
            valueSearch = $('#filter_text').val().toLowerCase()
        option1 = $('#checkbox_db').is(':checked')
        option2 = $('#checkbox_db_2').is(':checked')
        if !option1
            @props.triggerAutoCompleteFast optionRecord, valueSearch
        else
            formData = new FormData
            formData.append 'id_station', @props.station.id
            formData.append optionRecord.code, valueSearch
            $.ajax
                url: '/' + optionRecord.linksearch
                type: 'POST'
                data: formData
                async: false
                cache: false
                contentType: false
                processData: false
                success: ((result) ->
                    @setState autoComplete: result
                    return
                ).bind(this)
    triggerAutoCompleteAlt: (record) ->
        option = @getOption()
        if option.id != 0
            $('#filter_text').val(record[option.code])
        @setState autoComplete: null
    triggerSubmitSearch: ->
        optionRecord = @getOption()
        if optionRecord.list != undefined
            valueSearch = Number($('#filter_text').val())
        else
            valueSearch = $('#filter_text').val().toLowerCase()
        @props.triggerSubmitSearch optionRecord, valueSearch
    triggerClear: ->
        optionRecord = @getOption()
        @props.triggerClear optionRecord
    triggerSortAltDown: ->
        optionRecord = @getOption2()
        @props.triggerSortAltDown optionRecord
    triggerSortAltUp: ->
        optionRecord = @getOption2()
        @props.triggerSortAltUp optionRecord
    triggerStoreRecord: ->
        option2 = $('#checkbox_db_2').is(':checked')
        @props.triggerStoreRecord option2
    getOption: ->
        optionOut = {id: 0, text: 'none', code: 'none'}
        for option in @props.options
            if option.id == Number($('#filter_type_select').val())
                optionOut = option
                break
        return optionOut
    getOption2: ->
        optionOut = 0
        for option in @props.options
            if option.id == Number($('#filter_type_select2').val())
                optionOut = option
                break
        return optionOut
    normalRender: ->
        React.DOM.div className: 'col-sm-12 p-15 p-l-25 p-r-25 filter-form',
            React.DOM.div className: 'input-form-app-header',
                for tabrecord in @state.normalTask
                    React.createElement CustomerRecordBlock, record: tabrecord, current: @state.task, datatype: 1, key: tabrecord.id, trigger: @changeTask
            switch @state.task
                when 1
                    React.DOM.div className: 'input-form-app-filter',
                        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
                                    React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
                                    for option in @props.options
                                        React.DOM.option key: option.id, value: option.id, option.text
                        React.DOM.div className: 'form-group col-lg-6 col-sm-12',
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                if @state.selectList == null
                                    React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Nhập thông tin'
                                else
                                    React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "Click để chọn", records: @state.selectList, blurOut: @triggerAutoCompleteInput
                                React.DOM.div className: "auto-complete",
                                    if @state.autoComplete != null
                                        for record in @state.autoComplete
                                            try
                                                React.createElement AutoComplete, key: record.id, text: record[@getOption().code], record: record, trigger: @triggerAutoCompleteAlt
                                            catch error
                                                console.log error
                        React.DOM.div className: 'col-lg-12 text-center',
                            React.DOM.div className: 'btn-group text-center', style: {'marginBottom':'10px','paddingLeft':'15px', 'paddingRight':'15px','width':'100%'},
                                React.DOM.button type: 'button', className: 'btn btn-group-left', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSubmitSearch,
                                    React.DOM.i className: 'zmdi zmdi-search'
                                    ' Tìm kiếm'
                                React.DOM.button type: 'button', className: 'btn btn-group-right', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerClear,
                                    React.DOM.i className: 'zmdi zmdi-close'
                                    ' Về ban đầu'
                        React.DOM.div className: 'form-group col-sm-12', style: {'display':'none'},
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db', type: 'checkbox'  
                                "Gợi ý"
                        React.DOM.div className: 'form-group col-sm-12', style: {'display':'none'},
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db_2', type: 'checkbox', onChange: @triggerStoreRecord
                                "Dữ liệu hiện tại"
                        React.DOM.div className: 'form-group col-lg-12 col-sm-12', style: {'display':'none'},
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                React.DOM.select id: 'filter_type_select2', className: 'form-control',
                                    React.DOM.option value: '', 'Chọn tiêu chuẩn sắp xếp'
                                    for option in @props.options
                                        React.DOM.option key: option.id, value: option.id, option.text
                        React.DOM.div className: 'col-lg-12 text-center', style: {'display':'none'},
                            React.DOM.div className: 'btn-group text-center', style: {'marginBottom':'10px','paddingLeft':'15px', 'paddingRight':'15px','width':'100%'},
                                React.DOM.button type: 'button', className: 'btn btn-group-left', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSortAltDown,
                                    React.DOM.i className: 'zmdi zmdi-sort-amount-desc'
                                    ' Giảm dần'
                                React.DOM.button type: 'button', className: 'btn btn-group-right', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSortAltUp,
                                    React.DOM.i className: 'zmdi zmdi-sort-amount-asc'
                                    ' Tăng dần'
                when 2
                    React.DOM.div className: 'input-form-app-filter',
                        React.DOM.div className: 'form-group col-lg-6 col-sm-12', style: {'display':'none'},
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
                                    React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
                                    for option in @props.options
                                        React.DOM.option key: option.id, value: option.id, option.text
                        React.DOM.div className: 'form-group col-lg-6 col-sm-12', style: {'display':'none'},
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                if @state.selectList == null
                                    React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Input'
                                else
                                    React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
                                React.DOM.div className: "auto-complete",
                                    if @state.autoComplete != null
                                        for record in @state.autoComplete
                                            try
                                                React.createElement AutoComplete, key: record.id, text: record[@getOption().code], record: record, trigger: @triggerAutoCompleteAlt
                                            catch error
                                                console.log error
                        React.DOM.div className: 'col-lg-12 text-center', style: {'display':'none'},
                            React.DOM.div className: 'btn-group text-center', style: {'marginBottom':'10px','paddingLeft':'15px', 'paddingRight':'15px','width':'100%'},
                                React.DOM.button type: 'button', className: 'btn btn-group-left', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSubmitSearch,
                                    React.DOM.i className: 'zmdi zmdi-search'
                                    ' Tìm kiếm'
                                React.DOM.button type: 'button', className: 'btn btn-group-right', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerClear,
                                    React.DOM.i className: 'zmdi zmdi-close'
                                    ' Về ban đầu'
                        React.DOM.div className: 'form-group col-sm-12', style: {,'textAlign':'justify'},
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db', type: 'checkbox'  
                                "Gợi ý"
                        React.DOM.div className: 'form-group col-sm-12', style: {,'textAlign':'justify'},
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db_2', type: 'checkbox', onChange: @triggerStoreRecord
                                "Dữ liệu hiện tại"
                        React.DOM.div className: 'form-group col-lg-12 col-sm-12', style: {'display':'none'},
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                React.DOM.select id: 'filter_type_select2', className: 'form-control', onChange: @triggerChangeType,
                                    React.DOM.option value: '', 'Chọn tiêu chuẩn sắp xếp'
                                    for option in @props.options
                                        React.DOM.option key: option.id, value: option.id, option.text
                        React.DOM.div className: 'col-lg-12 text-center', style: {'display':'none'},
                            React.DOM.div className: 'btn-group text-center', style: {'marginBottom':'10px','paddingLeft':'15px', 'paddingRight':'15px','width':'100%'},
                                React.DOM.button type: 'button', className: 'btn btn-group-left', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSortAltDown,
                                    React.DOM.i className: 'zmdi zmdi-sort-amount-desc'
                                    ' Giảm dần'
                                React.DOM.button type: 'button', className: 'btn btn-group-right', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSortAltUp,
                                    React.DOM.i className: 'zmdi zmdi-sort-amount-asc'
                                    ' Tăng dần'
                when 3
                    React.DOM.div className: 'input-form-app-filter',
                        React.DOM.div className: 'form-group col-lg-6 col-sm-12', style: {'display':'none'},
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                React.DOM.select id: 'filter_type_select', className: 'form-control', onChange: @triggerChangeType,
                                    React.DOM.option value: '', 'Chọn tiêu chuẩn lọc'
                                    for option in @props.options
                                        React.DOM.option key: option.id, value: option.id, option.text
                        React.DOM.div className: 'form-group col-lg-6 col-sm-12', style: {'display':'none'},
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                if @state.selectList == null
                                    React.DOM.input id: 'filter_text', type: 'text', className: 'form-control', defaultValue: '', onChange: @triggerAutoCompleteInput, placeholder: 'Input'
                                else
                                    React.createElement SelectBox, id: 'filter_text', className: 'form-control', type: 4, text: "", records: @state.selectList, blurOut: @triggerAutoCompleteInput
                                React.DOM.div className: "auto-complete",
                                    if @state.autoComplete != null
                                        for record in @state.autoComplete
                                            try
                                                React.createElement AutoComplete, key: record.id, text: record[@getOption().code], record: record, trigger: @triggerAutoCompleteAlt
                                            catch error
                                                console.log error
                        React.DOM.div className: 'col-lg-12 text-center', style: {'display':'none'},
                            React.DOM.div className: 'btn-group text-center', style: {'marginBottom':'10px','paddingLeft':'15px', 'paddingRight':'15px','width':'100%'},
                                React.DOM.button type: 'button', className: 'btn btn-group-left', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSubmitSearch,
                                    React.DOM.i className: 'zmdi zmdi-search'
                                    ' Tìm kiếm'
                                React.DOM.button type: 'button', className: 'btn btn-group-right', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerClear,
                                    React.DOM.i className: 'zmdi zmdi-close'
                                    ' Về ban đầu'
                        React.DOM.div className: 'form-group col-sm-12', style: {'display':'none'},
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db', type: 'checkbox'  
                                "Gợi ý"
                        React.DOM.div className: 'form-group col-sm-12', style: {'display':'none'},
                            React.DOM.label className: 'checkbox checkbox-inline m-r-20', style: {'color': '#8191B1'},
                                React.DOM.input id: 'checkbox_db_2', type: 'checkbox', onChange: @triggerStoreRecord
                                "Dữ liệu hiện tại"
                        React.DOM.div className: 'form-group col-lg-12 col-sm-12',
                            React.DOM.div className: 'col-sm-12', style: {'marginBottom': '15px'},
                                React.DOM.select id: 'filter_type_select2', className: 'form-control', onChange: @triggerChangeType,
                                    React.DOM.option value: '', 'Chọn tiêu chuẩn sắp xếp'
                                    for option in @props.options
                                        React.DOM.option key: option.id, value: option.id, option.text
                        React.DOM.div className: 'col-lg-12 text-center',
                            React.DOM.div className: 'btn-group text-center', style: {'marginBottom':'10px','paddingLeft':'15px', 'paddingRight':'15px','width':'100%'},
                                React.DOM.button type: 'button', className: 'btn btn-group-left', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSortAltDown,
                                    React.DOM.i className: 'zmdi zmdi-sort-amount-desc'
                                    ' Giảm dần'
                                React.DOM.button type: 'button', className: 'btn btn-group-right', style: {'width':'50%', 'overflow':'hidden', 'textOverflow':'ellipsis'}, onClick: @triggerSortAltUp,
                                    React.DOM.i className: 'zmdi zmdi-sort-amount-asc'
                                    ' Tăng dần'
    render: ->
        switch @props.datatype
            when 1
                @normalRender()
            else
                @normalRender()