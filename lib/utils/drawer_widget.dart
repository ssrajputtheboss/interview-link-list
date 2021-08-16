
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget{
  final String _currentServer,_currentChannel;
  final Function _changeChannel;
  final bool _isLandscape;
  DrawerWidget(String current,String currentChannel,changeChannel,bool isLandscape,{Key? key}) : _currentServer = current,_currentChannel=currentChannel,_changeChannel=changeChannel,_isLandscape=isLandscape,super(key: key);
  _DrawerWidgetState createState() => _DrawerWidgetState(_currentServer,_currentChannel,_changeChannel,_isLandscape);
}

class _DrawerWidgetState extends State<DrawerWidget>{
  final Function _changeFunction;
  final bool _isLandscape;
  final List<CircleAvatar> _serverIcons = const [const CircleAvatar(backgroundImage:const NetworkImage('https://media.giphy.com/media/oYQ9HRm5Mo7VXeMNVR/giphy.gif'),)];
  final List<String> _channels = ['default','javascript','java','node_js','react_js','mongodb','postgresql','python','android'];
  String _currentServer;
  String _currentChannel ;
  _DrawerWidgetState(String current,
      String currentChannel,
      Function changeFunction,
      bool isLandscape) :
        _currentServer = current,
        _currentChannel=currentChannel,
        _changeFunction=changeFunction,
        _isLandscape=isLandscape
  ;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(32,34,37, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: ListView.builder(
                      itemCount: _serverIcons.length,
                      itemBuilder: (ctx,int i){
                        return Container(
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)
                          ),
                          child: _serverIcons[i]
                        );
                      }),
                )
            ),
            Expanded(
              flex: 4,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(47, 49, 54, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: ListView.builder(
                      itemCount: _channels.length,
                      itemBuilder: (ctx,int i){
                        if(i==0){
                          return Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Image(image: NetworkImage('https://media.giphy.com/media/WTjXuYA2y4o3UZly3W/giphy.gif'),errorBuilder: (ct,o,st)=>Container(),),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(_currentServer,style: TextStyle(color: Colors.white,shadows: [Shadow(color: Colors.black,offset: Offset(1,1),blurRadius: 2),],fontWeight: FontWeight.bold,fontSize: 20),),
                              )
                            ],
                          );
                        }
                        return Container(
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: TextButton(
                                    style:ButtonStyle(
                                      alignment: Alignment.centerLeft
                                    ),
                                    child:Text('# '+_channels[i].replaceAll('_','-'),overflow: TextOverflow.ellipsis,style: TextStyle(wordSpacing: 2,color: Colors.white54,fontSize: 20,fontFamily: "Arial",decoration: _channels[i]==_currentChannel? TextDecoration.underline:TextDecoration.none,decorationStyle: TextDecorationStyle.double))
                                    ,onPressed: (){
                                    _changeFunction(_channels[i]);
                                    setState(() {
                                      _currentChannel = _channels[i];
                                    });
                                    if(!_isLandscape)
                                      Navigator.pop(context);
                                  },
                                  )
                              )
                            ]
                          ),
                        );
                      }),
                )
            )
          ]
        )
      )
    );
  }

}
