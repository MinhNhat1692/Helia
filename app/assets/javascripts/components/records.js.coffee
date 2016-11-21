@Support = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      autoComplete: null
      filteredRecord: null
      adding: null
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState records: records
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState
        records: records
        record: null
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    addCommentRecord: (record) ->
      records = React.addons.update(@state.filteredRecord, { $push: [record] })
      @setState filteredRecord: records
    toggleAddForm: (e) ->
      @setState adding: true, selected: null, filteredRecord: null, record: null
    loadOpenRecord: (e) ->
      $.ajax
        url: '/support/list'
        type: 'POST'
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((data) ->
          @setState records: data[0], selected: null, filteredRecord: null, adding: null, record: null
          return
        ).bind(this)
    loadCloseRecord: (e) ->
      formData = new FormData
      formData.append 'status', 3
      $.ajax
        url: '/support/list'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((data) ->
          @setState records: data[0], selected: null, filteredRecord: null, adding: null, record: null
          return
        ).bind(this)
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
      formData = new FormData
      formData.append 'id', result.id
      $.ajax
        url: '/support/ticketinfo'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((data) ->
          @setState filteredRecord: data    
          return
        ).bind(this)
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/support/ticket"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
            @setState record: null, selected: null, filteredRecord: null, adding: null
    handleLock: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'put'
          url: "/support/ticket"
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
            @setState record: null, selected: null, filteredRecord: null, adding: null
    trigger: (e) ->
      console.log(1)
    render: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Hỗ trợ'
        React.DOM.div className: 'messages',
          React.DOM.div className: 'm-sidebar',
            React.DOM.header null,
              React.DOM.h2 className: 'hidden-xs', 'Danh sách yêu cầu hỗ trợ'
              React.DOM.ul className: 'actions',
                React.DOM.li onClick: @loadOpenRecord,
                  React.DOM.a className: 'bg-green',
                    React.DOM.i className: 'zmdi zmdi-lock-open',
                React.DOM.li onClick: @loadCloseRecord,
                  React.DOM.a className: 'bg-pink',
                    React.DOM.i className: 'zmdi zmdi-lock',
            React.DOM.div className: 'list-group',
              for record in @state.records
                if @state.selected != null
                  if record.id == @state.selected
                    React.createElement RecordGeneral, key: record.id, record: record, datatype: "support_record", selected: true, selectRecord: @selectRecord
                  else
                    React.createElement RecordGeneral, key: record.id, record: record, datatype: "support_record", selected: false, selectRecord: @selectRecord
                else
                  React.createElement RecordGeneral, key: record.id, record: record, datatype: "support_record", selected: false, selectRecord: @selectRecord
          React.DOM.div className: 'm-body',
            if @state.record != null
              React.DOM.header className: 'mb-header',
                React.DOM.div className: 'mbh-user clearfix',
                  React.DOM.div className: 'p-t-5', @state.record.title
                React.DOM.ul className: 'actions',
                  React.DOM.li onClick: @toggleAddForm,
                    React.DOM.a null,
                      React.DOM.i className: 'zmdi zmdi-plus', 
                  React.DOM.li onClick: @handleDelete,
                    React.DOM.a null,
                      React.DOM.i className: 'zmdi zmdi-delete',
                  React.DOM.li onClick: @handleLock,
                    React.DOM.a null,
                      React.DOM.i className: 'zmdi zmdi-lock', 
            else
              React.DOM.header className: 'mb-header',
                React.DOM.ul className: 'actions',
                  React.DOM.li onClick: @toggleAddForm,
                    React.DOM.a null,
                      React.DOM.i className: 'zmdi zmdi-plus',
            React.DOM.div className: 'mb-list',
              if @state.record != null
                React.DOM.div className: 'mbl-messages',
                  React.createElement RecordGeneral, record: @state.record, datatype: "ticket_record"
                  if @state.filteredRecord != null
                    for record in @state.filteredRecord
                      if record.user_id == @state.record.user_id
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "ticket_comment_record", selected: true, selectRecord: @trigger
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: "ticket_comment_record", selected: false, selectRecord: @trigger
              else if @state.adding != null
                React.DOM.div className: 'mbl-messages',
                  React.createElement SupportForm, datatype: 'ticket', trigger: @addRecord
              else
                React.DOM.div className: 'mbl-messages',
              React.createElement SupportForm, datatype: 'comment', record: @state.record, trigger: @

@RoomManager = React.createClass
    getInitialState: ->
      datatype: 'normal'
    draw: ->
      canvas = document.getElementById('myCanvas')
      if canvas != null
        myDoughnutChart = new Chart(canvas, {
          type: 'doughnut',
          data: {
            labels: ["Red","Blue","Yellow"]
            datasets: [{
              data: [300, 50, 100]
              backgroundColor: ["#F44336","#E91E63","#FFEB3B","#00BCD4"]
              hoverBackgroundColor: ["#F44336","#E91E63","#FFEB3B","#00BCD4"]
            }]
          }
        })
    normalModeRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        for room in @props.data.room
          React.createElement RoomSample, key: room.id, datatype: 'normal', data: room, timelong: @props.timelong, statwait: @props.data.order_map_wait, stattoday: @props.data.order_map_today, statincome: @props.data.total_income_today, position: @props.data.position, statincome_detail: @props.data.total_income_perhour
    expandModeRender: ->
    render: ->
      if @state.datatype == 'normal'
        @normalModeRender()
      else if @state.datatype == 'expand'
        @normalModeRender()

