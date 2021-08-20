import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_link_list/algorithm/index.dart';
import 'package:interview_link_list/utils/body.dart';
import 'package:interview_link_list/utils/drawer_widget.dart';
import 'package:interview_link_list/utils/message_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final INFO = '''Collection of interview questions with ans links.''';
final EMPTY_WIDGET = Container(height: 0,width: 0);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setIndexJSON();
    return MaterialApp(
      title: 'InterviewLinkList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Color.fromRGBO(32,34,37, 1),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  String _currentServer = "InterviewLinkList";
  String _currentChannel = "javascript";
  bool _isSearchMode = false;
  List<int> _searchResults = <int>[];
  int _pointer = -1;
  final ItemScrollController _itemScrollController = ItemScrollController();
  void _moveToIndex(int index) => _itemScrollController.jumpTo(index: index);
  void _setCurrentChannel(String channel) => setState(()=>this._currentChannel = channel);
  void _toggleSearchMode() => setState((){this._isSearchMode=!_isSearchMode;_searchResults=<int>[];_pointer=-1;});
  void _setPointer(int pointer) => setState(()=>this._pointer=pointer);
  void _setSearchResults(List<int> result) => setState(()=>_searchResults = result);
  void _onMoveUp(){
    if(_pointer <= 0)return;
    _setPointer(_pointer-1);
    _moveToIndex(_pointer);
  }
  void _onMoveDown(){
    if(_pointer >= (_searchResults.length-1))return;
    _setPointer(_pointer+1);
    _moveToIndex(_searchResults[_pointer]);
  }

  AppBar searchAppBar() => AppBar(
    leading: Container(),
    backgroundColor: Color.fromRGBO(32,34,37, 1),
    title: TextField(
      style: TextStyle(color: Colors.white),
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white),
      ),
      onSubmitted: (String value){
        _setSearchResults(search(_currentChannel, value.split(RegExp(r'\W+',dotAll: true))));
      },
    ),
    actions: [
      IconButton(
          icon: Icon(Icons.close,color: Colors.white,),
          onPressed: _toggleSearchMode
      )
    ]
  );

  AppBar normalAppBar() => AppBar(
    backgroundColor: Color.fromRGBO(32,34,37, 1),
    title: Text('#  ${_currentChannel.replaceAll('_', '-')}'),
    actions: [
      IconButton(
          icon: Icon(Icons.search_outlined,color: Colors.white,),
          onPressed: _toggleSearchMode
      ),
      IconButton(onPressed: ()=>showAboutDialog(
          applicationIcon: Image.asset('assets/icon/icon.png'),
          applicationName: 'InterviewLinkList',
          applicationVersion: '1.0.0',
          context: context,children: [
            SingleChildScrollView(
              child: Text(INFO),
            )
        ]
      ), icon: Icon(Icons.info_outline,color: Colors.white,))
    ]
  );

  AppBar landscapeAppBar() => AppBar(
    leading: Container(),
    backgroundColor: Color.fromRGBO(32,34,37, 1),
    title: Text('#  ${_currentChannel.replaceAll('_', '-')}'),
    centerTitle: true,
    actions: [
      IconButton(
          icon: Icon(Icons.search_outlined,color: Colors.white,),
          onPressed: _toggleSearchMode
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    final isLandscape = (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height * 3/2) && defaultTargetPlatform!=TargetPlatform.android && defaultTargetPlatform!=TargetPlatform.iOS;
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 49, 50, 1),
      appBar: _isSearchMode ? searchAppBar():(isLandscape ? landscapeAppBar(): normalAppBar()),
      drawer: isLandscape ? Container(width: 10,height: 10,) : DrawerWidget(
          _currentServer,
          _currentChannel,
          (String c){
            _setCurrentChannel(c);
          }
      ),
      body: FutureBuilder(
        initialData: "",
        future: rootBundle.loadString("assets/data/$_currentChannel.json",cache: true),
        builder: (ctx,res){
          if(res.hasData) {
            List<MessageBody> list = <MessageBody>[];
            String color;
            try {
              final decoded = jsonDecode(res.data.toString());
              color = decoded['color'].toString();
              decoded[_currentChannel].forEach((e) =>
                  list.add(MessageBody(e['msg'], e['time'], e['link'],
                      Map.from(e['reactions'])
                    )
                  )
              );
            }catch(e){
              color = 'w';
            }
            return isLandscape ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DrawerWidget(
                      _currentServer,
                      _currentChannel,
                          (String c){
                        _setCurrentChannel(c);
                      }
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Body(_currentChannel,color,list,_itemScrollController)
                )
              ],
            ) : Body(_currentChannel,color,list,_itemScrollController);
          }
          else
            return const Center(child: const CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
        ),
        child: Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(margin: EdgeInsets.all(3),child: CircleAvatar(child: Icon(Icons.image_outlined,color: Colors.white,),)),
                Container(margin: EdgeInsets.all(3),child: CircleAvatar(child: Icon(Icons.card_giftcard,color: Colors.white,),)),
              ],
            ),
            Expanded(flex: 6,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Message here',
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(Icons.emoji_emotions_rounded,color: Colors.grey,)
                    ),
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: _isSearchMode ?
      Container(
        padding: EdgeInsets.only(left: 6,right: 6),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${_pointer+1}/${_searchResults.length}',style: const TextStyle(color: Colors.white)),
            IconButton(
              iconSize: 16,
              icon: Icon(Icons.keyboard_arrow_up,color: Colors.white,),
              onPressed: _onMoveUp,
            ),
            IconButton(
              iconSize: 16,
              icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
              onPressed: _onMoveDown,
            )
          ],
        )
      ):
      Container()
    );
  }

}
