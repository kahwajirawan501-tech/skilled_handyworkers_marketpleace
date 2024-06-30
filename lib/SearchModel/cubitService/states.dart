abstract class ServiceStates {}

class ServiceStatesInitialStateStates extends ServiceStates {}
class ServiceLoadingStateStates extends ServiceStates {

  ServiceLoadingStateStates();
}

class ServiceSucssessfullStateStates extends ServiceStates {

  ServiceSucssessfullStateStates();
}
class ServiceErrorStateStates extends ServiceStates {
  final int stateCode;
  ServiceErrorStateStates(this.stateCode);
}
class ServiceStatesSearchResultState extends ServiceStates {
  final List<Map<String, dynamic>> searchResult;

  ServiceStatesSearchResultState(this.searchResult);
}
