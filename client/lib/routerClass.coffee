class @Router
  routes = []
  @route = (r) ->
    rx = /:[A-Za-z0-9]+/
    r.paramNames = []
    r.findPath = r.path
    while arr = rx.exec(r.findPath)
      for a in arr
        r.paramNames.push a.substring(1)
        r.findPath = r.findPath.replace(new RegExp(a), '([A-Za-z0-9]+)' )
    routes.push r
  @routes = (rs) => @route r for r in rs
  @notFound = ''

  getRoute = ->
    path = Client.url().path
    l = path.length
    path = path.substring(0, l - 1) if l > 1 and path.charAt(l - 1) is '/'
    for r in routes
      rx = new RegExp('^' + r.findPath + '$')
      return r if path.match(rx)
    undefined

  currentRoute = undefined
  @initialize = =>
    currentRoute = getRoute()
    if currentRoute
      r = currentRoute
      rx = new RegExp(r.findPath)
      url = Client.url()
      arr = rx.exec url.path
      r.params = {}
      if arr
        i = 0
        for a in arr
          if i > 0
            r.params[r.paramNames[i - 1]] = a
          i++

      r.query = {}
      for key of url.queryKey
        r.query[key] = url.queryKey[key]

  @template = =>
    currentRoute?.template || @notFound

  @data = =>
    r = currentRoute
    if r?.data then r.data() else undefined

  @layout = -> currentRoute?.layout