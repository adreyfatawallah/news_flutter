class MyIcons {
  MyIcons._();

  static const _baseIcons = 'assets/icons/';

  // static const flagId = "${_baseIcons}flag_id.svg";
  // static const flagEn = "${_baseIcons}flag_en.svg";
  static String getFlag(String code) => '${_baseIcons}flag_$code.svg';
}
