//
// import 'package:flutter/material.dart';
// import 'package:travelex/presentation/widgets/button.dart';
// import 'package:travelex/presentation/widgets/image_view.dart';
// import 'package:travelex/presentation/widgets/text_field.dart';
// import 'package:travelex/presentation/widgets/text_view.dart';
//
// class MapWidget{
//
//   Widget getWidget(item,{formKey,Function? onChanged}) {
//
//     switch(item['type']){
//
//       case "sized_box_view":
//         return SizedBox(height: item['data']['ht'],width: item['data']['wd'] );
//
//       case "text_view":
//         return MetaTextView(mapData: item['data']);
//
//       case "form_view":
//
//         List formData = item['data'] ?? [];
//         return Form(
//           autovalidateMode: AutovalidateMode.disabled,
//           key: formKey,
//           child: ListView(
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             children: formData.map((data) =>  getWidget(data)).toList(),
//           ),
//         );
//
//
//       case "image_view":
//         return MetaImageView(mapData: item['data']);
//
//
//       case "button_view":
//         return MetaButton(mapData: item['data'],
//             onButtonPressed: (){
//
//               if (_formKey.currentState!.validate()) {
//                 _formKey.currentState!.save();
//               }
//             }
//         );
//
//
//       case "text_field_view":
//         return  MetaTextFieldView(
//           mapData: item,
//           controller: TextEditingController(text: ""),
//           onChanged: (value){
//             item['answer'] = value;
//           },
//           onValidate: (value){
//
//           },
//         );
//
//       default :
//         return Container();
//     }
//
//   }
//
//
// }