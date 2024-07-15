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

class GetInformationPostLoadStateStates extends EditPostStates {

}
class GetInformationPostSucssessfullStateStates extends EditPostStates {

  GetInformationPostSucssessfullStateStates();
}
class GetInformationPostErrorStateStates extends EditPostStates {
  final int statusCode;
  GetInformationPostErrorStateStates(this.statusCode);
}

class PostFileLoadStateStates extends EditPostStates {

}
class PostFileSucssessfullStateStates extends EditPostStates {

}
class PostFileErrorStateStates extends EditPostStates {
  final int statusCode;
  final String message;
  PostFileErrorStateStates(this.statusCode, this.message);
}