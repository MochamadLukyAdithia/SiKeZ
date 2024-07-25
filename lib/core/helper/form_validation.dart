class FormValidation {
  static String? isValidPassword(String? value) {
    final required = isNotNullAndRequired(value);
    if (required != null) return required;
    if (value!.length <= 7) {
      return "Panjang minimal password adalah 8 huruf";
    }
    return null;
  }

  static String? isNotNullAndRequired(String? value) {
    if (value == null || value.isEmpty) {
      return "Kolom tidak boleh kosong";
    }
    return null;
  }

  static String? isEmail(String? value) {
    final required = isNotNullAndRequired(value);
    if (required != null) return required;
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (!emailValid) {
      return "Email tidak valid";
    }
    return null;
  }
}
