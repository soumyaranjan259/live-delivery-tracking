// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:live_delivery_tracking/presentation/blocs/tracking/tracking_bloc.dart';
// import 'package:live_delivery_tracking/presentation/widgets/bottom_sheet_widget.dart';
//
// class TrackingScreen extends StatefulWidget {
//   const TrackingScreen({super.key});
//
//   @override
//   State<TrackingScreen> createState() => _TrackingScreenState();
// }
//
// class _TrackingScreenState extends State<TrackingScreen> {
//   final MapController _mapController = MapController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Live Delivery Tracking')),
//       body: BlocBuilder<TrackingBloc, TrackingState>(
//         builder: (context, state) {
//           if (state is TrackingLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is TrackingError) {
//             return Center(child: Text(state.message));
//           }
//           if (state is TrackingLoaded) {
//             // Safe camera follow after frame build (fixes LateInitializationError)
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _mapController.move(state.currentPosition, 15.0);
//             });
//
//             return Stack(
//               children: [
//                 FlutterMap(
//                   mapController: _mapController,
//                   options: MapOptions(
//                     initialCenter: state.route.first,
//                     initialZoom: 13.0,
//                     onMapReady: () {
//                       _mapController.move(state.currentPosition, 15.0);
//                     },
//                   ),
//                   children: [
//                     TileLayer(
//                       urlTemplate: 'https://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
//                       subdomains: const ['0', '1', '2', '3'],
//                       userAgentPackageName: 'com.soumy.live_delivery_tracking',
//                     ),
//                     PolylineLayer(
//                       polylines: [
//                         Polyline(
//                           points: state.route,
//                           color: Colors.blueAccent,
//                           strokeWidth: 6,
//                           borderStrokeWidth: 3,
//                           borderColor: Colors.white,
//                         ),
//                       ],
//                     ),
//                     MarkerLayer(
//                       markers: [
//                         Marker(
//                           point: state.currentPosition,
//                           width: 60,
//                           height: 60,
//                           alignment: Alignment.topCenter,
//                           child: Transform.rotate(
//                             angle: state.heading * (3.1415926535 / 180),
//                             child: const Icon(Icons.motorcycle, color: Colors.red, size: 50),
//                           ),
//                         ),
//                         Marker(
//                           point: LatLng(state.order.customer.lat, state.order.customer.lng),
//                           width: 50,
//                           height: 50,
//                           child: const Icon(Icons.location_on, color: Colors.green, size: 50),
//                         ),
//                       ],
//                     ),
//                     const RichAttributionWidget(
//                       alignment: AttributionAlignment.bottomRight,
//                       attributions: [
//                         TextSourceAttribution('© Google Maps'),
//                         TextSourceAttribution('© OpenStreetMap contributors'),
//                       ],
//                     ),
//                   ],
//                 ),
//                 DraggableScrollableSheet(
//                   initialChildSize: 0.35,
//                   minChildSize: 0.15,
//                   maxChildSize: 0.6,
//                   builder: (_, controller) => BottomSheetWidget(state: state),
//                 ),
//               ],
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }


import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:live_delivery_tracking/presentation/blocs/tracking/tracking_bloc.dart';
import 'package:live_delivery_tracking/presentation/widgets/bottom_sheet_widget.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Delivery Tracking')),
      body: BlocBuilder<TrackingBloc, TrackingState>(
        builder: (context, state) {
          if (state is TrackingLoading) return const Center(child: CircularProgressIndicator());
          if (state is TrackingError) return Center(child: Text(state.message));

          if (state is TrackingLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _mapController.move(state.currentPosition, 15.0);
            });

            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: state.route.first,
                    initialZoom: 14.0,
                    onMapReady: () => _mapController.move(state.currentPosition, 15.0),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.qurinom.live_delivery_tracking',
                    ),
                    PolylineLayer(
                      polylines: [Polyline(points: state.route, color: Colors.blueAccent, strokeWidth: 6, borderColor: Colors.white, borderStrokeWidth: 3)],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: state.currentPosition,
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: state.heading * (math.pi / 180),
                            child: Image.network(
                              'https://www.shutterstock.com/image-photo/top-view-delivery-rider-red-600nw-2462807671.jpg',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(Icons.motorcycle, color: Colors.red, size: 60),
                            ),
                          ),
                        ),
                        Marker(
                          point: LatLng(state.order.customer.lat, state.order.customer.lng),
                          width: 50,
                          height: 50,
                          child: const Icon(Icons.location_on, color: Colors.green, size: 50),
                        ),
                      ],
                    ),
                    const RichAttributionWidget(attributions: [TextSourceAttribution('© OpenStreetMap contributors')]),
                  ],
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.35,
                  minChildSize: 0.15,
                  maxChildSize: 0.6,
                  builder: (_, controller) => BottomSheetWidget(state: state),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:live_delivery_tracking/presentation/blocs/tracking/tracking_bloc.dart';
import 'package:live_delivery_tracking/presentation/widgets/bottom_sheet_widget.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    context.read<TrackingBloc>().add(StartTracking());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Delivery Tracking')),
      body: BlocBuilder<TrackingBloc, TrackingState>(
        builder: (context, state) {
          if (state is TrackingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TrackingError) {
            return Center(child: Text(state.message));
          }
          if (state is TrackingLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _mapController.move(state.currentPosition, 15.0);
            });

            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: state.route.first,
                    initialZoom: 13.0,
                    onMapReady: () {
                      _mapController.move(state.currentPosition, 15.0);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                      subdomains: const ['0', '1', '2', '3'],
                      userAgentPackageName: 'com.qurinom.delivery.tracking',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: state.route,
                          color: Colors.blueAccent,
                          strokeWidth: 6,
                          borderStrokeWidth: 3,
                          borderColor: Colors.white,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        // Realistic delivery bike with rider (top view)
                        Marker(
                          point: state.currentPosition,
                          width: 70,
                          height: 70,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: state.heading * (pi / 180),
                            child: Image.network(
                              'https://static.vecteezy.com/system/resources/previews/046/062/085/non_2x/delivery-boy-riding-scooter-with-delivery-box-in-red-uniform-food-and-parcel-delivery-service-concept-vector.jpg',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(Icons.motorcycle, color: Colors.red, size: 60),
                            ),
                          ),
                        ),
                        // Destination pin
                        Marker(
                          point: LatLng(state.order.customer.lat, state.order.customer.lng),
                          width: 50,
                          height: 50,
                          child: const Icon(Icons.location_on, color: Colors.green, size: 50),
                        ),
                      ],
                    ),
                    const RichAttributionWidget(
                      alignment: AttributionAlignment.bottomRight,
                      attributions: [
                        TextSourceAttribution('© Google Maps'),
                        TextSourceAttribution('© OpenStreetMap contributors'),
                      ],
                    ),
                  ],
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.35,
                  minChildSize: 0.15,
                  maxChildSize: 0.6,
                  builder: (_, controller) => BottomSheetWidget(state: state),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}*/
