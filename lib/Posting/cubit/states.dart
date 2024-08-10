abstract class YourPostStates {}

class YourPostStatesInitialStateStates extends YourPostStates {}

class YourPostPostLoadStateStates extends YourPostStates {

}
class YourPostPostSucssessfullStateStates extends YourPostStates {

  YourPostPostSucssessfullStateStates();
}
class YourPostPostErrorStateStates extends YourPostStates {

  YourPostPostErrorStateStates();
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

  CustomerPostPostErrorStateStates();
}

class YourOpenQuestionPostLoadStateStates extends YourPostStates {

}
class YourOpenQuestionPostSucssessfullStateStates extends YourPostStates {

  YourOpenQuestionPostSucssessfullStateStates();
}
class YourOpenQuestionPostErrorStateStates extends YourPostStates {

  YourOpenQuestionPostErrorStateStates();
}

class CustomerOpenQuestionPostLoadStateStates extends YourPostStates {

}
class CustomerOpenQuestionPostSucssessfullStateStates extends YourPostStates {

  CustomerOpenQuestionPostSucssessfullStateStates();
}
class CustomerOpenQuestionPostErrorStateStates extends YourPostStates {
 // final int statusCode;
  CustomerOpenQuestionPostErrorStateStates();
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
  GetInformationErrorStateStates();
}
/////////////////////////////////////////////////////////////
class SuccessChangeFavoritesDateState extends YourPostStates{


}
class ErrorChangeFavoritesDateState extends YourPostStates{
  final int statusCode;

  ErrorChangeFavoritesDateState(this.statusCode);
}
class ChangeFavoritesDateState extends YourPostStates{}


class SuccessGetFavoritesDateState extends YourPostStates{}
class LoadingGetFavoritesDateState extends YourPostStates{}
class ErrorGetFavoritesDateState extends YourPostStates{


  ErrorGetFavoritesDateState();
}


class SuccessGetPostDateState extends YourPostStates{}
class LoadingGetPostDateState extends YourPostStates{}
class ErrorGetPostDateState extends YourPostStates{
  final int statusCode;

  ErrorGetPostDateState(this.statusCode);
}


class SaveSuccessFavoritesDateState extends YourPostStates{}
class SaveLoadingFavoritesDateState extends YourPostStates{}
class SaveErrorFavoritesDateState extends YourPostStates{
  final int statusCode;

  SaveErrorFavoritesDateState(this.statusCode);
}

class UnSaveSuccessFavoritesDateState extends YourPostStates{}
class UnSaveLoadingFavoritesDateState extends YourPostStates{}
class UnSaveErrorFavoritesDateState extends YourPostStates{
  final int statusCode;

  UnSaveErrorFavoritesDateState(this.statusCode);
}