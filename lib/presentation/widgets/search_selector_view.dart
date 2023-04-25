import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/data/models/tr/tr_traveller_details.dart';
import 'package:travelgrid/presentation/screens/common/cities_screen.dart';
import 'package:travelgrid/presentation/screens/common/countries_screen.dart';
import 'package:travelgrid/presentation/screens/common/employees_screen.dart';
import 'package:travelgrid/presentation/screens/common/non_employees_screen.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class MetaSearchSelectorView extends StatefulWidget {

  Map mapData;
  String? text;
  String? type;
  Function? onChange;
  bool isCitySearch;
  MetaSearchSelectorView(this.type,{super.key, required this.mapData,this.text,this.onChange,this.isCitySearch=true});

  @override
  State<StatefulWidget> createState() => _MetaSearchSelectorViewState();
}

class _MetaSearchSelectorViewState extends State<MetaSearchSelectorView> {

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Column(
        children: [
          MetaTextView(mapData: widget.mapData['label']),
          InkWell(
            onTap: (){

              if(widget.isCitySearch) {
                String countryCode = "";
                if (widget.type == "D") {
                  countryCode = "IN";
                }else {
                  countryCode = "";
                }

                if(widget.type == "OO"){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          CountriesScreen(
                            onTap: (data) {
                              Navigator.pop(context);
                              setState(() {
                                widget.text = data.countryName;
                                widget.onChange!(data);
                              });
                            },
                          )));
                }else{
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          CityScreen(
                            code: countryCode,
                            onTap: (data) {
                              Navigator.pop(context);
                              setState(() {
                                widget.text = data.name;
                                widget.onChange!(data);
                              });
                            },
                          )));
                }


              }else{


                if(widget.type == "Employee"){

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          EmployeeScreen(
                            onTap: (data) {
                              Navigator.pop(context);
                              setState(() {
                                widget.text = data.fullName;

                                TRTravellerDetails model = TRTravellerDetails(
                                    employeeCode: data.employeecode,
                                    employeeName: data.fullName,
                                    email: data.currentContact!.email ?? "",
                                    employeeType: widget.type,
                                    mobileNumber: data.currentContact!.mobile ?? "",
                                    emergencyContactNo: data.currentContact!.telephoneNo ?? ""
                                );

                                widget.onChange!(model);
                              });
                            },
                          )));
                }
                // else{
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) =>
                //           NonEmployeeScreen(
                //             onTap: (data) {
                //               Navigator.pop(context);
                //               setState(() {
                //                 widget.text = data.name;
                //
                //                 TRTravellerDetails model = TRTravellerDetails(
                //                     employeeCode: "",
                //                     employeeName: data.name,
                //                     email: data.email ?? "",
                //                     employeeType: widget.type,
                //                     mobileNumber: data.mobileNumber ?? "",
                //                     emergencyContactNo: data.emergencyContactNo ?? ""
                //                 );
                //
                //                 widget.onChange!(model);
                //               });
                //             },
                //           )));
                // }


              }

            },
              child: MetaTextView(mapData: widget.mapData['dataText'],text: widget.text)),
        ],
        )
    );
  }

}

