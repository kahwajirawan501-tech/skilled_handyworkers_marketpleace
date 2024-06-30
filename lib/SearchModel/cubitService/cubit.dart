import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitService/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';


class ServiceCubit extends Cubit<ServiceStates> {
  ServiceCubit() : super(ServiceStatesInitialStateStates());

  static ServiceCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>>service = [

  ];

  List<Map<String, dynamic>> filteredService = [];

  void searchService(String query) {
    if (query.isEmpty) {
      emit(ServiceStatesInitialStateStates());
    } else {
      filteredService = service
          .where((element) => element['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ServiceStatesSearchResultState(filteredService));
    }
  }

  void getService() {
    emit(ServiceLoadingStateStates());
    print("ServiceLoadingStateStates");
    DioHelper.getData(
      url: 'skills',
    ).then((value) {
      service=List<Map<String, dynamic>>.from(value.data);
      emit(ServiceSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(ServiceErrorStateStates(statusCode));
    });
  }
}
