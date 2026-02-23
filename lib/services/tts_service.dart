// lib/services/tts_service.dart
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _tts = FlutterTts();

  // Initialize TTS settings
  Future<void> initialize() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5);   // Slower for clarity
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  // Speak text
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  // Stop speaking
  Future<void> stop() async {
    await _tts.stop();
  }

  // Check if TTS is speaking
  Future<bool> isSpeaking() async {
    return await _tts.isSpeaking;
  }
}