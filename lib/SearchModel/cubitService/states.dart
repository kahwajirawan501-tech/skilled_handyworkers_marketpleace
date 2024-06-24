abstract class ServiceStates {}

class ServiceStatesInitialStateStates extends ServiceStates {}

class ServiceSucssessfullStateStates extends ServiceStates {

  ServiceSucssessfullStateStates();
}
class ServiceStatesSearchResultState extends ServiceStates {
  final List<String> searchResult;

  ServiceStatesSearchResultState(this.searchResult);
}
class ServiceErrorStateStates extends ServiceStates {

  ServiceErrorStateStates();
}