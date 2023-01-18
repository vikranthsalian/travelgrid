import 'package:flutter/material.dart';
import 'package:travelgrid/common/constants/event_types.dart';


class BlocMapToEvent extends StatelessWidget {
  BlocMapToEvent({Key? key,  required this.state, required this.child, required this.message }) : super(key: key);
  BlocEventState state;
  Widget child;
  String message;

  @override
  Widget build(BuildContext context) {
    return _mapStateToWidget(state);
  }

  Widget _mapStateToWidget(BlocEventState state) {
    switch (state) {
      case BlocEventState.LOADING:
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          ),
        );

      case BlocEventState.LOADED:
        return child;

      case BlocEventState.ERROR:
        return Center(
          child: Text(message),
        );

      default:
        return Container();
    }
  }
}