import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaSwitch extends StatefulWidget {

  Function(bool)? onSwitchPressed;
  Map mapData;
  bool value;

  MetaSwitch({
    this.onSwitchPressed,
    this.value = true,
    required this.mapData
  });

  @override
  State<StatefulWidget> createState() => _MetaSwitchState();
}

class _MetaSwitchState extends State<MetaSwitch> {
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(child: MetaTextView(mapData: widget.mapData['label'])),
          Switch(
            activeColor: Colors.green,
            value: widget.value,
            onChanged:(bool value) {
              setState(() {

              });
                widget.onSwitchPressed!(value);
            },
          ),
        ],
      ),
    );
  }

}


class MetaSwitchBloc extends StatelessWidget {
  BooleanFieldBloc? bloc;
  Function(bool)? onSwitchPressed;
  Map mapData;

  MetaSwitchBloc({
    this.onSwitchPressed,
    this.bloc,
    required this.mapData
  });
  @override
  Widget build(BuildContext context) {


    bloc!.stream.listen((event) {
      onSwitchPressed!(event.value);
    });

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary:Colors.green,
          secondary: Colors.green,
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.black, // button text color
          ),
        ),
      ),
      child:Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: SwitchFieldBlocBuilder(

          booleanFieldBloc: bloc!,
          body:Container(child: MetaTextView(mapData: mapData['label'])),
        ),
      )
    );


  }

}