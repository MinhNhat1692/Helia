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