import 'package:get/get.dart';

// 'en', 'hi', 'mr', 'ta', 'te', 'kn', 'pa', 'as', 'bn', 'gu', 'hr'
class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => //json;
      {
        "en": {
          "checkAndTryInternetConnectivity":
              "Please check your network connectivity and try again",
          "connectionError": "Connection Error",
          "homeTitle": 'Flyingwolf',
          "tournamentsPlayed": "Tournaments Played",
          "tournamentsWon": "Tournaments Won",
          "winningPercentage": "Winning Percentage",
          "recommendedForYou": "Recommended for you",
          "noRecordFound": "No Record Found",
          "userName": "Username",
          "password": "Password",
          'errorMsg':'should be between 3-11 characters',
          'continue':'Continue',
          'loginError':'Login failed. Invalid username or password.',
          "selectLanguage": "Select Language",
          "selectLanguageTitle": "Please select your language",
          "logoutTitle": "Logout?",
          "logoutConfirm": "Are you sure you want to log out of App?",
          "yes": "Yes",
          "notNow": "Not Now",
        },
        "ja": {
          "checkAndTryInternetConnectivity":
          "ネットワーク接続を確認して、もう一度お試しください",
          "connectionError": "接続エラー",
          "homeTitle": 'Flyingwolf',
          "tournamentsPlayed": "プレーしたトーナメント",
          "tournamentsWon": "トーナメントが勝ちました",
          "winningPercentage": "優勝トーナメント",
          "recommendedForYou": "あなたにおすすめ",
          "noRecordFound": "レコードが見つかりません",
          "userName": "ユーザー名",
          "password": "パスワード",
          'errorMsg':'3〜11文字にする必要があります',
          'continue':'継続する',
          'loginError':'ログインに失敗しました。無効なユーザー名またはパスワード。',
          "selectLanguage": "言語を選択する",
          "selectLanguageTitle": "言語を選択してください",
          "logoutTitle": "ログアウト？",
          "logoutConfirm": "アプリからログアウトしてもよろしいですか？",
          "yes": "はい",
          "notNow": "今はやめろ",
        },
      };
}
