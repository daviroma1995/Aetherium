// ignore_for_file: constant_identifier_names
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../models/language_model.dart';

class AppConstants {
  // Localiztion data

  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: 'en_img',
      languageName: 'English',
      languageCode: 'en',
      countryCode: 'US',
    ),
    LanguageModel(
      imageUrl: 'pk_img',
      languageName: 'Urdu',
      languageCode: 'ur',
      countryCode: 'Pk',
    )
  ];
}

class AppColors {
  static const PRIMARY_COLOR = Color(0XFF43231B);
  static const SECONDARY_COLOR = Color(0XFFA08960);
  static const WHITE_COLOR = Color(0XFFFFFFFF);
  static const BLACK_COLOR = Color(0XFF2A2B30);
  static const GREY_COLOR = Color(0XFFB8B8B8);
  static const GREY_DARK = Color(0xff6a6a6a);
  static const BORDER_COLOR = Color(0XFFE2E8F0);
  static const BACKGROUND_COLOR = Color(0XFFFCFCFC);
  static const SECONDARY_LIGHT = Color(0XFFDDCBAA);
  static const BACKGROUND_DARK = Color(0XFF1A1B26);
  static const PRIMARY_DARK = Color(0XFF232535);
  static const NAVIGATION_BAR_DARK = Color(0XFF15151E);
  static const ERROR_COLOR = Colors.redAccent;
  static const CANCELED_COLOR = Color(0XFFF3C2C2);
  static const DARK_CANCELED_COLOR = Color(0X48F3C2C2);
  static const ARCHIVED_COLOR = Color(0XFFDDCBAA);
  static const DARK_ARCHIVED_COLOR = Color(0X48DDCBAA);
  static const NO_SHOW_COLOR = Color(0XFFC3FFF8);
  static const DARK_NO_SHOW_COLOR = Color(0X48C3FFF8);
  static const CONFIRMED_COLOR = Color(0XFF85BC9E);
  static const DARK_CONFIRMED_COLOR = Color(0X4885BC9E);
  static const PROGRESS_COLOR = Color(0XFFB8A27B);
  static const CARD_COLOR = Color(0XFFFDF9F8);
  static const SHADOW_COLOR = Color.fromRGBO(186, 186, 186, .25);
  static const TEXT_FIELD_HINT_TEXT = Color(0xff939393);

  static const GREEN_COLOR = Color(0xff57CE63);
}

class AppAssets {
  static const SPLASH_TOP_IMAGE = 'assets/images/splash_top.png';
  static const SPLASH_TOP_IMAGE_DARK = 'assets/images/splash_top_dark.png';
  static const SPLASH_BOTTOM_IMAGE = 'assets/images/splash_bottom.png';
  static const SPLASH_BOTTOM_IMAGE_DARK =
      'assets/images/splash_bottom_dark.png';
  static const SPLASH_LOGO_IMAGE = 'assets/images/logo.png';
  static const SPLASH_LOGO_IMAGE_DARK = 'assets/images/splash_logo_dark.png';
  static const SPLASH_TEXT = 'assets/images/splash_text.svg';
  static const SPLASH_TOP = 'assets/images/splash_top.svg';
  static const SPLASH_BOTTOM = 'assets/images/splash_bottom.svg';
  static const JADE_ROLLER = 'assets/images/onboarding/jade_roller.svg';
  static const PIMPLE_PATCHES = 'assets/images/onboarding/pimple_patches.svg';
  static const SKIN_CARE = 'assets/images/onboarding/skin_care.svg';
  static const SCREEN_ONE_CURVE = 'assets/images/onboarding/screen_one.svg';
  static const SCREEN_TWO_CURVE = 'assets/images/onboarding/screen_two.svg';
  static const SCREEN_THREE_CURVE = 'assets/images/onboarding/screen_three.svg';
  static const LOGIN_TOP_BAR = 'assets/images/onboarding/login_top_bar.svg';
  static const TOP_BAR_LOGO = 'assets/images/onboarding/top_bar_logo.svg';
  static const BACK_ARROW = 'assets/images/icons/back_arrow.svg';
  static const RIGHT_ARROW = 'assets/images/icons/arrow_right.svg';
  static const LOCK_ICON = 'assets/images/icons/lock_icon.svg';
  static const MESSAGE_ICON = 'assets/images/icons/message_icon.svg';
  static const SEARCH_ICON = 'assets/images/icons/search_icon.svg';
  static const MIRROR_ICON = 'assets/images/icons/mirror_icon.svg';
  static const DARK_MIRROR_ICON = 'assets/images/icons/dark_service_1.svg';
  static const HAIR_ICON = 'assets/images/icons/hair_icon.svg';
  static const DARK_HAIR_ICON = 'assets/images/icons/dark_sercie_2.svg';
  static const PORCELAIN_ICON = 'assets/images/icons/porcelain_icon.svg';
  static const DARK_PORCELAIN_ICON = 'assets/images/icons/dark_service_3.svg';
  static const EMERGENT_ICON = 'assets/images/icons/emergent_icon.svg';
  static const DARK_EMERGENT_ICON = 'assets/images/icons/dark_service_4.svg';

