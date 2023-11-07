import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/extensions/capitalize.dart';

class MetaRadio extends StatefulWidget {

  Function? onRadioSwitched;
  bool? value;
  String? one;
  String? two;
  String? three;

  MetaRadio({
    this.onRadioSwitched,
    this.value,
    this.one,
    this.two,
    this.three,
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
    
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: (){

                  onSelect(widget.one!,"retail");

                },
                child:Column(
                  children: [
                    Radio(value:  widget.one!, groupValue: _value, onChanged: (value){
                      onSelect(value!,"retail");
                    }),
                    Text("Retail Fare \n"+widget.one!.inRupeesFormat(),style: TextStyle(fontSize: 10))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: (){
                onSelect(widget.two!,"corporate");
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(value:  widget.two!, groupValue: _value, onChanged: (value){
                      onSelect(value!,"corporate");
                    }),
                    Text("Corporate Fare \n"+widget.two!.inRupeesFormat(),style: TextStyle(fontSize: 10))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
                onTap: (){
                  onSelect(widget.three!,"splrt");
                },
                child: Container(
                    child: Column(
                      children: [
                        Radio(value:  widget.three!, groupValue: _value, onChanged: (value){
                          onSelect(value!,"splrt");
                        }),
                        Text("Special Fare \n"+widget.three!.inRupeesFormat(),style: TextStyle(fontSize: 12))
                      ],
                    )
                )
            ),
          ),
        ],
      ),
    );
  }

  void onSelect(String value,String type) {
    _value = value;
    print(_value);

    widget.onRadioSwitched!(_value,type);
    setState(() {

    });
  }

}
