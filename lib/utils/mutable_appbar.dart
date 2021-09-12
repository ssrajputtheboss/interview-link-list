
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:interview_link_list/algorithm/index.dart';
import 'package:interview_link_list/state_management/actions.dart';
import 'package:interview_link_list/state_management/app_state.dart';

final INFO = '''Collection of interview questions with ans links.''';

class MutableAppBar extends StatelessWidget{

  final bool isLandscape;
  MutableAppBar(this.isLandscape);

  void _toggleSearchMode(BuildContext context){
    StoreProvider.of<AppState>(context).dispatch(AppAction(action: ActionList.toggleSearchMode));
  }

  AppBar searchAppBar(BuildContext context,state) => AppBar(
      backgroundColor: Color.fromRGBO(32,34,37, 1),
      title: TextField(
        style: TextStyle(color: Colors.white),
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white),
        ),
        onSubmitted: (String value){
          StoreProvider.of<AppState>(context).dispatch(
              AppAction(
                  action: ActionList.setSearchResults,
                  payload: search(state.currentChannel, value.split(RegExp(r'\W+',dotAll: true)))
              )
          );
        },
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.close,color: Colors.white,),
            onPressed: ()=>_toggleSearchMode(context)
        )
      ]
  );

  AppBar normalAppBar(BuildContext context,state) => AppBar(
      backgroundColor: Color.fromRGBO(32,34,37, 1),
      title: Text('#  ${state.currentChannel.replaceAll('_', '-')}'),
      actions: [
        IconButton(
            icon: Icon(Icons.search_outlined,color: Colors.white,),
            onPressed: ()=>_toggleSearchMode(context)
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

  AppBar landscapeAppBar(BuildContext context,state) => AppBar(
    backgroundColor: Color.fromRGBO(32,34,37, 1),
    title: Text('#  ${state.currentChannel.replaceAll('_', '-')}'),
    centerTitle: true,
    actions: [
      IconButton(
          icon: Icon(Icons.search_outlined,color: Colors.white,),
          onPressed: ()=>_toggleSearchMode(context)
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,AppState>(
      converter: (store)=>store.state,
      builder: (context,state){
        return state.isSearchMode ? searchAppBar(context,state):(isLandscape ? landscapeAppBar(context,state): normalAppBar(context,state));
      },
    );
  }

}

