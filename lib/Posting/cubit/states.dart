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

