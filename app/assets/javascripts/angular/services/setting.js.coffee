App.factory 'Setting', ['$resource', ($resource) ->
  
  $resource("/settings/:id", {id: '@id'}, { update: { method: 'PUT' }})
  
]
