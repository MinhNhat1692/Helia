@Section = React.createClass
    getInitialState: ->
      type: 1
      data: @props.data
      task: 11 #11 - employee
      toggled: false
      profile:
        type: 0, active: false, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
        records: [
          {code: 5, active: false, name: 'Hỗ trợ'},
          {code: 6, active: false, name: 'Settings'},
          {code: 7, active: false, name: 'Log Out'}
        ]
      homeMenu: 
        type: 1, className: 'zmdi zmdi-home', active: false, name: "Home", code: 1
      Header:
        type: 2, className: 'zmdi zmdi-view-compact', active: false, name: "Header"
        records: [
          {code: 2, active: false, name: 'Top'},
          {code: 3, active: false, name: 'Middle'},
          {code: 4, active: false, name: 'Bottom'}
        ]
      DataInput:
        type: 2, className: 'zmdi zmdi-view-list', active: true, name: "Nhập dữ liệu gốc",
        records: [
          {code: 11, active: true, name: 'Danh sách nhân viên'},
          {code: 12, active: false, name: 'Danh sách phòng'},
          {code: 13, active: false, name: 'Danh sách chức vụ'},
          {code: 14, active: false, name: 'Danh sách dịch vụ'}
        ]
      DataLink:
        type: 2, className: 'fa fa-link', active: false, name: "Liên kết dữ liệu",
        records: [
          {code: 21, active: false, name: 'Liên kết chức vụ'},
          {code: 22, active: false, name: 'Liên kết dịch vụ'}
        ]
      Patient:
        type: 2, className: 'zmdi zmdi-account', active: false, name: "Bệnh nhân",
        records: [
          {code: 31, active: false, name: 'Danh sách bệnh nhân'}
          {code: 32, active: false, name: 'Danh sách phiếu khám'}
          {code: 33, active: false, name: 'Thông tin điều trị'}
          {code: 34, active: false, name: 'Thông tin khám'}
          {code: 35, active: false, name: 'Danh sách hóa đơn'}
        ]    
      Doctor: {type: 1, className: 'fa fa-user-md', active: false, name: "Trình tác vụ của bác sỹ", code: 60}
      Pharmacy:
        type: 2, className: 'fa fa-medkit', active: false, name: "Quản lý thuốc",
        records: [
          {code: 41, active: false, name: 'Nguồn cấp thuốc'},
          {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
          {code: 43, active: false, name: 'Mẫu thuốc'},
          {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
          {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
          {code: 46, active: false, name: 'Thông tin giá thuốc'},
          {code: 47, active: false, name: 'Đơn thuốc ngoài'},
          {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
          {code: 49, active: false, name: 'Đơn thuốc trong'},
          {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
          {code: 51, active: false, name: 'Thống kê kho thuốc'}
        ]
    Trigger: (code) ->
      if code == 1
        @setState homeMenu:
          type: 1, className: 'zmdi zmdi-home', active: true, name: "Home", code: 1
      else
        @setState homeMenu:
          type: 1, className: 'zmdi zmdi-home', active: false, name: "Home", code: 1
      if code == 2
        @setState Header:
          type: 2, className: 'zmdi zmdi-view-compact', active: true, name: "Header"
          records: [
            {code: 2, active: true, name: 'Top'},
            {code: 3, active: false, name: 'Middle'},
            {code: 4, active: false, name: 'Bottom'}
          ]
      else if code == 3
        @setState Header:
          type: 2, className: 'zmdi zmdi-view-compact', active: true, name: "Header"
          records: [
            {code: 2, active: false, name: 'Top'},
            {code: 3, active: true, name: 'Middle'},
            {code: 4, active: false, name: 'Bottom'}
          ]
      else if code == 4
        @setState Header:
          type: 2, className: 'zmdi zmdi-view-compact', active: true, name: "Header"
          records: [
            {code: 2, active: false, name: 'Top'},
            {code: 3, active: false, name: 'Middle'},
            {code: 4, active: true, name: 'Bottom'}
          ]
      else
        @setState Header:
          type: 2, className: 'zmdi zmdi-view-compact', active: false, name: "Header"
          records: [
            {code: 2, active: false, name: 'Top'},
            {code: 3, active: false, name: 'Middle'},
            {code: 4, active: false, name: 'Bottom'}
          ]
      if code == 5
        data =
          task: 5
          link: '/support/list'
        @handleGetdata(data)
        @setState profile:
          type: 0, active: true, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: true, name: 'Hỗ trợ'},
            {code: 6, active: false, name: 'Settings'},
            {code: 7, active: false, name: 'Log Out'}
          ]
      else if code == 6
        @setState profile:
          type: 0, active: true, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: false, name: 'Hỗ trợ'},
            {code: 6, active: true, name: 'Settings'},
            {code: 7, active: false, name: 'Log Out'}
          ]
      else if code == 7
        @setState profile:
          type: 0, active: true, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: false, name: 'Hỗ trợ'},
            {code: 6, active: false, name: 'Settings'},
            {code: 7, active: true, name: 'Log Out'}
          ]
      else
        @setState profile:
          type: 0, active: false, logo: @props.station.logo, sname: @props.station.sname, username: @props.username,
          records: [
            {code: 5, active: false, name: 'Hỗ trợ'},
            {code: 6, active: false, name: 'Settings'},
            {code: 7, active: false, name: 'Log Out'}
          ]
      if code == 11 #employee
        data =
          task: 11
          link: '/employee/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2, className: 'zmdi zmdi-view-list', active: true, name: "Nhập dữ liệu gốc",
          records: [
            {code: 11, active: true, name: 'Danh sách nhân viên'},
            {code: 12, active: false, name: 'Danh sách phòng'},
            {code: 13, active: false, name: 'Danh sách chức vụ'},
            {code: 14, active: false, name: 'Danh sách dịch vụ'}
          ]
      else if code == 12 #room
        data =
          task: 12
          link: '/room/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2, className: 'zmdi zmdi-view-list', active: true, name: "Nhập dữ liệu gốc",
          records: [
            {code: 11, active: false, name: 'Danh sách nhân viên'},
            {code: 12, active: true, name: 'Danh sách phòng'},
            {code: 13, active: false, name: 'Danh sách chức vụ'},
            {code: 14, active: false, name: 'Danh sách dịch vụ'}
          ]
      else if code == 13 #position
        data =
          task: 13
          link: '/position/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2, className: 'zmdi zmdi-view-list', active: true, name: "Nhập dữ liệu gốc",
          records: [
            {code: 11, active: false, name: 'Danh sách nhân viên'},
            {code: 12, active: false, name: 'Danh sách phòng'},
            {code: 13, active: true, name: 'Danh sách chức vụ'},
            {code: 14, active: false, name: 'Danh sách dịch vụ'}
          ]
      else if code == 14 #service
        data =
          task: 14
          link: '/service/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2, className: 'zmdi zmdi-view-list', active: true, name: "Nhập dữ liệu gốc",
          records: [
            {code: 11, active: false, name: 'Danh sách nhân viên'},
            {code: 12, active: false, name: 'Danh sách phòng'},
            {code: 13, active: false, name: 'Danh sách chức vụ'},
            {code: 14, active: true, name: 'Danh sách dịch vụ'}
          ]
      else
        @setState DataInput:
          type: 2, className: 'zmdi zmdi-view-list', active: false, name: "Nhập dữ liệu gốc",
          records: [
            {code: 11, active: false, name: 'Danh sách nhân viên'},
            {code: 12, active: false, name: 'Danh sách phòng'},
            {code: 13, active: false, name: 'Danh sách chức vụ'},
            {code: 14, active: false, name: 'Danh sách dịch vụ'}
          ]
      if code == 21 #employee link
        data =
          task: 21
          link: '/position_mapping/list'
        @handleGetdata(data)
        @setState DataLink:
          type: 2, className: 'fa fa-link', active: true, name: "Liên kết dữ liệu",
          records: [
            {code: 21, active: true, name: 'Liên kết chức vụ'},
            {code: 22, active: false, name: 'Liên kết dịch vụ'}
          ]
      else if code == 22 #service link
        data =
          task: 22
          link: '/service_mapping/list'
        @handleGetdata(data)
        @setState DataLink:
          type: 2, className: 'fa fa-link', active: true, name: "Liên kết dữ liệu",
          records: [
            {code: 21, active: false, name: 'Liên kết chức vụ'},
            {code: 22, active: true, name: 'Liên kết dịch vụ'}
          ]
      else
        @setState DataLink:
          type: 2, className: 'fa fa-link', active: false, name: "Liên kết dữ liệu",
          records: [
            {code: 21, active: false, name: 'Liên kết chức vụ'},
            {code: 22, active: false, name: 'Liên kết dịch vụ'}
          ]
      if code == 31 #patient list
        data =
          task: 31
          link: '/customer_record/list'
        @handleGetdata(data)
        @setState Patient:
          type: 2, className: 'zmdi zmdi-account', active: true, name: "Bệnh nhân",
          records: [
            {code: 31, active: true, name: 'Danh sách bệnh nhân'}
            {code: 32, active: false, name: 'Danh sách phiếu khám'}
            {code: 33, active: false, name: 'Thông tin điều trị'}
            {code: 34, active: false, name: 'Thông tin khám'}
            {code: 35, active: false, name: 'Danh sách hóa đơn'}
          ]
      else if code == 32
        data =
          task: 32
          link: '/order_map/list'
        @handleGetdata(data)
        @setState Patient:
          type: 2, className: 'zmdi zmdi-account', active: true, name: "Bệnh nhân",
          records: [
            {code: 31, active: false, name: 'Danh sách bệnh nhân'}
            {code: 32, active: true, name: 'Danh sách phiếu khám'}
            {code: 33, active: false, name: 'Thông tin điều trị'}
            {code: 34, active: false, name: 'Thông tin khám'}
            {code: 35, active: false, name: 'Danh sách hóa đơn'}
          ]
      else if code == 33
        data =
          task: 33
          link: '/check_info/list'
        @handleGetdata(data)
        @setState Patient:
          type: 2, className: 'zmdi zmdi-account', active: true, name: "Bệnh nhân",
          records: [
            {code: 31, active: false, name: 'Danh sách bệnh nhân'}
            {code: 32, active: false, name: 'Danh sách phiếu khám'}
            {code: 33, active: true, name: 'Thông tin điều trị'}
            {code: 34, active: false, name: 'Thông tin khám'}
            {code: 35, active: false, name: 'Danh sách hóa đơn'}
          ]
      else if code == 34
        data =
          task: 34
          link: '/doctor_check_info/list'
        @handleGetdata(data)
        @setState Patient:
          type: 2, className: 'zmdi zmdi-account', active: true, name: "Bệnh nhân",
          records: [
            {code: 31, active: false, name: 'Danh sách bệnh nhân'}
            {code: 32, active: false, name: 'Danh sách phiếu khám'}
            {code: 33, active: false, name: 'Thông tin điều trị'}
            {code: 34, active: true, name: 'Thông tin khám'}
            {code: 35, active: false, name: 'Danh sách hóa đơn'}
          ]
      else if code == 35
        data =
          task: 35
          link: '/bill_info/list'
        @handleGetdata(data)
        @setState Patient:
          type: 2, className: 'zmdi zmdi-account', active: true, name: "Bệnh nhân",
          records: [
            {code: 31, active: false, name: 'Danh sách bệnh nhân'}
            {code: 32, active: false, name: 'Danh sách phiếu khám'}
            {code: 33, active: false, name: 'Thông tin điều trị'}
            {code: 34, active: false, name: 'Thông tin khám'}
            {code: 35, active: true, name: 'Danh sách hóa đơn'}
          ]
      else
        @setState Patient:
          type: 2, className: 'zmdi zmdi-account', active: false, name: "Bệnh nhân",
          records: [
            {code: 31, active: false, name: 'Danh sách bệnh nhân'}
            {code: 32, active: false, name: 'Danh sách phiếu khám'}
            {code: 33, active: false, name: 'Thông tin điều trị'}
            {code: 34, active: false, name: 'Thông tin khám'}
            {code: 35, active: false, name: 'Danh sách hóa đơn'}
          ]
      if code == 41 #Pharmacy list
        data =
          task: 41
          link: '/medicine_supplier/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: true, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 42 #medicine company
        data =
          task: 42
          link: '/medicine_company/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: true, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 43 #medicine_sample
        data =
          task: 43
          link: '/medicine_sample/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: true, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 44 #medicine_bill_in
        data =
          task: 44
          link: '/medicine_bill_in/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: true, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 45 #medicine_bill_record Thông tin thuốc nhập kho
        data =
          task: 45
          link: '/medicine_bill_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: true, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 46 #medicine_price Thông tin giá thuốc
        data =
          task: 46
          link: '/medicine_price/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: true, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 47 #medicine_prescript_external Đơn thuốc ngoài
        data =
          task: 47
          link: '/medicine_prescript_external/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: true, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 48 #medicine external_record Thông tin thuốc kê ngoài
        data =
          task: 48
          link: '/medicine_external_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: true, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 49 #medicine_prescript_internal Đơn thuốc trong
        data =
          task: 49
          link: '/medicine_prescript_internal/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: true, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 50 #medicine_internal_record Thông tin thuốc kê trong
        data =
          task: 50
          link: '/medicine_internal_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: true, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      else if code == 51 #medicine_stock_record Thống kê kho thuốc
        data =
          task: 51
          link: '/medicine_stock_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: true, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: true, name: 'Thống kê kho thuốc'}
          ]
      else
        @setState Pharmacy:
          type: 2, className: 'fa fa-medkit', active: false, name: "Quản lý thuốc",
          records: [
            {code: 41, active: false, name: 'Nguồn cấp thuốc'},
            {code: 42, active: false, name: 'Doanh nghiệp sản xuất'},
            {code: 43, active: false, name: 'Mẫu thuốc'},
            {code: 44, active: false, name: 'Hóa đơn nhập thuốc'},
            {code: 45, active: false, name: 'Thông tin thuốc nhập kho'},
            {code: 46, active: false, name: 'Thông tin giá thuốc'},
            {code: 47, active: false, name: 'Đơn thuốc ngoài'},
            {code: 48, active: false, name: 'Thông tin thuốc kê ngoài'},
            {code: 49, active: false, name: 'Đơn thuốc trong'},
            {code: 50, active: false, name: 'Thông tin thuốc kê trong'}
            {code: 51, active: false, name: 'Thống kê kho thuốc'}
          ]
      if code == 60
        @setState Doctor: {type: 1, className: 'fa fa-user-md', active: true, name: "Trình tác vụ của bác sỹ", code: 60}
      else
        @setState Doctor: {type: 1, className: 'fa fa-user-md', active: false, name: "Trình tác vụ của bác sỹ", code: 60}
      
    handleGetdata: (data) ->
      $.ajax
        url: data.link
        type: 'POST'
        dataType: 'JSON'
        success: ((result) ->
          @setState
            data: result
            task: data.task
          $(APP).trigger('rebuild')
          return
        ).bind(this)
    componentWillMount: ->
      $(APP).on 'toggle', ((e) ->
        @setState toggled: !@state.toggled
      ).bind(this)
    normalRender: ->
      React.DOM.section id: 'main',
        React.DOM.aside
          id: 'sidebar'
          className:
            if @state.toggled
              'sidebar'
            else
              'sidebar toggled'
          React.DOM.ul className: 'main-menu',
            React.createElement MenuAside, submenu: @state.profile, Trigger: @Trigger      
            React.createElement MenuAside, submenu: @state.homeMenu, Trigger: @Trigger 
            React.createElement MenuAside, submenu: @state.Header, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.DataInput, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.DataLink, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.Patient, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.Doctor, Trigger: @Trigger 
            React.createElement MenuAside, submenu: @state.Pharmacy, Trigger: @Trigger
        React.DOM.section id: 'content',
          React.createElement MainApp, data: @state.data, task: @state.task
    render: ->
      @normalRender()