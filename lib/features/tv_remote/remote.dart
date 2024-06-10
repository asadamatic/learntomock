import 'package:learntomock/features/tv_remote/tv.dart';

class RemoteService {
  final TVService _tvService;

  RemoteService({required TVService tvService}) : _tvService = tvService;

  void toggleOnOff() => _tvService.toggleOnOff();

  double increaseVolume(double newVolume) {
    try {
      if (newVolume <= 100) {
        final volume = _tvService.increaseVolume(newVolume);
        return volume;
      } else {
        return 100;
      }
    } catch (error) {
      return 100;
    }
  }

  double decreaseVolume(double newVolume) {
    try{
    
    if (newVolume >= 0) {
      final volume = _tvService.decreaseVolume(newVolume);
      return volume;
    } else {
      return 0;
    }
    }
    catch (error){
      return 0;
    }
  }
}
