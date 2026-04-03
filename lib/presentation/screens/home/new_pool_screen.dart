import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/presentation/providers/pool_provider.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class NewPoolScreen extends ConsumerStatefulWidget {
  final PoolEntity? pool;

  const NewPoolScreen({
    super.key,
    this.pool,
  });

  @override
  ConsumerState<NewPoolScreen> createState() => _NewPoolScreenState();
}

class _NewPoolScreenState extends ConsumerState<NewPoolScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _volumeController;
  late final TextEditingController _shapeController;
  
  WaterType? _selectedWaterType;
  FilterType? _selectedFilterType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pool?.name ?? '');
    _volumeController = TextEditingController(
      text: widget.pool?.volumeLiters?.toString() ?? '',
    );
    _shapeController = TextEditingController(text: widget.pool?.shape ?? '');
    _selectedWaterType = widget.pool?.waterType;
    _selectedFilterType = widget.pool?.filterType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _volumeController.dispose();
    _shapeController.dispose();
    super.dispose();
  }

  Future<void> _savePool() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      final l10n = AppLocalizations.of(context)!;
      final pool = PoolEntity(
        id: widget.pool?.id,
        name: _nameController.text.trim(),
        volumeLiters: double.tryParse(_volumeController.text),
        waterType: _selectedWaterType,
        filterType: _selectedFilterType,
        shape: _shapeController.text.trim(),
        createdAt: widget.pool?.createdAt ?? DateTime.now(),
      );

      await ref.read(savePoolProvider(pool).future);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.pool == null ? l10n.poolCreated : l10n.poolUpdated,
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.error}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _validateForm() {
    final l10n = AppLocalizations.of(context)!;
    if (_nameController.text.isEmpty) {
      _showErrorDialog(l10n.nameRequired);
      return false;
    }
    if (_volumeController.text.isEmpty) {
      _showErrorDialog(l10n.volumeRequired);
      return false;
    }
    if (double.tryParse(_volumeController.text) == null) {
      _showErrorDialog(l10n.volumeInvalid);
      return false;
    }
    if (_selectedWaterType == null) {
      _showErrorDialog(l10n.waterTypeRequired);
      return false;
    }
    if (_selectedFilterType == null) {
      _showErrorDialog(l10n.filterTypeRequired);
      return false;
    }
    if (_shapeController.text.isEmpty) {
      _showErrorDialog(l10n.shapeRequired);
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.validationError),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.pool != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? l10n.editPool : l10n.newPool,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nombre
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.poolName,
                prefixIcon: const Icon(Icons.pool),
              ),
            ),
            const SizedBox(height: 16),

            // Volumen
            TextField(
              controller: _volumeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.volumeLiters,
                prefixIcon: const Icon(Icons.water_drop),
              ),
            ),
            const SizedBox(height: 16),

            // Tipo de agua
            DropdownButtonFormField<WaterType>(
              initialValue: _selectedWaterType,
              decoration: InputDecoration(
                labelText: l10n.waterType,
                prefixIcon: const Icon(Icons.science),
              ),
              items: WaterType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                    type.name == 'chlorine' ? l10n.chlorine : l10n.salt,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedWaterType = value);
              },
            ),
            const SizedBox(height: 16),

            // Tipo de filtro
            DropdownButtonFormField<FilterType>(
              initialValue: _selectedFilterType,
              decoration: InputDecoration(
                labelText: l10n.filterType,
                prefixIcon: const Icon(Icons.filter_list),
              ),
              items: FilterType.values.map((type) {
                String label;
                switch (type.name) {
                  case 'sand':
                    label = l10n.sand;
                    break;
                  case 'cartridge':
                    label = l10n.cartridge;
                    break;
                  case 'glass':
                    label = l10n.glass;
                    break;
                  default:
                    label = type.name;
                }
                return DropdownMenuItem(
                  value: type,
                  child: Text(label),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedFilterType = value);
              },
            ),
            const SizedBox(height: 16),

            // Forma de la piscina
            TextField(
              controller: _shapeController,
              decoration: InputDecoration(
                labelText: l10n.poolShape,
                hintText: l10n.shapeHint,
                prefixIcon: const Icon(Icons.shape_line),
              ),
            ),
            const SizedBox(height: 32),

            // Botón Guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _savePool,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  _isLoading
                      ? l10n.saving
                      : isEditing
                          ? l10n.updatePool
                          : l10n.createPool,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
