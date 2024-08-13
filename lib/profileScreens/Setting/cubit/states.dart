abstract class SettingStates {}

class SettingStatesInitialStateStates extends SettingStates {}

class SettingSucssessfullStateStates extends SettingStates {

  SettingSucssessfullStateStates();
}
class SettingErrorStateStates extends SettingStates {

  SettingErrorStateStates();
}
class ChangeOldPassWordVisibilityState extends SettingStates{}
class ChangeNewPassWordVisibilityState extends SettingStates{}
class ChangeConfigPassWordVisibilityState extends SettingStates{}

class ChangeLoadPassWord extends SettingStates{}
class ChangeSucsessfulPassWord extends SettingStates{}
class ChangeErrorPassWord extends SettingStates{}