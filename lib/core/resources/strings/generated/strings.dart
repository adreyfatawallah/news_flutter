import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'strings_en.dart';
import 'strings_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Strings
/// returned by `Strings.of(context)`.
///
/// Applications need to include `Strings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Strings.localizationsDelegates,
///   supportedLocales: Strings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Strings.supportedLocales
/// property.
abstract class Strings {
  Strings(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Strings? of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  static const LocalizationsDelegate<Strings> delegate = _StringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @lbl_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lbl_english;

  /// No description provided for @lbl_indonesia.
  ///
  /// In en, this message translates to:
  /// **'Indonesia'**
  String get lbl_indonesia;

  /// No description provided for @lbl_language.
  ///
  /// In en, this message translates to:
  /// **'Language:'**
  String get lbl_language;

  /// No description provided for @lbl_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme:'**
  String get lbl_theme;

  /// No description provided for @lbl_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get lbl_welcome;

  /// No description provided for @lbl_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get lbl_username;

  /// No description provided for @lbl_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get lbl_password;

  /// No description provided for @lbl_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get lbl_confirm_password;

  /// No description provided for @lbl_please_wait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get lbl_please_wait;

  /// No description provided for @hint_username.
  ///
  /// In en, this message translates to:
  /// **'Enter Username'**
  String get hint_username;

  /// No description provided for @hint_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get hint_password;

  /// No description provided for @btn_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get btn_login;

  /// No description provided for @btn_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get btn_register;

  /// No description provided for @msg_username_empty.
  ///
  /// In en, this message translates to:
  /// **'Username is empty'**
  String get msg_username_empty;

  /// No description provided for @msg_username_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get msg_username_not_valid;

  /// No description provided for @msg_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Password is empty'**
  String get msg_password_empty;

  /// No description provided for @msg_password_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 5 characters'**
  String get msg_password_not_valid;

  /// No description provided for @msg_confim_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Confirm password empty'**
  String get msg_confim_password_empty;

  /// No description provided for @msg_confim_password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Password not match'**
  String get msg_confim_password_not_match;

  /// No description provided for @msg_server_failure.
  ///
  /// In en, this message translates to:
  /// **'Failure connect to the server'**
  String get msg_server_failure;

  /// No description provided for @msg_login_success.
  ///
  /// In en, this message translates to:
  /// **'Welcome {username}...'**
  String msg_login_success(String username);

  /// No description provided for @msg_login_failure.
  ///
  /// In en, this message translates to:
  /// **'Username or password does not match'**
  String get msg_login_failure;

  /// No description provided for @msg_register_success.
  ///
  /// In en, this message translates to:
  /// **'Register success'**
  String get msg_register_success;

  /// No description provided for @msg_register_failure.
  ///
  /// In en, this message translates to:
  /// **'Username already exist'**
  String get msg_register_failure;
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return StringsEn();
    case 'id':
      return StringsId();
  }

  throw FlutterError(
    'Strings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
