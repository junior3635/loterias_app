import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Necesario porque LotteryResultCard usa DateFormat('d MMM y', 'es').
  // Sin esto, intl lanza: "Locale data has not been initialized,
  // call initializeDateFormatting(<locale>)".
  await initializeDateFormatting('es');

  runApp(
    // ProviderScope habilita Riverpod en toda la app.
    const ProviderScope(child: LoteriasApp()),
  );
}
