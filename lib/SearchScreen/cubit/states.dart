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


class SearchOpenQuestionLoadStateStates extends SearchStates {

}
class SearchOpenQuestionSucssessfullStateStates extends SearchStates {

  SearchOpenQuestionSucssessfullStateStates();
}
class SearchOpenQuestionErrorStateStates extends SearchStates {
  final int statusCode;
  SearchOpenQuestionErrorStateStates(this.statusCode);
}