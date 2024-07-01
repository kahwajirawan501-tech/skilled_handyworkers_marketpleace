abstract class AddPostStates {}

class AddPostStatesInitialStateStates extends AddPostStates {}

class AddPostLoadStateStates extends AddPostStates {

}
class AddPostSucssessfullStateStates extends AddPostStates {

}
class AddPostErrorStateStates extends AddPostStates {
  final int statusCode;
  final String message;

  AddPostErrorStateStates(this.statusCode, this.message);
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
  final String message;

  AddOpenQuestionErrorStateStates(this.statusCode, this.message);
}
class AddOpenQuestionStatesState extends AddPostStates{

}


class PostFileLoadStateStates extends AddPostStates {

}
class PostFileSucssessfullStateStates extends AddPostStates {

}
class PostFileErrorStateStates extends AddPostStates {
  final int statusCode;
  final String message;
  PostFileErrorStateStates(this.statusCode, this.message);
}