import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/common_text_messages.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? minLines;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool? autoFocus;
  final String hintText;
  final Color? fillColor;
  final String textFieldType;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? enableBorder;
  final InputBorder? focusBorder;
  final InputBorder? errorBorder;
  final BoxConstraints? prefixIconConstraints;
  final TextCapitalization? textCapitalization;
  final String? initialValue;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  const MyTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.onTap,
    this.keyboardType,
    this.obscureText,
    this.minLines,
    this.maxLines,
    this.onChanged,
    this.autoValidateMode,
    this.textInputAction,
    this.readOnly,
    this.textStyle,
    this.hintTextStyle,
    this.maxLength,
    this.validator,
    this.autoFocus,
    required this.hintText,
    this.fillColor,
    required this.textFieldType,
    this.contentPadding,
    this.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.enableBorder,
    this.focusBorder,
    this.errorBorder,
    this.prefixIconConstraints,
    this.textCapitalization,
    this.initialValue,
    this.errorText,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      spellCheckConfiguration: SpellCheckConfiguration(
        spellCheckService: DefaultSpellCheckService(),
      ),
      obscureText: obscureText ?? false,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      onSaved: onSaved,
      focusNode: focusNode,
      autovalidateMode: autoValidateMode,
      readOnly: readOnly ?? false,
      autocorrect: false,
      textInputAction: textInputAction ?? TextInputAction.next,
      textAlign: TextAlign.left,
      style: textStyle ?? TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'ReadexPro', color: Colors.black),
      maxLength: maxLength,
      buildCounter: (context, {required int currentLength, required bool isFocused, required int? maxLength}) {
        return null; // Hide the max length counter
      },
      validator: validator,
      autofocus: autoFocus ?? false,
      cursorColor: Colors.blue,
      mouseCursor: MouseCursor.uncontrolled,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      initialValue: initialValue,
      inputFormatters: inputFormatters ?? inputFormattersFun(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle().copyWith(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w300,

            ),
        errorMaxLines: 5,
        errorText: (errorText?.isNotEmpty ?? false) ? errorText : null,
        fillColor: fillColor,
        filled: true,
        enabled: enabled ?? true,
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(10, 18, 10, 18),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        suffixIcon: suffixIcon,
        errorStyle: TextStyle().copyWith(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w300,
              color: Colors.red,
              // fontSize: 10.sp,
            ),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))),
        border: border ?? const OutlineInputBorder(borderSide: BorderSide(color:  Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color:  Colors.black, width: 1), borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: focusBorder ?? const OutlineInputBorder(borderSide: BorderSide(color:  Colors.black, width: 1), borderRadius: BorderRadius.all(Radius.circular(10))),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color:  Colors.black), borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }

  List<TextInputFormatter> inputFormattersFun() {
    final CommonTextMessages validate = CommonTextMessages();

    if (textFieldType == validate.nameFormat) {
      return [
        LengthLimitingTextInputFormatter(35),
        NoLeadingSpaceFormatter(),
        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9 .,-]")),
      ];
    } else if (textFieldType == validate.emailFormat) {
      return [
        NoLeadingSpaceFormatter(),
        LowerCaseTextFormatter(),
        FilteringTextInputFormatter.deny(RegExp("[ ]")),
        FilteringTextInputFormatter.allow(RegExp("[a-zá-ú0-9.,-_@]")),
        LengthLimitingTextInputFormatter(50),
      ];
    } else if (textFieldType == validate.passFormat) {
      return [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.deny(RegExp('[ ]')),
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Zá-úÁ-Ú0-9-@\$%&#*]")),
      ];
    } else if (textFieldType == validate.numberFormat) {
      return [
        NoLeadingSpaceFormatter(),
        FilteringTextInputFormatter.allow(RegExp("[0-9,+]")),
      ];
    } else if (textFieldType == validate.textFormat) {
      return [
        FilteringTextInputFormatter.allow(RegExp("[a-zá-ú0-9.,-_@ ]")),
        LengthLimitingTextInputFormatter(200),
      ];
    } else if (textFieldType == validate.descriptionFormat) {
      return [
        NoLeadingSpaceFormatter(),
        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9 .,-@\$%&#*]")),
      ];
    } else if (textFieldType == "all") {
      return [NoLeadingSpaceFormatter(), LengthLimitingTextInputFormatter(12)];
    } else {
      return [
        NoLeadingSpaceFormatter(),
      ];
    }
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toLowerCase(), selection: newValue.selection);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}

Widget textFieldHeader(title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title,

    ),
  );
}
