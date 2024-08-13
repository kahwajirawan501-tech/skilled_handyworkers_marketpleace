import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Dashboard/cubit/state.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';


class DashBoardCubit extends Cubit<DashBoardStates> {
  DashBoardCubit() : super(LocationStatesInitialStateStates());

  static DashBoardCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> location = [];


  List<Map<String, dynamic>> filteredLocation = [];

  void searchLocation(String query) {
    if (query.isEmpty) {
      emit(LocationStatesInitialStateStates());
    } else {
      filteredLocation = location
          .where((element) => element['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(LocationStatesSearchResultState(filteredLocation));
    }
  }

  void getLocation() {
    emit(LocationLoadingStatesStateStates());
    print("LocationLoadingStatesStateStates");
    DioHelper.getData(
      url: 'regions/governorate',
    ).then((value) {
      location=List<Map<String, dynamic>>.from(value.data);
      emit(LocationSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(LocationErrorStateStates(statusCode));
    });
  }
  void deleteLocation(String regin) {
    print(regin);
    emit(DeletedLocationLoadStateStates());
    print("DeletedLocationLoadStateStates");
    DioHelper.deletePost(
      url: '/regions/$regin',
      token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU2YWI2NjBlN2FjNGU0NjhjNDI1ZDA5OSIsImZ1bGxOYW1lIjoiYWRtaW4gYWRtaW4iLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsImlhdCI6MTcyMzU1MzUyMSwiZXhwIjoxNzIzODEyNzIxfQ.mKutgbYx7DhIuvQ2FOKzLz64WjivoeWIBzZ05dV9EBg"
    ).then((value) {
     emit(DeletedLocationSucssessfullStateStates());
     print("DeletedLocationSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(DeletedLocationErrorStateStates(statusCode));
    });
  }
  void addLocation(String regin) {
    print(regin);
    emit(ADDLocationLoadStateStates());
    print("DeletedLocationLoadStateStates");
    DioHelper.postData(
        url: '/regions',
        data: {
          "name":regin ,
          "type": "محافظة"
        },
        token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU2YWI2NjBlN2FjNGU0NjhjNDI1ZDA5OSIsImZ1bGxOYW1lIjoiYWRtaW4gYWRtaW4iLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsImlhdCI6MTcyMzU1MzUyMSwiZXhwIjoxNzIzODEyNzIxfQ.mKutgbYx7DhIuvQ2FOKzLz64WjivoeWIBzZ05dV9EBg"
    ).then((value) {
      emit(ADDLocationSucssessfullStateStates());
      print("ADDLocationSucssessfullStateStates");
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(ADDLocationErrorStateStates(statusCode));
    });
  }
}
