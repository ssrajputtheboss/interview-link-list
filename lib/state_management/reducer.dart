import 'package:interview_link_list/main.dart';
import 'package:interview_link_list/state_management/actions.dart';
import 'package:interview_link_list/state_management/app_state.dart';

AppState reducer(AppState previousState, action) {
  AppState newState = AppState.fromOtherState(previousState);
  switch(action.action){
    case ActionList.changeChannel:
      newState.currentChannel = action.payload;
      break;
    case ActionList.toggleSearchMode:
      newState.isSearchMode = !newState.isSearchMode;
      newState.searchResults = [];
      newState.pointer = -1;
      break;
    case ActionList.upPointer:
      if(newState.pointer>0) {
        newState.pointer--;
        itemScrollController.jumpTo(index: newState.pointer);
      }else {
        newState.pointer =
        newState.searchResults.length == 0 ? 0 : newState.searchResults.length - 1;
        itemScrollController.jumpTo(index: newState.searchResults[newState.pointer]);
      }
      break;
    case ActionList.downPointer:
      int nextPointer = (newState.pointer+1) % newState.searchResults.length;
      newState.pointer = nextPointer;
      itemScrollController.jumpTo(index: newState.searchResults[newState.pointer]);
      break;
    case ActionList.setSearchResults:
      newState.searchResults = action.payload;
      newState.pointer = -1;
      break;
    case ActionList.setLoaded:
      newState.hasLoaded = true;
  }
  return newState;
}