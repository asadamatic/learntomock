class TVService {
  bool _isOn = false;
  bool get isOn => _isOn;
  void toggleOnOff() {
    _isOn = !_isOn;
  }

  double volume = 10;
  double increaseVolume(double newVolume) {
    if (newVolume > 100){
      throw Exception();
    }
    return volume = newVolume;
  }

  double decreaseVolume(double newVolume) {
    if (newVolume < 0) {
      throw Exception();
    }
    return volume = newVolume;
  }
}
