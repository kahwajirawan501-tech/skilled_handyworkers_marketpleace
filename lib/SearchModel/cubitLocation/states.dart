abstract class LocationStates {}

class LocationStatesInitialStateStates extends LocationStates {}
class LocationLoadingStatesStateStates extends LocationStates {}

class LocationSucssessfullStateStates extends LocationStates {

  LocationSucssessfullStateStates();
}
class LocationErrorStateStates extends LocationStates {
  final int statusCode;

  LocationErrorStateStates(this.statusCode);
}
class LocationStatesSearchResultState extends LocationStates {
  final  List<Map<String, dynamic>> searchResult;

  LocationStatesSearchResultState(this.searchResult);
}
