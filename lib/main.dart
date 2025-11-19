import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sfm_logistic/blocs/archived_lists_cubit/archived_lists_cubit.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_bloc.dart';
import 'package:sfm_logistic/blocs/loading_list_cubit/loading_list_cubit.dart';
import 'package:sfm_logistic/blocs/customer_bloc/customers_bloc.dart';
import 'package:sfm_logistic/blocs/loading_lists_cubit/loading_lists_cubit.dart';
import 'package:sfm_logistic/blocs/pdf_bloc/pdf_bloc.dart';
import 'package:sfm_logistic/core/router.dart';
import 'package:sfm_logistic/data/network_service.dart';
import 'package:sfm_logistic/services/customer_list_service.dart';
import 'package:sfm_logistic/services/motor_model_list_service.dart';
import 'package:sfm_logistic/services/pdf_service.dart';
import 'package:sfm_logistic/services/rest_api_service.dart';
import 'package:sfm_logistic/services/token_storage_service.dart';
import 'package:toastification/toastification.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('tr_TR', null);

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // Servisleri başlat
  final tokenStorageService = TokenStorageService();

  final networkService = NetworkService(tokenStorageService);
  final restApiService = RestApiService(networkService);
  final customerListService = CustomerListService(
    networkService: networkService,
  );
  final motorModelListService = MotorModelListService(networkService);
  final pdfService = PdfService(motorModelListService: motorModelListService);
  final loadingListCubit = LoadingListCubit();
  final loadingListsCubit = LoadingListsCubit(network: networkService);
  final archivedListsCubit = ArchivedListsCubit(network: networkService);
  await motorModelListService.getModels();

  runApp(
    MainApp(
      tokenStorageService: tokenStorageService,
      networkService: networkService,
      restApiService: restApiService,
      customerListService: customerListService,
      motorModelListService: motorModelListService,
      loadingListCubit: loadingListCubit,
      loadingListsCubit: loadingListsCubit,
      archivedListsCubit: archivedListsCubit,
      pdfService: pdfService,
    ),
  );
}

class MainApp extends StatelessWidget {
  final TokenStorageService tokenStorageService;
  final NetworkService networkService;
  final RestApiService restApiService;
  final CustomerListService customerListService;
  final MotorModelListService motorModelListService;
  final LoadingListCubit loadingListCubit;
  final LoadingListsCubit loadingListsCubit;
  final ArchivedListsCubit archivedListsCubit;
  final PdfService pdfService;

  const MainApp({
    super.key,
    required this.tokenStorageService,
    required this.networkService,
    required this.restApiService,
    required this.customerListService,
    required this.motorModelListService,
    required this.loadingListCubit,
    required this.loadingListsCubit,
    required this.archivedListsCubit,
    required this.pdfService,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: tokenStorageService),
            RepositoryProvider.value(value: networkService),
            RepositoryProvider.value(value: restApiService),
            RepositoryProvider.value(value: customerListService),
            RepositoryProvider.value(value: motorModelListService),
            RepositoryProvider.value(value: pdfService),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => CustomersBloc(service: customerListService),
              ),
              BlocProvider(create: (_) => PdfBloc(pdfService: pdfService)),
              BlocProvider.value(value: loadingListCubit),
              BlocProvider.value(value: loadingListsCubit),
              BlocProvider.value(value: archivedListsCubit),
              BlocProvider(
                create: (context) => ListEditBloc(
                  router: router,
                  customerListService: customerListService,
                  loadingListCubit: loadingListCubit,
                ),
              ),
            ],
            child: ToastificationWrapper(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,

                // theme: ThemeData.dark(),
                routerConfig: router,
              ),
            ),
          ),
        );
      },
    );
  }
}