  static const PROFILE_IMAGE_ONE = 'assets/images/png/profile_image_1.png';
  static const PROFILE_IMAGE_TWO = 'assets/images/png/profile_image_2.png';
  static const CLOCK_ICON = 'assets/images/icons/clock_icon.svg';
  static const CALANDER_ICON = 'assets/images/icons/calender_icon.svg';
  static const CALANDER_ICON_BUTTON = 'assets/images/icons/calender_button.svg';
  static const PLUS_ICON = 'assets/images/icons/plus_icon.svg';
  static const HOME_ICON = 'assets/images/icons/home.svg';
  static const HOME_ICON_SOLID = 'assets/images/icons/home_solid.svg';
  static const PEN_ICON = 'assets/images/icons/pen_outlined.svg';
  static const PEN_ICON_SOLID = 'assets/images/icons/pen_solid.svg';
  static const DEBIT_CARD_ICON = 'assets/images/icons/debit_card_outlined.svg';
  static const DEBIT_CARD_ICON_SOLID =
      'assets/images/icons/debit_card_solid.svg';
  static const PROFILE_ICON = 'assets/images/icons/profile_outlined.svg';
  static const PROFILE_ICON_SOLID = 'assets/images/icons/profile_solid.svg';
  static const CUP_ICON = 'assets/images/icons/cup_icon.svg';
  static const INVITE_FRIENDS_ICON =
      'assets/images/icons/invite_firends_icon.svg';
  static const PRIMO_SUCCESS_ICON =
      'assets/images/icons/primo_success_icon.svg';
  static const CONSULTATIONS_ICON = 'assets/images/icons/clipboard.svg';

  static const PROFILE_INFO_ICON = 'assets/images/icons/info.svg';
  static const USER_PLUS = 'assets/images/icons/user_plus.svg';

  static const EVENT_IMAGE_ONE =
      'https://images.unsplash.com/photo-1605497788044-5a32c7078486?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80';
  static const EVENT_IMAGE_TWO =
      'https://images.unsplash.com/photo-1593702295094-aea22597af65?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';
  static const EVENT_IMAGE_THREE =
      'https://images.unsplash.com/photo-1593702275687-f8b402bf1fb5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';
  static const USER_IMAGE = 'assets/images/user_image.jpg';
  static const MAKEUP_IMAGE = 'assets/images/make_up.jpg';
  static const BELL_ICON = 'assets/images/icons/bell_icon.svg';
  static const SETTINGS_ICON = 'assets/images/icons/settings_icon.svg';
  static const EXIT_ICON = 'assets/images/icons/exit_icon.svg';
  static const BOOK_ICON = 'assets/images/icons/book_icon.svg';
  static const FILE_ICON = 'assets/images/icons/file_icon.svg';
  static const FILE_MINUS = 'assets/images/icons/file-minus.svg';
  static const ARCHIVE = 'assets/images/icons/archive.svg';
  static const LOCK = 'assets/images/icons/lock.svg';
  static const QRCODE_ICON = 'assets/images/icons/qr_code_icon.svg';
  static const LINES = 'assets/images/icons/lines.svg';

