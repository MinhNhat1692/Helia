@Records = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.data[0]
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'records'
        React.DOM.h2
          className: 'title'
          'Employee'
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-3x', text: '', type: 2, trigger: @addRecord, datatype: 'employee'
        React.DOM.hr null
        React.createElement RecordForm, handleEmployeeRecord: @addRecord
        React.DOM.hr null
        React.DOM.div
          className: 'table-responsive'
          React.DOM.table
            className: 'table table-bordered'
            React.DOM.thead null,
              React.DOM.tr null,
                React.DOM.th null, 'Name'
                React.DOM.th null, 'Address'
                React.DOM.th null, 'Phone Number'
                React.DOM.th null, 'Ma NV'
                React.DOM.th null, 'Gioi tinh'
                React.DOM.th null, 'Anh'
                React.DOM.th null, 'Hanh dong'
            React.DOM.tbody null,
              for record in @state.records
                React.createElement Record, key: record.id, gender: @props.data[1], record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord


@Rooms = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @replaceState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @replaceState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.records
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'rooms'
        React.DOM.h2
          className: 'title'
          'Room'
        React.createElement RoomForm, handleRoomAdd: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Tên phòng'
              React.DOM.th null, 'Ngôn ngữ'
              React.DOM.th null, 'Bản đồ'
              React.DOM.th null, 'Hành động'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Room, key: record.id, record: record, handleDeleteRoom: @deleteRecord, handleEditRoom: @updateRecord
      

@Services = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.records
    getDefaultProps: ->
      records: []
    render: ->
      React.DOM.div
        className: 'services'
        React.DOM.h2
          className: 'title'
          'Service'
        React.createElement ServiceForm, handleServiceAdd: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Tên dịch vụ'
              React.DOM.th null, 'Ngôn ngữ'
              React.DOM.th null, 'Giá'
              React.DOM.th null, 'Đơn vị tiền'
              React.DOM.th null, 'Mô tả dịch vụ'
              React.DOM.th null, 'Logo dịch vụ'
              React.DOM.th null, 'Hành động'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Service, key: record.id, record: record, handleDeleteService: @deleteRecord, handleEditService: @updateRecord

              
@Positions = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @replaceState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @replaceState records: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
    getDefaultProps: ->
      records: []
      rooms: []
    render: ->
      React.DOM.div
        className: 'position'
        React.DOM.h2
          className: 'title'
          'Position'
        React.createElement PositionForm, rooms: @state.rooms, handlePositionAdd: @addRecord
        React.DOM.hr null
        React.DOM.table
          className: 'table table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Room'
              React.DOM.th null, 'name'
              React.DOM.th null, 'lang'
              React.DOM.th null, 'description'
              React.DOM.th null, 'file'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for record in @state.records
              React.createElement Position, key: record.id, record: record, rooms: @state.rooms, handleDeletePosition: @deleteRecord, handleEditPosition: @updateRecord


@AppViewsEmployees = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    updateMap: (data) ->
      check = true
      for map in @state.positionmap
        if map.id == data.id
          index = @state.positionmap.indexOf map
          listposmap = React.addons.update(@state.positionmap, { $splice: [[index, 1, data]] })
          @setState positionmap: listposmap
          check = false
          break
      if check
        listposmap = React.addons.update(@state.positionmap, { $push: [data] })
        @setState positionmap: listposmap
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
      positions: @props.data[2]
      positionmap: @props.data[3]
      station: @props.data[4]
    getDefaultProps: ->
      records: []
      rooms: []
    render: ->
      React.DOM.div
        className: 'row'
        for record in @state.records
          React.createElement AppViewsEmployee, key: record.id, record: record, rooms: @state.rooms, positions: @state.positions, positionmap: @state.positionmap, station: @state.station, handleEditAppMap: @updateRecord, handleEditPosMap: @updateMap
          

@AppViewsServices = React.createClass
    updateRecord: (record, data) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    updateMap: (data) ->
      check = true
      for map in @state.servicemap
        if map.id == data.id
          index = @state.servicemap.indexOf map
          listsermap = React.addons.update(@state.servicemap, { $splice: [[index, 1, data]] })
          @setState servicemap: listsermap
          check = false
          break
      if check
        listsermap = React.addons.update(@state.servicemap, { $push: [data] })
        @setState servicemap: listsermap
    getInitialState: ->
      records: @props.data[0]
      rooms: @props.data[1]
      servicemap: @props.data[2]
    getDefaultProps: ->
      records: []
      rooms: []
      servicemap: []
    render: ->
      React.DOM.div
        className: 'row'
        for record in @state.records
          React.createElement AppViewsService, key: record.id, record: record, rooms: @state.rooms, servicemap: @state.servicemap, handleEditSerMap: @updateMap, handleEditSer: @updateRecord


