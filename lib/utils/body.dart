
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_link_list/utils/message_view.dart';
import 'package:interview_link_list/utils/string_color.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Body extends StatelessWidget{
  final List<MessageBody> _messageList;
  final String _title,_color;
  final ItemScrollController _itemScrollController;
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  Body(String title,String color,List<MessageBody> list,ItemScrollController controller) :
    this._title = title,
    this._color = color,
    this._messageList = list,
    this._itemScrollController = controller
  ;
  @override
  Widget build(BuildContext context) {
    MessageView.avatar = Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(5),
      child: CircleAvatar(backgroundImage: AssetImage('assets/logos/$_title.png'),),
    );
    MessageView.titleName = Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(3),
      child: Text(_title.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold, color: StringColor.get[_color] ?? Colors.white,letterSpacing: 1.5,fontSize: 16)),
    );
    return ScrollablePositionedList.builder(
        itemCount: _messageList.length,
        itemBuilder: (ctx,i){
          return MessageView(_messageList[i]);
        },
        itemScrollController: _itemScrollController,
        itemPositionsListener: itemPositionsListener,
    );
  }

}
