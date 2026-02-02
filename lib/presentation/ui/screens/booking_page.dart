import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/helpers.dart';
import '../../state/cubit/booking_cubit.dart';
import 'booking_view.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});
  @override
  Widget build(BuildContext context) {
    AppDependencies.register();
    return BlocProvider(
      create: (_) => AppDependencies.getIt<BookingCubit>(),
      child: const BookingView(),
    );
  }
}
