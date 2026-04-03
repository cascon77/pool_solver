import 'package:flutter/material.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class TipEntity {
  final int id;
  final String category; // 'general', 'cloro', 'lona', 'obra', 'filtro'
  final String? poolType; // 'lona', 'obra', 'all' (null = all)
  final String? filterType; // 'arena', 'cartucho', 'diatomea', 'all' (null = all)
  final String? chemicalType; // 'cloro', 'salina', 'all' (null = all)

  const TipEntity({
    required this.id,
    required this.category,
    this.poolType,
    this.filterType,
    this.chemicalType,
  });

  /// Get translated title
  String getTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (id) {
      case 1:
        return l10n.tipTitle1;
      case 2:
        return l10n.tipTitle2;
      case 3:
        return l10n.tipTitle3;
      case 4:
        return l10n.tipTitle4;
      case 5:
        return l10n.tipTitle5;
      case 6:
        return l10n.tipTitle6;
      case 7:
        return l10n.tipTitle7;
      case 8:
        return l10n.tipTitle8;
      case 9:
        return l10n.tipTitle9;
      case 10:
        return l10n.tipTitle10;
      case 11:
        return l10n.tipTitle11;
      case 12:
        return l10n.tipTitle12;
      case 13:
        return l10n.tipTitle13;
      case 14:
        return l10n.tipTitle14;
      case 15:
        return l10n.tipTitle15;
      case 16:
        return l10n.tipTitle16;
      case 17:
        return l10n.tipTitle17;
      case 18:
        return l10n.tipTitle18;
      case 19:
        return l10n.tipTitle19;
      case 20:
        return l10n.tipTitle20;
      case 21:
        return l10n.tipTitle21;
      case 22:
        return l10n.tipTitle22;
      case 23:
        return l10n.tipTitle23;
      case 24:
        return l10n.tipTitle24;
      case 25:
        return l10n.tipTitle25;
      case 26:
        return l10n.tipTitle26;
      case 27:
        return l10n.tipTitle27;
      case 28:
        return l10n.tipTitle28;
      case 29:
        return l10n.tipTitle29;
      case 30:
        return l10n.tipTitle30;
      default:
        return 'Tip $id';
    }
  }

  /// Get translated description
  String getDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (id) {
      case 1:
        return l10n.tipDesc1;
      case 2:
        return l10n.tipDesc2;
      case 3:
        return l10n.tipDesc3;
      case 4:
        return l10n.tipDesc4;
      case 5:
        return l10n.tipDesc5;
      case 6:
        return l10n.tipDesc6;
      case 7:
        return l10n.tipDesc7;
      case 8:
        return l10n.tipDesc8;
      case 9:
        return l10n.tipDesc9;
      case 10:
        return l10n.tipDesc10;
      case 11:
        return l10n.tipDesc11;
      case 12:
        return l10n.tipDesc12;
      case 13:
        return l10n.tipDesc13;
      case 14:
        return l10n.tipDesc14;
      case 15:
        return l10n.tipDesc15;
      case 16:
        return l10n.tipDesc16;
      case 17:
        return l10n.tipDesc17;
      case 18:
        return l10n.tipDesc18;
      case 19:
        return l10n.tipDesc19;
      case 20:
        return l10n.tipDesc20;
      case 21:
        return l10n.tipDesc21;
      case 22:
        return l10n.tipDesc22;
      case 23:
        return l10n.tipDesc23;
      case 24:
        return l10n.tipDesc24;
      case 25:
        return l10n.tipDesc25;
      case 26:
        return l10n.tipDesc26;
      case 27:
        return l10n.tipDesc27;
      case 28:
        return l10n.tipDesc28;
      case 29:
        return l10n.tipDesc29;
      case 30:
        return l10n.tipDesc30;
      default:
        return 'Description for tip $id';
    }
  }

  /// Get translated category name
  String getCategoryName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case 'general':
        return l10n.tipCategoryGeneral;
      case 'lona':
        return l10n.tipCategoryLona;
      case 'obra':
        return l10n.tipCategoryObra;
      case 'cloro':
        return l10n.tipCategoryCloro;
      case 'filtro':
        return l10n.tipCategoryFiltro;
      default:
        return category;
    }
  }

  /// Check if this tip applies to the given pool configuration
  bool appliesToPool({
    String? poolType,
    String? filterType,
    String? chemicalType,
  }) {
    // Check pool type
    if (this.poolType != null && this.poolType != 'all') {
      if (poolType != null && this.poolType != poolType) {
        return false;
      }
    }

    // Check filter type
    if (this.filterType != null && this.filterType != 'all') {
      if (filterType != null && this.filterType != filterType) {
        return false;
      }
    }

    // Check chemical type
    if (this.chemicalType != null && this.chemicalType != 'all') {
      if (chemicalType != null && this.chemicalType != chemicalType) {
        return false;
      }
    }

    return true;
  }
}
