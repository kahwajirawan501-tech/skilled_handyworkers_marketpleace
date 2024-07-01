abstract class YourPostStates {}

class YourPostStatesInitialStateStates extends YourPostStates {}

class YourPostPostLoadStateStates extends YourPostStates {

}
class YourPostPostSucssessfullStateStates extends YourPostStates {

  YourPostPostSucssessfullStateStates();
}
class YourPostPostErrorStateStates extends YourPostStates {
  final int statusCode;
  YourPostPostErrorStateStates(this.statusCode);
}

class DeletePostLoadStateStates extends YourPostStates {

}
class  DeletePostSucssessfullStateStates extends YourPostStates {

  DeletePostSucssessfullStateStates();
}
class  DeletePostErrorStateStates extends YourPostStates {
  final int statusCode;
  DeletePostErrorStateStates(this.statusCode);
}



class YourOpenQuestionPostLoadStateStates extends YourPostStates {

}
class YourOpenQuestionPostSucssessfullStateStates extends YourPostStates {

  YourOpenQuestionPostSucssessfullStateStates();
}
class YourOpenQuestionPostErrorStateStates extends YourPostStates {
  final int statusCode;
  YourOpenQuestionPostErrorStateStates(this.statusCode);
}
