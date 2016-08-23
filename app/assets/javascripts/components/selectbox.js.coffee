@SelectBox = React.createClass
    getInitialState: ->
      href: '../country/list'
      type: 1
      text: 'dafuq'
    handleLoad: (e) ->
      @setState records: []
      e.preventDefault()
      $.post @state.href, { type: @state.type }, (data) =>
        @setState records: data
        console.log(@state.records)
      , 'JSON'
    render: ->
      React.DOM.select
        className: 'form-control'
        onChange: @handleLoad
        React.DOM.option null,'1'
        React.DOM.option null,'2'
        React.DOM.option null,'3'