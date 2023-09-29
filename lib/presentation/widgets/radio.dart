import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/extensions/capitalize.dart';

class MetaRadio extends StatefulWidget {

  Function? onRadioSwitched;
  bool? value;
  String? one;
  String? two;

  MetaRadio({
    this.onRadioSwitched,
    this.value,
    this.one,
    this.two,
  });

  @override
  State<StatefulWidget> createState() => _MetaRadioState();
}

class _MetaRadioState extends State<MetaRadio> {
  String _value = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = widget.one!;
  }

  @override
  Widget build(BuildContext context) {
    
    return Transform.translate(
      offset: Offset(0,-0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:Container(
                alignment: Alignment.center,
                height: 25.h,
                child: InkWell(
                  onTap: (){

                    onSelect(widget.one!);

                  },
                  child:Transform.translate(
                    offset: Offset(0,-15),
                    child: RadioListTile(
                      title: Text(widget.one!.inRupeesFormat(),style: TextStyle(fontSize: 10),),
                      value: widget.one!,
                      groupValue: _value,
                      onChanged: (value){
                        onSelect(value!);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  onSelect(widget.two!);
                },
                child: Container(
                  height: 25.h,
                  child: Transform.translate(
                    offset: Offset(0,-15),
                    child: RadioListTile(
                      title: Text(widget.two!.inRupeesFormat(),style: TextStyle(fontSize: 10),),
                      value: widget.two!,
                      groupValue: _value,
                      onChanged: (value){
                        onSelect(value!);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelect(String value) {
    _value = value;
    print(_value);

    widget.onRadioSwitched!(_value);
    setState(() {

    });
  }

}
