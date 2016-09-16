@Section = React.createClass
    getInitialState: ->
      type: 1
      data: @props.data
      task: 1 #1 - employee
      toggled: false
      profile:
        type: 0
        active: false
        logo: @props.station.logo
        sname: @props.station.sname
        username: @props.username
        records: [
          {
            code: 5
            active: false
            name: 'Messages'
          }
          {
            code: 6
            active: false
            name: 'Settings'
          }
          {
            code: 7
            active: false
            name: 'Log Out'
          }
        ]
      homeMenu: 
        type: 1
        className: 'zmdi zmdi-home'
        active: false
        name: "Home"
        code: 1
      Header:
        type: 2
        className: 'zmdi zmdi-view-compact'
        active: false
        name: "Header"
        records: [
          {
            code: 2
            active: false
            name: 'Top'
          }
          {
            code: 3
            active: false
            name: 'Middle'
          }
          {
            code: 4
            active: false
            name: 'Bottom'
          }
        ]
      DataInput:
        type: 2
        className: 'zmdi zmdi-view-list'
        active: true
        name: "Nhập dữ liệu gốc"
        records: [
          {
            code: 11 #employee
            active: true
            name: 'Danh sách nhân viên'
          }
          {
            code: 12 #room
            active: false
            name: 'Danh sách phòng'
          }
          {
            code: 13 #position
            active: false
            name: 'Danh sách chức vụ'
          }
          {
            code: 14 #service
            active: false
            name: 'Danh sách dịch vụ'
          }
        ]
      DataLink:
        type: 2
        className: 'fa fa-link'
        active: false
        name: "Liên kết dữ liệu"
        records: [
          {
            code: 21 #employee link
            active: false
            name: 'Liên kết chức vụ'
          }
          {
            code: 22 #service link
            active: false
            name: 'Liên kết dịch vụ'
          }
        ]
      Patient:
        type: 2
        className: 'zmdi zmdi-account'
        active: false
        name: "Bệnh nhân"
        records: [
          {
            code: 31 #customer record
            active: false
            name: 'Danh sách bệnh nhân'
          }
        ]    
      Pharmacy:
        type: 2
        className: 'fa fa-medkit'
        active: false
        name: "Quản lý thuốc"
        records: [
          {
            code: 41 #Supplier link
            active: false
            name: 'Nguồn cấp thuốc'
          }
          {
            code: 42 #Company medicine
            active: false
            name: 'Doanh nghiệp sản xuất'
          }
          {
            code: 43 #Medicine Sample
            active: false
            name: 'Mẫu thuốc'
          }
          {
            code: 44 #Medicine Bill In
            active: false
            name: 'Hóa đơn nhập thuốc'
          }
          {
            code: 45 #Medicine Sample
            active: false
            name: 'Thông tin thuốc nhập kho'
          }
          {
            code: 46 #Medicine Price
            active: false
            name: 'Thông tin giá thuốc'
          }
          {
            code: 47 #Medicine Prescript External
            active: false
            name: 'Đơn thuốc ngoài'
          }
          {
            code: 48 #Medicine External Record
            active: false
            name: 'Thông tin thuốc kê ngoài'
          }
          {
            code: 49 #Medicine Prescript Internal
            active: false
            name: 'Đơn thuốc trong'
          }
          {
            code: 50 #Medicine Internal Record
            active: false
            name: 'Thông tin thuốc kê trong'
          }
          {
            code: 51 #Medicine Stock Record
            active: false
            name: 'Thống kê kho thuốc'
          }
        ]
    Trigger: (code) ->
      if code == 1
        @setState homeMenu:
          type: 1
          className: 'zmdi zmdi-home'
          active: true
          name: "Home"
          code: 1
      else
        @setState homeMenu:
          type: 1
          className: 'zmdi zmdi-home'
          active: false
          name: "Home"
          code: 1
      if code == 2
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          active: true
          name: "Header"
          records: [
            {
              code: 2
              active: true
              name: 'Top'
            }
            {
              code: 3
              active: false
              name: 'Middle'
            }
            {
              code: 4
              active: false
              name: 'Bottom'
            }
          ]  
      else if code == 3
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          active: true
          name: "Header"
          records: [
            {
              code: 2
              active: false
              name: 'Top'
            }
            {
              code: 3
              active: true
              name: 'Middle'
            }
            {
              code: 4
              active: false
              name: 'Bottom'
            }
          ]
      else if code == 4
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          active: true
          name: "Header"
          records: [
            {
              code: 2
              active: false
              name: 'Top'
            }
            {
              code: 3
              active: false
              name: 'Middle'
            }
            {
              code: 4
              active: true
              name: 'Bottom'
            }
          ]
      else
        @setState Header:
          type: 2
          className: 'zmdi zmdi-view-compact'
          name: "Header"  
          active: false
          records: [
            {
              code: 2
              active: false
              name: 'Top'
            }
            {
              code: 3
              active: false
              name: 'Middle'
            }
            {
              code: 4
              active: false
              name: 'Bottom'
            }
          ]
      if code == 5
        @setState profile:
          type: 0
          active: true
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: true
              name: 'Messages'
            }
            {
              code: 6
              active: false
              name: 'Settings'
            }
            {
              code: 7
              active: false
              name: 'Log Out'
            }
          ]
      else if code == 6
        @setState profile:
          type: 0
          active: true
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: false
              name: 'Messages'
            }
            {
              code: 6
              active: true
              name: 'Settings'
            }
            {
              code: 7
              active: false
              name: 'Log Out'
            }
          ]
      else if code == 7
        @setState profile:
          type: 0
          active: true
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: false
              name: 'Messages'
            }
            {
              code: 6
              active: false
              name: 'Settings'
            }
            {
              code: 7
              active: true
              name: 'Log Out'
            }
          ]
      else
        @setState profile:
          type: 0
          active: false
          logo: @props.station.logo
          sname: @props.station.sname
          username: @props.username
          records: [
            {
              code: 5
              active: false
              name: 'Messages'
            }
            {
              code: 6
              active: false
              name: 'Settings'
            }
            {
              code: 7
              active: false
              name: 'Log Out'
            }
          ]
      if code == 11 #employee
        data =
          task: 1
          link: '/employees/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: true
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      else if code == 12 #room
        data =
          task: 3
          link: '/rooms/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: true
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      else if code == 13 #position
        data =
          task: 2
          link: '/positions/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: true
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      else if code == 14 #service
        data =
          task: 5
          link: '/services/list'
        @handleGetdata(data)
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: true
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: true
              name: 'Danh sách dịch vụ'
            }
          ]
      else
        @setState DataInput:
          type: 2
          className: 'zmdi zmdi-view-list'
          active: false
          name: "Nhập dữ liệu gốc"
          records: [
            {
              code: 11 #employee
              active: false
              name: 'Danh sách nhân viên'
            }
            {
              code: 12 #room
              active: false
              name: 'Danh sách phòng'
            }
            {
              code: 13 #position
              active: false
              name: 'Danh sách chức vụ'
            }
            {
              code: 14 #service
              active: false
              name: 'Danh sách dịch vụ'
            }
          ]
      if code == 21 #employee link
        data =
          task: 4
          link: '/position_mapping/list'
        @handleGetdata(data)
        @setState DataLink:
          type: 2
          className: 'fa fa-link'
          active: true
          name: "Liên kết dữ liệu"
          records: [
            {
              code: 21 #employee link
              active: true
              name: 'Liên kết chức vụ'
            }
            {
              code: 22 #service link
              active: false
              name: 'Liên kết dịch vụ'
            }
          ]
      else if code == 22 #service link
        data =
          task: 6
          link: '/service_mapping/list'
        @handleGetdata(data)
        @setState DataLink:
          type: 2
          className: 'fa fa-link'
          active: true
          name: "Liên kết dữ liệu"
          records: [
            {
              code: 21 #employee link
              active: false
              name: 'Liên kết chức vụ'
            }
            {
              code: 22 #service link
              active: true
              name: 'Liên kết dịch vụ'
            }
          ]
      else
        @setState DataLink:
          type: 2
          className: 'fa fa-link'
          active: false
          name: "Liên kết dữ liệu"
          records: [
            {
              code: 21 #employee link
              active: false
              name: 'Liên kết chức vụ'
            }
            {
              code: 22 #service link
              active: false
              name: 'Liên kết dịch vụ'
            }
          ]
      if code == 31 #patient list
        data =
          task: 7
          link: '/customer_record/list'
        @handleGetdata(data)
        @setState Patient:
          type: 2
          className: 'zmdi zmdi-account'
          active: true
          name: "Bệnh nhân"
          records: [
            {
              code: 31 #customer record
              active: true
              name: 'Danh sách bệnh nhân'
            }
          ]
      else
        @setState Patient:
          type: 2
          className: 'zmdi zmdi-account'
          active: false
          name: "Bệnh nhân"
          records: [
            {
              code: 31 #customer record
              active: false
              name: 'Danh sách bệnh nhân'
            }
          ]
      if code == 41 #Pharmacy list
        data =
          task: 41
          link: '/medicine_supplier/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: true
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 42 #medicine company
        data =
          task: 42
          link: '/medicine_company/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: true
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 43 #medicine_sample
        data =
          task: 43
          link: '/medicine_sample/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: true
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 44 #medicine_bill_in
        data =
          task: 44
          link: '/medicine_bill_in/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: true
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 45 #medicine_bill_record Thông tin thuốc nhập kho
        data =
          task: 45
          link: '/medicine_bill_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Bill Record
              active: true
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 46 #medicine_price Thông tin giá thuốc
        data =
          task: 46
          link: '/medicine_price/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: true
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 47 #medicine_prescript_external Đơn thuốc ngoài
        data =
          task: 47
          link: '/medicine_prescript_external/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: true
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 48 #medicine external_record Thông tin thuốc kê ngoài
        data =
          task: 48
          link: '/medicine_external_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: true
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 49 #medicine_prescript_internal Đơn thuốc trong
        data =
          task: 49
          link: '/medicine_prescript_internal/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: true
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 50 #medicine_internal_record Thông tin thuốc kê trong
        data =
          task: 50
          link: '/medicine_internal_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: true
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
      else if code == 51 #medicine_stock_record Thống kê kho thuốc
        data =
          task: 51
          link: '/medicine_stock_record/list'
        @handleGetdata(data)
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: true
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: true
              name: 'Thống kê kho thuốc'
            }
          ]
      else
        @setState Pharmacy:
          type: 2
          className: 'fa fa-medkit'
          active: false
          name: "Quản lý thuốc"
          records: [
            {
              code: 41 #Supplier link
              active: false
              name: 'Nguồn cấp thuốc'
            }
            {
              code: 42 #Company medicine
              active: false
              name: 'Doanh nghiệp sản xuất'
            }
            {
              code: 43 #Medicine Sample
              active: false
              name: 'Mẫu thuốc'
            }
            {
              code: 44 #Medicine Bill In
              active: false
              name: 'Hóa đơn nhập thuốc'
            }
            {
              code: 45 #Medicine Sample
              active: false
              name: 'Thông tin thuốc nhập kho'
            }
            {
              code: 46 #Medicine Price
              active: false
              name: 'Thông tin giá thuốc'
            }
            {
              code: 47 #Medicine Prescript External
              active: false
              name: 'Đơn thuốc ngoài'
            }
            {
              code: 48 #Medicine External Record
              active: false
              name: 'Thông tin thuốc kê ngoài'
            }
            {
              code: 49 #Medicine Prescript Internal
              active: false
              name: 'Đơn thuốc trong'
            }
            {
              code: 50 #Medicine Internal Record
              active: false
              name: 'Thông tin thuốc kê trong'
            }
            {
              code: 51 #Medicine Stock Record
              active: false
              name: 'Thống kê kho thuốc'
            }
          ]
    handleGetdata: (data) ->
      $.ajax
        url: data.link
        type: 'POST'
        dataType: 'JSON'
        success: ((result) ->
          @setState
            data: result
            task: data.task
          return
        ).bind(this)
    componentWillMount: ->
      $(APP).on 'toggle', ((e) ->
        @setState toggled: !@state.toggled
      ).bind(this)
    normalRender: ->
      React.DOM.section
        id: 'main'
        React.DOM.aside
          id: 'sidebar'
          className:
            if @state.toggled
              'sidebar'
            else
              'sidebar toggled'
          React.DOM.ul
            className: 'main-menu'
            React.createElement MenuAside, submenu: @state.profile, Trigger: @Trigger      
            React.createElement MenuAside, submenu: @state.homeMenu, Trigger: @Trigger 
            React.createElement MenuAside, submenu: @state.Header, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.DataInput, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.DataLink, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.Patient, Trigger: @Trigger
            React.createElement MenuAside, submenu: @state.Pharmacy, Trigger: @Trigger
        React.DOM.section
          id: 'content'
          React.createElement MainApp, data: @state.data, task: @state.task
    render: ->
      @normalRender()