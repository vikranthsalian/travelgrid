import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key,
    required this.controller,
    this.maxLength,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onValidate,
    this.suffixIcon,
    this.textStyling,
    this.labelStyling,
    this.backgroundColor,
    this.borderColor,
    this.errorColor,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.inputFormatters,
    this.hintStyle,
    this.isPassword = false,
    this.borderRadius = 8,
    this.maxLines,
    this.readOnly = false,
  })
      : super(key: key);
  String? labelText;
  TextEditingController? controller;
  String? hintText;
  int? maxLength;
  Function(String)? onChanged;
  FormFieldValidator<String>? onValidate;
  Widget? suffixIcon;
  TextStyle? textStyling;
  TextStyle? labelStyling;
  Color? backgroundColor;
  Color? borderColor;
  Color? errorColor;
  TextInputType inputType;
  bool enabled;
  bool readOnly;
  TextAlign? textAlign;
  List<TextInputFormatter>? inputFormatters;
  TextStyle? hintStyle;
  bool isPassword;
  final double borderRadius;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      autofocus: true,
      enabled: enabled,
      keyboardType: inputType,
      maxLength: maxLength != 0 ? maxLength : null,
      onChanged: onChanged,
      style: textStyling,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
      validator: onValidate,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: _renderBorder(),
        disabledBorder: _renderBorder(),
        focusedBorder: _renderBorder(),
        enabledBorder: _renderBorder(),
        label:Text(
          labelText ?? "",
          style: labelStyling,
        ),
        hintText: hintText,
        hintStyle: hintStyle ,
        filled: true,
        fillColor: backgroundColor,
        errorStyle: Theme.of(context).textTheme.caption?.copyWith(color: errorColor!),
        helperMaxLines: 1,
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
    );
  }

  OutlineInputBorder _renderBorder() =>
      OutlineInputBorder(
        borderRadius:  BorderRadius.circular(12.r),
        borderSide:  BorderSide(color: borderColor!),
      );

}

class MetaTextFieldBlocView extends StatelessWidget {
  MetaTextFieldBlocView({Key? key,
    this.controller,
    required this.mapData,
    required this.onChanged,
    required this.textFieldBloc,
     this.isEnabled=true,
  })
      : super(key: key);
  Map mapData;
  TextEditingController? controller;
  Function(String)? onChanged;
  TextFieldBloc textFieldBloc;
  bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextFieldBlocBuilder(
      key: UniqueKey(),
      textFieldBloc: textFieldBloc,
      //controller:controller,
      autofocus: false,
    //  enabled: mapData['enabled'],
      keyboardType: ParseDataType().getInputType(mapData['inputType'] ?? "") ,
      maxLength: mapData['maxLength'] ?? null,
    //  onChanged: onChanged,
     // suffixButton:mapData['isPassword'] ? SuffixButton.obscureText: SuffixButton.clearText,
      obscureText: mapData['isPassword']  ?? false,
      obscureTextTrueIcon: Icon(Icons.remove_red_eye,
          color: ParseDataType().getHexToColor(FlavourConstants.appThemeData['cursor_color'])),
      textStyle: MetaStyle(mapData: mapData['text']).getStyle() ,
      inputFormatters: mapData['inputFormatters']  ?? [],
      maxLines:  mapData['maxLines'] ?? 1 ,
     // autovalidateMode: AutovalidateMode.disabled,
      isEnabled: isEnabled,
      decoration: InputDecoration(
        isDense: true,
     //   enabled: mapData['readOnly'] ?? isEnabled,
        contentPadding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        border: _renderBorder(),
     // disabledBorder: _renderBorder(),
        focusedBorder: _renderBorder(),
        enabledBorder: _renderBorder(),
        label: MetaTextView(mapData: mapData['labelText']),
        hintText: mapData['hintText']['text'],
        hintStyle: MetaStyle(mapData: mapData['hintText']).getStyle() ,
        filled: true,
        fillColor:ParseDataType().getHexToColor(mapData['backgroundColor'] ?? "0xFFFFFFFF"),
        errorStyle: MetaStyle(mapData: mapData['errorText']).getStyle(),
        suffixIcon: mapData['suffixIcon'] ?? null,
      ),
      readOnly: mapData['readOnly'] ?? false,
      cursorColor:ParseDataType().getHexToColor(FlavourConstants.appThemeData['cursor_color']),
    );
  }

  UnderlineInputBorder _renderBorder() =>
      UnderlineInputBorder(borderSide:BorderSide(color:ParseDataType().getHexToColor(mapData['borderColor'] ?? "0xFFFFFFFF")));

}

class MetaTextFieldView extends StatelessWidget {
  MetaTextFieldView({Key? key,
    this.controller,
    required this.mapData,
    required this.onChanged,
  })
      : super(key: key);
  Map mapData;
  TextEditingController? controller;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: UniqueKey(),
      controller:controller,
      autofocus: false,
      keyboardType: ParseDataType().getInputType(mapData['inputType'] ?? "") ,
      maxLength: mapData['maxLength'] ?? null,
      obscureText: mapData['isPassword']  ?? false,
      style:  MetaStyle(mapData: mapData['text']).getStyle(),
      inputFormatters: mapData['inputFormatters']  ?? [],
      maxLines:  mapData['maxLines'] ?? 1 ,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        border: _renderBorder(),
        // disabledBorder: _renderBorder(),
        focusedBorder: _renderBorder(),
        enabledBorder: _renderBorder(),
        label: MetaTextView(mapData: mapData['labelText']),
        hintText: mapData['hintText']['text'],
        hintStyle: MetaStyle(mapData: mapData['hintText']).getStyle() ,
        filled: true,
        fillColor:ParseDataType().getHexToColor(mapData['backgroundColor'] ?? "0xFFFFFFFF"),
        errorStyle: MetaStyle(mapData: mapData['errorText']).getStyle(),
        suffixIcon: mapData['suffixIcon'] ?? null,
      ),
      readOnly: mapData['readOnly'] ?? false,
      cursorColor:ParseDataType().getHexToColor(FlavourConstants.appThemeData['cursor_color']),
    );
  }

  UnderlineInputBorder _renderBorder() =>
      UnderlineInputBorder(borderSide:BorderSide(color:ParseDataType().getHexToColor(mapData['borderColor'] ?? "0xFFFFFFFF")));

}
