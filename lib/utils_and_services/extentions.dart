extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension IDValidator on String {
  bool isValidID() {
    List<int> digits = split('').map((e) => int.parse(e)).toList();

    int lastDigit = digits.removeLast();

    for (int i = 0; i < digits.length; i++) {
      int multiplier = i %2 == 0 ? 1 : 2;
      digits[i] = digits[i] * multiplier;
    }

    String tempID = digits.join();

    List<int> tempIDList = tempID.split('').map((e) => int.parse(e)).toList();

    int tempIDSum = 0;

    for (int i = 0; i < tempIDList.length; i++) {
      tempIDSum += tempIDList[i];
    }

    return 10 - (tempIDSum % 10) == lastDigit;
  }
}