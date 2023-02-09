import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/data/models/location_model.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaCheckBox extends StatefulWidget {

  Function(bool)? onCheckPressed;
  Map mapData;
  bool? value;

  MetaCheckBox({
    this.onCheckPressed,
    this.value = false,
    required this.mapData,
  });

  @override
  State<StatefulWidget> createState() => _MetaCheckBoxState();
}

class _MetaCheckBoxState extends State<MetaCheckBox> {


  @override
  Widget build(BuildContext context) {


    return Container(
      child:Checkbox(
        value: widget.value!,
        activeColor: Colors.green,
        onChanged:(bool? newValue)
          {
            setState(() {
              widget.value = newValue;
            });
            widget.onCheckPressed!(newValue!);

        }
    ));
  }

}

class MetaCheckBoxBloc extends StatelessWidget {
  BooleanFieldBloc? bloc;
  Function(bool)? onSwitchPressed;
  Map mapData;

  MetaCheckBoxBloc({
    required this.onSwitchPressed,
    this.bloc,
    required this.mapData
  });
  @override
  Widget build(BuildContext context) {


    bloc!.stream.listen((event) {
      onSwitchPressed!(event.value);
    });

    return Container(
      child: CheckboxFieldBlocBuilder(
        booleanFieldBloc: bloc!,

        // /body: Container(),
        body:Container(
          width: 20.w,
            height: 20.w,
            child: Checkbox(
                    value: bloc!.value,
                    activeColor: Colors.green,
                    onChanged:(bool? newValue){

                      bloc!.updateValue(newValue!);

                     }

         ),
      )),
    );


  }

}
