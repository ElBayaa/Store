App.controller 'SettingsCtrl', ['$scope', 'Setting', ($scope, $setting) ->
  # Attributes accessible on the view
  $scope.settings = []
  $scope.new_setting = {data_type: 'String'}

  $scope.setSettings = (settings) ->
    $scope.settings = settings 
]