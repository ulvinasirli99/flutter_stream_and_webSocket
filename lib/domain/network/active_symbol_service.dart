import 'dart:convert';

import 'package:flutter_stream/const/constants.dart';
import 'package:flutter_stream/model/active_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/status.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActiveSymbolService {
 
  WebSocketChannel socketChannel = WebSocketChannel.connect(
 
    Uri.parse(WEB_SOCKET_URL),
 
  );

  BehaviorSubject<ActiveSymoblModel> activeSymbolSubject =
    
      BehaviorSubject<ActiveSymoblModel>();

  BehaviorSubject<ActiveSymoblModel> get getActiveSymbolSubject =>
    
      activeSymbolSubject;

  recieveActiveSymbolModData() {
    
    socketChannel.sink.add(
    
      jsonEncode(
    
        {"active_symbols": "brief", "product_type": "basic"},
    
      ),
    
    );

    socketChannel.stream
    
        .map<ActiveSymoblModel>(
    
      (event) => ActiveSymoblModel.fromJson(
    
        jsonDecode(event),
    
      ),
    ).listen((event) {
     
      activeSymbolSubject.sink.add(event);
    
    }).onDone(() {
     
      print("ActiveSymbol Data is Done.....");

      socketChannel.sink.close(normalClosure);
  
    });
  
  }

  diposeWebSocketChannel() {
    socketChannel.sink.close(normalClosure);
  }
}
