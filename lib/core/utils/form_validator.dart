String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  final emailRegex =
      RegExp(r'^[\w-]+(?:\.[\w-]+)*@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  if (!emailRegex.hasMatch(value)) {
    return 'Invalid email format';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  if (value.contains(' ')) {
    return 'Password should not contain spaces';
  }

  if (value.length > 32) {
    return 'Password should not exceed 32 characters';
  }
  if (value.length < 8) {
    return 'Password should be at least 8 characters';
  }

  return null;
}

String? validateWebURL(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  if (value.length > 255) {
    return 'Should not exceed 255 characters';
  }

  return null;
}

String? validateStringOptional(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  if (value.length > 60) {
    return 'Should not exceed 60 characters';
  }

  return null;
}

String? validateStringRequired(String? value) {
  if (value == null || value.isEmpty) {
    return 'Should not be empty';
  }

  if (value.length > 60) {
    return 'Should not exceed 60 characters';
  }

  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  final phoneRegex = RegExp(r'^\+?[0-9]{8,}$');

  if (!phoneRegex.hasMatch(value)) {
    return 'Invalid phone number format';
  }

  return null;
}
