import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitLocation/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';


class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(LocationStatesInitialStateStates());

  static LocationCubit get(context) => BlocProvider.of(context);

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


}