@MainPart = React.createClass
    getInitialState: ->
      analysis: 0
      records:
        if @props.data[0] != undefined
          @props.data[0]
        else
          []
      selected: null
      record: null
      classSideBar: 'sidebar'
      existed: false
      searchRecord: null
      userlink: null
      autoComplete: null
      filteredRecord: null
      extradata: null
      addRecordChild: []
      lastsorted: null
      viewperpage: 10
      currentpage: 1
      firstcount: 0
      lastcount:
        if @props.data[0] != null and @props.data[0] != undefined
          if @props.data[0].length < 10
            @props.data[0].length
          else
            10
        else
          0
    componentWillMount: ->
      $(APP).on 'rebuild', ((e) ->
        @setState
          analysis: 0
          records: @props.data[0]
          selected: null
          record: null
          classSideBar: 'sidebar'
          existed: false
          searchRecord: null
          userlink: null
          autoComplete: null
          filteredRecord: null
          addRecordChild: []
          lastsorted: null
          viewperpage: 10
          currentpage: 1
          firstcount: 0
          lastcount:
            if @props.data[0] != null and @props.data[0] != undefined
              if @props.data[0].length < 10
                @props.data[0].length
              else
                10
            else
              0
      ).bind(this)
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
    getTotalRecordNumberCreated: (time,type) ->
      now = new Date
      total = 0
      if @state.records != undefined
        switch type
          when 1#day
            for record in @state.records
              if Date.parse(record.created_at) >= now.setDate((new Date).getDate()-time)
                total += 1
            return total
          when 2#month
            for record in @state.records
              if Date.parse(record.created_at) >= now.setMonth((new Date).getMonth()-time)
                total += 1
            return total
          when 3#hours
            for record in @state.records
              if Date.parse(record.created_at) >= now.setHours((new Date).getHours()-time)
                total += 1
            return total
      else
        return total
    getTotalRecordNumberUpdated: (time,type) ->
      now = new Date
      total = 0
      if @state.records != undefined
        switch type
          when 1#day
            for record in @state.records
              if Date.parse(record.updated_at) >= now.setDate((new Date).getDate()-time) and record.updated_at != record.created_at
                total += 1
            return total
          when 2#month
            for record in @state.records
              if Date.parse(record.updated_at) >= now.setMonth((new Date).getMonth()-time) and record.updated_at != record.created_at
                total += 1
            return total
          when 3#hours
            for record in @state.records
              if Date.parse(record.updated_at) >= now.setHours((new Date).getHours()-time) and record.updated_at != record.created_at
                total += 1
            return total
      else
        return total
    getLastRecord: ->
      result = null
      if @state.records != undefined
        for record in @state.records
          if result == null and record.updated_at != record.created_at
            result = record
          else
            if result != null
              if Date.parse(record.updated_at) >= Date.parse(result.updated_at) and record.updated_at != record.created_at
                result = record
      return result
    getLastRecordCreated: ->
      result = null
      if @state.records != undefined
        for record in @state.records
          if result == null
            result = record
          else
            if result != null
              if Date.parse(record.created_at) >= Date.parse(result.created_at)
                result = record
      return result
    dynamicSort: (property) ->
      sortOrder = 1
      if property[0] == '-'
        sortOrder = -1
        property = property.substr(1)
      (a, b) ->
        result = if a[property] < b[property] then -1 else if a[property] > b[property] then 1 else 0
        result * sortOrder
    changeSearchRecord: (data) ->
      @state.userlink = data[2]
      if data[1] != null
        index = -1
        for record in @state.records
          if data[1].id == record.id
            index = @state.records.indexOf record
            break
        if index < 0
          @addRecord(data[1])
          @selectRecord(data[1])
        else
          @selectRecord(data[1])
        @setState existed: true
      else
        @setState existed: false
      @setState searchRecord: data[0]   
    updateRecord: (record, data) ->
      for recordlife in @state.records
        if recordlife.id == record.id
          index = @state.records.indexOf recordlife
          records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
          @setState
            records: records
            record: data
          break
    deleteRecord: (record) ->
      index = @state.records.indexOf record
      records = React.addons.update(@state.records, { $splice: [[index, 1]] })
      @setState
        records: records
        record: null
    deleteRecordChild: (record) ->
      index = @state.addRecordChild.indexOf record
      records = React.addons.update(@state.addRecordChild, { $splice: [[index, 1]] })
      @setState
        addRecordChild: records
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $unshift: [record] })
      @setState
        records: records
        addRecordChild: []
        lastcount: @state.lastcount + 1
    addRecordChild: (record) ->
      records = React.addons.update(@state.addRecordChild, { $push: [record] })
      @setState addRecordChild: records
    triggerChildRecord: (records) ->
      @setState addRecordChild: records
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    selectRecordAlt: (result) ->
      if @props.datatype == "doctor_room"
        formData = new FormData
        formData.append 'order_map_id', result.id
      if formData != undefined
        $.ajax
          url: '/' + @props.datatype + '/extra'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((data) ->
            @setState
              extradata: data
              record: result
              selected: result.id
            $('#modaldoctorview').modal({backdrop: 'static', keyboard: false})
            return
          ).bind(this)
    trigger: (e) ->
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
    triggerInput: (text,type,check1) ->
      if type != '' && text.length > 1
        if !check1.option1
          filtered = []
          for record in @state.records
            if @checkContain(type,text,record)
              filtered.push record
              @setState filteredRecord: filtered
        else
          if @props.datatype == "employee"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'ename', text.toLowerCase()
              when 2
                formData.append 'address', text.toLowerCase()
              when 3
                formData.append 'noid', Number(text)
              when 4
                formData.append 'pnumber', text.toLowerCase()
              when 5
                formData.append 'gender', text.toLowerCase()
          else if @props.datatype == "room"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'name', text.toLowerCase()
          else if @props.datatype == "position"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'pname', text.toLowerCase()
              when 2
                formData.append 'description', text.toLowerCase()
              when 3
                formData.append 'rname', text.toLowerCase()
          else if @props.datatype == "service"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'sname', text.toLowerCase()
              when 2
                formData.append 'price', text
              when 3
                formData.append 'description', text.toLowerCase()
          else if @props.datatype == "posmap"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'ename', text.toLowerCase()
              when 2
                formData.append 'pname', text.toLowerCase()
          else if @props.datatype == "sermap"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'sname', text.toLowerCase()
              when 2
                formData.append 'rname', text.toLowerCase()
          else if @props.datatype == "customer_record"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'namestring', text.toLowerCase()
              when 2
                formData.append 'dob', text.toLowerCase()
              when 3
                formData.append 'gender', Number(text)
              when 4
                formData.append 'address', text.toLowerCase()
              when 5
                formData.append 'pnumber', text.toLowerCase()
              when 6
                formData.append 'noid', text.toLowerCase()
          else if @props.datatype == "medicine_supplier"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'noid', text.toLowerCase()
              when 2
                formData.append 'name', text.toLowerCase()
              when 3
                formData.append 'contactname', text.toLowerCase()
              when 4
                formData.append 'spnumber', text.toLowerCase()
              when 5
                formData.append 'pnumber', text.toLowerCase()
              when 6
                formData.append 'address1', text.toLowerCase()
              when 7
                formData.append 'address2', text.toLowerCase()
              when 8
                formData.append 'address3', text.toLowerCase()
              when 9
                formData.append 'email', text.toLowerCase()
              when 10
                formData.append 'facebook', text.toLowerCase()
              when 11
                formData.append 'twitter', text.toLowerCase()
              when 12
                formData.append 'fax', text.toLowerCase()
              when 13
                formData.append 'taxcode', text.toLowerCase()
          else if @props.datatype == "medicine_company"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'noid', text.toLowerCase()
              when 2
                formData.append 'name', text.toLowerCase()
              when 3
                formData.append 'pnumber', text.toLowerCase()
              when 4
                formData.append 'address', text.toLowerCase()
              when 5
                formData.append 'email', text.toLowerCase()
              when 6
                formData.append 'website', text.toLowerCase()
              when 7
                formData.append 'taxcode', text.toLowerCase()
          else if @props.datatype == "medicine_sample"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'noid', text.toLowerCase()
              when 2
                formData.append 'name', text.toLowerCase()
              when 3
                formData.append 'typemedicine', text.toLowerCase()
              when 4
                formData.append 'groupmedicine', text.toLowerCase()
              when 5
                formData.append 'company', text.toLowerCase()
              when 6
                formData.append 'price', text.toLowerCase()
              when 7
                formData.append 'weight', text.toLowerCase()
              when 8
                formData.append 'remark', text.toLowerCase()
              when 9
                formData.append 'expire', text.toLowerCase()
          else if @props.datatype == "medicine_bill_in"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'billcode', text.toLowerCase()
              when 2
                formData.append 'supplier', text.toLowerCase()
              when 3
                formData.append 'remark', text.toLowerCase()
          else if @props.datatype == "medicine_bill_record"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'name', text.toLowerCase()
              when 2
                formData.append 'company', text.toLowerCase()
              when 3
                formData.append 'noid', text.toLowerCase()
              when 4
                formData.append 'signid', text.toLowerCase()
              when 5
                formData.append 'remark', text.toLowerCase()
          else if @props.datatype == "medicine_price"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'name', text.toLowerCase()
              when 2
                formData.append 'remark', text.toLowerCase()
          else if @props.datatype == "medicine_prescript_external"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'code', text.toLowerCase()
              when 2
                formData.append 'cname', text.toLowerCase()
              when 3
                formData.append 'ename', text.toLowerCase()
              when 4
                formData.append 'number_id', text.toLowerCase()
              when 5
                formData.append 'address', text.toLowerCase()
              when 6
                formData.append 'remark', text.toLowerCase()
          else if @props.datatype == "medicine_external_record"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'name', text.toLowerCase()
              when 2
                formData.append 'cname', text.toLowerCase()
              when 3
                formData.append 'script_code', text.toLowerCase()
              when 4
                formData.append 'remark', text.toLowerCase()
              when 5
                formData.append 'company', text.toLowerCase()
          else if @props.datatype == "medicine_prescript_internal"
            formData = new FormData
            switch Number(type)
              when 1
                formData.append 'code', text.toLowerCase()
              when 2
                formData.append 'cname', text.toLowerCase()
              when 3
                formData.append 'ename', text.toLowerCase()
              when 4
                formData.append 'number_id', text.toLowerCase()
              when 5
                formData.append 'remark', text.toLowerCase()
              when 6
                formData.append 'preparer', text.toLowerCase()
              when 7
                formData.append 'payer', text.toLowerCase()
          else if @props.datatype == "medicine_internal_record"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'name', text.toLowerCase()
              when 2
                formData.append 'cname', text.toLowerCase()
              when 3
                formData.append 'script_code', text.toLowerCase()
              when 4
                formData.append 'remark', text.toLowerCase()
              when 5
                formData.append 'company', text.toLowerCase()
              when 6
                formData.append 'noid', text.toLowerCase()
              when 7
                formData.append 'signid', text.toLowerCase()
          else if @props.datatype == "medicine_stock_record"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'name', text.toLowerCase()
              when 2
                formData.append 'noid', text.toLowerCase()
              when 3
                formData.append 'signid', text.toLowerCase()
              when 4
                formData.append 'supplier', text.toLowerCase()
              when 5
                formData.append 'bill_in_code', text.toLowerCase()
              when 6
                formData.append 'internal_record_code', text.toLowerCase()
              when 7
                formData.append 'remark', text.toLowerCase()
          else if @props.datatype == "order_map"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'cname', text.toLowerCase()
              when 2
                formData.append 'sername', text.toLowerCase()
              when 3
                formData.append 'remark', text.toLowerCase()
          else if @props.datatype == "check_info"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'ename', text.toLowerCase()
              when 2
                formData.append 'c_name', text.toLowerCase()
              when 3
                formData.append 'conclude', text.toLowerCase()
              when 4
                formData.append 'cdoan', text.toLowerCase()
              when 5
                formData.append 'hdieutri', text.toLowerCase()
          else if @props.datatype == "doctor_check_info"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'ename', text.toLowerCase()
              when 2
                formData.append 'c_name', text.toLowerCase()
              when 3
                formData.append 'qtbenhly', text.toLowerCase()
              when 4
                formData.append 'klamsang', text.toLowerCase()
              when 5
                formData.append 'cdbandau', text.toLowerCase()
              when 6
                formData.append 'bktheo', text.toLowerCase()
              when 7
                formData.append 'cdicd', text.toLowerCase()
              when 8
                formData.append 'kluan', text.toLowerCase()
          else if @props.datatype == "bill_info"
            formData = new FormData	  
            switch Number(type)
              when 1
                formData.append 'remark', text.toLowerCase()
              when 2
                formData.append 'c_name', text.toLowerCase()
          
          if formData != undefined
            $.ajax
              url: '/' + @props.datatype + '/search'
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
      if @props.datatype == "employee"
        switch Number(type)
          when 1
            if record.ename.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.address.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.noid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.pnumber.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.pnumber == Number(text)
              return true
            else
              return false
      else if @props.datatype == "room"
        switch Number(type)
          when 1
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "position"
        switch Number(type)
          when 1
            if record.pname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.description.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.rname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "service"
        switch Number(type)
          when 1
            if record.sname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.price == Number(text)
              return true
            else
              return false
          when 3
            if record.signid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false  
      else if @props.datatype == "posmap"
        switch Number(type)
          when 1
            if record.ename.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.pname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "sermap"
        switch Number(type)
          when 1
            if record.sname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.rname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "customer_record"
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
      else if @props.datatype == "medicine_supplier"
        switch Number(type)
          when 1
            if record.noid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.contactname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.spnumber.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.pnumber.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.address1.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.address2.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 8
            if record.address3.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 9
            if record.email.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 10
            if record.facebook.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 11
            if record.twitter.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 12
            if record.fax.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 13
            if record.taxcode.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "medicine_company"
        switch Number(type)
          when 1
            if record.noid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.pnumber.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.address.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.email.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.website.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.taxcode.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "medicine_sample"
        switch Number(type)
          when 1
            if record.noid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.typemedicine.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.groupmedicine.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.company.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.price.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.weight.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 8
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 9
            if record.expire.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "medicine_bill_in"
        switch Number(type)
          when 1
            if record.billcode.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.supplier.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if (record.dayin.toLowerCase().substring(8, 10) + "/" + record.dayin.toLowerCase().substring(5, 7) + "/" + record.dayin.toLowerCase().substring(0, 4)) == text.toLowerCase()
              return true
            else
              return false
          when 5
            if (record.daybook.toLowerCase().substring(8, 10) + "/" + record.daybook.toLowerCase().substring(5, 7) + "/" + record.daybook.toLowerCase().substring(0, 4)) == text.toLowerCase()
              return true
            else
              return false
          when 6
            if record.pmethod == Number(text)
              return true
            else
              return false
          when 7
            if record.tpayment == Number(text)
              return true
            else
              return false
          when 8
            if record.discount == Number(text)
              return true
            else
              return false
          when 9
            if record.tpayout == Number(text)
              return true
            else
              return false
          when 10
            if record.status == Number(text)
              return true
            else
              return false
      else if @props.datatype == "medicine_bill_record"
        switch Number(type)
          when 1
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.company.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.noid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.signid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if (record.expire.toLowerCase().substring(8, 10) + "/" + record.expire.toLowerCase().substring(5, 7) + "/" + record.expire.toLowerCase().substring(0, 4)) == text.toLowerCase()
              return true
            else
              return false
          when 7
            if record.pmethod == Number(text)
              return true
            else
              return false
          when 8
            if record.qty == Number(text)
              return true
            else
              return false
          when 9
            if record.taxrate == Number(text)
              return true
            else
              return false
          when 10
            if record.price == Number(text)
              return true
            else
              return false
      else if @props.datatype == "medicine_price"
        switch Number(type)
          when 1
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.minam == Number(text)
              return true
            else
              return false
          when 4
            if record.price == Number(text)
              return true
            else
              return false
      else if @props.datatype == "medicine_prescript_external"
        switch Number(type)
          when 1
            if record.code.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.cname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.ename.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.number_id.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.address.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.result_id == Number(text)
              return true
            else
              return false
          when 8
            if (record.date.toLowerCase().substring(8, 10) + "/" + record.date.toLowerCase().substring(5, 7) + "/" + record.date.toLowerCase().substring(0, 4)) == text.toLowerCase()
              return true
            else
              return false
      else if @props.datatype == "medicine_external_record"
        switch Number(type)
          when 1
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.cname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.script_code.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.company.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.amount == Number(text)
              return true
            else
              return false
          when 7
            if record.price == Number(text)
              return true
            else
              return false
          when 8
            if record.total == Number(text)
              return true
            else
              return false
      else if @props.datatype == "medicine_prescript_internal"
        switch Number(type)
          when 1
            if record.code.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.cname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.ename.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.number_id.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.preparer.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.payer.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 8
            if record.result_id == Number(text)
              return true
            else
              return false
          when 9
            if (record.date.toLowerCase().substring(8, 10) + "/" + record.date.toLowerCase().substring(5, 7) + "/" + record.date.toLowerCase().substring(0, 4)) == text.toLowerCase()
              return true
            else
              return false
          when 10
            if record.tpayment == Number(text)
              return true
            else
              return false
          when 11
            if record.discount == Number(text)
              return true
            else
              return false
          when 12
            if record.tpayout == Number(text)
              return true
            else
              return false
          when 13
            if record.pmethod == Number(text)
              return true
            else
              return false
      else if @props.datatype == "medicine_internal_record"
        switch Number(type)
          when 1
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.cname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.script_code.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.company.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.noid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.signid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 8
            if record.amount == Number(text)
              return true
            else
              return false
          when 9
            if record.price == Number(text)
              return true
            else
              return false
          when 10
            if record.discount == Number(text)
              return true
            else
              return false
          when 11
            if record.tpayment == Number(text)
              return true
            else
              return false
          when 12
            if record.status == Number(text)
              return true
            else
              return false
      else if @props.datatype == "medicine_stock_record"
        switch Number(type)
          when 1
            if record.name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.noid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.signid.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.supplier.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.bill_in_code.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.internal_record_code.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 8
            if record.amount == Number(text)
              return true
            else
              return false
          when 9
            if record.expire == Number(text)
              return true
            else
              return false
          when 10
            if record.typerecord == Number(text)
              return true
            else
              return false
      else if @props.datatype == "order_map"
        switch Number(type)
          when 1
            if record.cname.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.sername.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.status == Number(text)
              return true
            else
              return false
          when 5
            if record.tpayment == Number(text)
              return true
            else
              return false
          when 6
            if record.discount == Number(text)
              return true
            else
              return false
          when 7
            if record.tpayout == Number(text)
              return true
            else
              return false
      else if @props.datatype == "check_info"
        switch Number(type)
          when 1
            if record.ename.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.c_name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.conclude.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.cdoan.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.hdieutri.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.status == Number(text)
              return true
            else
              return false
      else if @props.datatype == "doctor_check_info"
        switch Number(type)
          when 1
            if record.ename.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.c_name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.qtbenhly.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 4
            if record.klamsang.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 5
            if record.cdbandau.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 6
            if record.bktheo.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 7
            if record.cdicd.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 8
            if record.kluan.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
      else if @props.datatype == "bill_info"
        switch Number(type)
          when 1
            if record.remark.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 2
            if record.c_name.toLowerCase().search(text.toLowerCase()) > -1
              return true
            else
              return false
          when 3
            if record.dvi == Number(text)
              return true
            else
              return false
          when 4
            if record.sluong == Number(text)
              return true
            else
              return false
          when 5
            if record.tpayment == Number(text)
              return true
            else
              return false
          when 6
            if record.discount == Number(text)
              return true
            else
              return false
          when 7
            if record.tpayout == Number(text)
              return true
            else
              return false
    triggerSubmit: (result) ->
      @setState
        autoComplete: null
        lastsorted: null
        filteredRecord: result
        currentpage: 1
        firstcount: 0
        lastcount:
          if result.length < @state.viewperpage
            result.length
          else
            @state.viewperpage
    triggerChose: (result) ->
      @setState
        autoComplete: null
    triggerClear: (e) ->
      @setState
        autoComplete: null
        lastsorted: null
        filteredRecord: null
        currentpage: 1
        firstcount: 0
        lastcount:
          if @state.records.length < @state.viewperpage
            @state.records.length
          else
            @state.viewperpage
    triggerFillModal: (code)->
      $(APP).trigger('fillmodal',[code])
    makeApikey: ->
      $.ajax
        url: '/' + @props.datatype + '/addkey'
        type: 'POST'
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @setState records: result
          return
        ).bind(this)
    changeApikey: ->
      $.ajax
        url: '/' + @props.datatype + '/changekey'
        type: 'POST'
        async: false
        cache: false
        contentType: false
        processData: false
        success: ((result) ->
          @setState records: result
          return
        ).bind(this)
    toggleSideBar: ->
      if @state.classSideBar == 'sidebar'
        @setState classSideBar: 'sidebar toggled'
      else
        @setState classSideBar: 'sidebar'
    addRecordAlt: ->
      if @props.datatype == "employee"
        if @state.searchRecord != null
          formData = new FormData
          formData.append 'id', @state.searchRecord.user_id
      else if @props.datatype == "customer_record"
        if @state.searchRecord != null
          formData = new FormData
          formData.append 'id', @state.searchRecord.user_id
      if formData != undefined
        $.ajax
          url: '/' + @props.datatype + '/add_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @addRecord(result)
            return
          ).bind(this)
    updateRecordAlt: ->
      if @props.datatype == "employee"
        if @state.searchRecord != null && @state.record != null
          formData = new FormData
          formData.append 'id', @state.searchRecord.user_id
          formData.append 'idrecord', @state.record.id
      else if @props.datatype == "customer_record"
        if @state.searchRecord != null && @state.record != null
          formData = new FormData
          formData.append 'id', @state.searchRecord.user_id
          formData.append 'idrecord', @state.record.id
      if formData != undefined
        $.ajax
          url: '/' + @props.datatype + '/update_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @updateRecord(@state.record,result)
            @setState record: result
            return
          ).bind(this)
    linkRecordAlt: ->
      if @props.datatype == "employee"
        if @state.searchRecord != null && @state.record != null
          formData = new FormData
          formData.append 'id', @state.searchRecord.user_id
          formData.append 'idrecord', @state.record.id
      else if @props.datatype == "customer_record"
        if @state.searchRecord != null && @state.record != null
          formData = new FormData
          formData.append 'id', @state.searchRecord.user_id
          formData.append 'idrecord', @state.record.id

      if formData != undefined
        $.ajax
          url: '/' + @props.datatype + '/link_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @updateRecord(@state.record,result)
            @setState record: result
            return
          ).bind(this)
    ClearlinkRecordAlt: ->
      if @props.datatype == "employee"
        if @state.record != null
          formData = new FormData
          formData.append 'idrecord', @state.record.id
      else if @props.datatype == "customer_record"
        if @state.record != null
          formData = new FormData
          formData.append 'idrecord', @state.record.id
    
      if formData != undefined
        $.ajax
          url: '/' + @props.datatype + '/clear_link_record'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @updateRecord(@state.record,result)
            @setState record: result
            return
          ).bind(this)
    handleDelete: ->
      if @props.datatype == 'customer_record'
        message = "thông tin khách hàng"
      else if @props.datatype == 'employee'
        message = "thông tin nhân viên"
      else if @props.datatype == 'room'
        message = "thông phòng"
      else if @props.datatype == 'position'
        message = "thông tin chức vụ"
      else if @props.datatype == 'service'
        message = "thông tin dịch vụ"
      else if @props.datatype == 'posmap'
        message = "thông tin định chức vụ"
      else if @props.datatype == 'sermap'
        message = "thông tin định dịch vụ"
      else if @props.datatype == 'order_map'
        message = "thông tin đăng ký khám bệnh"
      else if @props.datatype == 'medicine_supplier'
        message = "thông tin nguồn cung cấp thuốc"
      else if @props.datatype == 'medicine_company'
        message = "thông tin công ty sản xuất thuốc"
      else if @props.datatype == 'medicine_sample'
        message = "thông tin mẫu thuốc"
      else if @props.datatype == 'medicine_bill_in'
        message = "thông tin hóa đơn thuốc vào"
      else if @props.datatype == 'medicine_bill_record'
        message = "thông tin thành phần hóa đơn thuốc vào"
      else if @props.datatype == 'medicine_price'
        message = "thông tin giá thuốc"
      else if @props.datatype == 'medicine_prescript_external'
        message = "thông tin đơn thuốc kê ngoài"
      else if @props.datatype == 'medicine_external_record'
        message = "thông tin thuốc trong đơn kê ngoài"
      else if @props.datatype == 'medicine_prescript_internal'
        message = "thông tin đơn thuốc kê trong"
      else if @props.datatype == 'medicine_internal_record'
        message = "thông tin thuốc trong đơn kê trong"
      else if @props.datatype == 'medicine_stock_record'
        message = "thông tin thuốc trong kho"
      else if @props.datatype == 'check_info'
        message = "thông tin điều trị"
      else if @props.datatype == 'doctor_check_info'
        message = "thông tin khám lâm sàng"
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/" + @props.datatype
          dataType: 'JSON'
          data: {id: @state.record.id}
          error: ((result) ->
            @showtoast("Xóa " + message + " thất bại",3)
            return
          ).bind(this)
          success: () =>
            @deleteRecord @state.record
            @showtoast("Xóa " + message + " thành công",1)
    OpenModalAdd1: (code) ->
      @setState
        record: null
        selected: null
        addRecordChild: []
      $(APP).trigger('clearmodal',[code])
      $('#modal1').modal({backdrop: 'static', keyboard: false})  
    OpenModalAdd2: (code)->
      $(APP).trigger('clearmodal',[code])
      $(APP).trigger('fillmodal',[code])
      $('#modal2').modal({backdrop: 'static', keyboard: false})  
    OpenModalAdd3: (code)->
      $(APP).trigger('clearmodal',[code])
      $(APP).trigger('fillmodal',[code])
      $('#modal3').modal({backdrop: 'static', keyboard: false})  
    OpenModalAdd4: (code)->
      $(APP).trigger('clearmodal',[code])
      $(APP).trigger('fillmodal',[code])
      $('#modal4').modal({backdrop: 'static', keyboard: false})    
    employeeRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().ename != undefined
                          @getLastRecord().ename
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách nhân viên'
              #  React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-link', text: ' Liên kết', type: 1, Clicked: @toggleSideBar
              #  React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
              #  React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
              #  React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
              #  React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-flash-off', text: ' Bỏ liên kết', type: 1, Clicked: @ClearlinkRecordAlt
              #  React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm chức vụ cho nhân viên', code: 'posmap', type: 3, Clicked: @OpenModalAdd2
              #  React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm chức vụ', code: 'position', type: 3, Clicked: @OpenModalAdd3
              #  React.DOM.br null
              #  React.DOM.br null
              #  React.DOM.br null
                
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                  React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort, header: [
                    {id:1,name: 'Họ và tên', code: 'ename'}
                    {id:2, name: 'Địa chỉ', code: 'address'}
                    {id:3, name: 'Số điện thoại', code: 'pnumber'}
                    {id:4, name: 'Mã nhân viên', code: 'noid'}
                    {id: 5, name: 'Giới tính', code: 'gender'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
                React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
                React.createElement ModalOutside, id: 'modal2', datatype: 'posmap', record: null, employee: @state.record, position: null, trigger: @trigger, trigger2: @trigger
                React.createElement ModalOutside, id: 'modal3', datatype: 'position', record: null, room: null, trigger: @trigger, trigger2: @trigger
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Nhân viên'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Chức vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm chức vụ', code: 'position', type: 3, Clicked: @OpenModalAdd3
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Định chức vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm chức vụ cho nhân viên', code: 'posmap', type: 3, Clicked: @OpenModalAdd2
    roomRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách phòng'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                  React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort, header: [
                    {id:1,name: 'Tên phòng', code: 'name'}
                    {id:2, name: 'Ngôn ngữ', code: 'lang'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
            React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
            React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
            React.createElement ModalOutside, id: 'modal2', datatype: 'position', record: null, room: @state.record, trigger: @trigger, trigger2: @trigger
            React.createElement ModalOutside, id: 'modal3', datatype: 'sermap', record: null, room: @state.record, service: null, trigger: @trigger, trigger2: @trigger
            React.createElement ModalOutside, id: 'modal4', datatype: 'service', record: null, trigger: @trigger, trigger2: @trigger
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Phòng'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Dịch vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm dịch vụ', code: 'service', type: 3, Clicked: @OpenModalAdd4
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Chức vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm chức vụ', code: 'position', type: 3, Clicked: @OpenModalAdd2
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Định dịch vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm dịch vụ cho phòng', code: 'sermap', type: 3, Clicked: @OpenModalAdd3
    positionRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().pname != undefined
                          @getLastRecord().pname
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách chức vụ'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, rooms: @props.data[1], datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                  React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort, header: [
                    {id:1,name: 'Tên phòng', code: 'rname'}
                    {id:2, name: 'Tên vị trí', code: 'pname'}
                    {id:3, name: 'Ngôn ngữ', code: 'lang'}
                    {id:4, name: 'Diễn giải', code: 'description'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Chức vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Nhân viên'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm nhân viên', code: 'employee', type: 3, Clicked: @OpenModalAdd3
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Đinh chức vụ cho nhân viên'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Gán chức vụ cho nhân viên', code: 'posmap', type: 3, Clicked: @OpenModalAdd2
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, room: null, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'posmap', record: null, employee: null, position: @state.record, trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modal3', datatype: 'employee', record: null, trigger: @trigger, trigger2: @trigger
    serviceRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().sname != undefined
                          @getLastRecord().sname
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách dịch vụ'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id:1,name: 'Tên dịch vụ', code: 'sname'}
                    {id:2, name: 'Ngôn ngữ', code: 'lang'}
                    {id:3, name: 'Giá', code: 'price'}
                    {id:4, name: 'Đơn vị tiền', code: 'currency'}
                    {id: 5, name: 'Diễn giải', code: 'description'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Dịch vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Phòng'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm phòng', code: 'room', type: 3, Clicked: @OpenModalAdd3
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Đinh dịch vụ cho phòng'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Gán dịch vụ cho phòng', code: 'sermap', type: 3, Clicked: @OpenModalAdd2
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'sermap', record: null, room: null, service: @state.record, trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modal3', datatype: 'room', record: null, trigger: @trigger, trigger2: @trigger
    posmapRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().ename != undefined
                          @getLastRecord().ename
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách chức vụ của từng nhân viên'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id:1,name: 'Tên nhân viên', code: 'ename'}
                    {id:2, name: 'Tên chức vụ', code: 'pname'}
                    {id:3, name: 'Cập nhật lần cuối', code: 'updated_at'}
                    {id:4, name: 'Khởi tạo lúc', code: 'created_at'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Định chức vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Chức vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm chức vụ', code: 'position', type: 3, Clicked: @OpenModalAdd3
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Nhân viên'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm nhân viên', code: 'employee', type: 3, Clicked: @OpenModalAdd2
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, employee: null, position: null, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'employee', record: null, trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modal3', datatype: 'position', record: null, room: null, trigger: @trigger, trigger2: @trigger
    sermapRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().sname != undefined
                          @getLastRecord().sname
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách dịch vụ của từng phòng'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id:1,name: 'Tên dịch vụ', code: 'sname'}
                    {id:2, name: 'Tên phòng', code: 'rname'}
                    {id:3, name: 'Cập nhật lần cuối', code: 'updated_at'}
                    {id:4, name: 'Khởi tạo', code: 'created_at'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Định dịch vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Dịch vụ'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm dịch vụ', code: 'service', type: 3, Clicked: @OpenModalAdd2
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Phòng'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm phòng', code: 'room', type: 3, Clicked: @OpenModalAdd3
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, service: null, room: null, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'service', record: null, trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modal3', datatype: 'room', record: null, trigger: @trigger, trigger2: @trigger
    customerRecordRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().cname != undefined
                          @getLastRecord().cname
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách bệnh nhân'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id:1, name: 'Họ và tên', code: 'ename'}
                    {id:2, name: 'Ngày sinh', code: 'dob'}
                    {id:3, name: 'Tuổi', code: 'dob'}
                    {id:4, name: 'Giới tính', code: 'gender'}
                    {id:5, name: 'Địa chỉ', code: 'address'}
                    {id:6, name: 'Số điện thoại', code: 'pnumber'}
                    {id:7, name: 'CMTND', code: 'noid'}
                    {id:8, name: 'Ngày cấp', code: 'issue_date'}
                    {id:9, name: 'Nơi cấp', code: 'issue_place'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Bệnh nhân'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Yêu cầu khám bệnh'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm yêu cầu khám bệnh', type: 1, Clicked: @OpenModalAdd2
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Phòng'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm phòng', code: 'room', type: 3, Clicked: @OpenModalAdd3
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'order_map', record: null, service: null, customer: @state.record, trigger: @trigger, trigger2: @trigger
            React.DOM.div className: 'panel panel-default master-action',
              if @state.record != null
                React.createElement PatientProfile, gender: @props.data[1], record: @state.record, style: 'normal', clearLinkListener: @ClearlinkRecordAlt
        #React.createElement AsideMenu, key: 'Aside', style: 1, record: @state.searchRecord, gender: @props.data[1], className: @state.classSideBar, existed: @state.existed, userlink: @state.userlink, handleCustomerSearch: @changeSearchRecord, addListener: @addRecordAlt, linkListener: @linkRecordAlt, updateListener: @updateRecordAlt
              #React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-exchange', text: ' Toggle Sidebar', type: 1, Clicked: @toggleSideBar
              #React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 1, Clicked: @OpenModalAdd1
              #React.DOM.button className: 'btn btn-default', onClick: @triggerFillModal, 'data-target':'#modal1', 'data-toggle': 'modal', 'data-backdrop':'static', 'data-keyboard':'false', type: 'button',
              #  React.DOM.i className: 'zmdi zmdi-edit'
              #  'Sửa'
              #React.DOM.button className: 'btn btn-default', 'data-target':'#modaldelete', 'data-toggle': 'modal', 'data-backdrop':'static', 'data-keyboard':'false', type: 'button',
              #  React.DOM.i className: 'fa fa-trash-o'
              #  'Xóa'
              #React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm yêu cầu khám bệnh', type: 1, Clicked: @OpenModalAdd2
    medicineSupplierRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Nguồn cấp thuốc'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id:1,name: 'Mã', code: 'noid'}
                    {id:2,name: 'Tên nguồn', code: 'name'}
                    {id:3,name: 'Người liên lạc', code: 'contactname'}
                    {id:4,name: 'Số ĐT cố định', code: 'spnumber'}
                    {id:5,name: 'Số ĐT di động', code: 'pnumber'}
                    {id:6,name: 'Địa chỉ 1', code: 'address1'}
                    {id:7,name: 'Địa chỉ 2', code: 'address2'}
                    {id:8,name: 'Địa chỉ 3', code: 'address3'}
                    {id:9,name: 'Email', code: 'email'}
                    {id:10,name: 'Facebook', code: 'facebook'}
                    {id:11,name: 'Twitter', code: 'twitter'}
                    {id:12,name: 'Fax', code: 'fax'}
                    {id:13,name: 'Mã số thuế', code: 'taxcode'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Nguồn cấp thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
    medicineCompanyRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách doanh nghiệp sản xuất'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Mã', code: 'noid'}
                    {id: 2, name: 'Tên doanh nghiệp', code: 'name'}
                    {id: 3, name: 'Số điện thoại', code: 'pnumber'}
                    {id: 4, name: 'Địa chỉ', code: 'address'}
                    {id: 5, name: 'Email', code: 'email'}
                    {id: 6, name: 'Website', code: 'website'}
                    {id: 7, name: 'Mã số thuế', code: 'taxcode'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Doanh nghiệp sản xuất'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Mẫu thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm mẫu thuốc', code: 'medicine_sample', type: 3, Clicked: @OpenModalAdd2
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'medicine_sample', typemedicine: @props.data[2], groupmedicine: @props.data[1], company: @state.record, record: null, trigger: @trigger, trigger2: @trigger
    medicineSampleRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách mẫu thuốc'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, grouplist: @props.data[1], typelist: @props.data[2], autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Mã', code: 'noid'}
                    {id: 2, name: 'Tên thuốc', code: 'name'}
                    {id: 3, name: 'Loại thuốc', code: 'typemedicine'}
                    {id: 4, name: 'Nhóm thuốc', code: 'groupmedicine'}
                    {id: 5, name: 'Công ty sản xuất', code: 'company'}
                    {id: 6, name: 'Giá', code: 'price'}
                    {id: 7, name: 'Khối lượng', code: 'weight'}
                    {id: 8, name: 'Diễn giải', code: 'remark'}
                    {id: 9, name: 'Hạn sử dụng', code: 'expire'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]              
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Mẫu thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Doanh nghiệp sản xuất'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm công ty sản xuất', code: 'medicine_company', type: 3, Clicked: @OpenModalAdd2
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Giá thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm giá thuốc', code: 'medicine_price', type: 3, Clicked: @OpenModalAdd3
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, typemedicine: @props.data[2], groupmedicine: @props.data[1], company: null, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'medicine_company', record: null, trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modal3', datatype: 'medicine_price', sample: @state.record, record: null, grouplist: @props.data[1], typelist: @props.data[2], trigger: @addRecord, trigger2: @updateRecord
    medicineBillInRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().billcode != undefined
                          @getLastRecord().billcode
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách hóa đơn nhập thuốc'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Số hóa đơn', code: 'billcode'}
                    {id: 2, name: 'Ngày nhập', code: 'dayin'}
                    {id: 3, name: 'Người cung cấp', code: 'supplier'}
                    {id: 4, name: 'Ngày đặt hàng', code: 'daybook'}
                    {id: 5, name: 'Tổng giá hàng hóa', code: 'tpayment'}
                    {id: 6, name: 'Giảm giá', code: 'discount'}
                    {id: 7, name: 'Tổng tiền thanh toán', code: 'tpayout'}
                    {id: 8, name: 'Cách thanh toán', code: 'pmethod'}
                    {id: 9, name: 'Ghi chú', code: 'remark'}
                    {id: 10, name: 'Tình trạng hóa đơn', code: 'status'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Hóa đơn nhập thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thuốc nhập kho'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm thông tin thuốc nhập kho', code: 'medicine_bill_record', type: 3, Clicked: @OpenModalAdd2
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Phòng'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm phòng', code: 'room', type: 3, Clicked: @OpenModalAdd3
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, bill_record: @state.addRecordChild, record: @state.record, trigger: @addRecord, trigger2: @updateRecord, triggerDelete: @deleteRecordChild, triggerChildRefresh: @triggerChildRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'medicine_bill_record', record: null, bill_in: @state.record, grouplist: @props.data[1], typelist: @props.data[2], trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modalbillrecordmini', datatype: 'medicine_bill_record_mini', record: null, grouplist: @props.data[1], typelist: @props.data[2], trigger: @addRecordChild, trigger2: @trigger, record_id:
                if @state.addRecordChild.length == 0
                  1
                else
                  @state.addRecordChild[@state.addRecordChild.length - 1].id + 1
    medicineBillRecordRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách thông tin thuốc nhập kho'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Số hiệu', code: 'noid'}
                    {id: 2, name: 'Ký hiệu', code: 'signid'}
                    {id: 3, name: 'Tên thuốc', code: 'name'}
                    {id: 4, name: 'Công ty sản xuất', code: 'company'}
                    {id: 5, name: 'Hạn sử dụng', code: 'expire'}
                    {id: 6, name: 'Số lượng', code: 'qty'}
                    {id: 7, name: '% thuế', code: 'taxrate'}
                    {id: 8, name: 'Giá/đơn vị', code: 'price'}
                    {id: 9, name: 'Ghi chú', code: 'remark'}
                    {id: 10, name: 'Cách mua', code: 'pmethod'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thuốc nhập kho'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, bill_in: null, grouplist: @props.data[1], typelist: @props.data[2], trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
    medicinePriceRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách giá thuốc'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Tên thuốc', code: 'name'}
                    {id: 2, name: 'Số lượng ít nhất', code: 'minam'}
                    {id: 3, name: 'Giá thuốc', code: 'price'}
                    {id: 4, name: 'Ghi chú', code: 'remark'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Giá thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Mẫu thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm mẫu thuốc', code: 'medicine_sample', type: 3, Clicked: @OpenModalAdd2
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, sample: null, grouplist: @props.data[1], typelist: @props.data[2], trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'medicine_sample', typemedicine: @props.data[2], groupmedicine: @props.data[1], company: null, record: null, trigger: @trigger, trigger2: @trigger
    medicinePrescriptExternalRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().code != undefined
                          @getLastRecord().code
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách đơn thuốc ngoài'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Mã đơn thuốc', code: 'code'}
                    {id: 2, name: 'Bệnh nhân', code: 'cname'}
                    {id: 3, name: 'Người kê đơn', code: 'ename'}
                    {id: 4, name: 'Ngày kê', code: 'date'}
                    {id: 5, name: 'Kết quả khám', code: 'result_id'}
                    {id: 6, name: 'Số khám bệnh', code: 'number_id'}
                    {id: 7, name: 'Địa chỉ mua thuốc', code: 'address'}
                    {id: 8, name: 'Ghi chú', code: 'remark'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Đơn thuốc ngoài'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thuốc kê ngoài'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm thuốc kê ngoài vào đơn', code: 'medicine_external_record', type: 3, Clicked: @OpenModalAdd2
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, external_record: @state.addRecordChild, record: @state.record, trigger: @addRecord, trigger2: @updateRecord, triggerDelete: @deleteRecordChild, triggerChildRefresh: @triggerChildRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'medicine_external_record', record: null, prescript: @state.record, grouplist: @props.data[1], typelist: @props.data[2], trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modalexternalrecordmini', datatype: 'medicine_external_record_mini', record: null, grouplist: @props.data[1], typelist: @props.data[2], trigger: @addRecordChild, trigger2: @trigger, record_id:
                if @state.addRecordChild.length == 0
                  1
                else
                  @state.addRecordChild[@state.addRecordChild.length - 1].id + 1
    medicineExternalRecordRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách thuốc kê ngoài'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Mã đơn thuốc', code: 'script_code'}
                    {id: 2, name: 'Tên thuốc', code: 'name'}
                    {id: 3, name: 'Tên bệnh nhân', code: 'cname'}
                    {id: 4, name: 'Liều lượng', code: 'amount'}
                    {id: 5, name: 'Ghi chú', code: 'remark'}
                    {id: 6, name: 'Công ty sản xuất', code: 'company'}
                    {id: 7, name: 'Giá', code: 'price'}
                    {id: 8, name: 'Tổng tiền', code: 'total'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thuốc kê ngoài'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, prescript: null, grouplist: @props.data[1], typelist: @props.data[2], record: @state.record, trigger: @addRecord, trigger2: @updateRecord, triggerDelete: @deleteRecordChild, triggerChildRefresh: @triggerChildRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
    medicinePrescriptInternalRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().code != undefined
                          @getLastRecord().code
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách đơn thuốc trong'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Mã đơn thuốc', code: 'code'}
                    {id: 2, name: 'Bệnh nhân', code: 'cname'}
                    {id: 3, name: 'Người kê đơn', code: 'ename'}
                    {id: 4, name: 'Ngày kê', code: 'date'}
                    {id: 5, name: 'Người chuẩn bị thuốc', code: 'preparer'}
                    {id: 6, name: 'Người thanh toán', code: 'payer'}
                    {id: 7, name: 'Tổng giá trị', code: 'tpayment'}
                    {id: 8, name: 'Giảm giá', code: 'discount'}
                    {id: 9, name: 'Tổng tiền thanh toán', code: 'tpayout'}
                    {id: 10, name: 'Cách thanh toán', code: 'pmethod'}
                    {id: 11, name: 'Số kết quả khám', code: 'result_id'}
                    {id: 12, name: 'Số khám bệnh', code: 'number_id'}
                    {id: 13, name: 'Ghi chú', code: 'remark'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Đơn thuốc trong'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thuốc kê trong'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm thuốc kê trong vào đơn', code: 'medicine_internal_record', type: 3, Clicked: @OpenModalAdd2
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, internal_record: @state.addRecordChild, record: @state.record, trigger: @addRecord, trigger2: @updateRecord, triggerDelete: @deleteRecordChild, triggerChildRefresh: @triggerChildRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
              React.createElement ModalOutside, id: 'modal2', datatype: 'medicine_internal_record', record: null, prescript: @state.record, grouplist: @props.data[1], typelist: @props.data[2], trigger: @trigger, trigger2: @trigger
              React.createElement ModalOutside, id: 'modalinternalrecordmini', datatype: 'medicine_internal_record_mini', record: null, grouplist: @props.data[1], typelist: @props.data[2], trigger: @addRecordChild, trigger2: @trigger, record_id:
                if @state.addRecordChild.length == 0
                  1
                else
                  @state.addRecordChild[@state.addRecordChild.length - 1].id + 1
    medicineInternalRecordRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách thuốc kê trong'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Mã đơn thuốc', code: 'script_code'}
                    {id: 2, name: 'Tên thuốc', code: 'name'}
                    {id: 3, name: 'Tên bệnh nhân', code: 'cname'}
                    {id: 4, name: 'Liều lượng', code: 'amount'}
                    {id: 5, name: 'Ghi chú', code: 'remark'}
                    {id: 6, name: 'Công ty sản xuất', code: 'company'}
                    {id: 7, name: 'Giá', code: 'price'}
                    {id: 8, name: 'Giảm giá', code: 'discount'}
                    {id: 9, name: 'Tổng giá trị', code: 'tpayment'}
                    {id: 10, name: 'Tình trạng', code: 'status'}
                    {id: 11, name: 'Số kiệu', code: 'noid'}
                    {id: 12, name: 'Ký hiệu', code: 'signid'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thuốc kê trong'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, prescript: null, grouplist: @props.data[1], typelist: @props.data[2], record: @state.record, trigger: @addRecord, trigger2: @updateRecord, triggerDelete: @deleteRecordChild, triggerChildRefresh: @triggerChildRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
    medicineStockRecordRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().name != undefined
                          @getLastRecord().name
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách thuốc trong kho'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Tình trạng', code: 'typerecord'}
                    {id: 2, name: 'Tên thuốc', code: 'name'}
                    {id: 3, name: 'Kí hiệu', code: 'noid'}
                    {id: 4, name: 'Số hiệu', code: 'signid'}
                    {id: 5, name: 'Số lượng', code: 'amount'}
                    {id: 6, name: 'Hạn sử dụng', code: 'expire'}
                    {id: 7, name: 'Nguồn cung cấp', code: 'supplier'}
                    {id: 8, name: 'Ghi chú', code: 'remark'}
                    {id: 9, name: 'Mã hóa đơn vào', code: 'bill_in_code'}
                    {id: 10, name: 'Mã đơn thuốc trong', code: 'internal_record_code'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Kho thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, prescript: null, billin: null, grouplist: @props.data[1], typelist: @props.data[2], record: @state.record, trigger: @addRecord, trigger2: @updateRecord, triggerDelete: @deleteRecordChild, triggerChildRefresh: @triggerChildRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
    orderMapRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().cname != undefined
                          @getLastRecord().cname
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách yêu cầu khám bệnh'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Yêu cầu khám bệnh'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-plus', text: ' Thêm', code: @props.datatype, type: 3, Clicked: @OpenModalAdd1
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'fa fa-trash-o', text: ' Xóa', modalid: 'modaldelete', type: 5
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, service:null, customer: null, trigger: @addRecord, trigger2: @updateRecord
              React.createElement ModalOutside, id: 'modaldelete', datatype: 'delete_form', trigger: @handleDelete
    checkInfoRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().ename != undefined
                          @getLastRecord().ename
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thông tin điều trị'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Tên bệnh nhân', code: 'c_name'}
                    {id: 2, name: 'Tên bác sỹ', code: 'ename'}
                    {id: 3, name: 'Kết luận', code: 'kluan'}
                    {id: 4, name: 'Chuẩn đoán', code: 'cdoan'}
                    {id: 5, name: 'Hướng điều trị', code: 'hdieutri'}
                    {id: 6, name: 'Tình trạng', code: 'status'}
                    {id: 7, name: 'Ngày bắt đầu', code: 'daystart'}
                    {id: 8, name: 'Ngày kết thúc', code: 'dayend'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thông tin điều trị'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
    doctorCheckInfoRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Số bản ghi tải"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @state.records.length
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 1 tháng'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bản ghi tạo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số cập nhật"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Cập nhật gần nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecord() != null
                        if @getLastRecord().cname != undefined
                          @getLastRecord().cname
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thông tin khám'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'row text-center', style: {'padding': '20px 20px 0px 20px','backgroundImage': '-webkit-linear-gradient(-270deg, #2a5e82 10%, #182848 90%)', 'backgroundImage': 'linear-gradient(0deg, #2a5e82 10%, #182848 90%)','borderColor': 'white'},
                  React.DOM.div className: 'col-sm-12',
                    React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
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
                    {id: 1, name: 'Tên bệnh nhân', code: 'c_name'}
                    {id: 2, name: 'Tên bác sỹ', code: 'ename'}
                    {id: 3, name: 'Quá trình bệnh lý', code: 'qtbenhly'}
                    {id: 4, name: 'Khám lâm sàng', code: 'klamsang'}
                    {id: 5, name: 'Chuẩn đoán ban đầu', code: 'cdbandau'}
                    {id: 6, name: 'Bệnh kèm theo', code: 'bktheo'}
                    {id: 7, name: 'Chuẩn đoán ICD', code: 'cdicd'}
                    {id: 8, name: 'Kết luận', code: 'kluan'}
                    {id: 9, name: 'Ngày kiểm tra', code: 'daycheck'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.records.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thông tin khám'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Sửa', modalid: 'modal1', code: @props.datatype, type: 4, Clicked: @triggerFillModal
              React.createElement ModalOutside, id: 'modal1', datatype: @props.datatype, record: @state.record, trigger: @addRecord, trigger2: @updateRecord
    doctorRoomRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12 hidden-xs',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Thống kê'
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'row',
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bệnh nhân chờ"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'},
                      if @state.records != undefined
                        @state.records.length
                      else
                        0
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Số bệnh nhân khám"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Người tiếp theo"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(1,2)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Trong 24h'
                      React.DOM.br null
                      "Người đang khám"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberCreated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Tổng'
                      React.DOM.br null
                      "Thời gian khám"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'2.7em'}, @getTotalRecordNumberUpdated(24,3)
                  React.DOM.div className: 'col-md-2 text-center',
                    React.DOM.h4 null,
                      React.DOM.span className: 'gfx-range', 'Total'
                      React.DOM.br null
                      "Yêu cầu mới nhất"
                    React.DOM.span className: 'number-xxl text-center', style: {'fontSize':'1.2em', 'textOverflow': 'ellipsis'},
                      if @getLastRecordCreated() != null
                        if @getLastRecordCreated().cname != undefined
                          @getLastRecordCreated().cname
                        else
                          ''
                      else
                        ''
        React.DOM.div className: 'spacer10'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-md-9',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Danh sách bệnh nhân'
              React.DOM.div className: 'card-body table-responsive',
                React.DOM.div className: 'spacer10'
                React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                React.createElement InputField, id: 'record_per_page', className: 'form-control', type: 'number', step: 1, code: 'rpp', placeholder: 'Số bản ghi mỗi trang', min: 1, style: '', trigger: @trigger, trigger2: @triggerChangeRPP, trigger3: @trigger
                React.DOM.div className: 'col-sm-2 pull-right', style: {'paddingBottom': '5px'},
                  React.createElement InputField, id: 'page_number', className: 'form-control', type: 'number', code: 'pn', step: 1, placeholder: 'Số trang', style: '', min: 1, trigger: @trigger, trigger2: @triggerChangePage, trigger3: @trigger
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-8 pull-right', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-8 pull-right', cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage, tp:
                    if @state.records != undefined
                      Math.ceil(@state.records.length/@state.viewperpage)
                    else
                      Math.ceil(0/@state.viewperpage)
                React.DOM.div className: 'spacer10'
                React.DOM.table className: 'table table-hover table-condensed',
                  React.createElement TableHeader, csc: @state.lastsorted, triggerClick: @triggerSort,  header: [
                    {id: 1, name: 'Số khám bệnh', code: 'id'}
                    {id: 2, name: 'Tên dịch vụ', code: 'sername'}
                    {id: 3, name: 'Tên khách hàng', code: 'cname'}
                    {id: 4, name: 'Tình trạng', code: 'status'}
                    {id: 5, name: 'Ghi chú', code: 'remark'}
                  ]
                  React.DOM.tbody null,
                    if @state.filteredRecord != null
                      for record in @state.filteredRecord[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecordAlt
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecordAlt
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecordAlt
                    else
                      for record in @state.records[@state.firstcount...@state.lastcount]
                        if @state.selected != null
                          if record.id == @state.selected
                            React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecordAlt
                          else
                            React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecordAlt
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecordAlt
                React.DOM.div className: 'spacer10'
                if @state.filteredRecord != null
                  React.createElement Paginate, className: 'col-sm-12', tp: Math.ceil(@state.filteredRecord.length/@state.viewperpage), cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage
                else
                  React.createElement Paginate, className: 'col-sm-12', cp: @state.currentpage, triggerLeftMax: @triggerLeftMax, triggerLeft: @triggerLeft, triggerRight: @triggerRight, triggerRightMax: @triggerRightMax, triggerPage: @triggerPage, tp:
                    if @state.records != undefined
                      Math.ceil(@state.records.length/@state.viewperpage)
                    else
                      Math.ceil(0/@state.viewperpage)
          React.DOM.div className: 'col-md-3 explorer-sidebar',
            React.DOM.div className: 'panel panel-default master-action',
              React.DOM.div className: 'panel-heading',
                React.DOM.h3 null, 'Đơn thuốc'
              React.DOM.div className: 'panel-body manage-index-actions-container',
                React.createElement ButtonGeneral, className: 'btn btn-default col-sm-12', icon: 'zmdi zmdi-edit', text: ' Thêm đơn thuốc', modalid: 'modal1', code: 'medicine_prescript_internal', type: 4, Clicked: @triggerFillModal
              React.createElement ModalOutside, id: 'modaldoctorview', datatype: @props.datatype, record: @state.extradata
              React.createElement ModalOutside, id: 'modal1', datatype: 'medicine_prescript_internal', internal_record: @state.addRecordChild, ordermap: @state.record, record: null, trigger: @trigger, trigger2: @trigger, triggerDelete: @deleteRecordChild, triggerChildRefresh: @triggerChildRecord
              React.createElement ModalOutside, id: 'modalinternalrecordmini', datatype: 'medicine_internal_record_mini', record: null, grouplist: @props.data[1], typelist: @props.data[2], trigger: @addRecordChild, trigger2: @trigger, record_id:
                if @state.addRecordChild.length == 0
                  1
                else
                  @state.addRecordChild[@state.addRecordChild.length - 1].id + 1      
    apiKeyRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12',
            if @state.records[0] == null or @state.records[0] == undefined
              React.DOM.div className: 'panel',
                React.DOM.div className: 'panel-body',
                  React.DOM.div className: 'text-center application-rights-table-empty text-muted',
                    "Bạn chưa khởi tạo Apikey"
                    React.DOM.div style: {'margin':'0px 5px'}
                    React.DOM.a onClick: @makeApikey, 'Khởi tạo'
            else
              React.DOM.div className: 'panel',
                React.DOM.div className: 'panel-heading',
                  React.DOM.h3 null, 'Danh sách Apikey tài khoản của bạn'
                React.DOM.div className: 'panel-body',
                  React.DOM.div className: 'spacer20'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h3 null, 'Application ID'
                      React.DOM.small className: 'text-muted', 'Đây là mã sản phẩm của bạn. Nó được sử dụng để xác định tài khoản của bạn đang sử dụng hệ thống của chúng tôi'
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h4 null, @state.records[0].appid
                  React.DOM.div className: 'spacer20'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h3 null, 'Search-Only API Key'
                      React.DOM.small className: 'text-muted', 'Đây là mã cho phép website của bạn tìm kiếm dữ liệu theo api được cung cấp'
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h4 null, @state.records[0].soapi
                  React.DOM.div className: 'spacer20'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h3 null, 'Monitoring API Key'
                      React.DOM.small className: 'text-muted', 'Đây là mã cho phép bạn truy cập vào các số liệu dành riêng cho tài khoản cá nhân'
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h4 null, @state.records[0].mapi
                  React.DOM.div className: 'spacer20'
                  React.DOM.div className: 'row',
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h3 null, 'Admin API Key'
                      React.DOM.small className: 'text-muted', 'Đây là mã cho phép website bên ngoài được quyền chỉnh sửa dữ liệu trong cơ sở dữ liệu của bạn'
                    React.DOM.div className: 'col-sm-6',
                      React.DOM.h4 null, @state.records[0].adminapi
                  React.DOM.button className: 'btn btn-default bg-green pull-right', onClick: @changeApikey, 'Thay đổi APIkey'
    teamControlRender: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        React.DOM.div className: 'row',
          React.DOM.div className: 'col-sm-12',
            React.DOM.div className: 'panel',
              React.DOM.div className: 'panel-body',
                React.DOM.div className: 'text-center application-rights-table-empty text-muted',
                  "Bạn chưa cấp quyền cho tài khoản khác"
                  React.DOM.div style: {'margin':'0px 5px'}
                  React.DOM.a null, 'Chỉ dành cho tài khoản Pro trở lên'
    loadingRender: ->
      React.DOM.div className: 'content-wrapper animated fadeIn', style: {'height': '50vh'},
        React.DOM.div className: 'preloader',
          React.DOM.i className: 'fa fa-cog fa-spin fa-3x'
    medicineSummary: ->
      React.DOM.div className: 'content-wrapper',
        React.DOM.div className: 'spacer30'
        if @state.analysis == 0
          React.DOM.div className: 'row',
            React.createElement MinorMaterial, datatype: 'medicine_summary_part', className: 'col-sm-6 col-xs-6 animated fadeInUp', header_text: 'Thống kê ngoài phòng khám', description: 'Thuốc không được nhà thuốc phòng khám cung cấp', color: '#FDBD57', altitle: 'Thuốc ngoài phòng khám', img: '/assets/getting-started-small.png'
            React.createElement MinorMaterial, datatype: 'medicine_summary_part', className: 'col-sm-6 col-xs-6 animated fadeInUp', header_text: 'Thống kê trong phòng khám', description: 'Thuốc được nhà thuốc phòng khám cung cấp', color: '#F6624E', altitle: 'Thuốc trong phòng khám', img: '/assets/indexing-small.png'
            React.createElement MinorMaterial, datatype: 'medicine_stock_summary_part', className: 'col-sm-12 col-xs-12 animated fadeInUp', text: 'Thống kê kho thuốc', color: '#1F3B5D', minheight: '150px', textcolor: '#8191B1'
            React.createElement MinorMaterial, datatype: 'medicine_summary_part', className: 'col-sm-6 col-xs-6 animated fadeInUp', header_text: 'Tình hình nhập thuốc', description: 'Thống kê phân loại thuốc nhập theo nguồn', color: '#E7486B', altitle: 'Thuốc nhập', img: '/assets/search-small.png'
            React.createElement MinorMaterial, datatype: 'medicine_summary_part', className: 'col-sm-6 col-xs-6 animated fadeInUp', header_text: 'Thống kê kinh doanh thuốc', description: 'Tình hình kinh doanh của từng loại thuốc', color: '#9C4274', altitle: 'Kinh doanh thuốc', img: '/assets/relevance-small.png'
    render: ->
      if @props.datatype == 'employee'
        @employeeRender()
      else if @props.datatype == 'room'
        @roomRender()
      else if @props.datatype == 'position'
        @positionRender()
      else if @props.datatype == 'service'
        @serviceRender()
      else if @props.datatype == 'posmap'
        @posmapRender()
      else if @props.datatype == 'sermap'
        @sermapRender()
      else if @props.datatype == "customer_record"
        @customerRecordRender()
      else if @props.datatype == "medicine_supplier"
        @medicineSupplierRender()
      else if @props.datatype == "medicine_company"
        @medicineCompanyRender()
      else if @props.datatype == "medicine_sample"
        @medicineSampleRender()
      else if @props.datatype == "medicine_bill_in"
        @medicineBillInRender()
      else if @props.datatype == "medicine_bill_record"
        @medicineBillRecordRender()
      else if @props.datatype == "medicine_price"
        @medicinePriceRender()
      else if @props.datatype == "medicine_prescript_external"
        @medicinePrescriptExternalRender()
      else if @props.datatype == "medicine_external_record"
        @medicineExternalRecordRender()
      else if @props.datatype == "medicine_prescript_internal"
        @medicinePrescriptInternalRender()
      else if @props.datatype == "medicine_internal_record"
        @medicineInternalRecordRender()
      else if @props.datatype == "medicine_stock_record"
        @medicineStockRecordRender()
      else if @props.datatype == "order_map"
        @orderMapRender()
      else if @props.datatype == "check_info"
        @checkInfoRender()
      else if @props.datatype == "doctor_check_info"
        @doctorCheckInfoRender()
      else if @props.datatype == "doctor_room"
        @doctorRoomRender()
      else if @props.datatype == "apikey"
        @apiKeyRender()
      else if @props.datatype == 'team_control'
        @teamControlRender()
      else if @props.datatype == 'loading'
        @loadingRender()
      else if @props.datatype == "medicine_summary"
        @medicineSummary()