Router.routes [
  template: 'about'
  path: '/about'
,
  template: 'contact'
  path: '/contact'
  data: ->
    names: ['Tom', 'Dick', 'Harry']
,
  template: 'contact'
  path: '/contact/:name'
  data: ->
    names: [this.params.name]
,
  template: 'contact'
  path: '/contact/:name1/:name2'
  data: ->
    names: [this.params.name1, this.params.name2]
,
  template: 'contact'
  path: '/contactByName'
  data: ->
    names: [this.query.name]
,
  template: 'home'
  path: '/'
  layout: 'defaultLayout'
]

Router.notFound = 'notFound'
