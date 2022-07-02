import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/core/custom_sizer.dart';
import 'package:flutter_stream/domain/active_symbol_cubit/active_symbol_cubit.dart';
import 'package:flutter_stream/domain/crypto_bloc/crypto_bloc.dart';
import 'package:flutter_stream/model/active_model.dart';
import 'package:flutter_stream/model/tick.dart';
import 'package:flutter_stream/ui/widget/custom_dropdown.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  var uniqeItems = <String>{};
  List<String> values = [];
  String? selectedMarketValue;
  String? selectedTrickValue;
  double tickQuoteValue = 0.0;
  Color textColor = Colors.grey;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ActiveSymbolCubit>(context).initazlizedActiveSymbolSocket();
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<CryptoBloc>(context).disposeWebSocketConnection();
    BlocProvider.of<ActiveSymbolCubit>(context).disposeWebSocketConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.only(
                left: 70,
                right: 70,
                top: 30,
                bottom: 20,
              ),
              child: BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
                builder: (context, state) {
                  if (state is ActiveSymbolLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is ActiveSymbolError) {
                    return Center(
                      child: Text(
                        state.errorMessage.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  if (state is ActiveSymbolLoaded) {
                    return StreamBuilder<ActiveSymoblModel>(
                        stream: state.activeSymbolModelStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          if (snapshot.hasData) {
                            snapshot.data!.activeSymbols?.forEach((element) {
                              if (element.exchangeIsOpen == 1) {
                                uniqeItems.add(element.market!);
                              }
                            });
                            return CustomDropdownButton2(
                              hint: 'Select Market',
                              dropdownItems: uniqeItems.toList(),
                              value: selectedMarketValue,
                              onChanged: (value) {
                                setState(() {
                                  values = [];
                                  snapshot.data!.activeSymbols
                                      ?.forEach((element) {
                                    if (element.market == value &&
                                        element.exchangeIsOpen == 1) {
                                      values.add(element.symbol!);
                                    }
                                  });
                                  selectedMarketValue = value;
                                  selectedTrickValue = null;
                                });
                              },
                            );
                          }
                          return const SizedBox();
                        });
                  }
                  return const Center(
                    child: Text(
                      "No available data",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Todo Chnage and initazlied TrickSocket....
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.only(
                left: 70,
                right: 70,
                top: 30,
                bottom: 20,
              ),
              child: CustomDropdownButton2(
                hint: 'Select Trick',
                dropdownItems: values,
                value: selectedTrickValue,
                onChanged: (value) {
                  setState(() {
                    print("Tick Value : $value");
                    selectedTrickValue = value;
                    BlocProvider.of<CryptoBloc>(context).add(
                      OpenCryptoSocketEvent(value!),
                    );
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 120,
              child: BlocBuilder<CryptoBloc, CryptoState>(
                builder: (context, state) {
                  if (state is CryptoLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CryptoError) {
                    return Center(
                      child: Text("Error : ${state.errorStateMessage}"),
                    );
                  }
                  if (state is CryptoLoaded) {
                    return Center(
                      child: StreamBuilder<TickModel>(
                        stream: state.tickModelStream!,
                        builder: (context, AsyncSnapshot<TickModel>? snapshot) {
                          if (snapshot!.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.connectionState ==
                                  ConnectionState.none) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasData) {
                            tickQuoteValue = snapshot.data!.tick!.quote!;
                            state.tickModelStream!.listen((event) {
                              if (tickQuoteValue > event.tick!.quote!) {
                                textColor = Colors.red.shade600;
                              } else if (tickQuoteValue < event.tick!.quote!) {
                                textColor = const Color.fromRGBO(4, 211, 11, 1);
                              } else if (tickQuoteValue == event.tick!.quote!) {
                                textColor = Colors.grey;
                              }
                            });
                            return Text(
                              "Tick Data : " + tickQuoteValue.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: textColor,
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "Tick Data : " + tickQuoteValue.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        color: textColor,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: custom_height(context, 10),
            ),
            Center(
              child: SizedBox(
                width: custom_width(context, 35),
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CryptoBloc>(context).add(
                      ResetCryptoSocketEvent(),
                    );
                    setState(() {
                      tickQuoteValue = 0.0;
                      selectedTrickValue = null;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Center(
                    child: Text(
                      "Reset Socket Connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 145, 0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}