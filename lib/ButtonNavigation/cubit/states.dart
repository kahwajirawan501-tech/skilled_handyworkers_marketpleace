abstract class HomeStates {}

class HomeStatesInitialStateStates extends HomeStates {}

class HomeSucssessfullStateStates extends HomeStates {

  HomeSucssessfullStateStates();
}
class HomeErrorStateStates extends HomeStates {

  HomeErrorStateStates();
}
class GetInformationStatesLoadingStateStates extends HomeStates {}
class GetInformationSucssessfullStateStates extends HomeStates {

  GetInformationSucssessfullStateStates();
}
class GetInformationErrorStateStates extends HomeStates {
  final int stateCode;
  GetInformationErrorStateStates(this.stateCode);
}

class GetInformationIDStatesLoadingStateStates extends HomeStates {}
class GetInformationIDSucssessfullStateStates extends HomeStates {

  GetInformationIDSucssessfullStateStates();
}
class GetInformationIdErrorStateStates extends HomeStates {
  final int stateCode;
  GetInformationIdErrorStateStates(this.stateCode);
}