@PatientGeneral = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
    getDefaultProps: ->
      records: []
    updateRecord: (record, data) ->
      console.log(record)
      console.log(data)
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
      @setState records: records
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState records: records
    addRecord: (record) ->
      records = React.addons.update([record], { $push: @state.records })
      @setState records: records
    trigger: ->
      console.log(6)
    SelectHandle: (record) ->
      @setState
        record: record
        selected: record.id
      @forceUpdate()
    buttonRender: ->
      React.DOM.div
        className: 'row'
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus fa-2x', text: 'Add Record', type: 2, trigger: @addRecord, datatype: 'customer_record'
        React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o fa-2x', text: 'Edit', type: 2, trigger2: @updateRecord, datatype: 'customer_edit_record', record: @state.record
        React.DOM.hr null
        React.DOM.div
          className: 'row'
          style: {'padding': '10px'}
          React.DOM.div
            className: 'col-md-9'
            React.createElement PatientForm, handleOnchange: @checkrecord, handleRecordAdd: @addRecord
            React.DOM.hr null
            React.DOM.div
              className: 'row'
              React.DOM.div
                className: 'table-responsive col-md-12'
                React.DOM.table
                  className: 'table table-condensed table-hover'
                  React.DOM.thead null,
                    React.DOM.tr null,
                      React.DOM.th null, 'Name'
                      React.DOM.th null, 'DOB'
                      React.DOM.th null, 'Age'
                      React.DOM.th null, 'Gender'
                      React.DOM.th null, 'Address'
                      React.DOM.th null, 'Pnumber'
                      React.DOM.th null, 'Noid'
                      React.DOM.th null, 'datei'
                      React.DOM.th null, 'placei'
                      React.DOM.th null, 'avatar'
                      React.DOM.th null, 'created_at'
                      React.DOM.th null, 'updated_at'
                  React.DOM.tbody null,
                    for record in @state.records
                      if record.id == @state.selected
                        React.createElement PatientRecord, key: record.id, gender: @props.data[1], select: true, record: record, TriggerSelect: @SelectHandle
                      else
                        React.createElement PatientRecord, key: record.id, gender: @props.data[1], select: false, record: record, TriggerSelect: @SelectHandle  
          React.DOM.div
            className: 'col-md-3'
            if @state.record != null
              React.DOM.div
                className: "background1 animated flipInY"
                React.DOM.div
                  className: "pmo-pic"
                  React.DOM.div
                    className: 'p-relative'
                    React.DOM.a null,
                      React.DOM.img
                        className: 'img-responsive'
                        alt: ''
                        src: "http://byrushan.com/projects/ma/1-6-1/jquery/dark/img/profile-pics/profile-pic-2.jpg"
                    React.DOM.a
                      className: 'pmop-edit'
                      React.DOM.i
                        className: 'fa fa-camera'
                      React.DOM.span
                        className: 'hidden-xs'
                        'Update Picture'
                  React.DOM.div
                    className: 'pmo-stat'
                    React.DOM.h2 null, @state.record.name
                    '18 YearsOld'
                React.DOM.div
                  className: 'pmo-block pmo-contact hidden-xs'
                  React.DOM.h2 null, "Contact"
                  React.DOM.ul null,
                    React.DOM.li null,
                      React.DOM.i
                        className: 'fa fa-mobile'
                      '00971123456789'
                    React.DOM.li null,
                      React.DOM.i
                        className: 'fa fa-mobile'
                      '00971 12345678 9'
                    React.DOM.li null,
                      React.DOM.i
                        className: 'fa fa-mobile'
                      '00971 12345678 9'
                    React.DOM.li null,
                      React.DOM.i
                        className: 'fa fa-mobile'
                      '00971 12345678 9'
                    React.DOM.li null,
                      React.DOM.i
                        className: 'fa fa-mobile'
                      '00971 12345678 9'
            else
              React.DOM.div
                id: '#patient-info-1'
                className: "background1 animated flipOutX"
    render: ->
      @buttonRender()
      