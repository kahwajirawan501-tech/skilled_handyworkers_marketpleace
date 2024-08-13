abstract class DashBoardStates {}

class LocationStatesInitialStateStates extends DashBoardStates {}
class LocationLoadingStatesStateStates extends DashBoardStates {}

class LocationSucssessfullStateStates extends DashBoardStates {

  LocationSucssessfullStateStates();
}
class LocationErrorStateStates extends DashBoardStates {
  final int statusCode;

  LocationErrorStateStates(this.statusCode);
}
class LocationStatesSearchResultState extends DashBoardStates {
  final  List<Map<String, dynamic>> searchResult;

  LocationStatesSearchResultState(this.searchResult);
}


class DeletedLocationSucssessfullStateStates extends DashBoardStates {

  DeletedLocationSucssessfullStateStates();
}
class DeletedLocationErrorStateStates extends DashBoardStates {
  final int statusCode;

  DeletedLocationErrorStateStates(this.statusCode);
}
class DeletedLocationLoadStateStates extends DashBoardStates {

  DeletedLocationLoadStateStates();
}

class ADDLocationSucssessfullStateStates extends DashBoardStates {

  ADDLocationSucssessfullStateStates();
}
class ADDLocationErrorStateStates extends DashBoardStates {
  final int statusCode;

  ADDLocationErrorStateStates(this.statusCode);
}
class ADDLocationLoadStateStates extends DashBoardStates {

  ADDLocationLoadStateStates();
}

