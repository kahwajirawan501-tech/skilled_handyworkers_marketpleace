abstract class SearchStates {}

class SearchStatesInitialStateStates extends SearchStates {}

class SearchPostLoadStateStates extends SearchStates {

}
class SearchPostSucssessfullStateStates extends SearchStates {

  SearchPostSucssessfullStateStates();
}
class SearchPostErrorStateStates extends SearchStates {
  final int statusCode;
  SearchPostErrorStateStates(this.statusCode);
}


class SearchPostOnlyLocationLoadStateStates extends SearchStates {

}
class SearchPostOnlyLocationSucssessfullStateStates extends SearchStates {

  SearchPostOnlyLocationSucssessfullStateStates();
}
class SearchPostOnlyLocationErrorStateStates extends SearchStates {
  final int statusCode;
  SearchPostOnlyLocationErrorStateStates(this.statusCode);
}


class SearchPostOnlyServiceLoadStateStates extends SearchStates {

}
class SearchPostOnlyServiceSucssessfullStateStates extends SearchStates {

  SearchPostOnlyServiceSucssessfullStateStates();
}
class SearchPostOnlyServiceErrorStateStates extends SearchStates {
  final int statusCode;
  SearchPostOnlyServiceErrorStateStates(this.statusCode);
}