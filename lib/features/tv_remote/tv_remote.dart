import 'package:learntomock/features/tv_remote/tv_remote.dart' as learntomock;
import 'package:learntomock/features/tv_remote/remote.dart';
import 'package:learntomock/features/tv_remote/tv.dart';

void main() {
  final TVService tvService = TVService();
  final RemoteService remoteService = RemoteService(tvService: tvService);

  printPowerStatus(tvService.isOn);
  remoteService.toggleOnOff();
  printPowerStatus(tvService.isOn);

  printVolume(tvService.volume);
  // Increase volumet to max capacity
  remoteService.increaseVolume(100);
  printVolume(tvService.volume);

  // Increase volumet beyond max capacity
  remoteService.increaseVolume(101);
  printVolume(tvService.volume);

  // Decrease volumet to min capacity
  remoteService.decreaseVolume(0);
  printVolume(tvService.volume);

  // Decrease volumet beyond min capacity
  remoteService.increaseVolume(101);
  printVolume(tvService.volume);
}

printPowerStatus(bool value) => print("Power Status $value");
printVolume(double volume) => print("Volume $volume");
