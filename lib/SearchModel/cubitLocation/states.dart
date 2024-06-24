abstract class LocationStates {}

class LocationStatesInitialStateStates extends LocationStates {}

class LocationSucssessfullStateStates extends LocationStates {

  LocationSucssessfullStateStates();
}
class LocationStatesSearchResultState extends LocationStates {
  final List<String> searchResult;

  LocationStatesSearchResultState(this.searchResult);
}
class LocationErrorStateStates extends LocationStates {

  LocationErrorStateStates();
}