import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interview_link_list/utils/body.dart';
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
            drawer: isLandscape ? Container(width: 10,height: 10,) : DrawerWidget(),
            body: Body(),
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
            floatingActionButton: FloatingSearchWidget(),
        );
  }

}