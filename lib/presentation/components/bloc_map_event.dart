import 'package:flutter/material.dart';
import 'package:travelgrid/common/constants/event_types.dart';


class BlocMapToEvent extends StatelessWidget {
  BlocMapToEvent({Key? key,  required this.state, this.searchBar,required this.child, required this.message }) : super(key: key);
  BlocEventState state;
  Widget child;
  Widget? searchBar;
  String message;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          searchBar ?? Container(),
         _mapStateToWidget(state)
        ]);
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