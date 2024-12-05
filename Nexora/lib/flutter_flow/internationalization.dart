import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'de', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? deText = '',
    String? arText = '',
  }) =>
      [enText, esText, deText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // loginPage
  {
    'fzxvw3mu': {
      'en': 'Login to access your account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'a9j78va9': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'i7f18cve': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'wztjmbn8': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'lw1jpm1f': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    '3j719uj2': {
      'en': 'ID company',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lu7dohlq': {
      'en': 'Enter your ID...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm2xyjvuf': {
      'en': 'Forgot Password?',
      'ar': 'هل نسيت كلمة السر؟',
      'de': 'Passwort vergessen?',
      'es': '¿Has olvidado tu contraseña?',
    },
    'qbmoi1av': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
      'de': 'Anmeldung',
      'es': 'Acceso',
    },
    'cjqb8ial': {
      'en': 'Don\'t have an account?',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'a0iimirx': {
      'en': 'Create',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    '2bb3vct7': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // registerAccount
  {
    'gpokmd81': {
      'en': 'Get Started',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'oitrrwgg': {
      'en': 'Create your account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'gcwdqm4g': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'iam0xgwx': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'bqv15dcf': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'joih97mn': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'rzpiwq9p': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'de': 'Kennwort bestätigen',
      'es': 'Confirmar contraseña',
    },
    'eyfkffka': {
      'en': 'Enter your password...',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    '5kmjfwsk': {
      'en': 'Create Account',
      'ar': 'إنشاء حساب',
      'de': 'Benutzerkonto erstellen',
      'es': 'Crear una cuenta',
    },
    '3twynvfz': {
      'en': 'Login',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    '9ssznj0g': {
      'en': 'Already have an account?',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    'momge5oj': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // completeProfile
  {
    'yhcaf7r2': {
      'en': 'Complete Profile',
      'ar': 'الملف الشخصي الكامل',
      'de': 'Vollständiges Profil',
      'es': 'Perfil completo',
    },
    'r6npjsue': {
      'en': 'Upload a photo for us to easily identify you.',
      'ar': 'قم بتحميل صورة لنا للتعرف عليك بسهولة.',
      'de':
          'Laden Sie ein Foto hoch, damit wir Sie leicht identifizieren können.',
      'es': 'Sube una foto para que te identifiquemos fácilmente.',
    },
    'sdptn7dd': {
      'en': 'Your Name',
      'ar': 'اسمك',
      'de': 'Dein Name',
      'es': 'Tu nombre',
    },
    'n636qnrx': {
      'en': 'Your Age',
      'ar': 'عمرك',
      'de': 'Ihr Alter',
      'es': 'Su edad',
    },
    's7yvjzbs': {
      'en': 'i.e. 34',
      'ar': 'أي 34',
      'de': 'dh 34',
      'es': 'es decir, 34',
    },
    '72ii0waq': {
      'en': 'Your Title',
      'ar': 'لقبك',
      'de': 'Dein Titel',
      'es': 'Tu título',
    },
    'pf8glhkg': {
      'en': 'What is your position?',
      'ar': 'ماهوموقعك؟',
      'de': 'Wo befinden Sie sich?',
      'es': '¿Cual es tu posicion?',
    },
    'hbhd3bdt': {
      'en': 'Complete Profile',
      'ar': 'الملف الشخصي الكامل',
      'de': 'Vollständiges Profil',
      'es': 'Perfil completo',
    },
    'w75dikic': {
      'en': 'Skip for Now',
      'ar': 'تخطي في الوقت الراهن',
      'de': 'Für jetzt überspringen',
      'es': 'Saltar por ahora',
    },
    '1eac148w': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ew7dbn3s': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jhhlgzk5': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4k3jnl38': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // alert
  {
    'i8hl2uua': {
      'en': 'Alert ! ',
      'ar': 'إنشاء الميزانيات',
      'de': 'Erstellen Sie Budgets',
      'es': 'Crear presupuestos',
    },
    'hxtwax0y': {
      'en':
          'Alert! Fire detected!\n Please evacuate immediately\n and follow safety instructions.\n Do not use elevators and remain calm',
      'ar':
          'قم بإنشاء ميزانيات يمكنك ربط المعاملات بها أيضًا من أجل التتبع السهل.',
      'de':
          'Erstellen Sie Budgets, mit denen Sie auch Transaktionen verknüpfen können, um sie einfach nachverfolgen zu können.',
      'es':
          'Cree presupuestos en los que también pueda vincular transacciones para facilitar el seguimiento.',
    },
    'mjy3ljln': {
      'en': 'Keep Track of Spending',
      'ar': 'تتبع الإنفاق',
      'de': 'Behalten Sie die Ausgaben im Auge',
      'es': 'Mantenga un registro de los gastos',
    },
    'uf9k1spp': {
      'en':
          'Easily add transactions and associate them with budgets that have been created.',
      'ar': 'أضف المعاملات بسهولة وربطها بالميزانيات التي تم إنشاؤها.',
      'de':
          'Fügen Sie ganz einfach Transaktionen hinzu und verknüpfen Sie sie mit erstellten Budgets.',
      'es':
          'Agregue fácilmente transacciones y asócielas con los presupuestos que se han creado.',
    },
    '9c4outzf': {
      'en': 'Budget Analysis',
      'ar': 'تحليل الميزانية',
      'de': 'Budgetanalyse',
      'es': 'Análisis de presupuesto',
    },
    'q30ina4f': {
      'en': 'Know where your budgets are and how they can be adjusted.',
      'ar': 'تعرف على مكان ميزانياتك وكيف يمكن تعديلها.',
      'de': 'Wissen, wo Ihre Budgets sind und wie sie angepasst werden können.',
      'es': 'Sepa dónde están sus presupuestos y cómo se pueden ajustar.',
    },
    'oo0kk9qe': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // issuevizualisation
  {
    'njx7udqo': {
      'en': 'Machine Diagnostics',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4c2uf89o': {
      'en': 'Problem Details',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8q9iympr': {
      'en': 'Machine ID:',
      'ar': '',
      'de': '',
      'es': '',
    },
    '36io843i': {
      'en': 'M-2023-456',
      'ar': '',
      'de': '',
      'es': '',
    },
    '23n4hhlc': {
      'en': 'Status:',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pdputw15': {
      'en': 'Critical',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cerf3eet': {
      'en': 'Location:',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aavdh6qt': {
      'en': 'Assembly Line B',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4aj6r1ea': {
      'en': 'Issue Description',
      'ar': '',
      'de': '',
      'es': '',
    },
    'itpgy683': {
      'en':
          'Bearing failure detected in the main drive shaft. Excessive vibration and temperature readings indicate immediate maintenance required.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bx06oo60': {
      'en': 'Diagnostic Readings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zf5uzgpi': {
      'en': 'Temperature',
      'ar': '',
      'de': '',
      'es': '',
    },
    'puod8vyz': {
      'en': '78°C',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5dh80ynx': {
      'en': 'Vibration',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vuj0tivk': {
      'en': '45 Hz',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mmh1h69m': {
      'en': 'Pressure',
      'ar': '',
      'de': '',
      'es': '',
    },
    's0p9yq3r': {
      'en': '2.4 bar',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ub335tma': {
      'en': 'Historical Data',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2p4r07za': {
      'en': 'Last 24 Hours',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i2r6xnoy': {
      'en': 'Recommended Actions',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ho90400a': {
      'en': 'Schedule Maintenance',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5m9tkoid': {
      'en': 'Estimated downtime: 4 hours',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lai3vsbe': {
      'en': 'Order Replacement Parts',
      'ar': '',
      'de': '',
      'es': '',
    },
    'io966s6w': {
      'en': 'Bearing assembly kit required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ch2j56gq': {
      'en': 'Generate Work Order',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // simulation
  {
    '84vcivp5': {
      'en': 'Simulation Tools',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6z9km2xy': {
      'en': 'Workflow Simulation',
      'ar': '',
      'de': '',
      'es': '',
    },
    'h22sseeo': {
      'en':
          'Test changes to your process workflow and see the impact on efficiency and resources',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fkzz63xi': {
      'en': 'Current Efficiency',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qi32pcsd': {
      'en': '87%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qgu81mo8': {
      'en': '87%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o2k3at6u': {
      'en': 'Run New Simulation',
      'ar': '',
      'de': '',
      'es': '',
    },
    '92k3g5wj': {
      'en': 'Energy System Analysis',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gl80oa1k': {
      'en': 'Model energy consumption patterns and optimize for sustainability',
      'ar': '',
      'de': '',
      'es': '',
    },
    'h31lvmwk': {
      'en': 'Power Usage',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0hd26ir0': {
      'en': '45 kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xrjxagpw': {
      'en': 'Carbon Offset',
      'ar': '',
      'de': '',
      'es': '',
    },
    '75gcgrap': {
      'en': '-12%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0elx3wup': {
      'en': 'Start Energy Analysis',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r5gky55f': {
      'en': 'Recent Simulations',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xsw2yqdp': {
      'en': 'Process Optimization',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n7m0syvg': {
      'en': 'Completed',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rdsn0pe3': {
      'en': 'Improved efficiency by 15% through automated task routing',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zyjqfmfm': {
      'en': 'June 15, 2023',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pdrz2xik': {
      'en': 'Energy Consumption',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4lj6wu20': {
      'en': 'In Progress',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cxgwnyfg': {
      'en': 'Testing impact of new solar panel installation',
      'ar': '',
      'de': '',
      'es': '',
    },
    'y1hwewdl': {
      'en': 'June 14, 2023',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // employeewellness
  {
    'ov7la36g': {
      'en': 'Employee Wellness',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0ca81w60': {
      'en': 'Wellness Score',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cul4ydnw': {
      'en': '87',
      'ar': '',
      'de': '',
      'es': '',
    },
    'tlu0kd7j': {
      'en': 'Status: Excellent',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wx0msiq3': {
      'en': '+5% this week',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bsb7tejg': {
      'en': '72 BPM',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n8yjmfsd': {
      'en': 'Heart Rate',
      'ar': '',
      'de': '',
      'es': '',
    },
    'u3yg265v': {
      'en': '98.6°F',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hlcfvj6x': {
      'en': 'Temperature',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd4fc17g4': {
      'en': 'Good',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8lf9iogf': {
      'en': 'Air Quality',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bxmgs2bg': {
      'en': 'Stress Level Monitor',
      'ar': '',
      'de': '',
      'es': '',
    },
    'renu41es': {
      'en': 'Current Level',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bpibl6o5': {
      'en': 'Low',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6iv5fyds': {
      'en': 'Daily Activity',
      'ar': '',
      'de': '',
      'es': '',
    },
    '23eem10k': {
      'en': 'See All',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wtjslkgt': {
      'en': 'Steps Taken',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e69ngkv5': {
      'en': '2,547 steps',
      'ar': '',
      'de': '',
      'es': '',
    },
    '97xccbj0': {
      'en': 'Goal: 10,000',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rxmgx28p': {
      'en': 'Break Time',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2cl2dbc9': {
      'en': 'Last break: 45 mins ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wweyxaey': {
      'en': 'Take a break',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wkpaww4u': {
      'en': 'Light Exposure',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2psizqb5': {
      'en': 'Optimal level',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nwj2kboq': {
      'en': 'Good',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // explorecategorie
  {
    '9gssw70q': {
      'en': 'Categories',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4i35gldi': {
      'en': 'Equipment Categories',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w72h7jr1': {
      'en':
          'Browse through different types of industrial equipment and systems',
      'ar': '',
      'de': '',
      'es': '',
    },
    'woh7upj2': {
      'en': 'Manufacturing Equipment',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mdta1duj': {
      'en': 'Production machinery and tools',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ixdvkk1n': {
      'en': 'Heavy Machinery',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oova1cht': {
      'en': 'Construction and industrial vehicles',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n7ici7tn': {
      'en': 'Electrical Systems',
      'ar': '',
      'de': '',
      'es': '',
    },
    'paimsqth': {
      'en': 'Power distribution and controls',
      'ar': '',
      'de': '',
      'es': '',
    },
    'snwmwr4k': {
      'en': 'Hydraulic Systems',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lwrr1l7w': {
      'en': 'Fluid power and control systems',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0m9m5e2x': {
      'en': 'Recent Activity',
      'ar': '',
      'de': '',
      'es': '',
    },
    't14j6i8c': {
      'en': 'Assembly Line B',
      'ar': '',
      'de': '',
      'es': '',
    },
    'z52oe8jx': {
      'en': 'Last checked: 2 hours ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w3z89lys': {
      'en': 'Packaging Unit 3',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2w7d7hzi': {
      'en': 'Last checked: 5 hours ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w3npwvmd': {
      'en': 'Quick Actions',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0lzb18r4': {
      'en': 'New Report',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rfbmyo9q': {
      'en': 'Schedule',
      'ar': '',
      'de': '',
      'es': '',
    },
    'deljv7b7': {
      'en': 'Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // questionnaire
  {
    '0m4xnt48': {
      'en': 'Industry 4.0 Assessment',
      'ar': '',
      'de': '',
      'es': '',
    },
    'v72bw2v6': {
      'en': 'Let\'s evaluate your digital transformation journey',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hfacz2qj': {
      'en': 'Digital Infrastructure',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dpf8cbtu': {
      'en': 'How would you rate your current level of automation?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b964leov': {
      'en': 'Basic',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3ypcsfaa': {
      'en': 'Intermediate',
      'ar': '',
      'de': '',
      'es': '',
    },
    'eaupjc3l': {
      'en': 'Advanced',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r5t79djb': {
      'en': 'Data Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
    '02ffq83b': {
      'en': 'Do you collect and analyze production data in real-time?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'z76doy9j': {
      'en': 'No Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fwnsujgx': {
      'en': 'Basic Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9ozpztbu': {
      'en': 'Advanced Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
    '10pdegkc': {
      'en': 'IoT Implementation',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm4g8vb44': {
      'en': 'How many connected devices are in your production environment?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'k7qo30xj': {
      'en': '0-10',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ot1wo4xo': {
      'en': '11-50',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oi2k2xxd': {
      'en': '51-100',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ud7j1byu': {
      'en': '100+',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dtxkgtf3': {
      'en': 'Workforce Skills',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q88koo54': {
      'en':
          'What percentage of your workforce is trained in digital technologies?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ps8yt3gs': {
      'en': '0-25%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ltnobi39': {
      'en': '26-50%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'irb219pc': {
      'en': '51-75%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wih36h2m': {
      'en': '76-100%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xj8wxy9e': {
      'en': 'Cybersecurity Measures',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dhc53pua': {
      'en': 'How would you describe your cybersecurity infrastructure?',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vvoypqu6': {
      'en': 'Basic',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n8qd3hw8': {
      'en': 'Standard',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ptzit5fy': {
      'en': 'Advanced',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7k6zlfhc': {
      'en': 'Enterprise',
      'ar': '',
      'de': '',
      'es': '',
    },
    'czefi3b8': {
      'en': 'Submit Assessment',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // homepage
  {
    'mw37kurz': {
      'en': 'Dashboard',
      'ar': '',
      'de': '',
      'es': '',
    },
    '001kqdni': {
      'en': 'Total Revenue',
      'ar': '',
      'de': '',
      'es': '',
    },
    'k5tzf9w3': {
      'en': '\$847,532.89',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6qqgkm26': {
      'en': '+8.2% from last month',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ynwss7ph': {
      'en': 'Active Machines',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kxwvtipn': {
      'en': '45/48',
      'ar': '',
      'de': '',
      'es': '',
    },
    '48hqz3xp': {
      'en': 'Issues',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pt3l8cw7': {
      'en': '3',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vkq1qf7w': {
      'en': 'Machine Status',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o5rkdnkm': {
      'en': 'Machine A-101',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g9pe84uq': {
      'en': 'Operating normally',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4hmenwyh': {
      'en': '98%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sr1b6pku': {
      'en': 'Machine B-202',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm3gg5q0t': {
      'en': 'Maintenance required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zx90nycl': {
      'en': '76%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '82p9w6fz': {
      'en': 'Machine C-303',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hvcbuygc': {
      'en': 'Critical error',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm27a1kaw': {
      'en': '12%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qa1qcb9i': {
      'en': 'Recent Activities',
      'ar': '',
      'de': '',
      'es': '',
    },
    't2w0e1mp': {
      'en': 'System Update',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6sv1p0lo': {
      'en': '10 minutes ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    'eol8jvdg': {
      'en': 'Maintenance Complete',
      'ar': '',
      'de': '',
      'es': '',
    },
    'tgueax6q': {
      'en': '2 hours ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4rfcx5hi': {
      'en': 'Low Inventory Alert',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sjzwnzqy': {
      'en': '5 hours ago',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // SustainabilityImpactAnalytics
  {
    'm3uz2w2a': {
      'en': 'Sustainability Impact',
      'ar': '',
      'de': '',
      'es': '',
    },
    's8waol73': {
      'en': 'Carbon Footprint',
      'ar': '',
      'de': '',
      'es': '',
    },
    'or0vpr3n': {
      'en': '12.5',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ygmjn4de': {
      'en': 'Metric Tons CO₂e / Year',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2z8t6msf': {
      'en': '-2.3 from last month',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vav0c3mg': {
      'en': '18.4% reduction',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0wpdbb2b': {
      'en': 'Energy Savings',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w24yajfs': {
      'en': '1,234 kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0azq4ox7': {
      'en': 'Water Saved',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7cimoo3u': {
      'en': '850 Gal',
      'ar': '',
      'de': '',
      'es': '',
    },
    'krx3qdux': {
      'en': 'Sustainability Goals',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kc0wcwmp': {
      'en': 'Reduce Energy Usage',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2lhw0wba': {
      'en': '75%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2zddczhz': {
      'en': 'Zero Waste Target',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wrcyfwfj': {
      'en': '60%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2e68q27g': {
      'en': 'Renewable Energy',
      'ar': '',
      'de': '',
      'es': '',
    },
    'efwnmf8z': {
      'en': '45%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4uet5mha': {
      'en': 'Monthly Breakdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ciwb9buw': {
      'en': 'Jan',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1kmx6twf': {
      'en': 'Feb',
      'ar': '',
      'de': '',
      'es': '',
    },
    '39dsxvj7': {
      'en': 'Mar',
      'ar': '',
      'de': '',
      'es': '',
    },
    '70grc9br': {
      'en': 'Apr',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ooh5l6e7': {
      'en': 'May',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jhsvbpw5': {
      'en': 'Jun',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2h0in85o': {
      'en': 'Recent Activities',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4anqsxk6': {
      'en': 'LED Lighting Upgrade',
      'ar': '',
      'de': '',
      'es': '',
    },
    '89p49483': {
      'en': 'Completed • -245 kWh',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0aesvt3w': {
      'en': '-\$32.80',
      'ar': '',
      'de': '',
      'es': '',
    },
    'io07w230': {
      'en': 'Water System Optimization',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8xt2nm8i': {
      'en': 'In Progress • -120 Gal',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wmsf3rbg': {
      'en': '-\$15.40',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // RecruitmentManagement
  {
    'cn1nde5d': {
      'en': 'Candidate Evaluation',
      'ar': '',
      'de': '',
      'es': '',
    },
    'f0pg0l2c': {
      'en': 'Current Applications',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hgmn1i4o': {
      'en': '12 candidates to review',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sg8ioxxg': {
      'en': 'Software Engineer',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l8oz0ono': {
      'en': 'Yasmine Toukebri',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cjb0vsod': {
      'en': 'Full Stack Developer',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8g3nqny8': {
      'en': 'Shortlisted',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4fgpkk0d': {
      'en': 'Masters in Computer Science',
      'ar': '',
      'de': '',
      'es': '',
    },
    'acq4pf3h': {
      'en': '5 years experience',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lrx7k2rb': {
      'en': 'View Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nkifburq': {
      'en': 'Schedule',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hhuo6iee': {
      'en': 'Ahmed Ben Salah',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g5z01r1b': {
      'en': 'Backend Developer',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dg6dknfp': {
      'en': 'In Review',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p6ellsus': {
      'en': 'BS in Computer Engineering',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jcnwt4lt': {
      'en': '3 years experience',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9z12pqtg': {
      'en': 'View Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hfuxcly7': {
      'en': 'Schedule',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mqa193us': {
      'en': 'Ichrak Mjid',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r70bmb30': {
      'en': 'Frontend Developer',
      'ar': '',
      'de': '',
      'es': '',
    },
    'apyf6eft': {
      'en': 'Rejected',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ks9dqor2': {
      'en': 'BS in Computer Science',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gqt0kbch': {
      'en': '2 years experience',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4hoa0gr1': {
      'en': 'View Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'voztzhp1': {
      'en': 'Archive',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1332vp78': {
      'en': 'Quick Actions',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yesq437f': {
      'en': 'Add Candidate',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9saakmia': {
      'en': 'Evaluations',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hjnonve8': {
      'en': 'Schedule',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qwjqkmdl': {
      'en': 'Reports',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // monitorprogress
  {
    'd8wj0ztf': {
      'en': 'Progress Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fi8a9kfx': {
      'en': 'Overall Progress',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1m348pbz': {
      'en': '78%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd8v0airi': {
      'en': 'Sustainability Goals Met',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qjbh5ivn': {
      'en': '+5.2% from last month',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p6fkoem1': {
      'en': 'On Track',
      'ar': '',
      'de': '',
      'es': '',
    },
    'y7myncvq': {
      'en': 'Waste Reduction',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7tdwlk5p': {
      'en': '82%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'h5avrg02': {
      'en': 'Energy Efficiency',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1t11x0me': {
      'en': '65%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mqjk1fy5': {
      'en': 'Key Metrics',
      'ar': '',
      'de': '',
      'es': '',
    },
    'y5vjm3ta': {
      'en': 'Carbon Emissions',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vxq3ukx3': {
      'en': '85%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q3akzt90': {
      'en': 'Water Conservation',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2txsj4rm': {
      'en': '72%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7dhcsx21': {
      'en': 'Renewable Energy',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o6jiangb': {
      'en': '68%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'uakq4zw5': {
      'en': 'Recent Achievements',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6y2mlczg': {
      'en': 'Zero Waste Week',
      'ar': '',
      'de': '',
      'es': '',
    },
    'c2w7cgq1': {
      'en': 'Achieved • June 15',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p213nm6d': {
      'en': '+10pts',
      'ar': '',
      'de': '',
      'es': '',
    },
    '9iaail2x': {
      'en': 'Green Initiative',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w3klpz5r': {
      'en': 'Completed • June 10',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6ghw45zk': {
      'en': '+8pts',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7fwq630q': {
      'en': 'Improvement Areas',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g872n8pt': {
      'en': 'Transportation',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3kyy059y': {
      'en': 'Consider eco-friendly alternatives',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wwyqphin': {
      'en': 'Office Supplies',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ch27y8ij': {
      'en': 'Switch to recycled materials',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // advinfconn
  {
    '3mv5z4zw': {
      'en': 'Infrastructure Dashboard',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b2r4lrug': {
      'en': 'IoT Device Status',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8nvizw9z': {
      'en': 'Active Sensors',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o80cyjfo': {
      'en': '156/160 Online',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5kgc77cp': {
      'en': 'Data Transfer',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vla133uw': {
      'en': '1.2 TB/day',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mopjlmzl': {
      'en': 'System Health',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0hnnid8r': {
      'en': '98.5%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r1okvje5': {
      'en': 'Smart Grid Integration',
      'ar': '',
      'de': '',
      'es': '',
    },
    'evui3ng7': {
      'en': 'Solar',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ponaet4m': {
      'en': '45.2 MW',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2oahrutg': {
      'en': 'Wind',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l4sdifa9': {
      'en': '32.8 MW',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3wdvfpmz': {
      'en': 'Hydro',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5xf07zib': {
      'en': '28.5 MW',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nzc3o7rv': {
      'en': 'Autonomous Systems',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7xu92ju7': {
      'en': 'Delivery Drone #A127',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bkqvyk4c': {
      'en': 'Route: Warehouse A → Distribution Hub',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nasowuim': {
      'en': 'Active',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a5367hx5': {
      'en': 'AutoTruck #B238',
      'ar': '',
      'de': '',
      'es': '',
    },
    '20uz4tdd': {
      'en': 'Route: Distribution Hub → Retail Center',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mhkz8c6g': {
      'en': 'Charging',
      'ar': '',
      'de': '',
      'es': '',
    },
    'shlcnu7n': {
      'en': 'RoboLoader #C345',
      'ar': '',
      'de': '',
      'es': '',
    },
    'x48k3idu': {
      'en': 'Location: Warehouse B',
      'ar': '',
      'de': '',
      'es': '',
    },
    'powakmy7': {
      'en': 'Maintenance',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // CompanyNewsandUpdates
  {
    '1giq4lmt': {
      'en': 'Company Updates',
      'ar': '',
      'de': '',
      'es': '',
    },
    'phs0hyew': {
      'en': 'Latest Announcements',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r4x1jqhj': {
      'en': 'Company Milestone',
      'ar': '',
      'de': '',
      'es': '',
    },
    'noe6gttq': {
      'en': 'New',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kol8lkm9': {
      'en':
          'We\'re excited to announce reaching 1 million customers worldwide! Thank you to our dedicated team for making this possible.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ock6m2pj': {
      'en': 'June 15, 2023',
      'ar': '',
      'de': '',
      'es': '',
    },
    'iwqkcc1g': {
      'en': 'Department Updates',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0ob4ode6': {
      'en': 'Sales Department',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lmu2whie': {
      'en': 'Q2 Targets Exceeded',
      'ar': '',
      'de': '',
      'es': '',
    },
    't33rfsw1': {
      'en': '5h ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    's8k2dv6c': {
      'en': 'Upcoming Events',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vlw2usi4': {
      'en': 'All-Hands Meeting',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4lkorqye': {
      'en': 'June 20, 2023 • 10:00 AM',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lhtbuv9f': {
      'en': 'Add to Calendar',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xbfdmh6q': {
      'en': 'Employee Recognition',
      'ar': '',
      'de': '',
      'es': '',
    },
    'v31im8an': {
      'en': 'Sarah Johnson',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rr69b0d3': {
      'en': 'Employee of the Month',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3i1dxb4x': {
      'en':
          'Recognized for exceptional leadership in the recent product launch and mentoring new team members.',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // RenewableResourceOptimizer
  {
    'cyooqzi1': {
      'en': 'Resource Optimizer',
      'ar': '',
      'de': '',
      'es': '',
    },
    'd6k9f802': {
      'en': 'Energy Overview',
      'ar': '',
      'de': '',
      'es': '',
    },
    'thlhbd77': {
      'en':
          'Current renewable energy utilization and optimization opportunities',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5h5r8qen': {
      'en': 'Renewable Usage',
      'ar': '',
      'de': '',
      'es': '',
    },
    'tho29owf': {
      'en': '73%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zkp0xf82': {
      'en': '73%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'becrx432': {
      'en': 'Optimize Distribution',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2ptminsh': {
      'en': 'Resource Distribution',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8bobia2v': {
      'en': 'Solar',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vd9nz4yj': {
      'en': '45%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dtrn051d': {
      'en': 'Wind',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0e0nx0gf': {
      'en': '28%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g1r6dxzl': {
      'en': 'AI Forecasting',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2ukon2gm': {
      'en': '24-hour prediction of renewable resource availability',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vel6z7xm': {
      'en': 'Solar Generation',
      'ar': '',
      'de': '',
      'es': '',
    },
    'uzourvli': {
      'en': 'Optimal',
      'ar': '',
      'de': '',
      'es': '',
    },
    '13j20acv': {
      'en': 'Predicted peak generation between 11 AM - 3 PM',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7lv4f46y': {
      'en': 'Wind Generation',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3vie694r': {
      'en': 'Variable',
      'ar': '',
      'de': '',
      'es': '',
    },
    'z9zgacu4': {
      'en': 'Expected fluctuations due to changing wind patterns',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // CustomTrainingandCertification
  {
    'mm235t7f': {
      'en': 'Training Programs',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kzbivftj': {
      'en': 'Your Progress',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i8xyg2s8': {
      'en': 'Keep learning and growing!',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wiy0zx99': {
      'en': '75%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '52lkecpq': {
      'en': '8/12 Modules Completed',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q14e73n1': {
      'en': 'Est. 4h remaining',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hy2hlwtq': {
      'en': 'Active Courses',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zulk9yzv': {
      'en': 'Advanced Software Development',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e3uosvki': {
      'en': 'Module 3/5 • 65% Complete',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rliqsm6d': {
      'en': 'Data Analytics Fundamentals',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fmv7n16f': {
      'en': 'Module 2/4 • 45% Complete',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gfo7na6y': {
      'en': 'Available Certifications',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6foligw5': {
      'en': 'Cloud Architecture',
      'ar': '',
      'de': '',
      'es': '',
    },
    'cjatpmyj': {
      'en': 'Advanced • 40 hours',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lf3383x3': {
      'en': 'Enroll',
      'ar': '',
      'de': '',
      'es': '',
    },
    'iwcy9w2w': {
      'en': 'Cybersecurity Expert',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jduf8r2y': {
      'en': 'Intermediate • 32 hours',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ozit5uhf': {
      'en': 'Enroll',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lt98i5og': {
      'en': 'AI & Machine Learning',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mk03tcqj': {
      'en': 'Advanced • 48 hours',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p2on56vg': {
      'en': 'Enroll',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // EnhancedDigitalTwinIntegration
  {
    '3sl3qecf': {
      'en': 'Digital Twin Dashboard',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w99u675a': {
      'en': 'Real-time System Status',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xwwj3oat': {
      'en': 'Active Processes',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rxslbxmb': {
      'en': '847/850',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pkwyuog6': {
      'en': 'System Load',
      'ar': '',
      'de': '',
      'es': '',
    },
    'pa93qq8c': {
      'en': '76.4%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4ovl8ohq': {
      'en': 'Data Synchronization',
      'ar': '',
      'de': '',
      'es': '',
    },
    't3wwk5q7': {
      'en': 'Real-time',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6rz81o2k': {
      'en': 'Zone Overview',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n51ozf72': {
      'en': 'Zone A',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gfg6x0is': {
      'en': 'Optimal',
      'ar': '',
      'de': '',
      'es': '',
    },
    '77bezzfl': {
      'en': 'Zone B',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2mk07349': {
      'en': 'Warning',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3ldir9pg': {
      'en': 'Zone C',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e9xog2c1': {
      'en': 'Critical',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2blvr3j6': {
      'en': 'Scenario Testing',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vpkr96bm': {
      'en': 'Load Balancing Test',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8skqopdf': {
      'en': 'Efficiency: 94.2%',
      'ar': '',
      'de': '',
      'es': '',
    },
    '76cocpjl': {
      'en': 'Running',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oj7buu3u': {
      'en': 'Performance Optimization',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qqqdwnad': {
      'en': 'Progress: 67%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n6zf2n08': {
      'en': 'In Queue',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ov8cvqc4': {
      'en': 'Security Stress Test',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ft0iigfd': {
      'en': 'Scheduled: 2:30 PM',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xi06l6c7': {
      'en': 'Pending',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // EnvironmentalRiskDetector
  {
    'prs06ube': {
      'en': 'Environmental Monitor',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xack1ya0': {
      'en': 'Current Risk Level',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e1w9ux5i': {
      'en': 'Moderate',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vbpvzkl7': {
      'en': '65',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bytlghdp': {
      'en': '2 Active Warnings',
      'ar': '',
      'de': '',
      'es': '',
    },
    '3oaaje3t': {
      'en': 'Emissions',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8crhwr7b': {
      'en': 'Waste',
      'ar': '',
      'de': '',
      'es': '',
    },
    'lzemi2qm': {
      'en': 'Hazards',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w2e6bnp1': {
      'en': 'Active Alerts',
      'ar': '',
      'de': '',
      'es': '',
    },
    'szhdjqk7': {
      'en': 'High CO2 Levels',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ueq29jc5': {
      'en': 'Factory Section A',
      'ar': '',
      'de': '',
      'es': '',
    },
    'iom7gakd': {
      'en': 'View',
      'ar': '',
      'de': '',
      'es': '',
    },
    'blgsjlwi': {
      'en': 'Waste Overflow',
      'ar': '',
      'de': '',
      'es': '',
    },
    '94vbuekj': {
      'en': 'Disposal Unit 2',
      'ar': '',
      'de': '',
      'es': '',
    },
    '74ota6ew': {
      'en': 'View',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xir1zmwv': {
      'en': 'AI Recommendations',
      'ar': '',
      'de': '',
      'es': '',
    },
    'v3hab36j': {
      'en': 'Mitigation Strategies',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ikuzaley': {
      'en':
          '1. Optimize ventilation systems in Section A\n2. Schedule maintenance for Disposal Unit 2\n3. Update emergency response protocols',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hf7bj3bp': {
      'en': 'Implement',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // CompanyList
  {
    'qe5yjj68': {
      'en': 'All',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oek1270h': {
      'en': 'Inspector Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'v88mrn4q': {
      'en': 'Title',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hchw97v3': {
      'en': 'Inspector Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4b9czo61': {
      'en': 'Title',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8vcx2y00': {
      'en': 'Inspector Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r0b6fg6c': {
      'en': 'Title',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ilil2sbj': {
      'en': 'Active',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sm9gsgbj': {
      'en': 'Inspector Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7i8yaxvc': {
      'en': 'Title',
      'ar': '',
      'de': '',
      'es': '',
    },
    't1txct11': {
      'en': 'Inactive',
      'ar': '',
      'de': '',
      'es': '',
    },
    'eualcik2': {
      'en': 'Inspector Name',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p8eek36z': {
      'en': 'Title',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dgvu9dq8': {
      'en': 'Inspectors',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bjek1rmk': {
      'en': '•',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // probdetec
  {
    '6mum7tgt': {
      'en': 'Problem Detection',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vbykc2bg': {
      'en': 'System Health',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hdvmp4fz': {
      'en': 'Real-time monitoring and analysis',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4p06xui0': {
      'en': 'Overall Status',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wyel3fxw': {
      'en': '98%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm130fgpw': {
      'en': 'Active Alerts',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mbmf3343': {
      'en': 'High Temperature Alert',
      'ar': '',
      'de': '',
      'es': '',
    },
    'uwk8qsn1': {
      'en': 'Manufacturing Unit B',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i5vgvo38': {
      'en': 'Now',
      'ar': '',
      'de': '',
      'es': '',
    },
    'syuxvb1v': {
      'en': 'Maintenance Required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a1lsoskg': {
      'en': 'Assembly Line 3',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rbba7tod': {
      'en': '2h ago',
      'ar': '',
      'de': '',
      'es': '',
    },
    'b8g1m3s6': {
      'en': 'AI Solutions',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7it3tr1l': {
      'en': 'Temperature Optimization',
      'ar': '',
      'de': '',
      'es': '',
    },
    'f1zv77ej': {
      'en':
          'Suggested: Adjust cooling system parameters in Unit B to prevent overheating',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p1gd2l9y': {
      'en': 'Apply Solution',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0ttkd7c2': {
      'en': 'Predictive Maintenance',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mkfk9orc': {
      'en':
          'Suggested: Schedule maintenance for Assembly Line 3 within next 24 hours',
      'ar': '',
      'de': '',
      'es': '',
    },
    '22dghicu': {
      'en': 'Schedule Now',
      'ar': '',
      'de': '',
      'es': '',
    },
    'doqab66p': {
      'en': 'Sensor Network',
      'ar': '',
      'de': '',
      'es': '',
    },
    '59e7sso2': {
      'en': 'Temperature',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yhr2c0v2': {
      'en': '24 Sensors',
      'ar': '',
      'de': '',
      'es': '',
    },
    '30r5gyn6': {
      'en': 'Vibration',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wy7zn5pw': {
      'en': '16 Sensors',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4lgbr4xi': {
      'en': 'Pressure',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7k78dwj5': {
      'en': '20 Sensors',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // susforecasting
  {
    '80th4i92': {
      'en': 'Sustainability Forecast',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zg4aazuf': {
      'en': 'Environmental Impact',
      'ar': '',
      'de': '',
      'es': '',
    },
    'uekxtk89': {
      'en': 'Track and forecast your organization\'s environmental footprint',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nalw5dgi': {
      'en': 'Carbon Footprint',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gfgbyo0f': {
      'en': '-12.5%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qfz6wk4s': {
      'en': 'Global Standards',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mdqc7i4o': {
      'en': 'ISO 14001 Compliance',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dnl3cpio': {
      'en': 'Environmental Management',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ezbwsv7n': {
      'en': 'GRI Standards',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5jaapw8h': {
      'en': 'Sustainability Reporting',
      'ar': '',
      'de': '',
      'es': '',
    },
    'k85dpdya': {
      'en': 'Resource Efficiency',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e10imaq3': {
      'en': '85%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l9dsqqm0': {
      'en': 'Water Usage',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o0nqqf96': {
      'en': '92%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jzjmksjq': {
      'en': 'Energy Efficiency',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l94ubemp': {
      'en': '78%',
      'ar': '',
      'de': '',
      'es': '',
    },
    'smotzww3': {
      'en': 'Waste Reduction',
      'ar': '',
      'de': '',
      'es': '',
    },
    'u6xledts': {
      'en': 'Action Items',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xy932igm': {
      'en': 'Solar Panel Installation',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ziic0lz5': {
      'en': 'Due: Q3 2024',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dz0fgq47': {
      'en': 'Water Recycling System',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2xw7t889': {
      'en': 'Due: Q4 2024',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // incidentreplay
  {
    'a60kf44o': {
      'en': 'Incident Analysis',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l0iz72sn': {
      'en': 'Current Replay',
      'ar': '',
      'de': '',
      'es': '',
    },
    'x2wk4u7g': {
      'en': 'Time: 14:35:22',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dwqjqglb': {
      'en': 'Speed: 1.0x',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rihb8gyv': {
      'en': 'Incident Details',
      'ar': '',
      'de': '',
      'es': '',
    },
    'exid6ib5': {
      'en': 'Incident ID:',
      'ar': '',
      'de': '',
      'es': '',
    },
    'eu6mum3y': {
      'en': '#INC-2023-089',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mmtpyvdh': {
      'en': 'Date:',
      'ar': '',
      'de': '',
      'es': '',
    },
    '36rhbwqt': {
      'en': 'June 15, 2023',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gl18nrj1': {
      'en': 'Location:',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jrfnqe8e': {
      'en': 'Building A, Floor 3',
      'ar': '',
      'de': '',
      'es': '',
    },
    'elo9miu5': {
      'en': 'Severity:',
      'ar': '',
      'de': '',
      'es': '',
    },
    'nw9se2o9': {
      'en': 'High',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7u55c232': {
      'en': 'Analysis Points',
      'ar': '',
      'de': '',
      'es': '',
    },
    'h49769ct': {
      'en': '1',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rf8oo6sg': {
      'en': 'Initial Contact Point',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ix5le46u': {
      'en': 'First sign of incident detected at entrance',
      'ar': '',
      'de': '',
      'es': '',
    },
    '15w2u1qv': {
      'en': '2',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0k6l8wui': {
      'en': 'Escalation Point',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qihmnily': {
      'en': 'Situation escalated near emergency exit',
      'ar': '',
      'de': '',
      'es': '',
    },
    '86p80gol': {
      'en': '3',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2wfvsrwb': {
      'en': 'Resolution Point',
      'ar': '',
      'de': '',
      'es': '',
    },
    '93dx600e': {
      'en': 'Security intervention and containment',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0zxyxyrq': {
      'en': 'Generate Analysis Report',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // ManuPage
  {
    '7cfh8yyx': {
      'en': 'Navigate through your sustainability \njourney',
      'ar': '',
      'de': '',
      'es': '',
    },
    'e7a0ipbh': {
      'en': 'Menu',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xgnlt8vk': {
      'en': 'Main Features',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kgvr6519': {
      'en': 'Homepage',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mlgd514b': {
      'en': 'Company List',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7wazgn2t': {
      'en': 'News & Updates',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l2ypybb0': {
      'en': 'Assessment & Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zt8n0vr3': {
      'en': 'Industry 4.0 Assessment',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wmnag0i4': {
      'en': 'Sustainability Impact Analytics',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i0luu82c': {
      'en': 'Environmental Risk Detection',
      'ar': '',
      'de': '',
      'es': '',
    },
    'z4vgn06j': {
      'en': 'Sustainability Forecasting',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ea3xric3': {
      'en': 'Management Tools',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fouu09i8': {
      'en': 'Digital Twin Integration',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wqh0tv17': {
      'en': 'Incident Replay',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ef87dcuw': {
      'en': 'Issue Visualization',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xct9vnxd': {
      'en': 'Problem Detection',
      'ar': '',
      'de': '',
      'es': '',
    },
    'w6hvkyzr': {
      'en': 'Resource Optimization',
      'ar': '',
      'de': '',
      'es': '',
    },
    '67zp7f6y': {
      'en': 'HR & Training',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ak4to08d': {
      'en': 'Employee Wellness',
      'ar': '',
      'de': '',
      'es': '',
    },
    'hg9mfvct': {
      'en': 'Training & Certification',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zosi131r': {
      'en': 'Recruitment Management',
      'ar': '',
      'de': '',
      'es': '',
    },
    'mkfnh32x': {
      'en': 'Account',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o91e47nz': {
      'en': 'Complete Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8r17wxz3': {
      'en': 'Monitor Progress',
      'ar': '',
      'de': '',
      'es': '',
    },
    'p50572l2': {
      'en': 'Disconnect',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // bookAppointment
  {
    'sfzj3riz': {
      'en': 'Book Appointment',
      'ar': 'موعد الكتاب',
      'de': 'Einen Termin verabreden',
      'es': 'Reservar una cita',
    },
    '4skzh9os': {
      'en':
          'Fill out the information below in order to book your appointment with our office.',
      'ar': 'املأ المعلومات أدناه من أجل حجز موعدك مع مكتبنا.',
      'de':
          'Füllen Sie die folgenden Informationen aus, um Ihren Termin in unserem Büro zu buchen.',
      'es':
          'Complete la información a continuación para reservar su cita con nuestra oficina.',
    },
    'b87tcas2': {
      'en': 'Emails will be sent to:',
      'ar': 'سيتم إرسال رسائل البريد الإلكتروني إلى:',
      'de': 'E-Mails werden gesendet an:',
      'es': 'Los correos electrónicos serán enviados a:',
    },
    'iicnw3dq': {
      'en': 'Booking For',
      'ar': 'الحجز لـ',
      'de': 'Buchung für',
      'es': 'reserva para',
    },
    '5tkkg4yu': {
      'en': 'Type of Appointment',
      'ar': 'نوع التعيين',
      'de': 'Art der Ernennung',
      'es': 'Tipo de cita',
    },
    '7w5m45zt': {
      'en': 'Doctors Visit',
      'ar': 'زيارة الأطباء',
      'de': 'Arztbesuch',
      'es': 'Visita de médicos',
    },
    'bmfmxg71': {
      'en': 'Routine Checkup',
      'ar': 'فحص روتيني حتى',
      'de': 'Routineuntersuchung',
      'es': 'Chequeo de rutina',
    },
    'prt95f0g': {
      'en': 'Scan/Update',
      'ar': 'مسح / تحديث',
      'de': 'Scannen/Aktualisieren',
      'es': 'Escanear/Actualizar',
    },
    '7ohalsg9': {
      'en': 'What\'s the problem?',
      'ar': 'ما هي المشكلة؟',
      'de': 'Was ist das Problem?',
      'es': '¿Cuál es el problema?',
    },
    'xukiv2ku': {
      'en': 'Choose Date',
      'ar': 'اختر موعدا',
      'de': 'Wählen Sie Datum',
      'es': 'Elija fecha',
    },
    'lpc88cht': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    'b5umyycx': {
      'en': 'Book Now',
      'ar': 'احجز الآن',
      'de': 'buchen Sie jetzt',
      'es': 'Reservar ahora',
    },
  },
  // bookingOld
  {
    '8laf5zmk': {
      'en': 'Book Appointment',
      'ar': 'موعد الكتاب',
      'de': 'Einen Termin verabreden',
      'es': 'Reservar una cita',
    },
    'udwhsu8p': {
      'en':
          'Fill out the information below in order to book your appointment with our office.',
      'ar': 'املأ المعلومات أدناه من أجل حجز موعدك مع مكتبنا.',
      'de':
          'Füllen Sie die folgenden Informationen aus, um Ihren Termin in unserem Büro zu buchen.',
      'es':
          'Complete la información a continuación para reservar su cita con nuestra oficina.',
    },
    'm6f5lawq': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'yz52729g': {
      'en': 'Booking For',
      'ar': 'الحجز لـ',
      'de': 'Buchung für',
      'es': 'reserva para',
    },
    'hdmqdmzq': {
      'en': 'Type of Appointment',
      'ar': 'نوع التعيين',
      'de': 'Art der Ernennung',
      'es': 'Tipo de cita',
    },
    'stpxpct6': {
      'en': 'Doctors Visit',
      'ar': 'زيارة الأطباء',
      'de': 'Arztbesuch',
      'es': 'Visita de médicos',
    },
    'wvgk6obb': {
      'en': 'Routine Checkup',
      'ar': 'فحص روتيني حتى',
      'de': 'Routineuntersuchung',
      'es': 'Chequeo de rutina',
    },
    'xt7ujyt8': {
      'en': 'Scan/Update',
      'ar': 'مسح / تحديث',
      'de': 'Scannen/Aktualisieren',
      'es': 'Escanear/Actualizar',
    },
    'andpn0t0': {
      'en': 'What\'s the problem?',
      'ar': 'ما هي المشكلة؟',
      'de': 'Was ist das Problem?',
      'es': '¿Cuál es el problema?',
    },
    'ycaso9dc': {
      'en': 'Choose Date',
      'ar': 'اختر موعدا',
      'de': 'Wählen Sie Datum',
      'es': 'Elija fecha',
    },
    '2pmd2p3w': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    '13j05r8j': {
      'en': 'Book Now',
      'ar': 'احجز الآن',
      'de': 'buchen Sie jetzt',
      'es': 'Reservar ahora',
    },
  },
  // editBooking
  {
    '6j668hma': {
      'en': 'Edit Appointment',
      'ar': 'تحرير موعد',
      'de': 'Termin bearbeiten',
      'es': 'Editar cita',
    },
    'cbp936ta': {
      'en': 'Edit the fields below in order to change your appointment.',
      'ar': 'قم بتحرير الحقول أدناه لتغيير موعدك.',
      'de': 'Bearbeiten Sie die Felder unten, um Ihren Termin zu ändern.',
      'es': 'Edite los campos a continuación para cambiar su cita.',
    },
    '6btfslje': {
      'en': 'Emails will be sent to:',
      'ar': 'سيتم إرسال رسائل البريد الإلكتروني إلى:',
      'de': 'E-Mails werden gesendet an:',
      'es': 'Los correos electrónicos serán enviados a:',
    },
    'mhko6q8p': {
      'en': 'Booking For',
      'ar': 'الحجز لـ',
      'de': 'Buchung für',
      'es': 'reserva para',
    },
    'shqcgjqe': {
      'en': 'Type of Appointment',
      'ar': 'نوع التعيين',
      'de': 'Art der Ernennung',
      'es': 'Tipo de cita',
    },
    '5ixhbnsd': {
      'en': 'Doctors Visit',
      'ar': 'زيارة الأطباء',
      'de': 'Arztbesuch',
      'es': 'Visita de médicos',
    },
    'db46hhfw': {
      'en': 'Routine Checkup',
      'ar': 'فحص روتيني حتى',
      'de': 'Routineuntersuchung',
      'es': 'Chequeo de rutina',
    },
    'e1zm6kzh': {
      'en': 'Scan/Update',
      'ar': 'مسح / تحديث',
      'de': 'Scannen/Aktualisieren',
      'es': 'Escanear/Actualizar',
    },
    'oy6qvd33': {
      'en': 'What\'s the problem?',
      'ar': 'ما هي المشكلة؟',
      'de': 'Was ist das Problem?',
      'es': '¿Cuál es el problema?',
    },
    '9emhgrhs': {
      'en': 'Choose Date',
      'ar': 'اختر موعدا',
      'de': 'Wählen Sie Datum',
      'es': 'Elija Fecha',
    },
    '2bzoinpy': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    'gjnq0j86': {
      'en': 'Save Changes',
      'ar': 'حفظ التغييرات',
      'de': 'Änderungen speichern',
      'es': 'Guardar cambios',
    },
  },
  // pauseCard
  {
    'dt7m486y': {
      'en': 'Pause Card',
      'ar': 'بطاقة وقفة',
      'de': 'Pausenkarte',
      'es': 'Tarjeta de pausa',
    },
    '6edae99k': {
      'en': 'Are you sure you want to pause your card?',
      'ar': 'هل أنت متأكد أنك تريد إيقاف بطاقتك مؤقتًا؟',
      'de': 'Möchten Sie Ihre Karte wirklich pausieren?',
      'es': '¿Seguro que quieres pausar tu tarjeta?',
    },
    'omtrfcm5': {
      'en': 'Nevermind',
      'ar': 'لا بأس',
      'de': 'egal',
      'es': 'No importa',
    },
    'hw07mkb9': {
      'en': 'Yes, Pause',
      'ar': 'نعم توقف',
      'de': 'Ja, Pause',
      'es': 'Sí, pausa',
    },
  },
  // Miscellaneous
  {
    'lzyb73wy': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kx9cdks4': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'efvtwj7k': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ec5hfa1e': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q5ljwvfo': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'j4rmwb3h': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6ah1b18f': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2kos1hen': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aox3s4fb': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l8hv5a7z': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4pjwb70a': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0xlokf4y': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8twlwiwt': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    't4xzlq9q': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '513nj4m0': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a1jxfgju': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
