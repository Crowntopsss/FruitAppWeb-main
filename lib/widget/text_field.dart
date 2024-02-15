
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_const.dart';
import 'money_formatter.dart';


Widget customTextFormField(String label,
    {String? hint,
      bool hideInput = false,
      bool showLabel = false,
      bool isWeb = false,
      bool enable = true,
      bool borderless = false,
      TextInputType textInputType = TextInputType.text,
      ValueChanged<String>? onChanged,
      String? prefixText,
      Widget? prefixIcon,
      Widget? suffixIcon,
      TextEditingController? textEditingController,
      int maxLength = 256,
      int maxLines = 1,
      double? width,
      double? height,
      double? fontSize = 14,
      bool moneyInput = false}) {
  return Container(
    width: isWeb? 350: width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: showLabel,
            child: Container(
                padding: EdgeInsets.zero,
                child: Text(
                  label,
                  style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ))),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: height??55,
          width: width,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: borderless? null: Border.all(color: enable? Colors.grey.withOpacity(0.4): Colors.grey.withOpacity(0.4)),
              color: Colors.white),
          child: TextFormField(
            style: GoogleFonts.spaceGrotesk(fontSize: fontSize),
            keyboardType:moneyInput? TextInputType.numberWithOptions(decimal: true):textInputType,
            maxLines: textInputType==TextInputType.multiline? null : maxLines,
            textInputAction: TextInputAction.newline,
            onEditingComplete: () {

            },
            inputFormatters: textInputType== TextInputType.number ?
            [
              FilteringTextInputFormatter.digitsOnly,
              new LengthLimitingTextInputFormatter(maxLength),
            ]:
            [
              new LengthLimitingTextInputFormatter(maxLength),
            ],
            onChanged: onChanged,
            textCapitalization: TextCapitalization.sentences,
            controller: textEditingController,
            cursorColor: Colors.grey,
            obscureText: hideInput,
            enabled: enable,
            decoration: InputDecoration(
              hintText: "",
              contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              labelText: label,
              hintStyle: GoogleFonts.spaceGrotesk(color: Colors.grey, fontSize: 12, height: 0.1),
              labelStyle: GoogleFonts.spaceGrotesk(color: Colors.grey, fontSize: 12, height: 0.8),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              prefixStyle: GoogleFonts.spaceGrotesk(fontSize: 14),
              prefixText: prefixText,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        )
      ],
    ),
  );
}

