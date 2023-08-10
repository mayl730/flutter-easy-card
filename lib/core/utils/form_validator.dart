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