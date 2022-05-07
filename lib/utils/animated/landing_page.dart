
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:interview_link_list/state_management/actions.dart';
import 'package:interview_link_list/state_management/app_state.dart';

class LandingPage extends StatefulWidget{

  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin{
  late AnimationController _animationController;
  bool _hasScaled = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1))..forward();
    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() => _hasScaled = true);
        _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1))..forward();
        _animationController.addStatusListener((status) {
          if(status == AnimationStatus.completed){
            StoreProvider.of<AppState>(context).dispatch(AppAction(action: ActionList.setLoaded, payload: null));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,AppState>(
      converter: (store) => store.state,
      builder: (context, state) => Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            child: Image(image: AssetImage("assets/icon/icon.png"),),
            builder: (ctx, child) => _hasScaled ? Transform.rotate(
              angle: _animationController.value * pi * 2,
              child: child,
            ):Transform.scale(
              scale: _animationController.value,
              child: child,
            ),
          ),
        ),
      )
    );
  }

}