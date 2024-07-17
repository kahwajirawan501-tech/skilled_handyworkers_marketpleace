abstract class SearchStates {}

class SearchStatesInitialStateStates extends SearchStates {}

class SearchPostLoadStateStates extends SearchStates {

}
class SearchPostSucssessfullStateStates extends SearchStates {

  SearchPostSucssessfullStateStates();
}
class SearchPostErrorStateStates extends SearchStates {
  final int statusCode;
  SearchPostErrorStateStates(this.statusCode);
}


class SearchPostOnlyLocationLoadStateStates extends SearchStates {

}
class SearchPostOnlyLocationSucssessfullStateStates extends SearchStates {

  SearchPostOnlyLocationSucssessfullStateStates();
}
class SearchPostOnlyLocationErrorStateStates extends SearchStates {
  final int statusCode;
  SearchPostOnlyLocationErrorStateStates(this.statusCode);
}


class SearchPostOnlyServiceLoadStateStates extends SearchStates {

}
class SearchPostOnlyServiceSucssessfullStateStates extends SearchStates {

  SearchPostOnlyServiceSucssessfullStateStates();
}
class SearchPostOnlyServiceErrorStateStates extends SearchStates {
  final int statusCode;
  SearchPostOnlyServiceErrorStateStates(this.statusCode);
}



class SearchPostLoadStateStatesNext extends SearchStates {

}
class SearchPostSucssessfullStateStatesNext extends SearchStates {

  SearchPostSucssessfullStateStatesNext();
}
class SearchPostErrorStateStatesNext extends SearchStates {
  final int statusCode;
  SearchPostErrorStateStatesNext(this.statusCode);
}


class SearchPostOnlyLocationLoadStateStatesNext extends SearchStates {

}
class SearchPostOnlyLocationSucssessfullStateStatesNext extends SearchStates {

  SearchPostOnlyLocationSucssessfullStateStatesNext();
}
class SearchPostOnlyLocationErrorStateStatesNext extends SearchStates {
  final int statusCode;
  SearchPostOnlyLocationErrorStateStatesNext(this.statusCode);
}


class SearchPostOnlyServiceLoadStateStatesNext extends SearchStates {

}
class SearchPostOnlyServiceSucssessfullStateStatesNext extends SearchStates {

  SearchPostOnlyServiceSucssessfullStateStatesNext();
}
class SearchPostOnlyServiceErrorStateStatesNext extends SearchStates {
  final int statusCode;
  SearchPostOnlyServiceErrorStateStatesNext(this.statusCode);
}


class DeletePostLoadStateStatesSearch extends SearchStates {

}
class  DeletePostSucssessfullStateStatesSearch extends SearchStates {

  DeletePostSucssessfullStateStatesSearch();
}
class  DeletePostErrorStateStatesSearch extends SearchStates {
  final int statusCode;
  DeletePostErrorStateStatesSearch(this.statusCode);
}