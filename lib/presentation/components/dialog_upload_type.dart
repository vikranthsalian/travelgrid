import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class DialogUploadType extends StatelessWidget{
  Map<String,dynamic> mapData = {};
  Function? onSelected;
  DialogUploadType({required this.mapData,this.onSelected});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(

        height: MediaQuery.of(context).size.height * 0.25,
        child:ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(children: [
                SizedBox(height: 20.h,),
                MetaTextView(mapData: mapData['title']),
                Expanded(child: getListView()),
                Container(
                  width: double.infinity,
                  child: MetaButton(mapData: mapData['bottomButtonCentre'],
                      onButtonPressed: (){
                        Navigator.pop(context);
                      }
                  ),
                )
            ]),
             )
         )
     )
    );
  }

  Widget getListView(){
    List list = [];
    list = mapData['listView']['data'];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {


        return InkWell(
          onTap: () async{
            Navigator.pop(context);
            onSelected!(list[index]['text']);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 35.h,
              alignment: Alignment.centerLeft,
              child: MetaTextView(mapData: list[index],
                  text:((index+1).toString() + ". "+ list[index]['text'] ))
          ),
        );


      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 3.h);
      },
      itemCount:list.length,
    ):  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MetaTextView(mapData: mapData['listView']['emptyData']['title'])
        ]
    );
  }



}
