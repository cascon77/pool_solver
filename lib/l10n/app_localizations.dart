import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Pool Solver'**
  String get appTitle;

  /// No description provided for @homeMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get homeMaintenance;

  /// No description provided for @homeParameters.
  ///
  /// In en, this message translates to:
  /// **'Parameters'**
  String get homeParameters;

  /// No description provided for @homeProblems.
  ///
  /// In en, this message translates to:
  /// **'Problems'**
  String get homeProblems;

  /// No description provided for @homeTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get homeTips;

  /// No description provided for @homeConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get homeConfiguration;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Intelligent maintenance'**
  String get description;

  /// No description provided for @homePools.
  ///
  /// In en, this message translates to:
  /// **'My pools'**
  String get homePools;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @versionNumber.
  ///
  /// In en, this message translates to:
  /// **'v0.0.1 - Pool Solver'**
  String get versionNumber;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this pool?'**
  String get confirmDelete;

  /// No description provided for @tipCategoryGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get tipCategoryGeneral;

  /// No description provided for @tipCategoryLona.
  ///
  /// In en, this message translates to:
  /// **'Liner'**
  String get tipCategoryLona;

  /// No description provided for @tipCategoryObra.
  ///
  /// In en, this message translates to:
  /// **'Concrete'**
  String get tipCategoryObra;

  /// No description provided for @tipCategoryCloro.
  ///
  /// In en, this message translates to:
  /// **'Chlorine'**
  String get tipCategoryCloro;

  /// No description provided for @tipCategoryFiltro.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get tipCategoryFiltro;

  /// No description provided for @tipTitle1.
  ///
  /// In en, this message translates to:
  /// **'pH Control'**
  String get tipTitle1;

  /// No description provided for @tipDesc1.
  ///
  /// In en, this message translates to:
  /// **'Keep your pool\'s pH between 7.2 and 7.6 for crystal clear and safe water. Check it at least 2-3 times per week.'**
  String get tipDesc1;

  /// No description provided for @tipTitle2.
  ///
  /// In en, this message translates to:
  /// **'Filter Cleaning'**
  String get tipTitle2;

  /// No description provided for @tipDesc2.
  ///
  /// In en, this message translates to:
  /// **'Clean filters regularly according to type. A clean filter ensures good water circulation and reduces energy consumption.'**
  String get tipDesc2;

  /// No description provided for @tipTitle3.
  ///
  /// In en, this message translates to:
  /// **'Post-Rain Hygiene'**
  String get tipTitle3;

  /// No description provided for @tipDesc3.
  ///
  /// In en, this message translates to:
  /// **'After heavy rains, increase disinfection and check chlorine levels. Rain dilutes chemicals.'**
  String get tipDesc3;

  /// No description provided for @tipTitle4.
  ///
  /// In en, this message translates to:
  /// **'Water Circulation'**
  String get tipTitle4;

  /// No description provided for @tipDesc4.
  ///
  /// In en, this message translates to:
  /// **'Keep the pump running at least 4-6 hours daily in winter and 8-10 hours in summer for good circulation.'**
  String get tipDesc4;

  /// No description provided for @tipTitle5.
  ///
  /// In en, this message translates to:
  /// **'Total Alkalinity'**
  String get tipTitle5;

  /// No description provided for @tipDesc5.
  ///
  /// In en, this message translates to:
  /// **'Keep alkalinity between 80-120 ppm. This stabilizes pH and improves chemical efficiency.'**
  String get tipDesc5;

  /// No description provided for @tipTitle6.
  ///
  /// In en, this message translates to:
  /// **'Liner Protection'**
  String get tipTitle6;

  /// No description provided for @tipDesc6.
  ///
  /// In en, this message translates to:
  /// **'Avoid leaving sharp or pointed objects in the pool. Use a liner protector under the water.'**
  String get tipDesc6;

  /// No description provided for @tipTitle7.
  ///
  /// In en, this message translates to:
  /// **'Liner Cleaning'**
  String get tipTitle7;

  /// No description provided for @tipDesc7.
  ///
  /// In en, this message translates to:
  /// **'Clean the liner with a soft brush regularly to prevent algae buildup. Avoid abrasive products.'**
  String get tipDesc7;

  /// No description provided for @tipTitle8.
  ///
  /// In en, this message translates to:
  /// **'Winter Maintenance'**
  String get tipTitle8;

  /// No description provided for @tipDesc8.
  ///
  /// In en, this message translates to:
  /// **'In winter, cover the pool to protect the liner. Use a special winter cover or blanket.'**
  String get tipDesc8;

  /// No description provided for @tipTitle9.
  ///
  /// In en, this message translates to:
  /// **'Waterproofing'**
  String get tipTitle9;

  /// No description provided for @tipDesc9.
  ///
  /// In en, this message translates to:
  /// **'Regularly check that the coating has no cracks. Repair small cracks before they get bigger.'**
  String get tipDesc9;

  /// No description provided for @tipTitle10.
  ///
  /// In en, this message translates to:
  /// **'Coating Maintenance'**
  String get tipTitle10;

  /// No description provided for @tipDesc10.
  ///
  /// In en, this message translates to:
  /// **'Clean walls regularly with a brush to prevent stains and algae. The coating lasts longer with good maintenance.'**
  String get tipDesc10;

  /// No description provided for @tipTitle11.
  ///
  /// In en, this message translates to:
  /// **'Joint Sealing'**
  String get tipTitle11;

  /// No description provided for @tipDesc11.
  ///
  /// In en, this message translates to:
  /// **'Periodically check joint sealing. Re-seal if necessary to prevent leaks.'**
  String get tipDesc11;

  /// No description provided for @tipTitle12.
  ///
  /// In en, this message translates to:
  /// **'Chlorine Control'**
  String get tipTitle12;

  /// No description provided for @tipDesc12.
  ///
  /// In en, this message translates to:
  /// **'Keep free chlorine between 1.0-3.0 ppm. Low levels favor algae, high levels irritate eyes and skin.'**
  String get tipDesc12;

  /// No description provided for @tipTitle13.
  ///
  /// In en, this message translates to:
  /// **'Combined Chlorine'**
  String get tipTitle13;

  /// No description provided for @tipDesc13.
  ///
  /// In en, this message translates to:
  /// **'If combined chlorine exceeds 0.5 ppm, apply shock treatment. This improves water quality.'**
  String get tipDesc13;

  /// No description provided for @tipTitle14.
  ///
  /// In en, this message translates to:
  /// **'Chlorine Addition'**
  String get tipTitle14;

  /// No description provided for @tipDesc14.
  ///
  /// In en, this message translates to:
  /// **'Add chlorine in the afternoon/evening to better utilize its disinfection. Sun reduces effectiveness during the day.'**
  String get tipDesc14;

  /// No description provided for @tipTitle15.
  ///
  /// In en, this message translates to:
  /// **'Correct Salinity'**
  String get tipTitle15;

  /// No description provided for @tipDesc15.
  ///
  /// In en, this message translates to:
  /// **'Keep salinity between 2700-3400 ppm depending on the electrolyzer type. More salt improves disinfection.'**
  String get tipDesc15;

  /// No description provided for @tipTitle16.
  ///
  /// In en, this message translates to:
  /// **'Cell Cleaning'**
  String get tipTitle16;

  /// No description provided for @tipDesc16.
  ///
  /// In en, this message translates to:
  /// **'Clean the electrolysis cell every 3-6 months to maintain efficiency. Use diluted muriatic acid.'**
  String get tipDesc16;

  /// No description provided for @tipTitle17.
  ///
  /// In en, this message translates to:
  /// **'Cell Calcification'**
  String get tipTitle17;

  /// No description provided for @tipDesc17.
  ///
  /// In en, this message translates to:
  /// **'If the cell calcifies, chlorine production decreases. Regular cleaning prevents this.'**
  String get tipDesc17;

  /// No description provided for @tipTitle18.
  ///
  /// In en, this message translates to:
  /// **'Sand Backwashing'**
  String get tipTitle18;

  /// No description provided for @tipDesc18.
  ///
  /// In en, this message translates to:
  /// **'Perform backwashing when pressure rises 8-10 psi above normal working pressure.'**
  String get tipDesc18;

  /// No description provided for @tipTitle19.
  ///
  /// In en, this message translates to:
  /// **'Sand Replacement'**
  String get tipTitle19;

  /// No description provided for @tipDesc19.
  ///
  /// In en, this message translates to:
  /// **'Change sand every 5-7 years. Old sand loses filtration capacity.'**
  String get tipDesc19;

  /// No description provided for @tipTitle20.
  ///
  /// In en, this message translates to:
  /// **'Multiport Valve'**
  String get tipTitle20;

  /// No description provided for @tipDesc20.
  ///
  /// In en, this message translates to:
  /// **'Keep the multiport valve in FILTER position during normal operation. Check its operation regularly.'**
  String get tipDesc20;

  /// No description provided for @tipTitle21.
  ///
  /// In en, this message translates to:
  /// **'Cartridge Cleaning'**
  String get tipTitle21;

  /// No description provided for @tipDesc21.
  ///
  /// In en, this message translates to:
  /// **'Clean the cartridge with high pressure water every 2 weeks or when pressure rises. Avoid chemicals.'**
  String get tipDesc21;

  /// No description provided for @tipTitle22.
  ///
  /// In en, this message translates to:
  /// **'Cartridge Replacement'**
  String get tipTitle22;

  /// No description provided for @tipDesc22.
  ///
  /// In en, this message translates to:
  /// **'Replace the cartridge every 1-2 years or when it doesn\'t maintain adequate pressure. New cartridges improve filtration.'**
  String get tipDesc22;

  /// No description provided for @tipTitle23.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get tipTitle23;

  /// No description provided for @tipDesc23.
  ///
  /// In en, this message translates to:
  /// **'Store spare cartridges in a dry place. Avoid direct sunlight that damages the material.'**
  String get tipDesc23;

  /// No description provided for @tipTitle24.
  ///
  /// In en, this message translates to:
  /// **'Diatomaceous Earth Recharge'**
  String get tipTitle24;

  /// No description provided for @tipDesc24.
  ///
  /// In en, this message translates to:
  /// **'Recharge with diatomaceous earth every 2-3 weeks or after backwashing.'**
  String get tipDesc24;

  /// No description provided for @tipTitle25.
  ///
  /// In en, this message translates to:
  /// **'Frequent Backwashing'**
  String get tipTitle25;

  /// No description provided for @tipDesc25.
  ///
  /// In en, this message translates to:
  /// **'Diatomaceous earth filters require more frequent backwashing. Do it when pressure rises 7-8 psi.'**
  String get tipDesc25;

  /// No description provided for @tipTitle26.
  ///
  /// In en, this message translates to:
  /// **'Diatomaceous Earth Handling'**
  String get tipTitle26;

  /// No description provided for @tipDesc26.
  ///
  /// In en, this message translates to:
  /// **'Use a mask when handling diatomaceous earth. Avoid inhaling dust to protect your lungs.'**
  String get tipDesc26;

  /// No description provided for @tipTitle27.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Record'**
  String get tipTitle27;

  /// No description provided for @tipDesc27.
  ///
  /// In en, this message translates to:
  /// **'Keep a record of measurements and treatments. This helps identify patterns and problems.'**
  String get tipDesc27;

  /// No description provided for @tipTitle28.
  ///
  /// In en, this message translates to:
  /// **'Complete Water Test'**
  String get tipTitle28;

  /// No description provided for @tipDesc28.
  ///
  /// In en, this message translates to:
  /// **'Perform a complete water test (pH, chlorine, alkalinity, hardness) at least once a week.'**
  String get tipDesc28;

  /// No description provided for @tipTitle29.
  ///
  /// In en, this message translates to:
  /// **'Algae Prevention'**
  String get tipTitle29;

  /// No description provided for @tipDesc29.
  ///
  /// In en, this message translates to:
  /// **'Keep chlorine and pH at correct levels to prevent algae. It\'s easier to prevent than to cure.'**
  String get tipDesc29;

  /// No description provided for @tipTitle30.
  ///
  /// In en, this message translates to:
  /// **'UV Protector'**
  String get tipTitle30;

  /// No description provided for @tipDesc30.
  ///
  /// In en, this message translates to:
  /// **'Use chlorine stabilizer (cyanuric acid) to protect against UV radiation. Dose according to instructions.'**
  String get tipDesc30;

  /// No description provided for @filterGeneralTips.
  ///
  /// In en, this message translates to:
  /// **'General tips'**
  String get filterGeneralTips;

  /// No description provided for @filterLonaTips.
  ///
  /// In en, this message translates to:
  /// **'Liner pools'**
  String get filterLonaTips;

  /// No description provided for @filterObraTips.
  ///
  /// In en, this message translates to:
  /// **'Concrete pools'**
  String get filterObraTips;

  /// No description provided for @filterChlorineTips.
  ///
  /// In en, this message translates to:
  /// **'Chlorine system'**
  String get filterChlorineTips;

  /// No description provided for @filterFilterTips.
  ///
  /// In en, this message translates to:
  /// **'Filter maintenance'**
  String get filterFilterTips;

  /// No description provided for @filterByPoolType.
  ///
  /// In en, this message translates to:
  /// **'Filter by pool type'**
  String get filterByPoolType;

  /// No description provided for @filterByFilterType.
  ///
  /// In en, this message translates to:
  /// **'Filter by filter type'**
  String get filterByFilterType;

  /// No description provided for @filterByChemicalType.
  ///
  /// In en, this message translates to:
  /// **'Filter by chemical system'**
  String get filterByChemicalType;

  /// No description provided for @poolTypeAll.
  ///
  /// In en, this message translates to:
  /// **'All pools'**
  String get poolTypeAll;

  /// No description provided for @poolTypeLona.
  ///
  /// In en, this message translates to:
  /// **'Liner pool'**
  String get poolTypeLona;

  /// No description provided for @poolTypeObra.
  ///
  /// In en, this message translates to:
  /// **'Concrete pool'**
  String get poolTypeObra;

  /// No description provided for @filterTypeAll.
  ///
  /// In en, this message translates to:
  /// **'All filters'**
  String get filterTypeAll;

  /// No description provided for @filterTypeArena.
  ///
  /// In en, this message translates to:
  /// **'Sand filter'**
  String get filterTypeArena;

  /// No description provided for @filterTypeCartucho.
  ///
  /// In en, this message translates to:
  /// **'Cartridge filter'**
  String get filterTypeCartucho;

  /// No description provided for @filterTypeDiatomea.
  ///
  /// In en, this message translates to:
  /// **'Diatomaceous earth filter'**
  String get filterTypeDiatomea;

  /// No description provided for @chemicalTypeAll.
  ///
  /// In en, this message translates to:
  /// **'All systems'**
  String get chemicalTypeAll;

  /// No description provided for @chemicalTypeCloro.
  ///
  /// In en, this message translates to:
  /// **'Traditional chlorine'**
  String get chemicalTypeCloro;

  /// No description provided for @chemicalTypeSalina.
  ///
  /// In en, this message translates to:
  /// **'Salt chlorine'**
  String get chemicalTypeSalina;

  /// No description provided for @noTipsFound.
  ///
  /// In en, this message translates to:
  /// **'No tips found for the selected filters'**
  String get noTipsFound;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get resetFilters;

  /// No description provided for @noName.
  ///
  /// In en, this message translates to:
  /// **'No name'**
  String get noName;

  /// No description provided for @noPoolsMessage.
  ///
  /// In en, this message translates to:
  /// **'No pools registered'**
  String get noPoolsMessage;

  /// No description provided for @createPoolHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to create a new pool'**
  String get createPoolHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @errorLoadingPools.
  ///
  /// In en, this message translates to:
  /// **'Error loading pools'**
  String get errorLoadingPools;

  /// No description provided for @poolCreated.
  ///
  /// In en, this message translates to:
  /// **'Pool created successfully'**
  String get poolCreated;

  /// No description provided for @poolUpdated.
  ///
  /// In en, this message translates to:
  /// **'Pool updated successfully'**
  String get poolUpdated;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Pool name is required'**
  String get nameRequired;

  /// No description provided for @volumeRequired.
  ///
  /// In en, this message translates to:
  /// **'Volume is required'**
  String get volumeRequired;

  /// No description provided for @volumeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Volume must be a valid number'**
  String get volumeInvalid;

  /// No description provided for @waterTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'You must select a water type'**
  String get waterTypeRequired;

  /// No description provided for @filterTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'You must select a filter type'**
  String get filterTypeRequired;

  /// No description provided for @shapeRequired.
  ///
  /// In en, this message translates to:
  /// **'Pool shape is required'**
  String get shapeRequired;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation error'**
  String get validationError;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @editPool.
  ///
  /// In en, this message translates to:
  /// **'Edit Pool'**
  String get editPool;

  /// No description provided for @newPool.
  ///
  /// In en, this message translates to:
  /// **'New Pool'**
  String get newPool;

  /// No description provided for @poolName.
  ///
  /// In en, this message translates to:
  /// **'Pool name'**
  String get poolName;

  /// No description provided for @volumeLiters.
  ///
  /// In en, this message translates to:
  /// **'Volume (Liters)'**
  String get volumeLiters;

  /// No description provided for @waterType.
  ///
  /// In en, this message translates to:
  /// **'Water type'**
  String get waterType;

  /// No description provided for @chlorine.
  ///
  /// In en, this message translates to:
  /// **'Chlorine'**
  String get chlorine;

  /// No description provided for @salt.
  ///
  /// In en, this message translates to:
  /// **'Salt'**
  String get salt;

  /// No description provided for @filterType.
  ///
  /// In en, this message translates to:
  /// **'Filter type'**
  String get filterType;

  /// No description provided for @sand.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get sand;

  /// No description provided for @cartridge.
  ///
  /// In en, this message translates to:
  /// **'Cartridge'**
  String get cartridge;

  /// No description provided for @glass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get glass;

  /// No description provided for @poolShape.
  ///
  /// In en, this message translates to:
  /// **'Pool shape'**
  String get poolShape;

  /// No description provided for @shapeHint.
  ///
  /// In en, this message translates to:
  /// **'E.g.: Kidney, Rectangular, Oval'**
  String get shapeHint;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @updatePool.
  ///
  /// In en, this message translates to:
  /// **'Update Pool'**
  String get updatePool;

  /// No description provided for @createPool.
  ///
  /// In en, this message translates to:
  /// **'Create Pool'**
  String get createPool;

  /// No description provided for @rectangular.
  ///
  /// In en, this message translates to:
  /// **'Rectangular'**
  String get rectangular;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @liters.
  ///
  /// In en, this message translates to:
  /// **' L'**
  String get liters;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @calculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get calculator;

  /// No description provided for @problems.
  ///
  /// In en, this message translates to:
  /// **'Problems'**
  String get problems;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @parameters.
  ///
  /// In en, this message translates to:
  /// **'Parameters'**
  String get parameters;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @alkalinity.
  ///
  /// In en, this message translates to:
  /// **'Alkalinity'**
  String get alkalinity;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @stabilizer.
  ///
  /// In en, this message translates to:
  /// **'Stabilizer'**
  String get stabilizer;

  /// No description provided for @hardness.
  ///
  /// In en, this message translates to:
  /// **'Hardness'**
  String get hardness;

  /// No description provided for @phCalcDescription.
  ///
  /// In en, this message translates to:
  /// **'The pH level measures the acidity or alkalinity of your pool water; managing it is crucial for a healthy swimming environment. High pH levels render chlorine ineffective, causing the water to become cloudy or green easily. Conversely, low pH leads to eye and respiratory irritation, as well as corrosive acidic water that can damage metal components.'**
  String get phCalcDescription;

  /// No description provided for @poolVolume.
  ///
  /// In en, this message translates to:
  /// **'Pool volume'**
  String get poolVolume;

  /// No description provided for @initialPh.
  ///
  /// In en, this message translates to:
  /// **'Current pH'**
  String get initialPh;

  /// No description provided for @targetPh.
  ///
  /// In en, this message translates to:
  /// **'Target pH'**
  String get targetPh;

  /// No description provided for @currentAlkalinity.
  ///
  /// In en, this message translates to:
  /// **'Current alkalinity (ppm)'**
  String get currentAlkalinity;

  /// No description provided for @selectProduct.
  ///
  /// In en, this message translates to:
  /// **'Select product'**
  String get selectProduct;

  /// No description provided for @sodiumBicarbonate.
  ///
  /// In en, this message translates to:
  /// **'Sodium Bicarbonate'**
  String get sodiumBicarbonate;

  /// No description provided for @sodiumCarbonate.
  ///
  /// In en, this message translates to:
  /// **'Sodium Carbonate (Soda Ash)'**
  String get sodiumCarbonate;

  /// No description provided for @causticSoda.
  ///
  /// In en, this message translates to:
  /// **'Caustic Soda'**
  String get causticSoda;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @resultAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount to add'**
  String get resultAmount;

  /// No description provided for @addMeasurementOrTreatment.
  ///
  /// In en, this message translates to:
  /// **'Add measurement or treatment'**
  String get addMeasurementOrTreatment;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
