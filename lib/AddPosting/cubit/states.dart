abstract class AddPostStates {}

class AddPostStatesInitialStateStates extends AddPostStates {}

class AddPostLoadStateStates extends AddPostStates {

}
class AddPostSucssessfullStateStates extends AddPostStates {

  AddPostSucssessfullStateStates();
}
class AddPostErrorStateStates extends AddPostStates {
  final int statusCode;
  AddPostErrorStateStates(this.statusCode);
}
class AddPostStatesState extends AddPostStates{
  AddPostStatesState();

}


class AddOpenQuestionLoadStateStates extends AddPostStates {

}
class AddOpenQuestionSucssessfullStateStates extends AddPostStates {

}
class AddOpenQuestionErrorStateStates extends AddPostStates {
  final int statusCode;
  AddOpenQuestionErrorStateStates(this.statusCode);
}
class AddOpenQuestionStatesState extends AddPostStates{

}