class EPValidator {
  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 8) {
      return 'Enter a password with length at least 8';
    }

    return null;
  }
}

class AccRecValidator {
  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateAmount({required String name}) {
    if (name.isEmpty) {
      return 'Amount can\'t be empty';
    }

    return null;
  }
}

class GoalValidator {
  static String? validateGPercent({required String gPercent}) {
    double? percent = double.tryParse(gPercent);

    if (percent! < 0) {
      return 'Goal percent must be in range 0-100';
    } else if (percent > 100) {
      return 'Goal percent must be in range 0-100';
    }
    return null;
  }

  static String? validateGAmount({required String gAmount}) {
    double? amount = double.tryParse(gAmount);

    if (amount! < 0) {
      return 'Goal amount must exceed 0';
    }

    return null;
  }

  static String? validateDayMonth({required String gTime}) {
    double? time = double.tryParse(gTime);

    if (time! < 0) {
      return 'Value must be in range 0-1000';
    } else if (time > 1000) {
      return 'Value must be in range 0-1000';
    }
    return null;
  }

  static String? validateYear({required String gTime}) {
    double? time = double.tryParse(gTime);

    if (time! < 0) {
      return 'Value must be in range 0-100';
    } else if (time > 100) {}
    return null;
  }
}