  static const CROWN_ICON = 'assets/images/icons/crown_icon.svg';
  static const SHIELD_ICON = 'assets/images/icons/shield_icon.svg';
  static const PDF_ICON = 'assets/images/icons/pdf_icon.svg';
  static const CAMERA_ICON = 'assets/images/icons/camera_icon.svg';
  static const ARROW_UP = 'assets/images/icons/arrow_up.svg';
  static const ARROW_DOWN = 'assets/images/icons/arrow_down.svg';
  static const ACOUNTS_INFO_SCREEN_CURVE =
      'assets/images/acount_info_screen_curve.svg';
  static const CHECKED_ICON = 'assets/images/icons/checked_icon.svg';
  static const UNCHECKED_ICON = 'assets/images/icons/unchecked_icon.svg';
  static const PROFILE_PIC = 'assets/images/png/profile-placeholder.png';
  static const CALENDER_ICON_LIGHT =
      'assets/images/icons/calender_iocn_light.svg';
  static const APPOINTMENT_TOP = 'assets/images/backgroundtop.svg';
  static const APPOINTMENT_BOTTOM = 'assets/images/backgroundbottom.svg';
  static const APPOINTMENT_CONFIRM =
      'assets/images/icons/confirm_appointment_icon.svg';
  static const MAP_IMAGE = 'assets/images/map.jpg';
  static const WHATSAPP_ICON = 'assets/images/icons/whatsapp_logo.svg';
  static const DARK_CONFIRM_ICON = 'assets/images/icons/dark_confirm_icon.svg';
  static const INFO_ICON = 'assets/images/icons/info.svg';
  static const THEME_MODE = 'assets/images/icons/theme_mode.svg';
  static const PLUSS_BTN = 'assets/images/icons/add_btn.svg';
  static const CROSS_BTN = 'assets/images/icons/x-circle.svg';
  static const SCAN_ICON = 'assets/images/icons/scan_icon.svg';
}

class AppLanguages {
  static const THEME = 'Change Theme';
  static const NEXT = 'Next';
  static const SCAN = 'Scan';
  static const APP_NAME = 'Aetherium Saloon';
  static const WELCOME_TO = 'Welcome to';
  static const AETHERIUM = 'AETHERIUM';
  static const FRAGRANCES_PERFUMES = 'Fragrances & Perfumes';
  static const ONBOARDING_DESCRIPTION =
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.';
  static const APPDEO = 'AP/Deo';
  static const SKIN_CARE = 'Skin Care';
  static const AVANTI = 'Avanti';
  static const INZIA = 'Inizia';
  static const INVIA = 'Invia';
  static const ACCEDI = 'Accedi';
  static const LOGIN = 'Login';
  static const EMAIL = 'Email';
  static const PASSWORD = 'Password';
  static const FORGET_PASSWORD = 'Forget Password';
  static const EMAIL_IS_NOT_VALID = 'Email is not valid';
  static const EMAIL_SHOULD_NOT_BE_EMPTY = 'Email should not be empty';
  static const PASSWORD_MUST_BE_8_CHARACTERS_LONG =
      'Password must be 8 characters long';
  static const WELCOME = 'Welcome';
  static const LOYALITY_CARD = 'Loyalty card';
  static const POINTS_COLLECTED = 'Points Collected';
  static const PRIMO = 'Primo';
  static const ACTIVE_PRIMO = 'Active Primo';
  static const POINTS = 'Points';
  static const NAME = 'Name';
  static const SURNAME = 'Surname';
  static const LEVEL = 'Level';
  static const EXPIRY_DATE = 'Expiry Date';
  static const BASIC = 'Basic';
  static const INVITE_FRIENDS = 'Invite Friends';
  static const INVITATION_DESCRIPTION =
      'Bring a Friend to the Shop and get 25 points';
  static const MY_APPOINTMENTS = 'My Appointments';
  static const UPCOMING_APPOINTMENTS = 'Upcoming Appointments';

