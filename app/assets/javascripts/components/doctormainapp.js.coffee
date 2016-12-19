@DoctorMainApp = React.createClass
    getInitialState: ->
        task: null
        tabheader: "Settings"
        headertextcolor: "fff"
        backgroundimg: "http://www.diqiushijie.com/uploads/2015/10/56251_0.jpg"
        listbg: ["red","pink","purple","deep-purple","indigo","blue", "light-blue","cyan", "teal", "green", "light-green", "lime", "yellow", "amber", "orange", "deep-orange", "brown", "gray", "blue-gray", "black"]
        sidebartoggled: false
        sidebarmenu: [{id:1, code: 1, text: "Work station", icon: "fa fa-building fa-3x"},{id:2, code: 2, text: "Settings", icon: "fa fa-wrench fa-3x"},{id:3, code: 3, text: "Logout", icon: "fa fa-power-off fa-3x"}]
        currentsidebarmenu: null
        doctor: @props.doctor
    trigger: ->
    triggerbycode: (code) ->
        switch code
            when 1
                @trigger
            when 2
                @setState
                    task: 2
                    tabheader: "Cài đặt"
                    currentsidebarmenu: 2
            when 3
                @trigger
    requestData: (code) ->
        switch code
            when 1
            when 2
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
                                    React.DOM.div className: 'col-sm-4',
                                        React.DOM.div className: 'content-app',
                                            React.DOM.h4 null, "PKBS Tạ Thị Loan"
                                            React.DOM.img alt: 'pic1', src: '/assets/settings.svg', className: 'img-responsive'
                                            React.DOM.div className: 'content-info-block',
                                                React.DOM.p null, "267A Vĩnh Hưng, Hoàng Mai, Hà Nội"
                                                React.DOM.p null, "09887231"
                                    React.DOM.div className: 'col-sm-4 hidden-xs',
                                        React.DOM.div className: 'content-app',
                                            React.DOM.h4 null, "PKBS Tạ Thị Loan"
                                            React.DOM.img alt: 'pic2', src: '/assets/monitor.svg', className: 'img-responsive'
                                            React.DOM.div className: 'content-info-block',
                                                React.DOM.p null, "267A Vĩnh Hưng, Hoàng Mai, Hà Nội"
                                                React.DOM.p null, "09887231"
                                    React.DOM.div className: 'col-sm-4 hidden-xs',
                                        React.DOM.div className: 'content-app',
                                            React.DOM.h4 null, "PKBS Tạ Thị Loan"
                                            React.DOM.img alt: 'pic3', src: '/assets/cloud.svg', className: 'img-responsive'
                                            React.DOM.div className: 'content-info-block',
                                                React.DOM.p null, "267A Vĩnh Hưng, Hoàng Mai, Hà Nội"
                                                React.DOM.p null, "09887231"
                                    React.DOM.div className: 'side-left-button',
                                        React.DOM.i className: 'zmdi zmdi-chevron-left'
                                    React.DOM.div className: 'side-right-button',
                                        React.DOM.i className: 'zmdi zmdi-chevron-right'
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
                                                React.createElement ButtonGeneral, className: 'btn btn-secondary-docapp pull-right', icon: "fa fa-repeat", text: ' Reset', type: 2, code: 1, Clicked: @requestData
                                                React.createElement ButtonGeneral, className: 'btn btn-primary-docapp pull-right', icon: "fa fa-floppy-o", text: ' Lưu', type: 2, code: 2, Clicked: @requestData
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
      