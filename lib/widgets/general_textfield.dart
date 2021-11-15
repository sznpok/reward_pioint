import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reward_calculator/constant/color_constant.dart';

class GeneralTextField extends StatefulWidget {
  final String? labelText;
  final String? suffixText;
  final String? hintText;
  final bool isSmallText;
  final IconData? suffixIcon;
  final Widget? preferWidget;
  final bool obscureText;
  final bool removePrefixIconDivider;
  final VoidCallback? onClickPsToggle;
  final TextInputType keywordType;
  final Function validate;
  final Function onFieldSubmit;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Function onSave;
  final Function? onChanged;
  final TextEditingController? controller;
  final bool readonly;
  final int? maxLength;
  final double? borderRad;

  const GeneralTextField({
    Key? key,
    this.labelText,
    this.suffixIcon,
    this.borderRad,
    this.preferWidget,
    this.suffixText,
    required this.obscureText,
    this.onClickPsToggle,
    required this.keywordType,
    required this.validate,
    required this.onFieldSubmit,
    required this.textInputAction,
    this.readonly = false,
    this.focusNode,
    required this.onSave,
    this.controller,
    this.onChanged,
    this.removePrefixIconDivider = false,
    this.isSmallText = false,
    this.maxLength,
    this.hintText,
  }) : super(key: key);

  @override
  _GeneralTextFieldState createState() => _GeneralTextFieldState();
}

class _GeneralTextFieldState extends State<GeneralTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged == null
          ? (_) {}
          : (newValue) => widget.onChanged!(newValue),
      controller: widget.controller,
      onSaved: (newValue) => widget.onSave(newValue),
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: (newValue) => widget.onFieldSubmit(newValue),
      validator: (value) => widget.validate(value),
      keyboardType: widget.keywordType,
      readOnly: widget.readonly,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
