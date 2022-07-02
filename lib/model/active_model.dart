// To parse this JSON data, do
//
//     final activeSymoblModel = activeSymoblModelFromJson(jsonString);

import 'dart:convert';

ActiveSymoblModel activeSymoblModelFromJson(String str) =>
    ActiveSymoblModel.fromJson(json.decode(str));

String activeSymoblModelToJson(ActiveSymoblModel data) =>
    json.encode(data.toJson());

class ActiveSymoblModel {
  ActiveSymoblModel({
    this.activeSymbols,
    this.echoReq,
    this.msgType,
  });

  List<ActiveSymbol>? activeSymbols;
  EchoReq? echoReq;
  String? msgType;

  factory ActiveSymoblModel.fromJson(Map<String, dynamic> json) =>
      ActiveSymoblModel(
        activeSymbols: List<ActiveSymbol>.from(
            json["active_symbols"].map((x) => ActiveSymbol.fromJson(x))),
        echoReq: EchoReq.fromJson(json["echo_req"]),
        msgType: json["msg_type"],
      );

  Map<String, dynamic> toJson() => {
        "active_symbols":
            List<dynamic>.from(activeSymbols!.map((x) => x.toJson())),
        "echo_req": echoReq!.toJson(),
        "msg_type": msgType,
      };
}

class ActiveSymbol {
  ActiveSymbol({
    this.allowForwardStarting,
    this.displayName,
    this.exchangeIsOpen,
    this.isTradingSuspended,
    this.market,
    this.marketDisplayName,
    this.pip,
    this.submarket,
    this.submarketDisplayName,
    this.symbol,
    this.symbolType,
  });

  int? allowForwardStarting;
  String? displayName;
  int? exchangeIsOpen;
  int? isTradingSuspended;
  String? market;
  MarketDisplayName? marketDisplayName;
  double? pip;
  String? submarket;
  String? submarketDisplayName;
  String? symbol;
  SymbolType? symbolType;

  factory ActiveSymbol.fromJson(Map<String, dynamic> json) => ActiveSymbol(
        allowForwardStarting: json["allow_forward_starting"],
        displayName: json["display_name"],
        exchangeIsOpen: json["exchange_is_open"],
        isTradingSuspended: json["is_trading_suspended"],
        market: json["market"],
        marketDisplayName:
            marketDisplayNameValues.map![json["market_display_name"]],
        pip: json["pip"].toDouble(),
        submarket: json["submarket"],
        submarketDisplayName: json["submarket_display_name"],
        symbol: json["symbol"],
        symbolType: symbolTypeValues.map![json["symbol_type"]],
      );

  Map<String, dynamic> toJson() => {
        "allow_forward_starting": allowForwardStarting,
        "display_name": displayName,
        "exchange_is_open": exchangeIsOpen,
        "is_trading_suspended": isTradingSuspended,
        "market": marketValues.reverse[market],
        "market_display_name":
            marketDisplayNameValues.reverse[marketDisplayName],
        "pip": pip,
        "submarket": submarket,
        "submarket_display_name": submarketDisplayName,
        "symbol": symbol,
        "symbol_type": symbolTypeValues.reverse[symbolType],
      };
}

enum Market {
  BASKET_INDEX,
  FOREX,
  INDICES,
  CRYPTOCURRENCY,
  SYNTHETIC_INDEX,
  COMMODITIES
}

final marketValues = EnumValues({
  "basket_index": Market.BASKET_INDEX,
  "commodities": Market.COMMODITIES,
  "cryptocurrency": Market.CRYPTOCURRENCY,
  "forex": Market.FOREX,
  "indices": Market.INDICES,
  "synthetic_index": Market.SYNTHETIC_INDEX
});

enum MarketDisplayName {
  BASKET_INDICES,
  FOREX,
  STOCK_INDICES,
  CRYPTOCURRENCIES,
  SYNTHETIC_INDICES,
  COMMODITIES
}

final marketDisplayNameValues = EnumValues({
  "Basket Indices": MarketDisplayName.BASKET_INDICES,
  "Commodities": MarketDisplayName.COMMODITIES,
  "Cryptocurrencies": MarketDisplayName.CRYPTOCURRENCIES,
  "Forex": MarketDisplayName.FOREX,
  "Stock Indices": MarketDisplayName.STOCK_INDICES,
  "Synthetic Indices": MarketDisplayName.SYNTHETIC_INDICES
});

enum SymbolType {
  FOREX_BASKET,
  FOREX,
  STOCKINDEX,
  CRYPTOCURRENCY,
  EMPTY,
  COMMODITY_BASKET,
  COMMODITIES
}

final symbolTypeValues = EnumValues({
  "commodities": SymbolType.COMMODITIES,
  "commodity_basket": SymbolType.COMMODITY_BASKET,
  "cryptocurrency": SymbolType.CRYPTOCURRENCY,
  "": SymbolType.EMPTY,
  "forex": SymbolType.FOREX,
  "forex_basket": SymbolType.FOREX_BASKET,
  "stockindex": SymbolType.STOCKINDEX
});

class EchoReq {
  EchoReq({
    this.activeSymbols,
    this.productType,
  });

  String? activeSymbols;
  String? productType;

  factory EchoReq.fromJson(Map<String, dynamic> json) => EchoReq(
        activeSymbols: json["active_symbols"],
        productType: json["product_type"],
      );

  Map<String, dynamic> toJson() => {
        "active_symbols": activeSymbols,
        "product_type": productType,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
