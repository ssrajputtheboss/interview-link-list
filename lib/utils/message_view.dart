import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interview_link_list/main.dart';
import 'package:interview_link_list/utils/reaction.dart';
import 'package:url_launcher/url_launcher.dart';

final errorWidget = const Chip(
  avatar: const Image(image: const AssetImage('assets/images/doge_sad.png'),),
  label: const Text('Can not load preview for this website:(',style: const TextStyle(color: Colors.red)),
);

class MessageView extends StatelessWidget{
  final MessageBody _messageBody;
  static Widget? _titleName,_avatar;
  static void set avatar(Widget avatar) => _avatar=avatar;
  static void set titleName(Widget title) => _titleName=title;
  MessageView(MessageBody messageBody) : _messageBody=messageBody;

  @override
  Widget build(BuildContext context) {
    final reactions = <Widget>[];
    _messageBody.reactions.forEach((String key,int value) => reactions.add(Reaction(key, value)));
    reactions.add(Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.grey,
            size: 20,
          )
        ],
      )));
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(2),
        child:Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatar!,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _titleName!,
                      Container(
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.all(3),
                        child: Text(_messageBody.time,style: TextStyle( color: Colors.grey,fontSize: 11),),
                      ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.all(3),
                      child: Text(_messageBody.msg, style: TextStyle( color: Colors.white,fontSize: 14), overflow: TextOverflow.clip )
                  ),
                  FutureBuilder(
                      future: canLaunch(_messageBody.link),
                      builder: (ctx,res){
                        if(res.hasData && res.connectionState == ConnectionState.done && res.data == true )
                          return TextButton(onPressed: ()=>launch(_messageBody.link), child: Text(_messageBody.link,style: const TextStyle(color: Colors.blue)));
                        else
                          return EMPTY_WIDGET;
                      }
                  ), (_messageBody.link.trim() == '' || kIsWeb)?
                  EMPTY_WIDGET:
                  Container(
                      child: AnyLinkPreview(
                        titleStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        link: _messageBody.link,
                        displayDirection: UIDirection.UIDirectionHorizontal,
                        showMultimedia: true,
                        errorWidget: errorWidget,
                        placeholderWidget: EMPTY_WIDGET,
                        backgroundColor: Colors.black,
                        boxShadow: [BoxShadow(color: Colors.white,blurRadius: 0.2)],
                      )),
                  Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(2),
                      child: Wrap(children: reactions)
                  )
                ],
              ))
          ],
        )));
  }
}

/*class MessageWrapper extends StatelessWidget{
  final String _msg;
  MessageWrapper(String msg) : _msg = msg;

  Widget getEmojiByName(String name){
    final Image? emoji = Emoji.get[name];
    return emoji ?? const Icon(Icons.error,size: 14,color: Colors.red,) ;
  }

  List<Widget> createWidgets(){
    var widgets = <Widget>[];
    final re =  RegExp(r':\w+:',dotAll: true);
    final texts = _msg.split(re);
    widgets.add(Text(texts[0],style: TextStyle( color: Colors.white,fontSize: 14),overflow: TextOverflow.visible,));
    int i=1;
    re.allMatches(_msg).forEach((element) {
      widgets.add(getEmojiByName(element.group(0)!));
      widgets.add(Text(texts[i] , style: TextStyle( color: Colors.white,fontSize: 14),overflow: TextOverflow.visible,));
      ++i;
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: createWidgets() ,
    );
  }

}*/

class MessageBody{
  String _msg,_time,_link;
  Map<String,int> _reactions;
  String get msg => this._msg;
  set msg(String m) => this._msg=m;
  String get time => this._time;
  set time(String t) => this._time =t;
  String get link => this._link;
  set link(String l) => this._link=l;
  Map<String,int> get reactions => this._reactions;
  set reactions(Map<String,int> r) => this._reactions=r;
  MessageBody(String msg,
      String time,
      String link,
      Map<String,int> reactions
      ) : _msg= msg,
        _time = time,
        _link=link,
        _reactions=reactions;
  @override
  String toString() => 'msg:$_msg,time:$_time,link$_link,${_reactions.toString()}';
}

