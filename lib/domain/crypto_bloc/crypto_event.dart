part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

class OpenCryptoSocketEvent extends CryptoEvent {
  final String tickID;

  const OpenCryptoSocketEvent(this.tickID);

  @override
  List<Object> get props => [tickID];
}

class ResetCryptoSocketEvent extends CryptoEvent {
  @override
  List<Object> get props => [];
}
