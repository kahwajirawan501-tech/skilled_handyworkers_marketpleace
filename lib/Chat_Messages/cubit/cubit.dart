import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skilled_handyworkers_marketpleace/main.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:skilled_handyworkers_marketpleace/Chat_Messages/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/network/remote/dio_helper.dart';

class ChatCubit extends Cubit<MessageStates> {
  ChatCubit() : super(MessageStatesInitialStateStates()) {
    initializeSocket();
  }

  static ChatCubit get(context) => BlocProvider.of(context);
//
  List<Map<String, dynamic>> messages = [

  ];
  late IO.Socket _socket;
 late bool online=false;
  void initializeSocket() {
    _socket = IO.io('http://192.168.43.142:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();

    _socket.on('connect', (_) {
      print('Connected to socket server');
      online=true;
    });

    _socket.on('disconnect', (_) {
      print('Disconnected from socket server');
      online=false;
    });

    _socket.on('newMessage', (data) {


       messages.add(data);
      //showNotification("New Message", data['message']);
      emit(AddMessageSucssessfullStateStates(messages));
     // emit(RecMessageSucssessfullStateStates(messages));
    });

    _socket.on('messageEdited', (updatedMessage) {
      int index = messages.indexWhere((message) => message['_id'] == updatedMessage['_id']);
      if (index != -1) {
        messages[index] = updatedMessage;
        emit(EditMessageSucssessfullStateStates(messages));
      }
    });

    _socket.on('messageDeleted', (deletedMessageId) {
      int index = messages.indexWhere((message) => message['_id'] == deletedMessageId);
      if (index != -1) {
        messages.removeAt(index);
        emit(DeleteMessageSucssessfullStateStates(messages));
      }
    });


    _socket.on('connect_error', (error) {
      print('Connection Error: $error');
      online=false;
    });

    _socket.on('error', (error) {

      print('Socket Error: $error');
    });
  }
  void sendMessage(String content, String receiverId) {
    emit(AddMessageLoadStateStates());
    final newMessage = {
      '_id':"",
      'sender_id':id,
      'receiver_id': receiverId,
      'message': content,
      'createdAt':""
    };
    DioHelper.postData(url: '/chat/send', data: {
      'receiver_id': receiverId,
      'message': content,
    },token: accessToken).then((value) {
      if(value.data!=null){

        newMessage['_id']=value.data['_id'];
        newMessage['createdAt']=value.data['createdAt'];

      }
      // إرسال الرسالة عبر WebSocket
      _socket.emit('sendMessage', newMessage);



      print("Message sent successfully via API");
    }).catchError((error) {
      print("Failed to send message via API: ${error.toString()}");
    });


  }
  void deleteMessage(int messageIndex) {
    final messageId = messages[messageIndex]['_id'];
    emit(DeleteMessageLoadStateStates());
    DioHelper.deletePost(url: '/chat/$messageId',token: accessToken).then((_) {
      _socket.emit('deleteMessage', {'messageId': messageId});

      //    messages.removeAt(messageIndex);

      //
      // _socket.on('messageDeleted', (deletedMessageId) {
      //   if (deletedMessageId == messageId) {
      //     messages.removeAt(messageIndex);
      //     emit(DeleteMessageSucssessfullStateStates(messages));
      //   }
      // });
      //
      // _socket.on('error', (error) {
      //   int statusCode = error['statusCode'] ?? -1;
      //   emit(DeleteMessageErrorStateStates(statusCode));
      // });
      //  emit(DeleteMessageSucssessfullStateStates(messages));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(DeleteMessageErrorStateStates(statusCode));
      print(error.toString());
      print("DeleteMessageErrorStateStates");
    });
  }
  void editMessage(int messageIndex, String content) {
    final messageId = messages[messageIndex]['_id'];
    emit(EditMessageLoadStateStates());
    DioHelper.putData(url: '/chat/$messageId', data: {
      'message': content,

    },token: accessToken).then((_) {
      messages[messageIndex]['message'] = content;
      final editPayload = {
        'messageId': messageId,
        'content': content,
      };

      _socket.emit('editMessage', editPayload);

      // _socket.on('messageEdited', (updatedMessage) {
      //   if (updatedMessage['_id'] == messageId) {
      //     messages[messageIndex]['message'] = content;
      //   //  emit(EditMessageSucssessfullStateStates(messages));
      //   }
      // });
      //
      // _socket.on('error', (error) {
      //   int statusCode = error['statusCode'] ?? -1;
      //   //emit(EditMessageErrorStateStates(statusCode));
      // });
     // emit(EditMessageSucssessfullStateStates(messages));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
      emit(EditMessageErrorStateStates(statusCode));
    });
  }






  void getMessages(String receiverId) {
    emit(MessageLoadStateStates());
    print("MessageLoadStateStates");
    DioHelper.getData(url: '/chat/conversation?receiver_id=$receiverId',token: accessToken).then((value) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(value.data);
      // data.forEach((message) {
      // //  message['createdAt'] = _formatTime(message['createdAt']);
      // });
      messages = data;
      print(value.data);
      print("MessageSucssessfullStateStates");
      emit(MessageSucssessfullStateStates(messages));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(MessageErrorStateStates(statusCode));
      print("MessageErrorStateStates");

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

  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'unique_channel_id',
      'Message Notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics
       );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }




  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }




  List<Map<String, dynamic>>users = [

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
    DioHelper.getData2(
      url:'/chat/chatted-persons',
    token: accessToken
    ).then((value) {
      print(value.data);

      users=List<Map<String, dynamic>>.from(value.data);
      emit(GetUserMessageSucssessfullStateStates());
      print("GetUserMessageSucssessfullStateStates");
    }).catchError((error) {
       int statusCode = error.response?.statusCode ?? -1;
      print(error.toString());
     emit(GetUserMessageErrorStateStates(statusCode));

      print("GetUserMessageErrorStateStates");

    });
  }
}
