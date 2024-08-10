abstract class MessageStates {}

class MessageStatesInitialStateStates extends MessageStates {}

class MessageLoadStateStates extends MessageStates {

}
class MessageSucssessfullStateStates extends MessageStates {
  final List<Map<String, dynamic>> message;

  MessageSucssessfullStateStates(this.message);
}
class MessageErrorStateStates extends MessageStates {
  final int statusCode;
  MessageErrorStateStates(this.statusCode);
}

class DeleteMessageLoadStateStates extends MessageStates {

}
class DeleteMessageSucssessfullStateStates extends MessageStates {
  final List<Map<String, dynamic>> message;

  DeleteMessageSucssessfullStateStates(this.message);
}
class DeleteMessageErrorStateStates extends MessageStates {
  final int statusCode;
  DeleteMessageErrorStateStates(this.statusCode);
}

class EditMessageLoadStateStates extends MessageStates {

}
class EditMessageSucssessfullStateStates extends MessageStates {
  final List<Map<String, dynamic>> message;

  EditMessageSucssessfullStateStates(this.message);
}
class EditMessageErrorStateStates extends MessageStates {
  final int statusCode;
  EditMessageErrorStateStates(this.statusCode);
}

class AddMessageLoadStateStates extends MessageStates {

}
class AddMessageSucssessfullStateStates extends MessageStates {
  final List<Map<String, dynamic>> message;

  AddMessageSucssessfullStateStates(this.message);

}
class AddMessageErrorStateStates extends MessageStates {
  //final int statusCode;
  AddMessageErrorStateStates();
}


class MessageStatesState extends MessageStates{
  final List<Map<String, dynamic>> message;
  MessageStatesState(this.message);

}


class RecMessageLoadStateStates extends MessageStates {

}
class RecMessageSucssessfullStateStates extends MessageStates {
  final List<Map<String, dynamic>> message;

  RecMessageSucssessfullStateStates(this.message);

}
class RecMessageErrorStateStates extends MessageStates {
  final int statusCode;
  RecMessageErrorStateStates(this.statusCode);
}

class GetUserMessageInitialStateStates extends MessageStates {

}
class GetUserMessageSearchResultState extends MessageStates {
  final List<Map<String, dynamic>> searchResult;

  GetUserMessageSearchResultState(this.searchResult);
}

class GetUserMessageLoadStateStates extends MessageStates {

}
class GetUserMessageSucssessfullStateStates extends MessageStates {

  GetUserMessageSucssessfullStateStates();

}
class GetUserMessageErrorStateStates extends MessageStates {
  final int statusCode;
  GetUserMessageErrorStateStates(this.statusCode);
}

class UserStatusUpdatedState extends MessageStates{
  final bool online;
  final String id;

  UserStatusUpdatedState(this.online, this.id);

}