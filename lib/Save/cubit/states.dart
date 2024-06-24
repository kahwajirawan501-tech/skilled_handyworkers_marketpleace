abstract class FavoritesStates{}

class FavoritesInitialState extends FavoritesStates{}
class SuccessChangeFavoritesDateState extends FavoritesStates{


}
class ErrorChangeFavoritesDateState extends FavoritesStates{
  final int statusCode;

  ErrorChangeFavoritesDateState(this.statusCode);
}
class ChangeFavoritesDateState extends FavoritesStates{}


class SuccessGetFavoritesDateState extends FavoritesStates{}
class LoadingGetFavoritesDateState extends FavoritesStates{}
class ErrorGetFavoritesDateState extends FavoritesStates{
  final int statusCode;

  ErrorGetFavoritesDateState(this.statusCode);
}


class SuccessGetPostDateState extends FavoritesStates{}
class LoadingGetPostDateState extends FavoritesStates{}
class ErrorGetPostDateState extends FavoritesStates{
  final int statusCode;

  ErrorGetPostDateState(this.statusCode);
}