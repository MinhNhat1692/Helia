@news = React.createClass
    getInitialState: ->
      header: @props.header
      recommend: @props.recommend
      mostview: @props.mostview
      recordheader: null
      record: null
    selectRecord: (record) ->
      formData = new FormData
      formData.append 'news_id', record.id
      if formData != undefined
        $.ajax
          url: '/news'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @setState
              recordheader: record
              record: result
            return
          ).bind(this)
    loadNewsList: (code) ->
      formData = new FormData
      formData.append 'cat', code
      if formData != undefined
        $.ajax
          url: '/news'
          type: 'POST'
          data: formData
          async: false
          cache: false
          contentType: false
          processData: false
          success: ((result) ->
            @setState
              record: null
              recordheader: null
              header: result[0]
              recommend: result[1]
              mostview: result[2]
            return
          ).bind(this)
    FullRender: ->
      React.DOM.section className: 'row clog',
        React.DOM.img className: 'clog-top-img', src: 'assets/bg-pricing.jpg', style: {'width': '100%', 'height': '250px'}
        React.DOM.div className: 'container clog-content',
          React.DOM.div className: 'col-sm-12',
            React.DOM.div className: 'row text-center',
              React.DOM.h2 null, "Thông tin"
              React.DOM.hr className: 'colored'
              React.DOM.p null, 'Mời các bạn chọn tin tức muốn xem'
              React.DOM.br null
              React.createElement ButtonGeneral, className: 'btn btn-default', text: 'Tin tức sản phẩm', code: '1', type: 3, Clicked: @loadNewsList
              React.createElement ButtonGeneral, className: 'btn btn-default', text: 'Hướng dẫn sử dụng', code: '2', type: 3, Clicked: @loadNewsList
              React.createElement ButtonGeneral, className: 'btn btn-default', text: 'Thông tin khuyến mãi', code: '3', type: 3, Clicked: @loadNewsList
              React.DOM.br null
            React.DOM.div className: 'col-sm-9 news-content',
              if @state.record == null
                React.createElement newslist, records: @state.header, selectRecord: @selectRecord, datatype: 1
              else
                React.createElement newscontent, record: @state.record, records: @state.header, header: @state.recordheader, selectRecord: @selectRecord, datatype: 1
            React.DOM.div className: 'col-sm-3 hidden-xs',
              React.createElement newslist, records: @state.recommend, selectRecord: @selectRecord, datatype: 2
              React.createElement newslist, records: @state.mostview, selectRecord: @selectRecord, datatype: 3
    render: ->
      @FullRender()

@newscontent = React.createClass
    getInitialState: ->
      select: null
    selectRecord: (record) ->
      @props.selectRecord record
    renderNews: ->
      React.DOM.div className: 'news-body animated fadeInLeftBig',
        React.DOM.h4 null, @props.header.title
        React.DOM.hr className: 'colored'
        React.DOM.p className: 'datetime', @props.header.updated_at.substring(8, 10) + "/" + @props.header.updated_at.substring(5, 7) + "/" + @props.header.updated_at.substring(0, 4) + " " + @props.header.updated_at.substring(11,18)
        React.DOM.br null
        React.DOM.b null, @props.header.des
        React.DOM.p null, @props.record.content
        React.DOM.br null
        React.DOM.h4 null, "Các tin liên quan"
        React.DOM.hr className: 'colored'
        React.DOM.ul null,
          for record in @props.records
            React.createElement newlistblock, key: record.id, record: record, selectRecord: @selectRecord, datatype: 3
    render: ->
      @renderNews()
      
@newslist = React.createClass
    getInitialState: ->
      select: null
    selectRecord: (record) ->
      @props.selectRecord record
    NewsListRender: ->
      React.DOM.div className: 'news-body animated fadeIn',
        React.DOM.h3 null, "Tin tức"
        React.DOM.hr className: 'colored'
        if @props.records != null
          for record in @props.records
            React.createElement newlistblock, key: record.id, record: record, selectRecord: @selectRecord, datatype: 1
    recomendRender: ->
      React.DOM.div className: 'news-recommend animated fadeIn',
        React.DOM.h4 null, "Tin cùng chủ để"
        if @props.records != null
          for record in @props.records
            React.createElement newlistblock, key: record.id, record: record, selectRecord: @selectRecord, datatype: 2
    mostviewRender: ->
      React.DOM.div className: 'news-mostview animated fadeIn',
        React.DOM.h4 null, "Xem nhiều nhất"
        if @props.records != null
          for record in @props.records
            React.createElement newlistblock, key: record.id, record: record, selectRecord: @selectRecord, datatype: 2
    render: ->
      if @props.datatype == 1
        @NewsListRender()
      else if @props.datatype == 2
        @recomendRender()
      else if @props.datatype == 3
        @mostviewRender()


@newlistblock = React.createClass
  getInitialState: ->
    select: null
  selectRecord: ->
    @props.selectRecord @props.record
  newlistblockRender: ->
    React.DOM.div className: 'row news-block',
      React.DOM.div className: 'col-sm-5',
        React.DOM.img src: @props.record.image_f, className: 'news-list-img', style: {'cursor':'pointer'}, onClick: @selectRecord
      React.DOM.div className: 'col-sm-7',
        React.DOM.h4 style: {'cursor':'pointer'}, onClick: @selectRecord, @props.record.title
        React.DOM.p className: 'datetime', @props.record.updated_at.substring(8, 10) + "/" + @props.record.updated_at.substring(5, 7) + "/" + @props.record.updated_at.substring(0, 4) + " " + @props.record.updated_at.substring(11,18)
        React.DOM.p className: 'desc', @props.record.des
  newlistblockRender2: ->
    React.DOM.div className: 'row',
      React.DOM.div className: 'col-sm-5',
        React.DOM.img src: @props.record.image_f, className: 'news-list-img', style: {'cursor':'pointer'}, onClick: @selectRecord
      React.DOM.div className: 'col-sm-7',
        React.DOM.p style: {'cursor':'pointer'}, onClick: @selectRecord, @props.record.title
  newlistblockRender3: ->
    React.DOM.li style: {'cursor':'pointer'}, onClick: @selectRecord,
      React.DOM.p null, @props.record.title
  render: ->
    if @props.datatype == 1
      @newlistblockRender()  
    else if @props.datatype == 2
      @newlistblockRender2()
    else if @props.datatype == 3
      @newlistblockRender3()