class CommonTextMessages {
  CommonTextMessages._internalConstructor();

  static final CommonTextMessages _instance = CommonTextMessages._internalConstructor();

  factory CommonTextMessages() {
    return _instance;
  }

  ///TextFiled Format
  final String nameFormat = "name";
  final String emailFormat = "email";
  final String passFormat = "password";
  final String numberFormat = "number";
  final String descriptionFormat = "description";
  final String textFormat = "text";
  final String exDateFormat = "exDate";
  final String cardNoFormat = "cardNumber";
}
