import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/cubitLocation/states.dart';


class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(LocationStatesInitialStateStates());

  static LocationCubit get(context) => BlocProvider.of(context);

  List<String> location = [
    "Damascus",
    "Rif Dimashq",
    "Aleppo",
    "Homs",
    "Hama",
    "Latakia",
    "Tartus",
    "Idlib",
    "Deir ez-Zor",
    "Al-Hasakah",
    "Raqqa",
    "As-Suwayda",
    "Daraa",
    "Quneitra"
  ];


  List<String> filteredLocation = [];

  void searchLocation(String query) {
    if (query.isEmpty) {
      emit(LocationStatesInitialStateStates());
    } else {
      filteredLocation = location
          .where((element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(LocationStatesSearchResultState(filteredLocation));
    }
  }
}
