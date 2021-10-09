import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interview_link_list/main.dart';
import 'package:interview_link_list/utils/body.dart';
import 'package:interview_link_list/utils/bottom_bar.dart';
import 'package:interview_link_list/utils/drawer_widget.dart';
import 'package:interview_link_list/utils/floating_search_widget.dart';
import 'package:interview_link_list/utils/mutable_appbar.dart';

class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final isLandscape = (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height * 3/2) && defaultTargetPlatform!=TargetPlatform.android && defaultTargetPlatform!=TargetPlatform.iOS;
    return Scaffold(
            backgroundColor: Color.fromRGBO(47, 49, 50, 1),
            appBar:PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: MutableAppBar(isLandscape),
            ),
            drawer: isLandscape ? EMPTY_WIDGET : DrawerWidget(),
            body: Body(),
            bottomNavigationBar: isLandscape? EMPTY_WIDGET : BottomBar(),
            floatingActionButton: FloatingSearchWidget(),
        );
  }

}