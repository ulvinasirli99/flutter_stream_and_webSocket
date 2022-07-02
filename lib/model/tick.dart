import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'tick.g.dart';

TickModel tickModelFromJson(String str) => TickModel.fromJson(json.decode(str));

String tickModelToJson(TickModel data) => json.encode(data.toJson());

@JsonSerializable()
class TickModel {
  TickModel({
    this.echoReq,
    this.msgType,
    this.subscription,
    this.tick,
  });

  EchoReq? echoReq;
  String? msgType;
  Subscription? subscription;
  Tick? tick;

  factory TickModel.fromJson(Map<String, dynamic> json) => TickModel(
        echoReq: EchoReq.fromJson(json["echo_req"]),
        msgType: json["msg_type"],
        subscription: Subscription.fromJson(json["subscription"]),
        tick: Tick.fromJson(json["tick"]),
      );

  Map<String, dynamic> toJson() => {
        "echo_req": echoReq?.toJson(),
        "msg_type": msgType,
        "subscription": subscription?.toJson(),
        "tick": tick?.toJson(),
      };
}

@JsonSerializable()
class EchoReq {
  EchoReq({
    this.ticks,
  });

  String? ticks;

  factory EchoReq.fromJson(Map<String, dynamic> json) => EchoReq(
        ticks: json["ticks"],
      );

  Map<String, dynamic> toJson() => {
        "ticks": ticks,
      };
}

@JsonSerializable()
class Subscription {
  Subscription({
    this.id,
  });

  String? id;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

@JsonSerializable()
class Tick {
  Tick({
    this.ask,
    this.bid,
    this.epoch,
    this.id,
    this.pipSize,
    this.quote,
    this.symbol,
  });

  double? ask;
  double? bid;
  int? epoch;
  String? id;
  int? pipSize;
  double? quote;
  String? symbol;

  factory Tick.fromJson(Map<String, dynamic> json) => Tick(
        ask: json["ask"].toDouble(),
        bid: json["bid"].toDouble(),
        epoch: json["epoch"],
        id: json["id"],
        pipSize: json["pip_size"],
        quote: json["quote"].toDouble() ?? 0,
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "ask": ask,
        "bid": bid,
        "epoch": epoch,
        "id": id,
        "pip_size": pipSize,
        "quote": quote,
        "symbol": symbol,
      };
}
