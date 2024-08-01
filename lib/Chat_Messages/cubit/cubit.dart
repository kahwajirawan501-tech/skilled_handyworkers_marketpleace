import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class ChatCubit extends Cubit<MessageStates> {
  ChatCubit() : super(MessageStatesInitialStateStates()) {
    initializeSocket();
  }

  static ChatCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> messages = [
    { 'id':"889",
      'userId': id,
      'text': "كيف حالك ",
      'createdAt': "8:08",
    },
    {
      'id':"889",
      'userId': "88h",
      'text': "الحمد لله انا بخير ",
      'createdAt': "9:08",
    },
  ];
  late IO.Socket _socket;

  void initializeSocket() {
    _socket = IO.io('http://your_backend_url', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();
    _socket.on('connect', (_) {
      print('Connected to socket server');
    });
    _socket.on('disconnect', (_) {
      print('Disconnected from socket server');
    });
    _socket.on('message', (data) {
      messages.add(data);
      emit(RecMessageSucssessfullStateStates(messages));
    });
  }

  void getMessages(String receiverId) {
    emit(MessageLoadStateStates());
    DioHelper.getData(url: 'your_api_endpoint?receiverId=$receiverId').then((value) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);
      data.forEach((message) {
        message['createdAt'] = _formatTime(message['createdAt']);
      });
      messages = data;
      emit(MessageSucssessfullStateStates(messages));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(MessageErrorStateStates(statusCode));
    });
  }

  void sendMessage(String content, String receiverId) {
    emit(AddMessageLoadStateStates());
    final newMessage = {
      'userId': id,
      'receiverId': receiverId,
      'text': content,
      'createdAt': DateTime.now().toIso8601String(),
    };

    // إضافة الرسالة إلى القائمة محلياً حتى قبل إرسالها إلى الـ Backend
    messages.add(newMessage);

    // إرسال الرسالة عبر الـ WebSocket
    _socket.emit('message', newMessage);

    // مراقبة تأكيد الرسالة من الـ WebSocket
    _socket.on('messageSent', (data) {
      if (data['status'] == 'success') {
        // الرسالة أرسلت بنجاح
        emit(AddMessageSucssessfullStateStates(messages));
      } else {
        // حدث خطأ أثناء إرسال الرسالة
       // messages.remove(newMessage); // إزالة الرسالة من القائمة المحلية
        emit(AddMessageErrorStateStates(data['error'])); // إظهار رسالة الخطأ
      }
    });
    // التعامل مع الأخطاء الخاصة بالـ WebSocket
    _socket.on('error', (error) {
      // حدث خطأ في الاتصال
      //messages.remove(newMessage); // إزالة الرسالة من القائمة المحلية
      emit(AddMessageErrorStateStates(error)); // إظهار رسالة الخطأ
    });
  }


  void deleteMessage(int messageIndex) {
    final messageId = messages[messageIndex]['id'];
    emit(DeleteMessageLoadStateStates());
    DioHelper.deletePost(url: 'your_api_endpoint/$messageId').then((_) {
      messages.removeAt(messageIndex);
      emit(DeleteMessageSucssessfullStateStates(messages));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(DeleteMessageErrorStateStates(statusCode));
    });
  }

  void editMessage(int messageIndex, String content) {
    final messageId = messages[messageIndex]['id'];
    emit(EditMessageLoadStateStates());
    DioHelper.putData(url: 'your_api_endpoint/$messageId', data: {
      'text': content,
    }).then((_) {
      messages[messageIndex]['text'] = content;
      emit(EditMessageSucssessfullStateStates(messages));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(EditMessageErrorStateStates(statusCode));
    });
  }

  String _formatTime(String postTimeStr) {
    DateTime postTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ", 'en_US').parse(postTimeStr);
    DateTime now = DateTime.now();
    Duration delta = now.difference(postTime);

    if (delta < Duration(minutes: 1)) {
      return "الآن";
    } else if (delta < Duration(hours: 1)) {
      return "منذ ${delta.inMinutes} دقائق";
    } else if (delta < Duration(days: 1)) {
      return "منذ ${delta.inHours} ساعات";
    } else if (delta < Duration(days: 2)) {
      return "أمس الساعة ${DateFormat('HH:mm', 'ar').format(postTime)}";
    } else {
      return DateFormat('dd MMM yyyy الساعة HH:mm', 'ar').format(postTime);
    }
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }




  List<Map<String, dynamic>>users = [
    {
      'id': "",
      'fullName': "Rawan",
      'profileImage': imageNetwork,
      'text': "كيف حالك ",
      'createdAt':"8:00",
    },
    {
      'id': "",
      'fullName': "Roaa",
      'profileImage': imageNetwork,
      'text': "لحمد لله  ",
      'createdAt':"9:00",
    }
  ];

  List<Map<String, dynamic>> filteredUsers = [];

  void searchUsers(String query) {
    if (query.isEmpty) {
      emit(GetUserMessageInitialStateStates());
    } else {
      filteredUsers = users
          .where((element) => element['fullName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(GetUserMessageSearchResultState(filteredUsers));
    }
  }

  void getUsersMessage() {
    emit(GetUserMessageLoadStateStates());
    print("GetUserMessageLoadStateStates");
    DioHelper.getData(
      url: '',
    ).then((value) {
      users=List<Map<String, dynamic>>.from(value.data);
      emit(GetUserMessageSucssessfullStateStates());
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(GetUserMessageErrorStateStates(statusCode));
    });
  }
}
