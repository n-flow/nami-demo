import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:smart_attend/app/data/network/models/response/base_model.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class Socket {
  late io.Socket socket;

  final isConnected = false.obs;

  var eventCallBack = <String, Function(BaseModel)>{};

  Socket() {
    Log.i('Init');
    connectSocket();
  }

  void setCallBack(String screen, Function(BaseModel) event) {
    eventCallBack[screen] = event;
  }

  void removeCallBack(String screen) {
    eventCallBack.remove(screen);
  }

  void connectSocket() {
    socket = io.io('http://192.168.1.6:8888', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
    });
    socket.connect();

    socket.on('connection', (_) {
      Log.i('connected');
      isConnected.value = true;
    });

    socket.on('on_event', (data) {
      hideLoading();
      Log.i('on_event_Received: $data');
      eventReceived(data);
    });

    socket.on('disconnect', (_) {
      hideLoading();
      Log.i('disconnected');
      isConnected.value = false;
    });

    socket.on('on_error', (data) {
      hideLoading();
      Log.i('on_error');
      Log.i('on_error  $data');
    });
  }

  void emmitEvent(event, data) {
    var baseModel = BaseModel(eventName: event, eventData: data);
    Log.i(
        'connected:  ${socket.connected}  event:  $event  data:  ${jsonEncode(data)}  baseData:  ${baseModel.toJson().removeNull()}');
    if (!socket.connected) {
      socket.connect();
    }
    socket.emit("on_event", baseModel.toJson().removeNull());
  }

  void eventReceived(dynamic data) {
    var baseModel = BaseModel.fromJson(data);
    eventCallBack.forEach((key, value) {
      value.call(baseModel);
    });
  }
}
