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



class DeleteCommitLoadStateStates extends CommitStates {

}
class DeleteCommitSucssessfullStateStates extends CommitStates {

  DeleteCommitSucssessfullStateStates();
}
class DeleteCommitErrorStateStates extends CommitStates {
  final int statusCode;
  DeleteCommitErrorStateStates(this.statusCode);
}

class EditCommitLoadStateStates extends CommitStates {

}
class EditCommitSucssessfullStateStates extends CommitStates {

}
class EditCommitErrorStateStates extends CommitStates {
  final int statusCode;
  EditCommitErrorStateStates(this.statusCode);
}

class AddCommitLoadStateStates extends CommitStates {

}
class AddCommitSucssessfullStateStates extends CommitStates {

}
class AddCommitErrorStateStates extends CommitStates {
  final int statusCode;
  AddCommitErrorStateStates(this.statusCode);
}


class CommitStatesState extends CommitStates{
  final List<Map<String, dynamic>> comments;
  CommitStatesState(this.comments);

}




