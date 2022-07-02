import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stream/domain/network/active_symbol_service.dart';
import 'package:flutter_stream/model/active_model.dart';

part 'active_symbol_state.dart';

class ActiveSymbolCubit extends Cubit<ActiveSymbolState> {
 
  ActiveSymbolCubit() : super(ActiveSymbolInitial());

  ActiveSymbolService activeSymbolService = ActiveSymbolService();

  StreamController<ActiveSymoblModel> activeSymbolCubitStream =
 
      StreamController<ActiveSymoblModel>.broadcast();

  initazlizedActiveSymbolSocket() {
 
    try {
 
      emit(ActiveSymbolLoading());
 
      activeSymbolService.recieveActiveSymbolModData();
 
      activeSymbolCubitStream = activeSymbolService.getActiveSymbolSubject;
 
      emit(ActiveSymbolLoaded(activeSymbolCubitStream.stream));
 
    } catch (e) {
 
      emit(ActiveSymbolError(errorMessage: e.toString()));
 
    }
 
  }

  disposeWebSocketConnection() {
    activeSymbolService.diposeWebSocketChannel();
  }
}
