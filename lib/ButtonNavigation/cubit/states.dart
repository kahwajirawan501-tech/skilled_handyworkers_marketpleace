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

class GetUserSearchStatesLoadingStateStates extends HomeStates {}
class GetUserSearchSucssessfullStateStates extends HomeStates {

  GetUserSearchSucssessfullStateStates();
}
class GetUserSearchErrorStateStates extends HomeStates {
  final int stateCode;
  GetUserSearchErrorStateStates(this.stateCode);
}//OpenQuestion
class PostLoadStateStates extends HomeStates{}
class PostSucssessfullStateStates extends HomeStates{}
class PostErrorStateStates extends HomeStates{}
class PostLoadStateStatesNext extends HomeStates{}

class PostLoadStateStatesOpenQuestion extends HomeStates{}
class PostSucssessfullStateStatesOpenQuestion extends HomeStates{}
class PostErrorStateStatesOpenQuestion extends HomeStates{}
class PostLoadStateStatesNextOpenQuestion extends HomeStates{}