  static const NEWCLIENT = 'Nuovo Cliente';
  static const CLIENT_DETAILS = 'Dettaglio Cliente';
  static const SETTINGS = 'Settings';
  static const CONSULTATIONS = 'Consultations';
  static const NOTIFICATIONS = 'Notifiche';
  static const NOTIFICATION_SETTINGS = 'Notification';

  static const ACCOUNT_INFO_DETAIL = 'My Information';
  static const LOGOUT = 'Logout';
  static const PROFILE = 'Profile';
  static const TERMS_OF_SERVICE = 'Terms of service';
  static const TERMS_OF_USE = 'Terms of use';
  static const PRIVACY = 'Privacy';
  static const PHONE_NUMBER = 'Telefono';
  static const GENDER = 'Gender';
  static const ADDRESS = 'Address';
  static const BIRTHDAY = 'Birthday';
  static const APPOINTMENTS = 'Appointments';
  static const APPOINTMENT_DESCRIPTION =
      'Discover and book beauty & wellness professionals near you. Your scheduled appointments will show up here.';
  static const EMPTY_AGENDA_MESSAGE =
      'Clicca sul bottone in basso a destra pereffettuare una nuova prenotazione. Per qualsiasi dubbio o domanda, contattaci pure tramite mail o WhatsApp, puoi trovare tutte le informazioni nella sezione contatti, andando sul tuo profilo utente.';
  static const SERVICES_TREATMENTS = 'Services/Treatments';
  static const CHOOSE_DATE_AND_TIME = 'Choose Date & Time';
  static const AVAILABLE_SLOT = 'Available Slot';
  static const ADDED_APPOINTMENT = 'Added Appointment';
  static const CONFIRM_APPOINTMENT = 'Confirm Appointment';
  static const CONGRATS = 'Congratulazioni!';

  static const YOUR_APPOINTMENT = 'Your appointment';
  static const CLIENT_CREATION_MESSAGE_I = 'Il tuo cliente è stato creato,';
  static const CLIENT_CREATION_MESSAGE_II = ' complimenti!';

  static const BOOKING_IS_SUCCESSFULLY = 'booking is successfully!';

  static const APPOINTMENT_DETAILS = 'Appointlments - Details';
  static const SERVICE_TREATMENT_DURATION = 'Service/Treatment Duration';
  static const SERVICE_TREATMENT_CATEGORY = 'Service Treatment Category';
  static const PRICE = 'Price';
  static const TOTAL_PRICE = 'Total Price';
  static const SHOP_PHONE = 'shop Ph';
  static const NOTES = 'Note:';
  static const APPOINTMENT_DETAILS_DESC =
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit.';
  static const CANCEL = 'Cancel';
  static const EDIT = 'Edit';
  static const FLOURISH_ESSENTIALS = 'Flourish Essentials';
  static const CONTACTS = 'Contacts';
  static const TIME = 'Time';
  static const OPENING_HOURS_OF_THE_SHOP = 'Orari di apertura';
  static const DESCRIPTION = 'Descrizione';
  static const BEAUTY_SPECIALIST = 'Beauty Specialist';
  static const AppuntamentoDettagli = 'Appuntamento - Dettagli';
  static const APPOINTMENTCONFERMA = 'Appuntamento - Conferma';
  static const SELECT_CLIENT = 'Seleziona Cliente';
  static const INCREASE_TOTAL_DURATION = 'Increase Total Duration By';
}

class AppTextStyle {
  static const heading1Light = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
    color: AppColors.BLACK_COLOR,
  );
  static const heading1Bold = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
    color: AppColors.BLACK_COLOR,
  );
}

class Secret {
  static const ANDROID_CLIENT_ID =
      "216835986009-qs954okm7fe307m5b373i0p88m8eh3bq.apps.googleusercontent.com";
  static const IOS_CLIENT_ID =
      "216835986009-tg5lod101ur4fkoj3jted3v63krjgsl5.apps.googleusercontent.com";
  static String getId() =>
      Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
