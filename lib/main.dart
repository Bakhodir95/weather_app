import 'package:exchange_app/app.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/theme/theme_block.dart';
import 'package:exchange_app/src/repositories/exchange_repositories.dart';
import 'package:exchange_app/src/repositories/theme_repository.dart';
import 'package:exchange_app/src/services/exchange_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final exchangeApiService = ExchangeApiService();
  final exchangeRateRepository =
      ExchangeRateRepository(apiService: exchangeApiService);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(ThemeRepository()),
        ),
        BlocProvider(
          create: (context) =>
              ExchangeRateBloc(repository: exchangeRateRepository),
        ),
      ],
      child: MyApp(),
    ),
  );
}
