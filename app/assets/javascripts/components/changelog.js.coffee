@clog = React.createClass
    getInitialState: ->
      lcl: @props.lcl
      data: @props.data
    FullRender: ->
      React.DOM.ul id: 'timeline',
        React.DOM.li className: 'arrow hidden-xs'
        for date in @props.lcl
          React.createElement clogbody, key: date.id, d_a: date.d_a, records: @props.data
    render: ->
      @FullRender()

#clogbody use to print out changelog each day
#input: d_a - date of that update
#       records - all data

@clogbody = React.createClass
  getInitialState: ->
    select: null
  clogBodyRender: ->
    React.DOM.li className: 'show-details',
      React.DOM.div className: 'relative',
        React.DOM.label className: 'anchored-changelog', @props.d_a.substring(8, 10) + "/" + @props.d_a.substring(5, 7) + "/" + @props.d_a.substring(0, 4)
        React.DOM.span className: 'circle'
      React.createElement clogbodyc, key: @props.d_a, records: @props.records, d_a: @props.d_a
  render: ->
    @clogBodyRender()
    
@clogbodyc = React.createClass
  getInitialState: ->
    select: null
  clogBodyChildRender: ->
    React.DOM.div className: 'content',
      if @props.records != null
        for record in @props.records
          if record.d_a == @props.d_a
            changes = record.c_content.split("|")
            start = 0
            React.DOM.div key: record.id,
              React.DOM.p null, record.c_c
              React.DOM.ul null,
                for change in changes
                  start += 1
                  React.DOM.li key: start, change
  render: ->
    @clogBodyChildRender()
    
#Doc 
@DocsList = React.createClass
  getInitialState: ->
    cat: @props.cat
    sub: @props.sub
    con: @props.con
  trigger: (code) ->
    $.ajax
      url: '/documentation/guides'
      type: 'POST'
      data: {sub_id:code}
      dataType: 'JSON'
      success: ((result) ->
        @setState
          con: result
        return
      ).bind(this)
  DocRender: ->
    React.DOM.div id: 'doc-content-wrapper',
      React.DOM.div className: 'container',
        React.createElement DoclistNav, cat: @state.cat, sub: @state.sub, con: @state.con, trigger: @trigger
        React.createElement DocsContent, cat: @state.cat, sub: @state.sub, con: @state.con
  render: ->
    @DocRender()

@DocsContent = React.createClass
  getInitialState: ->
    type: 1
  getrightcat: ->
    result = {cat: {color: '000000', name: 'Không có tin khả dụng'}, sub: {name: 'Không có tin khả dụng'}}
    for cat in @props.cat
      for sub in @props.sub
        if cat.id == sub.doc_cats_id
          for con in @props.con
            if con.doc_subs_id == sub.id
              result = {cat: cat, sub: sub}
              return result
    return result
  DocsContentRender: ->
    React.DOM.div id: 'doc-content',
      React.DOM.div className: 'doc-online', id: 'doc-tab-content',
        React.DOM.div className: 'markdown-page',
          React.DOM.section className: 'heading',
            React.DOM.div className: 'title_wrapper', style: {'backgroundColor': '#' + @getrightcat().cat.color},
              React.DOM.div className: 'title_sub_wrapper row',
                React.DOM.div className: 'type-icon',
                  React.DOM.i className: 'fa fa-book fa-3x'
                React.DOM.div className: 'title_sub_sub_wrapper',
                  React.DOM.div className: 'breadcrumb',
                    "Hướng dẫn > " + @getrightcat().cat.name
                  React.DOM.h1 null, @getrightcat().sub.name
            React.DOM.div className: 'toc_wrapper',
              React.DOM.div className: 'summary_title',
                'Danh mục'
              React.DOM.ul null,
                for con in @props.con
                  React.DOM.li key: con.id, con.header
        React.DOM.div className: 'markdown-page',
          for con in @props.con
            React.createElement 'section', key: con.id, dangerouslySetInnerHTML: __html: con.content
  render: ->
    @DocsContentRender()
        
@DoclistNav = React.createClass
  getInitialState: ->
    type: 1
  trigger: (id) ->
    @props.trigger id
  NavRender: ->
    React.DOM.div id: 'navbar-doc-wrapper',
      React.DOM.nav className: 'scrollable navbar-guide-toc fixed', id: 'navbar-doc',
        for cat in @props.cat
          React.createElement DoclistNavChild, key: cat.id, sub: @props.sub, con: @props.con, cat: cat, trigger: @trigger
  render: ->
    @NavRender()

