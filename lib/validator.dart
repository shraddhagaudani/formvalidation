// ignore_for_file: prefer_is_empty

import 'package:flutter/services.dart';
import 'package:get/utils.dart';

//check validation for email field value
String? validateEmailField(String? value) {
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value == null || value.isEmpty) {
    return "Please enter your email address".tr;
  } else if (!emailValid.hasMatch(value)) {
    return "Please provide a valid email address".tr;
  }
  return null;
}

//check validation for field value
String? validateString(String value, String type) {
  if (value.isEmpty) {
    return "Please enter $type";
  } else if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return null;
  } else {
    return "$type can only contain alphabets";
  }
}

//check validation for phone number field value
String? validateMobileField(String? value) {
  if (value!.isEmpty) {
    return "PhoneNumber is required";
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter phone number';
  }
  // Check if the value matches the required format
  final RegExp phoneRegExp = RegExp(r'^\(\d{3}\) \d{3}-\d{4}$');
  if (!phoneRegExp.hasMatch(value)) {
    return 'Please enter a valid phone number in the correct format.';
  }
  return null;
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters from the input
    String filtered = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Check if the filtered input length exceeds the max allowed length
    if (filtered.length > 10) {
      filtered = filtered.substring(0, 10);
    }

    // Format the phone number
    String formatted = '';
    if (filtered.length >= 1) {
      formatted += '(${filtered.substring(0, filtered.length > 3 ? 3 : filtered.length)}';
    }
    if (filtered.length >= 4) {
      formatted += ') ${filtered.substring(3, filtered.length > 6 ? 6 : filtered.length)}';
    }
    if (filtered.length >= 7) {
      formatted += '-${filtered.substring(6, filtered.length)}';
    }

    // Return the formatted value
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CapitalizeWordsFormatter extends TextInputFormatter {
  final RegExp _allowedChars = RegExp(r'[a-zA-Z\s]');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String text = newValue.text;

    // Filter out any disallowed characters (anything that isn't a letter or a space)
    final String filteredText = text.split('').where((char) => _allowedChars.hasMatch(char)).join('');

    // Capitalize the first letter of each word
    final String capitalizedText = filteredText.split(' ').map((word) =>
    word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '').join(' ');

    return newValue.copyWith(
      text: capitalizedText,
      selection: newValue.selection,
    );
  }
}


String formatPhoneNumber(String phoneNumber) {
  // Remove all non-digit characters from the input
  String digits = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // Check if the number has exactly 10 digits
  if (digits.length != 10) {
    throw ArgumentError('The phone number must contain exactly 10 digits.');
  }

  // Extract area code, first three digits, and last four digits
  String areaCode = digits.substring(0, 3);
  String firstThree = digits.substring(3, 6);
  String lastFour = digits.substring(6, 10);

  // Format the phone number as (XXX) XXX-XXXX
  return '($areaCode) $firstThree-$lastFour';
}

class CustomNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Regex to allow only numbers and decimal points
    final regExp = RegExp(r'^\d*\.?\d{0,2}$');

    if (regExp.hasMatch(text)) {
      // Automatically add .00 if only two digits are entered

      return newValue;
    }

    return oldValue;
  }
}

class DiscountFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any invalid characters from the input
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Ensure only one decimal point is present
    if (newText.contains('.') && newText.indexOf('.') != newText.lastIndexOf('.')) {
      newText = newText.substring(0, newText.lastIndexOf('.') + 1) + newText.substring(newText.lastIndexOf('.') + 1).replaceAll('.', '');
    }

    // Split the text into integer and decimal parts
    List<String> parts = newText.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Limit the decimal part to 2 digits
    if (decimalPart.length > 2) {
      decimalPart = decimalPart.substring(0, 2);
    }

    // Combine the integer and decimal parts
    newText = decimalPart.isNotEmpty ? '$integerPart.$decimalPart' : integerPart;

    // Convert to a double and clamp it to the range [0, 100]
    double value = double.tryParse(newText) ?? 0;
    value = value.clamp(0, 100).toDouble();

    // Convert the value back to string with at most 2 decimal places
    newText = value.toStringAsFixed(decimalPart.isNotEmpty ? 2 : 0);

    // Handle cases where value is 0 or 100
    if (value == 0) {
      newText = '0';
    } else if (value == 100) {
      newText = '100';
    }

    // Return the formatted text with updated cursor position
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
