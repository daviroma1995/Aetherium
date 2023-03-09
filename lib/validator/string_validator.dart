class StringUtils {
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Inserisci una Password';
    }
    if (value.length < 6) {
      return 'La password deve contenere almeno 6 caratteri';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if ((value!.isEmpty || !value.contains('@'))) {
      return 'Inserire una mail valida';
    }
    return null;
  }
}
