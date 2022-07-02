import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stream/domain/network/crypto_socket.dart';
import 'package:flutter_stream/model/tick.dart';
import 'package:rxdart/rxdart.dart';
part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {

  BehaviorSubject<TickModel> tickStream = BehaviorSubject<TickModel>();

  CryptoSocketService cryptoSocketService = CryptoSocketService();

  String? newTickIDEvent;

  CryptoBloc() : super(CryptoInitial()) {

    on<CryptoEvent>((event, emit) {

      if (event is OpenCryptoSocketEvent) {

        try {

          emit(CryptoLoading());

          newTickIDEvent = null;

          if (newTickIDEvent == event.tickID) {
           
            tickStream = cryptoSocketService.getickSubject;
           
            emit(CryptoLoaded(tickModelStream: tickStream.stream));
           
            return;
          
          }

          newTickIDEvent = event.tickID;

          cryptoSocketService.diposeWebSocketChannel();

          cryptoSocketService.openCryptoSocketConnection(newTickIDEvent!);

          tickStream = cryptoSocketService.getickSubject;

          emit(CryptoLoaded(tickModelStream: tickStream.stream));

        } catch (e) {

          emit(CryptoError(e.toString()));

        }

      } else if (event is ResetCryptoSocketEvent) {

        emit(CryptoLoading());

        cryptoSocketService.diposeWebSocketChannel();

        emit(CryptoInitial());

      }

    });

  }


  disposeWebSocketConnection() {
    cryptoSocketService.diposeWebSocketChannel();
  }

}
