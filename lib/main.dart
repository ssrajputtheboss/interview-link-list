
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:interview_link_list/algorithm/index.dart';
import 'package:interview_link_list/state_management/app_state.dart';
import 'package:interview_link_list/state_management/reducer.dart';
import 'package:interview_link_list/utils/main_page.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final EMPTY_WIDGET = const SizedBox();
final ItemScrollController itemScrollController = ItemScrollController();

void main() {
  final _initialState = AppState();
  final Store<AppState> store = Store<AppState>( reducer, initialState: _initialState);
  runApp(InterviewLinkListApp(store: store));
}

class InterviewLinkListApp extends StatelessWidget {
  final Store<AppState> store;
  InterviewLinkListApp({required this.store});
  @override
  Widget build(BuildContext context) {
    setIndexJSON();
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'InterviewLinkList',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            canvasColor: Color.fromRGBO(32,34,37, 1),
          ),
          home: MainPage(),
          ),
    );
  }
}