@DoclistNavChild = React.createClass
  getInitialState: ->
    open: @getopenstat()
  getopenstat: ->
    for sub in @props.sub
      if sub.doc_cats_id == @props.cat.id
        for con in @props.con
          if sub.id == con.doc_subs_id
            return true
    return false
  trigger: (id) ->
    @props.trigger id
  toggleOpen: (e) ->
    @setState open: !@state.open
  NavchildRender:->
    if @state.open
      React.DOM.div className: 'ul-group active', style: {'borderColor': '#' + @props.cat.color},
        React.DOM.div className: 'ul-group-name', onClick: @toggleOpen,
          @props.cat.name
          React.DOM.i className: 'fa fa-angle-up'
        React.DOM.ul className: 'nav',
          for sub in @props.sub
            if sub.doc_cats_id == @props.cat.id
              React.createElement DoclistNavChildMini, key: sub.id, sub: sub, con: @props.con, trigger: @trigger 
    else
      React.DOM.div className: 'ul-group', style: {'borderColor': '#' + @props.cat.color},
        React.DOM.div className: 'ul-group-name', onClick: @toggleOpen, 
          @props.cat.name
          React.DOM.i className: 'fa fa-angle-down'
        React.DOM.ul className: 'nav',
          for sub in @props.sub
            if sub.doc_cats_id == @props.cat.id
              React.createElement DoclistNavChildMini, key: sub.id, sub: sub, con: @props.con, trigger: @trigger 
  render: ->
    @NavchildRender()

@DoclistNavChildMini = React.createClass
  getInitialState: ->
    type: 1
  trigger: (e) ->
    @props.trigger @props.sub.id
  getopenstat: ->
    for con in @props.con
      if @props.sub.id == con.doc_subs_id
        return true
      else
        return false
    return false
  render: ->
    if @getopenstat()
      React.DOM.li className: 'active caretable', onClick: @trigger, @props.sub.name
    else
      React.DOM.li className: 'caretable', onClick: @trigger, @props.sub.name  

#News
@NewsList = React.createClass
  getInitialState: ->
    cat: @props.cat
    sub: @props.sub
    con: @props.con
    relate: @props.related
  NewRender: ->
    if @props.datatype == 'news_con'
      React.DOM.div id: 'doc-content-wrapper',
        React.DOM.div className: 'container',
          React.createElement NewslistNav, cat: @state.cat, sub: @state.sub, con: @state.con
          React.createElement NewsContent, cat: @state.cat, sub: @state.sub, con: @state.con, relate: @state.relate, datatype: @props.datatype
    else if @props.datatype == 'news_cat'
      React.DOM.div id: 'doc-content-wrapper',
        React.DOM.div className: 'container',
          React.createElement NewslistNav, cat: @state.cat, sub: @state.sub, con: @state.con
          React.createElement NewsContent, cat: @state.cat, sub: @state.sub, con: @state.con, datatype: @props.datatype
  render: ->
    @NewRender()
    
