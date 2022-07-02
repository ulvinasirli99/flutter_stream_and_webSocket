part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object> get props => [];
}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final Stream<TickModel>? tickModelStream;

  const CryptoLoaded({this.tickModelStream});

  @override
  List<Object> get props => [tickModelStream!];
}

class CryptoError extends CryptoState {
  final String? errorStateMessage;

  const CryptoError(this.errorStateMessage);
  @override
  List<Object> get props => [errorStateMessage!];
}
