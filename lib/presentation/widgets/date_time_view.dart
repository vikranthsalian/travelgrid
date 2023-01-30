import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
class MetaDateTimeView extends StatefulWidget {

  Map mapData;
  String? text;
  Function(Map)? onChange;
  MetaDateTimeView({required this.mapData,this.text,this.onChange});


  @override
  State<StatefulWidget> createState() => _MetaDateTimeViewState();
}

class _MetaDateTimeViewState extends State<MetaDateTimeView> {
  String? date,week,month,time="00:00";
  String? dateText ;
  @override
  Widget build(BuildContext context) {

    if(widget.mapData['showView'] == "date"){
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
          child: dateView()
      );
    }else if(widget.mapData['showView'] == "time"){
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
          child: timeView()
      );
    }else{
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
          child: dateTimeView()
      );
    }
  }


  Widget dateView(){
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: MetaTextView(mapData: widget.mapData['dateView']['label'])),
            InkWell(
              onTap: ()async{
                DateTime? pickedDate = await showDatePicker(
                    context: appNavigatorKey.currentState!.context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary:ParseDataType().getHexToColor( FlavourConstants.appThemeData['primary_color']), // <-- SEE HERE
                          onPrimary: Colors.white, // <-- SEE HERE
                          onSurface: Colors.black, // <-- SEE HERE
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            primary: Colors.black, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  setState(() {
                    date= pickedDate.day.toString();
                    week= DateFormat('EEEE').format(pickedDate);
                    month= DateFormat('MMMM, y').format(pickedDate);
                    dateText = DateFormat('dd-MM-yyyy').format(pickedDate);
                    print(dateText);


                    if(widget.mapData['showView'] == "date_time"){
                      widget.onChange!(
                          {
                            "date":dateText,
                            "time":time,
                          }
                      );
                    }else{
                      widget.onChange!({"date":dateText});
                    }

                  });
                }


              },
              child: Row(
                children: [
                  MetaTextView(mapData: widget.mapData['dateView']['dateText'],text: date),
                  SizedBox(width: 5.w,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MetaTextView(mapData: widget.mapData['dateView']['monthYearText'],text: month,),
                        MetaTextView(mapData: widget.mapData['dateView']['weekText'],text: week),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }

  Widget timeView(){
    return InkWell(
      onTap: () async{
      final TimeOfDay? picked_s = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {

            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary:ParseDataType().getHexToColor( FlavourConstants.appThemeData['primary_color']), // <-- SEE HERE
                  onPrimary: Colors.white, // <-- SEE HERE
                  onSurface: Colors.black, // <-- SEE HERE
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.black, // button text color
                  ),
                ),
              ),
              child:MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                child: child!,
              ),
            );

          });

        if (picked_s != null )
          setState(() {
            time= picked_s.hour.toString() +":"+picked_s.minute.toString();
            if(widget.mapData['showView'] == "date_time"){
              widget.onChange!(
                  {
                    "date":dateText,
                    "time":time,
                  }
              );
            }else{
              widget.onChange!({"time":dateText});
            }


          });
      },
      child: Container(
          child: Column(
            children: [
              MetaTextView(mapData: widget.mapData['timeView']['label']),
              MetaTextView(mapData: widget.mapData['timeView']['timeText'],text: time,),
            ],
          )
      ),
    );
  }

  Widget dateTimeView(){
    return Container(
        child: Row(
          children: [
            Expanded(child: dateView()),
            Expanded(child: timeView()),
          ],
        )
    );
  }

}
