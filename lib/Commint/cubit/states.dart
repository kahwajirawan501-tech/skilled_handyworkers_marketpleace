abstract class CommitStates {}

class CommitStatesInitialStateStates extends CommitStates {}
class CommitLoadStateStates extends CommitStates {

}

class CommitSucssessfullStateStates extends CommitStates {

  CommitSucssessfullStateStates();
}
class CommitErrorStateStates extends CommitStates {
  final int statusCode;
  CommitErrorStateStates(this.statusCode);
}
class CommitStatesState extends CommitStates{
  final List<Map<String, dynamic>> comments;
  CommitStatesState(this.comments);

}