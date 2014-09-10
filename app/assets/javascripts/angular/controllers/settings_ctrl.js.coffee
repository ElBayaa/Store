App.controller 'SettingsCtrl', ['$scope', 'Setting', ($scope, $setting) ->
  # Attributes accessible on the view
  $scope.settings = []
  $scope.new_setting = {data_type: 'String'}

  $scope.setSettings = (settings) ->
    $scope.settings = settings 

  $scope.createSetting = ()->
    persisted_setting = $setting.save($scope.new_setting)
    $scope.settings.unshift persisted_setting
    $scope.new_setting = {data_type: 'String'}

  $scope.editSetting = (setting)->
    $scope.new_setting = setting

  $scope.updateSetting = ()->
    persisted_setting = $setting.update($scope.new_setting)
    $scope.new_setting = {data_type: 'String'}
  
  $scope.deleteSetting = (setting, index)->
    $setting.remove(setting)
    $scope.settings.splice(index, 1)
]