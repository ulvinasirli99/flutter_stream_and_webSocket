import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/domain/active_symbol_cubit/active_symbol_cubit.dart';
import 'package:flutter_stream/domain/di/dependency_inject.dart';
import 'package:flutter_stream/domain/observer/bloc_observer.dart';
import 'package:flutter_stream/ui/screen/crypto_page.dart';
import 'domain/crypto_bloc/crypto_bloc.dart';

void main() {
  setup();
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: AppBlocObserver(),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CryptoBloc(),
        ),
        BlocProvider(
          create: (_) => ActiveSymbolCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CryptoScreen(),
    );
  }
}
