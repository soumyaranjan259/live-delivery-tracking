import 'package:flutter/material.dart';
import 'package:live_delivery_tracking/presentation/blocs/tracking/tracking_bloc.dart';

class BottomSheetWidget extends StatelessWidget {
  final TrackingLoaded state;

  const BottomSheetWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (state.status) {
      "picked" => Colors.orange,
      "en_route" => Colors.blue,
      "arriving" => Colors.purple,
      "delivered" => Colors.green,
      _ => Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Container(width: 50, height: 5, color: Colors.grey[300])),
          const SizedBox(height: 20),
          Text('Order ID: ${state.order.orderId}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('Driver: ${state.order.driver.name}', style: const TextStyle(fontSize: 18)),
          Text('Vehicle: ${state.order.driver.vehicle}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          Text('Status: ${state.status.toUpperCase()}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: statusColor)),
          const SizedBox(height: 12),
          Text('ETA: ${state.eta} minutes', style: const TextStyle(fontSize: 18)),
          Text('Distance Remaining: ${state.remainingDistance.toStringAsFixed(2)} km', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          Text('Last Updated: ${state.lastUpdated.hour}:${state.lastUpdated.minute.toString().padLeft(2, '0')}', style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}