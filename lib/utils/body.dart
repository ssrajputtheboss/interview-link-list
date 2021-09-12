

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:interview_link_list/main.dart';
import 'package:interview_link_list/state_management/app_state.dart';
import 'package:interview_link_list/utils/drawer_widget.dart';
import 'package:interview_link_list/utils/message_view.dart';
import 'package:interview_link_list/utils/string_color.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Body extends StatelessWidget{
  static int c=0;
  static AppState? _lastState;
  final ItemScrollController _itemScrollController = itemScrollController;
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  @override
  Widget build(BuildContext context) {
    final isLandscape = (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height * 3/2) && defaultTargetPlatform!=TargetPlatform.android && defaultTargetPlatform!=TargetPlatform.iOS;
    return StoreConnector<AppState,AppState>(
      ignoreChange: (state)=>_lastState?.currentChannel == state.currentChannel,
      converter: (store)=>store.state,
      builder: (context,state){
        print(++c);
        _lastState = state;
        MessageView.avatar = Container(
          padding: const EdgeInsets.all(3),
          margin: const EdgeInsets.all(5),
          child: CircleAvatar(backgroundImage: AssetImage('assets/logos/${state.currentChannel}.png'),),
        );
        return FutureBuilder(
          initialData: "",
          future: rootBundle.loadString("assets/data/${state.currentChannel}.json",cache: true),
          builder: (ctx,res){
            if(res.hasData) {
              List<MessageBody> list = <MessageBody>[];
              String color;
              try {
                final decoded = jsonDecode(res.data.toString());
                color = decoded['color'].toString();
                decoded[state.currentChannel].forEach((e) =>
                    list.add(MessageBody(e['msg'], e['time'], e['link'],
                        Map.from(e['reactions'])
                    )
                    )
                );
              }catch(e){
                color = 'w';
              }
              MessageView.titleName = Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(3),
                child: Text(state.currentChannel.replaceAll('_',' ').toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold, color: StringColor.get[color] ?? Colors.white,letterSpacing: 1.5,fontSize: 16)),
              );
              return isLandscape ? Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DrawerWidget(
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: body(list)
                  )
                ],
              ) : body(list);
            }
            else
              return const Center(child: const CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget body(List<MessageBody> _messageList){
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
