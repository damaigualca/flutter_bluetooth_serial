import 'dart:io';

import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
import 'package:video_player/video_player.dart';

class ResourceParameter{
  int terapiaPosActual;
  List<Terapia> terapias;
  File image;
  VideoPlayerController videoPlayerController;

  ResourceParameter(
    this.terapiaPosActual,
    this.terapias,
    this.image,
    this.videoPlayerController
  );
}