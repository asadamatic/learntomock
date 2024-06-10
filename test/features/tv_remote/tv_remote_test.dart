import 'package:learntomock/features/tv_remote/tv_remote.dart';
import 'package:learntomock/features/tv_remote/remote.dart';
import 'package:learntomock/features/tv_remote/tv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'tv_remote_test.mocks.dart';


@GenerateMocks([TVService])
void main() {
  final MockTVService mockTVService = MockTVService();
  final RemoteService remoteService = RemoteService(tvService: mockTVService);

  group('Testing Power Button', () {
    test("Toggle Power", () {
      final mockAction = mockTVService.toggleOnOff;
      when(mockAction()).thenReturn(null);

      remoteService.toggleOnOff();
      verify(mockAction()).called(1);
    });
  });
  group('Testing Volume Up Button', () {
    test("Volume Up Successful", () {
      final mockAction = mockTVService.increaseVolume;
      when(mockAction(100)).thenReturn(100);
      final result = remoteService.increaseVolume(100);
      verify(mockAction(100)).called(1);
      expect(result, 100);
    });
    test("Volume Up Failed", () {
      final mockAction = mockTVService.increaseVolume;

      when(mockAction(101)).thenThrow(Exception());
      final result = remoteService.increaseVolume(101);
      verifyNever(mockAction(101));
      expect(result, 100);
      expect(() => mockAction(101), throwsException);
    });
  });
  group('Testing Volume Button', () {
    test("Volume Down Successful", () {
      final mockAction = mockTVService.decreaseVolume;

      when(mockAction(0)).thenReturn(0);
      final result = remoteService.decreaseVolume(0);
      verify(mockAction(0)).called(1);
      expect(result, 0);
    });
    test("Volume Down Failed", () {
      final mockAction = mockTVService.decreaseVolume;
      when(mockAction(-1)).thenThrow(Exception());
      final result = remoteService.decreaseVolume(-1);
      verifyNever(mockTVService.decreaseVolume(-1));
      expect(result, 0);
      expect(() => mockAction(-1), throwsException);
    });
  });
}
