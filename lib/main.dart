import 'package:arcopen_enquirer/utils/helpers/k_storage.dart';
import 'package:arcopen_enquirer/utils/services/k_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/core/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Loading DotEnv from .env file
  await dotenv.load();

  // Registering routes
  KRoutes.registerRoutes();

  // Initialising storage
  KStorage().init();

  // Registering service locators
  KService().registerServices();

  // Running application
  runApp(Application());
}
