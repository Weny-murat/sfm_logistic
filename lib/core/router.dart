import 'package:go_router/go_router.dart';
import 'package:sfm_logistic/pages/archived_lists_page.dart';
import 'package:sfm_logistic/pages/home_page.dart';
import 'package:sfm_logistic/pages/loading_list_page.dart';
import 'package:sfm_logistic/pages/loading_lists_page.dart';
import 'package:sfm_logistic/pages/splash_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashPage()),
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: '/l_list',
          builder: (context, state) => LoadingListPage(),
        ),
        GoRoute(
          path: '/l_lists',
          builder: (context, state) => LoadingListsPage(),
        ),
        GoRoute(
          path: '/archived_lists',
          builder: (context, state) => ArchivedListsPage(),
        ),
      ],
    ),
  ],
);
