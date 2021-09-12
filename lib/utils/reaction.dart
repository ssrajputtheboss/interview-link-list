
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_link_list/utils/emoji.dart';

class Reaction extends StatelessWidget{
  final String _emoji;
  final int _count;
  Reaction(String emoji,int count) : _count=count,_emoji=emoji;
  Widget getEmojiByName(String name){
    final Image? emoji = Emoji.get[name];
    return emoji ?? const Icon(Icons.error,size: 14,color: Colors.red,) ;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 2,right: 2),
      child: Chip(
          padding: const EdgeInsets.all(0),
          backgroundColor: const Color.fromRGBO(0, 0, 100, 0.4),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 2,
                  color: Colors.indigo
              ),
              borderRadius: BorderRadius.circular(5)
          ),
          avatar: getEmojiByName(_emoji),
          label: Text(
            '$_count',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            ))));
  }
}
/*
return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo,width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(0, 0, 100, 0.4)
      ),
        child:
        SizedBox(
          height: 20,
          width: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getEmojiByName(_emoji),
              Text('$_count',style: TextStyle(color: Colors.white,fontSize: 14),)
            ],
          ),
        )
    );
*/