@clog = React.createClass
    getInitialState: ->
      lcl: @props.lcl
      data: @props.data
    selectRecord: (record) ->
      formData = new FormData
      formData.append 'd_a', record.d_a
      if formData != undefined
        $.ajax
          url: '/changelogs'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @setState data: result
            return
          ).bind(this)
    FullRender: ->
      React.DOM.section className: 'row clog',
        React.DOM.img className: 'clog-top-img', src: 'assets/bg-pricing.jpg', style: {'width': '100%', 'height': '250px'}
        React.DOM.div className: 'container clog-content',
          React.DOM.div className: 'col-sm-12',
            React.DOM.div className: 'row text-center',
              React.DOM.h2 null, "Cập nhật"
              React.DOM.hr className: 'colored'
              React.DOM.p null, 'Danh sách những thay đổi trong sản phẩm của chúng tôi qua thời gian'
              React.DOM.br null
            React.DOM.div className: 'col-sm-9',
              React.createElement clogbody, d_a: @state.data[0].d_a, records: @state.data
            React.DOM.div className: 'col-sm-3',
              React.createElement clogbox, records: @props.lcl, selectRecord: @selectRecord
    render: ->
      @FullRender()
      
@clogbody = React.createClass
  getInitialState: ->
    select: null
  selectRecord: (record) ->
    @props.selectRecord record
  clogBodyRender: ->
    React.DOM.div className: 'clog-body',
      React.DOM.h3 null, @props.d_a.substring(8, 10) + "/" + @props.d_a.substring(5, 7) + "/" + @props.d_a.substring(0, 4)
      React.DOM.br null
      if @props.records != null
        for record in @props.records
          React.createElement clogbodyc, key: record.id, record: record, selectRecord: @selectRecord
  render: ->
    @clogBodyRender()
      
@clogbox = React.createClass
  getInitialState: ->
    select: null
  selectRecord: (record) ->
    @props.selectRecord record
  clogBoxRender: ->
    React.DOM.div className: 'clog-box',
      React.DOM.h4 null, 'Danh sách thay đổi'
      React.DOM.ul null,
        if @props.records != null
          for record in @props.records
            React.createElement clogboxc, key: record.id, record: record, selectRecord: @selectRecord
  render: ->
    @clogBoxRender()
            
            
@clogboxc = React.createClass
  getInitialState: ->
    select: null
  selectRecord: (e) ->
    @props.selectRecord @props.record
  clogBoxChildRender: ->
    React.DOM.li style: {'cursor': 'pointer'}, onClick: @selectRecord,
      React.DOM.p null, @props.record.d_a.substring(8, 10) + "/" + @props.record.d_a.substring(5, 7) + "/" + @props.record.d_a.substring(0, 4)
  render: ->
    @clogBoxChildRender()
    
@clogbodyc = React.createClass
  getInitialState: ->
    select: null
  clogBodyChildRender: ->
    changes = @props.record.c_content.split("|")
    start = 0
    React.DOM.div null,
      React.DOM.h4 null, @props.record.c_c
      React.DOM.ul null,
        React.DOM.li null,
          React.DOM.p null, @props.record.c_content
        for change in changes
          start += 1 
          React.DOM.li key: start,
            React.DOM.p key: start, change
      React.DOM.br null
  render: ->
    @clogBodyChildRender()