@NewsContent = React.createClass
  getInitialState: ->
    type: 1
  getrightcat: -> #need change to right value
    result = {cat: {color: '000000', name: 'Không có tin khả dụng'}, sub: {name: 'Không có tin khả dụng'}}
    for cat in @props.cat
      for sub in @props.sub
        if cat.id == sub.news_category_id
          for con in @props.con
            if con.news_sub_category_id == sub.id
              result = {cat: cat, sub: sub}
              return result
    return result
  getrightlink: (con)->
    console.log(con)
    link = "/blogs/"
    link+= con.title.toLowerCase().replace(" ","-") + "-" + con.id
    return link
  NewsContentRender: ->
    React.DOM.div id: 'doc-content',
      if @props.datatype == 'news_con'
        React.DOM.div className: 'doc-online', id: 'doc-tab-content',
          React.DOM.div className: 'markdown-page',
            React.DOM.section className: 'heading',
              React.DOM.div className: 'title_wrapper', style: {'backgroundColor': '#' + @getrightcat().cat.color},
                React.DOM.div className: 'title_sub_wrapper row',
                  React.DOM.div className: 'type-icon',
                    React.DOM.i className: 'fa fa-book fa-3x'
                  React.DOM.div className: 'title_sub_sub_wrapper',
                    React.DOM.div className: 'breadcrumb',
                      "Tin tức > " + @getrightcat().cat.name
                    React.DOM.h1 null, @getrightcat().sub.name
              React.DOM.div className: 'toc_wrapper',
                React.DOM.div className: 'summary_title',
                  'Tin liên quan'
                React.DOM.ul null,
                  for relate in @props.relate
                    React.DOM.li key: relate.id,
                      React.DOM.a href: @getrightlink(relate), relate.title
          React.DOM.div className: 'markdown-page',
            for con in @props.con
              React.createElement 'section', key: con.id, dangerouslySetInnerHTML: __html: con.content
      else if @props.datatype == 'news_cat'
        React.DOM.div className: 'doc-online', id: 'doc-tab-content',
          React.DOM.div className: 'markdown-page',
            React.DOM.section className: 'heading',
              React.DOM.div className: 'title_wrapper', style: {'backgroundColor': '#' + @getrightcat().cat.color},
                React.DOM.div className: 'title_sub_wrapper row',
                  React.DOM.div className: 'type-icon',
                    React.DOM.i className: 'fa fa-book fa-3x'
                  React.DOM.div className: 'title_sub_sub_wrapper',
                    React.DOM.div className: 'breadcrumb',
                      "Tin tức > " + @getrightcat().cat.name
                    React.DOM.h1 null, @getrightcat().sub.name
              React.DOM.div className: 'toc_wrapper',
                React.DOM.div className: 'summary_title',
                  'Danh sách tin'
                React.DOM.ul null,
                  for relate in @props.con
                    React.DOM.li key: relate.id,
                      React.DOM.a href: @getrightlink(relate), relate.title
  render: ->
    @NewsContentRender()

@NewslistNav = React.createClass
  getInitialState: ->
    type: 1
  NavRender: ->
    React.DOM.div id: 'navbar-doc-wrapper',
      React.DOM.nav className: 'scrollable navbar-guide-toc fixed', id: 'navbar-doc',
        for cat in @props.cat
          React.createElement NewslistNavChild, key: cat.id, sub: @props.sub, con: @props.con, cat: cat, trigger: @trigger
  render: ->
    @NavRender()
    
@NewslistNavChild = React.createClass
  getInitialState: ->
    open: @getopenstat()
  getopenstat: ->
    for sub in @props.sub
      if sub.news_category_id == @props.cat.id
        for con in @props.con
          if sub.id == con.news_sub_category_id
            return true
    return false
  toggleOpen: (e) ->
    @setState open: !@state.open
  NavchildRender:->
    if @state.open
      React.DOM.div className: 'ul-group active', style: {'borderColor': '#' + @props.cat.color},
        React.DOM.div className: 'ul-group-name', onClick: @toggleOpen,
          @props.cat.name
          React.DOM.i className: 'fa fa-angle-up'
        React.DOM.ul className: 'nav',
          for sub in @props.sub
            if sub.news_category_id == @props.cat.id
              React.createElement NewslistNavChildMini, key: sub.id, sub: sub, con: @props.con 
    else
      React.DOM.div className: 'ul-group', style: {'borderColor': '#' + @props.cat.color},
        React.DOM.div className: 'ul-group-name', onClick: @toggleOpen, 
          @props.cat.name
          React.DOM.i className: 'fa fa-angle-down'
        React.DOM.ul className: 'nav',
          for sub in @props.sub
            if sub.news_category_id == @props.cat.id
              React.createElement NewslistNavChildMini, key: sub.id, sub: sub, con: @props.con
  render: ->
    @NavchildRender()
    
@NewslistNavChildMini = React.createClass
  getInitialState: ->
    type: 1
  getrightlink: (sub) ->
    link = '/blogs?cat_id='
    link+= sub.id
    return link
  getopenstat: ->
    for con in @props.con
      if @props.sub.id == con.news_sub_category_id
        return true
      else
        return false
    return false
  render: ->
    if @getopenstat()
      React.DOM.li className: 'active caretable',
        React.DOM.a href: @getrightlink(@props.sub), style: {'padding': '0px 5px 0px 0px'}, @props.sub.name
    else
      React.DOM.li className: 'caretable',
        React.DOM.a href: @getrightlink(@props.sub), style: {'padding': '0px 5px 0px 0px'}, @props.sub.name


