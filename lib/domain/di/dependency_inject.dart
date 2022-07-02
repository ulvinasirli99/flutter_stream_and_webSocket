import 'package:flutter_stream/domain/active_symbol_cubit/active_symbol_cubit.dart';
import 'package:flutter_stream/domain/crypto_bloc/crypto_bloc.dart';
import 'package:flutter_stream/domain/product_cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ProductCubit>(() => ProductCubit());

  getIt.registerLazySingleton<CryptoBloc>(() => CryptoBloc());

  getIt.registerLazySingleton<ActiveSymbolCubit>(() => ActiveSymbolCubit());
}
