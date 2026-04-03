
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pool_solution/core/widgets/common/common.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/presentation/providers/pool_provider.dart';
import 'package:pool_solution/routes/routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final poolsAsync = ref.watch(poolsListProvider);

    return Scaffold(
      drawer: LateralMenu(),
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: poolsAsync.when(
        data: (pools) {
          if (pools.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pool,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noPoolsMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.createPoolHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: pools.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.poolSetup,
                    extra: pools[index],
                  );
                },
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: Text(l10n.edit),
                              onTap: () {
                                Navigator.of(context).pop();
                                context.pushNamed(
                                  Routes.newPool,
                                  extra: pools[index],
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete),
                              title: Text(l10n.delete),
                              onTap: () {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(l10n.confirmDelete),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(l10n.cancel),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(l10n.delete),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            await ref.read(deletePoolProvider(pools[index].id!).future);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: PoolCard(pool: pools[index]),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                l10n.errorLoadingPools,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.newPool);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
