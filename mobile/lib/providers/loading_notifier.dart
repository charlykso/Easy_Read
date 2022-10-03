import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  /// Set loading state of the app as true
  void turnOn() => state = true;

  /// Set loading state of the app as false
  void turnOff() => state = false;
}
