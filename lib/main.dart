import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_delivery_tracking/presentation/blocs/tracking/tracking_bloc.dart';
import 'package:live_delivery_tracking/presentation/screens/tracking_screen.dart';

import 'core/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Delivery Tracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: BlocProvider(
        create: (_) => di.sl<TrackingBloc>()..add(StartTracking()),
        child: const TrackingScreen(),
      ),
    );
  }
}