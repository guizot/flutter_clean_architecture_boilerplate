import 'package:flutter_clean_architecture/presentation/pages/form/model/form_content.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_values.dart';

import '../model/form_item.dart';

class FormValidation {

  dynamic getContentValue(String key, List<FormContent> content) {
    if(content.isNotEmpty) {
      FormContent? foundItem = content.firstWhere((item) => item.label == key);
      return foundItem.value;
    } else {
      return '';
    }
  }

  bool checkFormItem(FormItem item) {
    return
      item.value == null ||
      item.value == "" ||
      item.value == "No Data" ||
      item.value == false ||
      (item.type == FormValues.slider && item.value == getContentValue('min', item.content)) ||
      (item.type == FormValues.textField && (getContentValue('type', item.content)).toString() == 'email' && checkIsEmail(item.value) != null) ||
      (item.value is List && item.value.isEmpty);
  }

  bool checkFormItems(List<FormItem> items) {
    bool isValid = true;
    for (var item in items) {
      try {
        if (checkFormItem(item)) {
          if(item.required) {
            item.error = true;
            isValid = false;
          } else {
            item.error = false;
          }
        } else {
          item.error = false;
        }
      } catch(e) {
        item.error = true;
        isValid = false;
      }
    }
    return isValid;
  }

  String? checkIsEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

}