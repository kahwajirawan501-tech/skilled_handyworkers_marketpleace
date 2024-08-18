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
    //   initializeNotifications();
    getUsersMessage();
  }

  static ChatCubit get(context) => BlocProvider.of(context);

//
  List<Map<String, dynamic>> messages = [];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late IO.Socket _socket;
 Map<String,bool>usersStatus={};
  void initializeSocket() {
    _socket = IO.io('http://192.168.43.142:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': id}, // إرسال معرف المستخدم عند الاتصال
    });

    _socket.connect();

    _socket.on('connect', (_) {
      print('Connected to socket server');
    });

    _socket.on('disconnect', (_) {
      print('Disconnected from socket server');
    });

    _socket.on('newMessage', (data) {
      messages.add(data);
      emit(AddMessageSucssessfullStateStates(messages));
      //    showNotification(data['message']);
    });
    _socket.on('newNotification', (data) {
      // إظهار الإشعار بناءً على البيانات المستلمة
      //  showNotification(data['message']);
    });
    _socket.on('messageEdited', (updatedMessage) {
      int index = messages.indexWhere((message) =>
      message['_id'] == updatedMessage['_id']);
      if (index != -1) {
        messages[index] = updatedMessage;
        emit(EditMessageSucssessfullStateStates(messages));
      }
    });

    _socket.on('messageDeleted', (deletedMessageId) {
      int index = messages.indexWhere((message) =>
      message['_id'] == deletedMessageId);
      if (index != -1) {
        messages.removeAt(index);
        emit(DeleteMessageSucssessfullStateStates(messages));
      }
    });

    _socket.on('userStatus', (data) {
      print("User status update received: $data");

      bool isOnline = data['isOnline'];
      String userId = data['userId'];

      emit(UserStatusUpdatedState(isOnline, userId));
    });


    _socket.on('chattedPersons', (data) {
      print("object");
      print(data);
      users = List<Map<String, dynamic>>.from(data);
      emit(GetUserMessageSucssessfullStateStates(users));
    });


    _socket.on('connect_error', (error) {
      print('Connection Error: $error');
    });

    _socket.on('error', (error) {
      print('Socket Error: $error');
    });
  }

  void sendMessage(String content, String receiverId) {
    emit(AddMessageLoadStateStates());
    final newMessage = {
      'sender_id': id,
      'receiver_id': receiverId,
      'message': content,

    };

    // إرسال الرسالة عبر WebSocket
    _socket.emit('sendMessage', newMessage);

    _socket.on('error', (error) {
      emit(AddMessageErrorStateStates());
      print('Socket Error: $error');
    });
  }

  void deleteMessage(int messageIndex) {
    final messageId = messages[messageIndex]['_id'];
    emit(DeleteMessageLoadStateStates());
    _socket.emit('deleteMessage', {'messageId': messageId});
  }

  void editMessage(int messageIndex, String content) {
    final messageId = messages[messageIndex]['_id'];
    emit(EditMessageLoadStateStates());
    messages[messageIndex]['message'] = content;
    final editPayload = {
      'messageId': messageId,
      'content': content,
    };

    _socket.emit('editMessage', editPayload);

    _socket.on('error', (error) {
      int statusCode = error['statusCode'] ?? -1;
      emit(EditMessageErrorStateStates(statusCode));
    });
  }

  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String message) async {
    var androidDetails = AndroidNotificationDetails(
      'channelId', // Channel ID
      'channelName', // Channel Name
      channelDescription: 'channelDescription',
      // Channel Description as a named argument
      importance: Importance.max,
      priority: Priority.high,
    );

    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'New Message', // Notification Title
      message, // Notification Body
      generalNotificationDetails,
    );
  }

  void getMessages(String receiverId) {
    emit(MessageLoadStateStates());
    print("MessageLoadStateStates");
    DioHelper.getData(
        url: '/chat/conversation?receiver_id=$receiverId', token: accessToken)
        .then((value) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
          value.data);
      // data.forEach((message) {
      // //  message['createdAt'] = _formatTime(message['createdAt']);
      // });
      messages = data;
      //
      print("MessageSucssessfullStateStates");
      emit(MessageSucssessfullStateStates(messages));
    }).catchError((error) {
      int statusCode = error.response?.statusCode ?? -1;
      emit(MessageErrorStateStates(statusCode));
      print("MessageErrorStateStates");
    });
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }

  List<Map<String, dynamic>>users = [];
  List<Map<String, dynamic>> filteredUsers = [];

  void searchUsers(String query) {
    if (query.isEmpty) {
      emit(GetUserMessageInitialStateStates());
    } else {
      filteredUsers = users
          .where((element) =>
          element['fullName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(GetUserMessageSearchResultState(filteredUsers));
    }
  }

  getUsersMessage() {
    emit(GetUserMessageLoadStateStates());
    print("GetUserMessageLoadStateStates");
    _socket.emit('getChattedPersons', {'userId': id});
    print("users");

    print(users);
    _socket.on('error', (error) {
      int statusCode = error['statusCode'] ?? -1;
      emit(GetUserMessageErrorStateStates(statusCode));
    });
  }


  openConversation(String conversationId) {
    // إرسال الطلب عبر WebSocket
    _socket.emit(
        'openConversation', {'userId': id, 'conversationId': conversationId});
  }//leaveConversation
  leaveConversation(String conversationId) {
    // إرسال الطلب عبر WebSocket
    _socket.emit(
        'leaveConversation', {'userId': id, 'conversationId': conversationId});
  }
}