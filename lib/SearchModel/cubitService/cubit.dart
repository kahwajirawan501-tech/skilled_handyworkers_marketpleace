import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitService/states.dart';


class ServiceCubit extends Cubit<ServiceStates> {
  ServiceCubit() : super(ServiceStatesInitialStateStates());

  static ServiceCubit get(context) => BlocProvider.of(context);

  List<String> service = [
    "Accounting & Finance",
    "Animal Care",
    "Art, Media, Design",
    "Bar Staff",
    "Barista",
    "Chef & Cook",
    "Cleaning",
    "Construction & Trades",
    "Customer Service",
    "Driver & Delivery",
    "Education",
    "Engineering",
  ];

  List<String> filteredService = [];

  void searchService(String query) {
    if (query.isEmpty) {
      emit(ServiceStatesInitialStateStates());
    } else {
      filteredService = service
          .where((element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ServiceStatesSearchResultState(filteredService));
    }
  }
}
