// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hi_base/log.dart';
import 'package:web_socket_channel/io.dart';

import 'barrage_model.dart';

///负责与后端进行websocket通信
class HiSocket implements ISocket {
  final Map<String, dynamic> headers;
  static const _url = 'wss://api.devio.org/uapi/fa/barrage/';
  late IOWebSocketChannel? _channel;
  late ValueChanged<List<BarrageModel>>? _callBack;
  HiSocket(this.headers);

  ///心跳间隔秒数, 根据服务器实际timeout时间来调，这里nginx服务器的timeout为60
  final int _intervalSeconds = 50;
  @override
  ISocket open(String vid) {
      _channel = IOWebSocketChannel.connect(_url + vid,
       headers: headers, 
       pingInterval: Duration(seconds: _intervalSeconds));
       _channel?.stream.handleError((error){
         Log().debug('webSocket连接发生错误:$error');
       }).listen((message) {
           _headerMessage(message);
       });
       return this;
  }

  @override
  ISocket send(String message) {
    _channel?.sink.add(message);
    return this;
  }

  @override
  void close() {
      if(_channel != null){
          _channel?.sink.close();
      }    
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callBack) {
    _callBack = callBack;
    return this;
  }
  //处理服务端返回数据
  void _headerMessage(message) {
     Log().debug('webSocket:received:$message');
     var result = BarrageModel.fromJsonString(message);
     if(_channel!=null && _callBack != null){
        _callBack!(result);
     }
  }
}

abstract class ISocket {
  ///和服务端建立链接
  ISocket open(String vid);

  ///发送弹幕
  ISocket send(String message);

  ///关闭连接
  void close();

  ///接受弹幕
  ISocket listen(ValueChanged<List<BarrageModel>> callBack);
}
