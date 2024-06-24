import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Save/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CubitFavorites extends Cubit<FavoritesStates>{
  CubitFavorites():super(FavoritesInitialState());

  static CubitFavorites get(context)=>BlocProvider.of(context);

  Map<int,bool>favorites={};
  void getPostData(){
    emit(LoadingGetPostDateState());
    print('LoadingGetPostDateState');
    DioHelper.getData(
      url:'',
      token:"",
    ).then((value)
    {
      print("successful get post");

     // postModel=PostModel.fromJson(value.data);

      // postModel!.data!.post.forEach((element) {
      //   favorites.addAll({
      //     element.id!:element.inFavorite!
      //   });
      // });
      emit(SuccessGetPostDateState());
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(ErrorGetPostDateState(statusCode));
      print("get post"+error);
      print(statusCode);
    });
  }

  void changeFavorites(int productId){
    favorites[productId]=!favorites[productId]!;
    emit(ChangeFavoritesDateState());//غير الضو قبل ما يدخل

    DioHelper.postData(
        url:'', data: {
      'product_id':productId,
    },token: '')
        .then((value){
      //changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      // if(!changeFavoritesModel!.status!){//اذا التوكين خطا
      //   favorites[productId]=!favorites[productId]!;
      //
      // }
      // else{
      //   getFavorites();
      // }
      emit(SuccessChangeFavoritesDateState());

    }).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      favorites[productId]=!favorites[productId]!;
      emit(ErrorChangeFavoritesDateState(statusCode));
    });

  }
  // Data From Post
  // FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(LoadingGetFavoritesDateState());
    print("LoadingGetFavoritesDateState");
    DioHelper.getData(
      url:'',
      token: '',
    ).then((value)
    {

      // favoritesModel=FavoritesModel.fromJson(value.data);
      // emit(SuccessGetFavoritesDateState());
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(ErrorGetFavoritesDateState(statusCode));
    });
  }


}