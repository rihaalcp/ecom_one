class LoginPageModel {
  final String appName;
  final String appLogo;
  final String tagline;

  final String welcomeTitle;
  final String welcomeSubtitle;

  final String emailLabel;
  final String emailPlaceholder;

  final String passwordLabel;
  final String passwordPlaceholder;

  final String rememberMeText;
  final String forgotPasswordText;

  final String loginButtonText;

  final bool googleLoginEnabled;
  final bool appleLoginEnabled;

  final String googleButtonText;
  final String appleButtonText;

  LoginPageModel({
    required this.appName,
    required this.appLogo,
    required this.tagline,
    required this.welcomeTitle,
    required this.welcomeSubtitle,
    required this.emailLabel,
    required this.emailPlaceholder,
    required this.passwordLabel,
    required this.passwordPlaceholder,
    required this.rememberMeText,
    required this.forgotPasswordText,
    required this.loginButtonText,
    required this.googleLoginEnabled,
    required this.appleLoginEnabled,
    required this.googleButtonText,
    required this.appleButtonText,
  });
    factory LoginPageModel.fromJson(Map<String, dynamic> json) {
    return LoginPageModel(
      appName: json['appName'],
      appLogo: json['appLogo'],
      tagline: json['tagline'],
      welcomeTitle: json['welcomeTitle'],
      welcomeSubtitle: json['welcomeSubtitle'],
      emailLabel: json['emailLabel'],
      emailPlaceholder: json['emailPlaceholder'],
      passwordLabel: json['passwordLabel'],
      passwordPlaceholder: json['passwordPlaceholder'],
      rememberMeText: json['rememberMeText'],
      forgotPasswordText: json['forgotPasswordText'],
      loginButtonText: json['loginButtonText'],
      googleLoginEnabled: json['googleLoginEnabled'],
      appleLoginEnabled: json['appleLoginEnabled'],
      googleButtonText: json['googleButtonText'],
      appleButtonText: json['appleButtonText'],
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'appLogo': appLogo,
      'tagline': tagline,
      'welcomeTitle': welcomeTitle,
      'welcomeSubtitle': welcomeSubtitle,
      'emailLabel': emailLabel,
      'emailPlaceholder': emailPlaceholder,
      'passwordLabel': passwordLabel,
      'passwordPlaceholder': passwordPlaceholder,
      'rememberMeText': rememberMeText,
      'forgotPasswordText': forgotPasswordText,
      'loginButtonText': loginButtonText,
      'googleLoginEnabled': googleLoginEnabled,
      'appleLoginEnabled': appleLoginEnabled,
      'googleButtonText': googleButtonText,
      'appleButtonText': appleButtonText,
    };
  }
}