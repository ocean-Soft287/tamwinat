import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../repository/repository.dart';
import '../handlers/handlers.dart';
import '../routes/app_router.gr.dart';

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<OrdersRepository>(OrdersRepositoryImpl());
  getIt.registerSingleton<ShopsRepository>(ShopsRepositoryImpl());
  getIt.registerSingleton<CatalogRepository>(CatalogRepositoryImpl());
  getIt.registerSingleton<CartsRepository>(CartsRepositoryImpl());
  getIt.registerSingleton<ProductsRepository>(ProductsRepositoryImpl());
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
  getIt.registerSingleton<RecipesRepository>(RecipesRepositoryImpl());
  getIt.registerSingleton<SettingsRepository>(SettingsSettingsRepositoryImpl());
  getIt.registerSingleton<AppRouter>(AppRouter());
}

final authRepository = getIt.get<AuthRepository>();
final ordersRepository = getIt.get<OrdersRepository>();
final shopsRepository = getIt.get<ShopsRepository>();
final catalogRepository = getIt.get<CatalogRepository>();
final cartRepository = getIt.get<CartsRepository>();
final productsRepository = getIt.get<ProductsRepository>();
final userRepository = getIt.get<UserRepository>();
final recipesRepository = getIt.get<RecipesRepository>();
final settingsRepository = getIt.get<SettingsRepository>();
final appRouter = getIt.get<AppRouter>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
