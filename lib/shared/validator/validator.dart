import 'package:projecttas_223200007/shared/formatter/formatter.dart';

class Validator {
  static String? nama(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Nama is required';
    }
    return null;
  }

  static String? description(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Description is required';
    }
    return null;
  }

  static String? price(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Price is required';
    }
    final isValidPrice = RegExp(r'^[1-9]\d*$').hasMatch(value!);
    if (!isValidPrice) {
      return 'Price must be a valid non-zero positive integer';
    }

    return null;
  }

  static String? priceMinimun(String? value, String? minimum) {
    if (value?.isEmpty ?? true) {
      return 'Price is required';
    }
    final isValidPrice = RegExp(r'^[1-9]\d*$').hasMatch(value!);
    if (!isValidPrice) {
      return 'Price must be a valid non-zero positive integer';
    }
    if (double.parse(value) < double.parse(minimum ?? '0')) {
      return 'Price must be at least ${Formatter.formatRupiah(int.parse(minimum ?? '0'))}';
    }

    return null;
  }

  static String? quantity(String? value) {
    if (value?.isEmpty ?? true) {
      return 'quantity is required';
    } else if (value!.startsWith('0')) {
      return 'quantity is not start 0';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Quantity must be a valid non-zero positive integer';
    }

    return null;
  }

  static String? imageUrl(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Image URL is required';
    }
    return null;
  }

  static String? address(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Address is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    } else if (value!.length < 12) {
      return 'Email is too short, it must be at least 12 characters';
    } else if (value.length > 55) {
      return 'Email is too long, it must be at most 55 characters';
    } else if (!RegExp(r'^[A-Za-z0-9.]+@gmail\.com$').hasMatch(value)) {
      return 'Email is not valid';
    }
    return null;
  }

  static String? password(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Password is required';
    } else if (value!.length < 6) {
      return 'Password is too short, it must be at least 6 characters';
    } else if (value.length > 55) {
      return 'Password is too long, it must be at most 55 characters';
    }
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Phone number is required';
    } else if (value!.length < 12) {
      return 'Phone number is too short, it must have at least 12 digits';
    } else if (value.length > 15) {
      return 'Phone number is too long, it can have at most 15 digits';
    } else if (!value.startsWith('08')) {
      return 'Phone number is not valid, Phone number start with "08"';
    } else if (!RegExp(r'^08[0-9]*$').hasMatch(value)) {
      return 'The remaining characters must be digits (0-9)';
    }
    return null;
  }
}
