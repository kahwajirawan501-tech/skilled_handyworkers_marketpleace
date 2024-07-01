abstract class EditPostStates {}

class EditPostStatesInitialStateStates extends EditPostStates {}

class EditPostPostLoadStateStates extends EditPostStates {

}
class EditPostPostSucssessfullStateStates extends EditPostStates {

  EditPostPostSucssessfullStateStates();
}
class EditPostPostErrorStateStates extends EditPostStates {
  final int statusCode;
  EditPostPostErrorStateStates(this.statusCode);
}

class EditOpenQuestionPostLoadStateStates extends EditPostStates {

}
class EditOpenQuestionPostSucssessfullStateStates extends EditPostStates {

  EditOpenQuestionPostSucssessfullStateStates();
}
class EditOpenQuestionPostErrorStateStates extends EditPostStates {
  final int statusCode;
  EditOpenQuestionPostErrorStateStates(this.statusCode);
}