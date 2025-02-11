class Validator {

  verifEmail(value) {
    // verify email
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return "Veuillez entrer un email valide";
    }
    return null;
  }
}