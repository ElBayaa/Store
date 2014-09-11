App.controller 'SettingsCtrl', ['$scope', 'Setting', ($scope, $setting) ->
  # Attributes accessible on the view
  $scope.settings = []
  $scope.new_setting = {data_type: 'String'}
  $scope.model_errors = null

  $scope.setSettings = (settings) ->
    $scope.settings = settings 

  $scope.createSetting = ()->
    $setting.save $scope.new_setting, (data)->
      $scope.settings = $setting.query()
      $scope.new_setting = {data_type: 'String'}
      $scope.model_errors = null
      $('input.validation').removeClass('ng-dirty')
    , (res)->
      $scope.model_errors = res.data

  $scope.editSetting = (setting)->
    $scope.new_setting = setting

  $scope.updateSetting = ()->
    $setting.update $scope.new_setting, (data)->
      $scope.new_setting = {data_type: 'String'}
      $scope.model_errors = null
      $('input.validation').removeClass('ng-dirty')
    , (res)->
      $scope.model_errors = res.data
  
  $scope.deleteSetting = (setting, index)->
    $setting.remove(setting)
    $scope.settings.splice(index, 1)
]