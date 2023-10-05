// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the button on the right!

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import '/backend/backend.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _AudioRecorderWidgetState createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  String? _path;
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isUploaded = false;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
  }

  @override
  void dispose() {
    _recorder?.closeAudioSession();
    _player?.closeAudioSession();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    _path = '${directory.path}/audio.mp4';

    await _recorder?.openAudioSession();
    await _recorder?.startRecorder(toFile: _path, codec: Codec.aacMP4);

    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder?.stopRecorder();
    await _recorder?.closeAudioSession();

    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _startPlaying() async {
    if (_path != null) {
      await _player?.openAudioSession();
      await _player?.startPlayer(
          fromURI: _path!,
          codec: Codec.aacMP4,
          whenFinished: () {
            setState(() {
              _isPlaying = false;
            });
          });
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _stopPlaying() async {
    await _player?.stopPlayer();
    await _player?.closeAudioSession();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _uploadAudio() async {
    if (_path != null) {
      File file = File(_path!);
      try {
        final timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        final fileName = 'uploads/audio_$timestamp.mp4';
        setState(() {
          _isUploading =
              true; // Set _isUploading to true before starting the upload
        });
        await FirebaseStorage.instance
            .ref(fileName)
            .putFile(file)
            .then((taskSnapshot) async {
          final String downloadURL = await taskSnapshot.ref.getDownloadURL();
          FFAppState().filePath = downloadURL ?? '';
          setState(() {
            _isUploaded = true;
            _isUploading =
                false; // Set _isUploading to false after the upload is complete
          });
        });
      } on FirebaseException catch (e) {
        print(e);
      }
    } else {
      print('Failed to read the recorded audio file');
    }

    // Hide Buttons 1 and 3 when the upload starts
    setState(() {
      _isRecording = false;
      _isUploading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Button 1
            Container(
              width: MediaQuery.of(context).size.width * 0.15, // 33% width
              height: 40.0, // 30px height
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: (!_isRecording &&
                        !_isPlaying &&
                        _path != null &&
                        !_isUploaded)
                    ? IconButton(
                        key: ValueKey<int>(1),
                        icon: Icon(Icons.refresh),
                        color: Color(0xffD8AD6F),
                        onPressed: _startRecording,
                        iconSize: 30.0,
                      )
                    : SizedBox.shrink(),
              ),
            ),

            // Button 2
            // Button 2
            Container(
              width: MediaQuery.of(context).size.width * 0.34, // 34% width
              height: 40.0, // 40px height (adjusted for a larger indicator)
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: _isUploaded
                    ? IconButton(
                        key: ValueKey<int>(8),
                        icon: Icon(Icons.check_circle, size: 28.0),
                        color: Color(0xffD8AD6F),
                        onPressed: () {},
                      )
                    : _path == null || _isRecording
                        ? IconButton(
                            key: ValueKey<int>(_isRecording ? 2 : 3),
                            icon: _isRecording
                                ? Icon(Icons.stop, size: 30.0)
                                : Icon(Icons.mic, size: 30.0),
                            color: Color(0xffD8AD6F),
                            onPressed:
                                _isRecording ? _stopRecording : _startRecording,
                          )
                        : (!_isRecording && _isPlaying)
                            ? IconButton(
                                key: ValueKey<int>(4),
                                icon: Icon(Icons.stop, size: 30.0),
                                color: Color(0xffD8AD6F),
                                onPressed: _stopPlaying,
                              )
                            : (!_isUploaded &&
                                    !_isRecording &&
                                    !_isPlaying &&
                                    _path != null)
                                ? _isUploading
                                    ? SizedBox(
                                        width: 25.0,
                                        height: 25.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xffD8AD6F)),
                                          strokeWidth: 2.0,
                                        ),
                                      )
                                    : IconButton(
                                        key: ValueKey<int>(5),
                                        icon:
                                            Icon(Icons.play_arrow, size: 30.0),
                                        color: Color(0xffD8AD6F),
                                        onPressed: _startPlaying,
                                      )
                                : SizedBox.shrink(),
              ),
            ),

            // Button 3
            Container(
              width: MediaQuery.of(context).size.width * 0.15, // 33% width
              height: 40.0, // 30px height
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: (!_isRecording &&
                        !_isPlaying &&
                        _path != null &&
                        !_isUploaded)
                    ? IconButton(
                        key: ValueKey<int>(6),
                        icon: Icon(Icons.cloud_upload),
                        color: Color(0xffD8AD6F),
                        onPressed: () async {
                          await _uploadAudio();

                          setState(() {
                            _isUploading = true;
                          });

                          // Hide all buttons (Button 1 and Button 3)
                          Future.delayed(Duration(milliseconds: 100), () {
                            setState(() {
                              _isRecording = false;
                              _isUploading = false;
                            });
                          });

                          await Future.delayed(Duration(seconds: 1));

                          setState(() {
                            _isUploaded = true;
                          });
                        },
                        iconSize: 30.0,
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
