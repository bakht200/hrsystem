import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_system/cubit/authentication/authentication_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<AuthenticationCubit>(
        create: (context) => AuthenticationCubit()),
  ];
}
