
import 'package:interview_link_list/utils/message_view.dart';

class AppState{
  String currentServer = "InterviewLinkList",currentChannel = "javascript";
  bool isSearchMode = false;
  List<int> searchResults = [];
  //List<MessageBody> messageList = [];
  int pointer = -1;
  AppState();
  AppState.fromOtherState(AppState appState){
    this.currentServer = appState.currentServer;
    this.currentChannel = appState.currentChannel;
    this.isSearchMode = appState.isSearchMode;
    this.searchResults = appState.searchResults;
    this.pointer = appState.pointer;
    //this.messageList = appState.messageList;
  }

  @override
  String toString() {
    return 'AppState{$currentChannel}';
  }
}