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

class ServiceLoadingStateStates extends DashBoardStates {

  ServiceLoadingStateStates();
}
class ServiceSucssessfullStateStates extends DashBoardStates {

  ServiceSucssessfullStateStates();
}
class ServiceErrorStateStates extends DashBoardStates {
  final int stateCode;
  ServiceErrorStateStates(this.stateCode);
}
class ServiceStatesSearchResultState extends DashBoardStates {
  final List<Map<String, dynamic>> searchResult;

  ServiceStatesSearchResultState(this.searchResult);
}
class ServiceStatesInitialStateStates extends DashBoardStates {}

class DeletedServiceSucssessfullStateStates extends DashBoardStates {

  DeletedServiceSucssessfullStateStates();
}
class DeletedServiceErrorStateStates extends DashBoardStates {
  final int statusCode;

  DeletedServiceErrorStateStates(this.statusCode);
}
class DeletedServiceLoadStateStates extends DashBoardStates {

  DeletedServiceLoadStateStates();
}

class ADDServiceSucssessfullStateStates extends DashBoardStates {

  ADDServiceSucssessfullStateStates();
}
class ADDServiceErrorStateStates extends DashBoardStates {
  final int statusCode;

  ADDServiceErrorStateStates(this.statusCode);
}
class ADDServiceLoadStateStates extends DashBoardStates {

  ADDServiceLoadStateStates();
}
class PostLoadStateStates extends DashBoardStates{}
class PostSucssessfullStateStates extends DashBoardStates{}
class PostErrorStateStates extends DashBoardStates{}
class PostLoadStateStatesNext extends DashBoardStates{}

class DeletePostLoadStateStatesSearch extends DashBoardStates {

}
class  DeletePostSucssessfullStateStatesSearch extends DashBoardStates {

  DeletePostSucssessfullStateStatesSearch();
}
class  DeletePostErrorStateStatesSearch extends DashBoardStates {
  final int statusCode;
  DeletePostErrorStateStatesSearch(this.statusCode);
}

class GetUsersLoadStateStatesSearch extends DashBoardStates {

}
class  GetUsersSucssessfullStateStatesSearch extends DashBoardStates {

  GetUsersSucssessfullStateStatesSearch();
}
class  GetUsersErrorStateStatesSearch extends DashBoardStates {
  final int statusCode;
  GetUsersErrorStateStatesSearch(this.statusCode);
}

class DeletedUsersLoadStateStatesSearch extends DashBoardStates {

}
class  DeletedUsersSucssessfullStateStatesSearch extends DashBoardStates {

  DeletedUsersSucssessfullStateStatesSearch();
}
class  DeletedUsersErrorStateStatesSearch extends DashBoardStates {
  final int statusCode;
  DeletedUsersErrorStateStatesSearch(this.statusCode);
}
class GetUserMessageInitialStateStates extends DashBoardStates{}
class GetUserMessageSearchResultState  extends DashBoardStates{
  final List<Map<String, dynamic>> filteredUsers;

  GetUserMessageSearchResultState(this.filteredUsers);
}