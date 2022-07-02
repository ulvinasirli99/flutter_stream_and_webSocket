part of 'active_symbol_cubit.dart';

abstract class ActiveSymbolState extends Equatable {
  const ActiveSymbolState();

  @override
  List<Object> get props => [];
}

class ActiveSymbolInitial extends ActiveSymbolState {}

class ActiveSymbolLoading extends ActiveSymbolState {}

class ActiveSymbolLoaded extends ActiveSymbolState {
  final Stream<ActiveSymoblModel>? activeSymbolModelStream;

  const ActiveSymbolLoaded(this.activeSymbolModelStream);
}

class ActiveSymbolError extends ActiveSymbolState {
  final String? errorMessage;

  const ActiveSymbolError({this.errorMessage});
}
