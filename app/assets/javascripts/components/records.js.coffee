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
              

@MainPart = React.createClass
    getInitialState: ->
      records: @props.data[0]
      selected: null
      record: null
      classSideBar: 'sidebar'
      existed: false
      searchRecord: null
      userlink: null
      autoComplete: null
      filteredRecord: null
    componentWillMount: ->
      $(APP).on 'rebuild', ((e) ->
        @setState
          records: @props.data[0]
          selected: null
          record: null
          classSideBar: 'sidebar'
          existed: false
          searchRecord: null
          userlink: null
          autoComplete: null
          filteredRecord: null
      ).bind(this)
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
    addRecord: (record) ->
      records = React.addons.update(@state.records, { $push: [record] })
      @setState records: records
    selectRecord: (result) ->
      @setState
        record: result
        selected: result.id
    trigger: (e) ->
      console.log(1)
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
        filteredRecord: result
    triggerChose: (result) ->
      @setState
        autoComplete: null
    triggerClear: (e) ->
      @setState
        autoComplete: null
        filteredRecord: null
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
    handleDelete: (e) ->
      e.preventDefault()
      if @state.record != null
        $.ajax
          method: 'DELETE'
          url: "/" + @props.datatype
          dataType: 'JSON'
          data: {id: @state.record.id}
          success: () =>
            @deleteRecord @state.record
    employeeRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Nhân viên'
        React.createElement AsideMenu, style: 2, record: @state.searchRecord, gender: @props.data[1], className: @state.classSideBar, existed: @state.existed, userlink: @state.userlink, handleSearch: @changeSearchRecord, addListener: @addRecordAlt, linkListener: @linkRecordAlt, updateListener: @updateRecordAlt
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-link', text: ' Liên kết', type: 1, Clicked: @toggleSideBar
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: "add"
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: "edit", record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-flash-off', text: ' Bỏ liên kết', type: 1, Clicked: @ClearlinkRecordAlt
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm chức vụ cho nhân viên', type: 2, trigger: @trigger, datatype: 'position_set_add', record: @state.record
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Name'
                  React.DOM.th null, 'Address'
                  React.DOM.th null, 'Phone Number'
                  React.DOM.th null, 'Ma NV'
                  React.DOM.th null, 'Gioi tinh'
                  React.DOM.th null, 'Anh'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    roomRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Phòng'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: "add"
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: "edit", record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên phòng'
                  React.DOM.th null, 'Ngôn ngữ'
                  React.DOM.th null, 'Bản đồ'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    positionRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Chức vụ'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add', extra: @props.data[1]
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', extra: @props.data[1], record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, rooms: @props.data[1], datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên phòng'
                  React.DOM.th null, 'Tên vị trí'
                  React.DOM.th null, 'Ngôn ngữ'
                  React.DOM.th null, 'Miêu tả ngắn'
                  React.DOM.th null, 'File đính kèm'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, room: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    serviceRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Dịch vụ'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên dịch vụ'
                  React.DOM.th null, 'Ngôn ngữ'
                  React.DOM.th null, 'Giá'
                  React.DOM.th null, 'Đơn vị tiền'
                  React.DOM.th null, 'Mô tả dịch vụ'
                  React.DOM.th null, 'Logo dịch vụ'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    posmapRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Định chức vụ cho nhân viên'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên nhân viên'
                  React.DOM.th null, 'Tên chức vụ'
                  React.DOM.th null, 'Cập nhật lần cuối'
                  React.DOM.th null, 'Khởi tạo lúc'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    sermapRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Định dịch vụ cho từng phòng'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên dịch vụ'
                  React.DOM.th null, 'Tên phòng'
                  React.DOM.th null, 'Cập nhật lần cuối'
                  React.DOM.th null, 'Khởi tạo lúc'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    customerRecordRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Danh sách bệnh nhân'
        React.createElement AsideMenu, key: 'Aside', style: 1, record: @state.searchRecord, gender: @props.data[1], className: @state.classSideBar, existed: @state.existed, userlink: @state.userlink, handleCustomerSearch: @changeSearchRecord, addListener: @addRecordAlt, linkListener: @linkRecordAlt, updateListener: @updateRecordAlt
        React.DOM.div className: 'col-md-9',
          React.DOM.div className: 'card',
            React.DOM.div className: 'card-header',
              React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-exchange', text: ' Toggle Sidebar', type: 1, Clicked: @toggleSideBar
              React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Add Record', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: "add"
              React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-pencil-square-o', text: ' Edit', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: "edit", record: @state.record
              React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Delete', type: 1, Clicked: @deleteRecord
              React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm yêu cầu khám bệnh', type: 2, trigger: @trigger, datatype: 'order_map', prefix: "add", extra: {datatype: @props.datatype, data: @state.record}
              React.DOM.br null
              React.DOM.br null
              React.createElement FilterForm, datatype: 'customer_record', autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
            React.DOM.div className: 'card-body table-responsive',
              React.DOM.table className: 'table table-hover table-condensed',
                React.DOM.thead null,
                  React.DOM.tr null,
                    React.DOM.th null, 'Họ và tên'
                    React.DOM.th null, 'Ngày sinh'
                    React.DOM.th null, 'Tuổi'
                    React.DOM.th null, 'Giới tính'
                    React.DOM.th null, 'Địa chỉ'
                    React.DOM.th null, 'Số điện thoại'
                    React.DOM.th null, 'CMTND'
                    React.DOM.th null, 'Ngày cấp'
                    React.DOM.th null, 'Nơi cấp'
                    React.DOM.th null, 'Ảnh đại diện'
                React.DOM.tbody null,
                  if @state.filteredRecord != null
                    for record in @state.filteredRecord
                      if @state.selected != null
                        if record.id == @state.selected
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                  else
                    for record in @state.records
                      if @state.selected != null
                        if record.id == @state.selected
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                        else
                          React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, gender: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
        React.DOM.div className: 'col-md-3',
          if @state.record != null
            React.createElement PatientProfile, gender: @props.data[1], record: @state.record, style: 'normal', clearLinkListener: @ClearlinkRecordAlt
    medicineSupplierRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Nguồn cấp thuốc'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã'
                  React.DOM.th null, 'Tên nguồn'
                  React.DOM.th null, 'Người liên lạc'
                  React.DOM.th null, 'Số ĐT cố định'
                  React.DOM.th null, 'Số ĐT di động'
                  React.DOM.th null, 'Địa chỉ 1'
                  React.DOM.th null, 'Địa chỉ 2'
                  React.DOM.th null, 'Địa chỉ 3'
                  React.DOM.th null, 'Email'
                  React.DOM.th null, 'Link Facebook'
                  React.DOM.th null, 'Twitter'
                  React.DOM.th null, 'Số fax'
                  React.DOM.th null, 'Mã số thuế'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    medicineCompanyRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Doanh nghiệp sản xuất'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã'
                  React.DOM.th null, 'Tên Doanh Nghiệp'
                  React.DOM.th null, 'Số ĐT'
                  React.DOM.th null, 'Địa chỉ'
                  React.DOM.th null, 'Email'
                  React.DOM.th null, 'Website'
                  React.DOM.th null, 'Mã số thuế'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord 
    medicineSampleRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Mẫu thuốc'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add', extra: [{data: @props.data[1]},{data: @props.data[2]}]
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record, extra: [{data: @props.data[1]},{data: @props.data[2]}]
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm công ty sản xuất', type: 2, datatype: 'medicine_company', prefix: 'add'
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, grouplist: @props.data[1], typelist: @props.data[2], autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã'
                  React.DOM.th null, 'Tên thuốc'
                  React.DOM.th null, 'Loại thuốc'
                  React.DOM.th null, 'Nhóm thuốc'
                  React.DOM.th null, 'Công ty sản xuất'
                  React.DOM.th null, 'Giá'
                  React.DOM.th null, 'Khối lượng'
                  React.DOM.th null, 'Ghi chú'
                  React.DOM.th null, 'Hạn sử dụng'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
    medicineBillInRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Hóa đơn nhập thuốc'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm thông tin thuốc nhập kho', type: 2, datatype: 'medicine_bill_record', prefix: 'add', billrecord: @state.record, record: null
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Số hóa đơn'
                  React.DOM.th null, 'Ngày nhập'
                  React.DOM.th null, 'Người cung cấp'
                  React.DOM.th null, 'Ngày đặt hàng'
                  React.DOM.th null, 'Tổng giá hàng hóa'
                  React.DOM.th null, 'Giảm giá'
                  React.DOM.th null, 'Tổng giá thanh toán'
                  React.DOM.th null, 'Cách thanh toán'
                  React.DOM.th null, 'Ghi chú'
                  React.DOM.th null, 'Tình trạng hóa đơn'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    medicineBillRecordRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Thông tin thuốc nhập kho'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm hóa đơn thuốc nhập kho', type: 2, datatype: 'medicine_bill_in', prefix: 'add', record: null
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
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
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    medicinePriceRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Thông tin giá thuốc'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record, extra: @props.data
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm mẫu thuốc', type: 2, datatype: 'medicine_sample', prefix: 'add', extra: @props.data
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên thuốc'
                  React.DOM.th null, 'Số lượng ít nhất'
                  React.DOM.th null, 'Giá thuốc'
                  React.DOM.th null, 'Ghi chú'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord, grouplist: @props.data[1], typelist: @props.data[2]
    medicinePrescriptExternalRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Đơn thuốc ngoài'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm thông tin bệnh nhân', type: 2, datatype: 'customer_record', prefix: 'add'
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã đơn thuốc'
                  React.DOM.th null, 'Bệnh nhân'
                  React.DOM.th null, 'Người kê đơn'
                  React.DOM.th null, 'Ngày kê'
                  React.DOM.th null, 'Kết quả khám'
                  React.DOM.th null, 'Số khám bệnh'
                  React.DOM.th null, 'Địa chỉ mua thuốc'
                  React.DOM.th null, 'Ghi chú'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    medicineExternalRecordRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Thông tin thuốc kê ngoài'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm đơn thuốc ngoài', type: 2, datatype: 'medicine_prescript_external', prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm thông tin bệnh nhân', type: 2, datatype: 'customer_record', prefix: 'add'
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã đơn thuốc'
                  React.DOM.th null, 'Tên thuốc'
                  React.DOM.th null, 'Tên bệnh nhân'
                  React.DOM.th null, 'Liều lượng'
                  React.DOM.th null, 'Ghi chú'
                  React.DOM.th null, 'Công ty sản xuất'
                  React.DOM.th null, 'Giá'
                  React.DOM.th null, 'Tổng tiền'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    medicinePrescriptInternalRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Đơn thuốc trong'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm thông tin bệnh nhân', type: 2, datatype: 'customer_record', prefix: 'add'
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Mã đơn thuốc'
                  React.DOM.th null, 'Bệnh nhân'
                  React.DOM.th null, 'Người kê đơn'
                  React.DOM.th null, 'Ngày kê'
                  React.DOM.th null, 'Người chuẩn bị thuốc'
                  React.DOM.th null, 'Người thanh toán'
                  React.DOM.th null, 'Tổng giá trị'
                  React.DOM.th null, 'Giảm giá'
                  React.DOM.th null, 'Tổng tiền thanh toán'
                  React.DOM.th null, 'Cách thanh toán'
                  React.DOM.th null, 'Số kết quả khám'
                  React.DOM.th null, 'Số khám bệnh'
                  React.DOM.th null, 'Ghi chú'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    medicineInternalRecordRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Thông tin thuốc kê trong'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm đơn thuốc trong', type: 2, datatype: 'medicine_prescript_internal', prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-plus', text: ' Thêm thông tin bệnh nhân', type: 2, datatype: 'customer_record', prefix: 'add'
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
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
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    medicineStockRecordRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Thông tin thống kê kho thuốc'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm đơn thuốc trong', type: 2, datatype: 'medicine_prescript_internal', prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm hóa đơn thuốc vào', type: 2, datatype: 'medicine_bill_in', prefix: 'add'
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tình trạng'
                  React.DOM.th null, 'Tên thuốc'
                  React.DOM.th null, 'Kí hiệu'
                  React.DOM.th null, 'Số hiệu'
                  React.DOM.th null, 'Số lượng'
                  React.DOM.th null, 'Hạn sử dụng'
                  React.DOM.th null, 'Nguồn cung cấp'
                  React.DOM.th null, 'Ghi chú'
                  React.DOM.th null, 'Mã hóa đơn vào'
                  React.DOM.th null, 'Mã đơn thuốc trong'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    orderMapRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Danh sách phiếu khám'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên dịch vụ'
                  React.DOM.th null, 'Tên khách hàng'
                  React.DOM.th null, 'Tình trạng'
                  React.DOM.th null, 'Tổng đơn giá'
                  React.DOM.th null, 'Giảm giá'
                  React.DOM.th null, 'Tổng thanh toán'
                  React.DOM.th null, 'Ghi chú'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    checkInfoRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Thông tin điều trị'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default disabled', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên bệnh nhân'
                  React.DOM.th null, 'Tên bác sỹ'
                  React.DOM.th null, 'Kết luận'
                  React.DOM.th null, 'Chuẩn đoán'
                  React.DOM.th null, 'Hướng điều trị'
                  React.DOM.th null, 'Tình trạng'
                  React.DOM.th null, 'Ngày bắt đầu'
                  React.DOM.th null, 'Ngày kết thúc'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    doctorCheckInfoRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Thông tin khám'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default disabled', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên bệnh nhân'
                  React.DOM.th null, 'Tên bác sỹ'
                  React.DOM.th null, 'Quá trình bệnh lý'
                  React.DOM.th null, 'Khám lâm sàng'
                  React.DOM.th null, 'Chuẩn đoán ban đầu'
                  React.DOM.th null, 'Bệnh kèm theo'
                  React.DOM.th null, 'Chuẩn đoán ICD'
                  React.DOM.th null, 'Kết luận'
                  React.DOM.th null, 'Ngày kiểm tra'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, datatype: @props.datatype, selected: false, selectRecord: @selectRecord
    billInfoRender: ->
      React.DOM.div className: 'container',
        React.DOM.div className: 'block-header',
          React.DOM.h2 null, 'Danh sách hóa đơn'
        React.DOM.div className: 'card',
          React.DOM.div className: 'card-header',
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-plus', text: ' Thêm', type: 2, trigger: @addRecord, datatype: @props.datatype, prefix: 'add'
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'zmdi zmdi-edit', text: ' Sửa', type: 2, trigger2: @updateRecord, datatype: @props.datatype, prefix: 'edit', record: @state.record
            React.createElement ButtonGeneral, className: 'btn btn-default', icon: 'fa fa-trash-o', text: ' Xóa', type: 1, Clicked: @handleDelete
            React.DOM.br null
            React.DOM.br null
            React.createElement FilterForm, datatype: @props.datatype, dvi: @props.data[1], autoComplete: @state.autoComplete, triggerInput: @triggerInput, triggerSubmit: @triggerSubmit, triggerClear: @triggerClear, triggerChose: @triggerChose
          React.DOM.div className: 'card-body table-responsive',
            React.DOM.table className: 'table table-hover table-condensed',
              React.DOM.thead null,
                React.DOM.tr null,
                  React.DOM.th null, 'Tên bệnh nhân'
                  React.DOM.th null, 'Diễn giải'
                  React.DOM.th null, 'Đơn vị'
                  React.DOM.th null, 'Số lượng'
                  React.DOM.th null, 'Đơn giá'
                  React.DOM.th null, 'Giảm giá'
                  React.DOM.th null, 'Thanh toán'
              React.DOM.tbody null,
                if @state.filteredRecord != null
                  for record in @state.filteredRecord
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                else
                  for record in @state.records
                    if @state.selected != null
                      if record.id == @state.selected
                        React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: true, selectRecord: @selectRecord
                      else
                        React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
                    else
                      React.createElement RecordGeneral, key: record.id, record: record, dvi: @props.data[1], datatype: @props.datatype, selected: false, selectRecord: @selectRecord
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
      else if @props.datatype == "bill_info"
        @billInfoRender()