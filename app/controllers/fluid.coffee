App.EmberTableFluidController = Ember.Controller.extend
  numRows: 100

  showTable: yes

  columns: Ember.computed ->
    dateColumn = App.FluidColumnDefinition.create
      textAlign: 'text-align-left'
      headerCellName: 'Date'
      getCellContent: (row) -> row.get('date').toDateString();
      defaultMinWidth: 200
    openColumn = App.FluidColumnDefinition.create
      headerCellName: 'Open'
      getCellContent: (row) -> row.get('open').toFixed(2)
    highColumn = App.FluidColumnDefinition.create
      savedWidth: 100
      headerCellName: 'High'
      getCellContent: (row) -> row.get('high').toFixed(2)
    lowColumn = App.FluidColumnDefinition.create
      savedWidth: 100
      headerCellName: 'Low'
      isResizable: no
      getCellContent: (row) -> row.get('low').toFixed(2)
    closeColumn = App.FluidColumnDefinition.create
      savedWidth: 100
      headerCellName: 'Close'
      getCellContent: (row) -> row.get('close').toFixed(2)
    [dateColumn, openColumn, highColumn, lowColumn, closeColumn]

  content: Ember.computed ->
    [0...@get('numRows')].map (index) ->
      date = new Date()
      date.setDate(date.getDate() + index)
      date:  date
      open:  Math.random() * 100 - 50
      high:  Math.random() * 100 - 50
      low:   Math.random() * 100 - 50
      close: Math.random() * 100 - 50
      volume: Math.random() * 1000000
  .property 'numRows'

  actions:
    refreshTable: ->
      @set 'showTable', no
      console.log 'refresh'
      Ember.run.next =>
        @set 'showTable', yes


App.FluidColumnDefinition = Ember.Table.ColumnDefinition.extend
  minWidth: 25
  minWidthValue: Ember.computed (key, value) ->
    if arguments.length is 1
      return @get('minWidth')
    else
      @set('minWidth', parseInt(value))
      return @get('minWidth')
  .property 'minWidth'


# Add some observers so configuration changes will work properly
#App.FluidTableComponent = Ember.Table.EmberTableComponent.extend
  #configurationObserver: Ember.observer ->
    #console.log 'configuration changed!'
    #@updateLayout()
    #@doForceFillColumns()
    #@rerender()
  #, 'columns.@each.minWidth'
