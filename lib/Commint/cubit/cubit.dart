import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class CommitCubit extends Cubit<CommitStates>{
  CommitCubit():super(CommitStatesInitialStateStates());
  static CommitCubit get(context)=>BlocProvider.of(context);

  final Map<String, dynamic> _comments =
    {
      'postId': 1,
      'postAuthor': {
        'id': 1,
        'name': 'اسم الكاتب',
        'gender': 'ذكر',
        'address': 'عنوان الكاتب',
        'profileImage': 'assets/images/Mask group.png', // مثال على مسار الصورة
      },
      'comments': [
        {
          'id': 1,
          'content': ' Hi nina',
          'time': '2024-06-27T15:30:00Z', // تاريخ التعليق بتنسيق ISO 8601
          'author': {
            'id': 2,
            'name': 'Taimaa',
            'gender': 'female',
            'address': 'Damascus',
            'profileImage': 'assets/images/Mask group.png', // مثال على مسار الصورة
          },
          'replies': [
            {
              'id': 1,
              'content': ' hi Taimaa ',
              'time': '2024-06-27T16:00:00Z', // تاريخ الرد بتنسيق ISO 8601
              'author': {
                'id': 3,
                'name': 'nina',
                'gender': 'female',
                'address': 'Damascus',
                'profileImage': 'assets/images/imagePerson.jpg', // مثال على مسار الصورة
              },
            },
            // يمكن إضافة ردود إضافية هنا حسب الحاجة
          ],
        },
        // يمكن إضافة تعليقات إضافية هنا حسب الحاجة
      ],
    };
    // يمكن إضافة منشورات إضافية هنا حسب الحاجة


 //CommitModel commitModel;
  void getCommitForPost(int idPost){
    emit(CommitLoadStateStates());
    print("CommitLoadStateStates");
    DioHelper.getData(
      url:'',
      token: '',
    ).then((value)
    {

      // commitModel=CommitModel.fromJson(value.data);
       emit(CommitSucssessfullStateStates());
    }
    ).catchError((error){
      int statusCode = error.response?.statusCode ?? -1;
      emit(CommitErrorStateStates(statusCode));
    });
  }














}