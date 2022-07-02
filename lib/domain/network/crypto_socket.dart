import 'dart:convert';

import 'package:flutter_stream/const/constants.dart';
import 'package:flutter_stream/model/tick.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/status.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoSocketService {

  WebSocketChannel socketChannel = WebSocketChannel.connect(
   
    Uri.parse(WEB_SOCKET_URL),
  
  );

  BehaviorSubject<TickModel> tickSubject =
     
      BehaviorSubject<TickModel>(sync: true);

  BehaviorSubject<TickModel> get getickSubject => tickSubject;

  bool isCloseCase = false;

  openCryptoSocketConnection(String tickID) {
    if (isCloseCase == true) {
      socketChannel = WebSocketChannel.connect(
        Uri.parse(WEB_SOCKET_URL),
      );
      socketChannel.sink.add(jsonEncode({"ticks": tickID, "subscribe": 1}));
      isCloseCase = false;
      tickSubject = BehaviorSubject<TickModel>(sync: true);
    } else if (isCloseCase == false) {
      isCloseCase = true;
      socketChannel.sink.add(jsonEncode({"ticks": tickID, "subscribe": 1}));
      tickSubject = BehaviorSubject<TickModel>(sync: true);
    }
    socketChannel.stream
        .map<TickModel>(
      (event) => TickModel.fromJson(
        jsonDecode(event),
      ),
    ).listen((event) {
      tickSubject.sink.add(event);
    });
  }

  diposeWebSocketChannel() {
    socketChannel.sink.close(normalClosure);
    isCloseCase = true;
  }
}
