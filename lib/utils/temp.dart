
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:interview_link_list/state_management/app_state.dart';

class TempWidget extends StatelessWidget{
  static int c=0;
  static AppState? lastState;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,AppState>(
      ignoreChange: (state)=>lastState?.isSearchMode == state.isSearchMode,
      converter: (store)=>store.state,
      builder: (context,state) {
        lastState = state;
        print(++c);
        return Text(state.isSearchMode?"On":"Off");
      },
    );
  }

}