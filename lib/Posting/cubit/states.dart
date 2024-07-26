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


class CustomerPostPostLoadStateStates extends YourPostStates {

}
class CustomerPostPostSucssessfullStateStates extends YourPostStates {

  CustomerPostPostSucssessfullStateStates();
}
class CustomerPostPostErrorStateStates extends YourPostStates {
  final int statusCode;
  CustomerPostPostErrorStateStates(this.statusCode);
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

class CustomerOpenQuestionPostLoadStateStates extends YourPostStates {

}
class CustomerOpenQuestionPostSucssessfullStateStates extends YourPostStates {

  CustomerOpenQuestionPostSucssessfullStateStates();
}
class CustomerOpenQuestionPostErrorStateStates extends YourPostStates {
  final int statusCode;
  CustomerOpenQuestionPostErrorStateStates(this.statusCode);
}



class GetInformationPostLoadStateStates extends YourPostStates {

}
class GetInformationPostSucssessfullStateStates extends YourPostStates {

  GetInformationPostSucssessfullStateStates();
}
class GetInformationPostErrorStateStates extends YourPostStates {
  final int statusCode;
  GetInformationPostErrorStateStates(this.statusCode);
}
class GetInformationStatesLoadingStateStates extends YourPostStates {}
class GetInformationSucssessfullStateStates extends YourPostStates {

  GetInformationSucssessfullStateStates();
}
class GetInformationErrorStateStates extends YourPostStates {
  final int stateCode;
  GetInformationErrorStateStates(this.stateCode);
}