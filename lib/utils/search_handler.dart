
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBoxController{
  late final Function _pointerSetter,_lengthSetter;
  void initialize(Function ps,Function ls){_pointerSetter=ps;_lengthSetter=ls;}
  void setPointer(int pointer) => _pointerSetter(pointer);
  void setLength(int pointer) => _lengthSetter(pointer);
}

class SearchBox extends StatefulWidget{
  final SearchBoxController _controller;
  SearchBox(SearchBoxController controller): _controller=controller;
  _SearchBox createState() => _SearchBox(_controller);
}

class _SearchBox extends State<SearchBox>{
  final SearchBoxController _controller;
  _SearchBox(SearchBoxController controller): _controller=controller;
  int _pointer=-1,_length=0;
  void _setPointer(int p) => setState(()=>_pointer=p);
  void _setLength(int l) => setState(()=>_length=l);
  @override
  void initState() {
    super.initState();
    _controller.initialize(_setPointer, _setLength);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 6,right: 6),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${_pointer+1}/${_length}',style: TextStyle(color: Colors.white)),
            IconButton(
              iconSize: 16,
              icon: Icon(Icons.keyboard_arrow_up,color: Colors.white),
              onPressed: (){}//_onMoveUp,
            ),
            IconButton(
              iconSize: 16,
              icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
              onPressed: (){}//_onMoveDown,
            )
          ],
        )
    );
  }

}
