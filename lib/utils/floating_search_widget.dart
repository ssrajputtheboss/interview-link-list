

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:interview_link_list/state_management/actions.dart';
import 'package:interview_link_list/state_management/app_state.dart';

class FloatingSearchWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,AppState>(
      converter: (store)=>store.state,
      builder: (context,state){
        return state.isSearchMode ?
        Container(
            padding: EdgeInsets.only(left: 6,right: 6),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${state.pointer+1}/${state.searchResults.length}',style: const TextStyle(color: Colors.white)),
                IconButton(
                  iconSize: 16,
                  icon: Icon(Icons.keyboard_arrow_up,color: Colors.white,),
                  onPressed: (){
                    StoreProvider.of<AppState>(context).dispatch(AppAction(action: ActionList.upPointer));
                  },
                ),
                IconButton(
                  iconSize: 16,
                  icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                  onPressed: (){
                    StoreProvider.of<AppState>(context).dispatch(AppAction(action: ActionList.downPointer));
                  },
                )
              ],
            )
        ):
        Container();
      },
    );
  }
}