import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sfm_logistic/blocs/customer_bloc/customers_bloc.dart';
import 'package:sfm_logistic/core/utils.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/pages/widgets/loading_indicator.dart';
import 'package:sfm_logistic/services/customer_list_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerListService>().getCustomers().then((value) {
      switch (value) {
        case Success():
          context.go('/');
          context.showToast('Firma listesi yüklendi');
        case Failure():
          context.go('/');
          context.showErrorToast('Firma listesi yüklenemedi.${value.message}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
          state is CustomersLoaded ? context.replace('/') : null;
        },
        builder: (context, state) {
          switch (state) {
            case CustomersLoading():
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: size.width - 50,
                      height: size.height - 50,
                      child: LoadingIndicator(),
                    ),
                  ),
                ],
              );
            case CustomersLoaded():
              return SizedBox();
            case CustomersLoadFailed():
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(64),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  FilledButton(onPressed: () {}, child: Text('Tekrar Dene')),
                ],
              );
          }
        },
      ),
    );
  }
}
