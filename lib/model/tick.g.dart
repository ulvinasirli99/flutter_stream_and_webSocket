// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TickModel _$TickModelFromJson(Map<String, dynamic> json) => TickModel(
      echoReq: json['echoReq'] == null
          ? null
          : EchoReq.fromJson(json['echoReq'] as Map<String, dynamic>),
      msgType: json['msgType'] as String?,
      subscription: json['subscription'] == null
          ? null
          : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      tick: json['tick'] == null
          ? null
          : Tick.fromJson(json['tick'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TickModelToJson(TickModel instance) => <String, dynamic>{
      'echoReq': instance.echoReq,
      'msgType': instance.msgType,
      'subscription': instance.subscription,
      'tick': instance.tick,
    };

EchoReq _$EchoReqFromJson(Map<String, dynamic> json) => EchoReq(
      ticks: json['ticks'] as String?,
    );

Map<String, dynamic> _$EchoReqToJson(EchoReq instance) => <String, dynamic>{
      'ticks': instance.ticks,
    };

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

Tick _$TickFromJson(Map<String, dynamic> json) => Tick(
      ask: (json['ask'] as num?)?.toDouble(),
      bid: (json['bid'] as num?)?.toDouble(),
      epoch: json['epoch'] as int?,
      id: json['id'] as String?,
      pipSize: json['pipSize'] as int?,
      quote: (json['quote'] as num?)?.toDouble(),
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$TickToJson(Tick instance) => <String, dynamic>{
      'ask': instance.ask,
      'bid': instance.bid,
      'epoch': instance.epoch,
      'id': instance.id,
      'pipSize': instance.pipSize,
      'quote': instance.quote,
      'symbol': instance.symbol,
    };
