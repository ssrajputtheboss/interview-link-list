
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(topLeft: const Radius.circular(10),topRight: const Radius.circular(10))
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(margin: const EdgeInsets.all(3),child: CircleAvatar(child: Icon(Icons.image_outlined,color: Colors.white,),)),
              Container(margin: const EdgeInsets.all(3),child: CircleAvatar(child: Icon(Icons.card_giftcard,color: Colors.white,),)),
            ],
          ),
          Expanded(flex: 6,
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
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
    );
  }

}