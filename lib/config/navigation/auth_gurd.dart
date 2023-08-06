// import 'package:b2c_mobile_app/servicess/service_locator/getit_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/core/constants/providers.dart';

class AuthGuard extends StatelessWidget {
  final Widget Function(BuildContext) authenticatedBuilder;
  final Widget Function(BuildContext) unauthenticatedBuilder;

  const AuthGuard({
    super.key,
    required this.authenticatedBuilder,
    required this.unauthenticatedBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // final authBloc = getIt<AuthorizationBloc>();

    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      // bloc: authBloc,
      builder: (context, state) {
        if (state is Authenticate) {
          return authenticatedBuilder(context);
        } else {
          return unauthenticatedBuilder(context);
        }
      },
    );
  }
}

// class AuthGuardWidget extends StatelessWidget {
//   final Widget child;

//   const AuthGuardWidget({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final authBloc = getIt<AuthorizationBloc>();

//     return BlocBuilder<AuthorizationBloc, AuthorizationState>(
//       bloc: authBloc,
//       builder: (context, state) {
//         if (state is Authenticate) {
//           return child;
//         } else {
//           final String currentRoute =
//               ModalRoute.of(context)?.settings.name ?? '';

//           return AuthScreen(
//             afterSuccessGo: () {
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 currentRoute,
//                 (route) => false,
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
