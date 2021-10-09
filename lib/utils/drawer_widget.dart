

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:interview_link_list/main.dart';
import 'package:interview_link_list/state_management/actions.dart';
import 'package:interview_link_list/state_management/app_state.dart';

class DrawerWidget extends StatelessWidget{
  static AppState? lastState;
  static final List<CircleAvatar> _serverIcons = const [const CircleAvatar(backgroundImage:const NetworkImage('https://media.giphy.com/media/oYQ9HRm5Mo7VXeMNVR/giphy.gif'),)];
  static final List<String> _channels = [
    'default', 'javascript','java','node_js','react_js','mongodb','postgresql',
    'python','android','spring_boot', 'operating_systems', 'computer_networks', 'coding'
  ];
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,AppState>(
      ignoreChange: (state)=>state.currentChannel == lastState?.currentChannel,
      converter: (store) => store.state,
      builder: (context, state){
        return Drawer(
            child: Container(
                child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(32,34,37, 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: ListView.builder(
                                controller: ScrollController(),
                                itemCount: _serverIcons.length,
                                itemBuilder: (ctx,int i){
                                  return Container(
                                      padding: const EdgeInsets.all(2),
                                      margin: const EdgeInsets.all(2),
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
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(47, 49, 54, 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: ListView.builder(
                                itemCount: _channels.length,
                                itemBuilder: (ctx,int i){
                                  if(i==0){
                                    return Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Image(image: const NetworkImage('https://media.giphy.com/media/WTjXuYA2y4o3UZly3W/giphy.gif'),errorBuilder: (ct,o,st)=>EMPTY_WIDGET,),
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          child: Text(
                                            state.currentServer,
                                            style: TextStyle(
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(1,1),
                                                      blurRadius: 2
                                                  ),
                                                ],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return Container(
                                    padding: const EdgeInsets.all(2),
                                    margin: const EdgeInsets.all(2),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    alignment: Alignment.centerLeft
                                                ),
                                                child: Text(
                                                    '# '+_channels[i].replaceAll('_','-'),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        wordSpacing: 2,
                                                        color: Colors.white54,
                                                        fontSize: 20,
                                                        fontFamily: "Arial",
                                                        decoration: _channels[i]==state.currentChannel? TextDecoration.underline:TextDecoration.none,
                                                        decorationStyle: TextDecorationStyle.double
                                                    )
                                                ),
                                                onPressed: (){
                                                  StoreProvider.of<AppState>(context).dispatch(AppAction(action: ActionList.changeChannel,payload: _channels[i]));
                                                  if(Navigator.canPop(context))
                                                    Navigator.pop(context);
                                                },
                                              ))
                                        ]
                                    ));
                                })))
                    ]
                )));
      },
    );
  }
}

