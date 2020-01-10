import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/resource_parameter.dart';
import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MotivationalTypePage extends StatefulWidget {

  MotivationalTypePage({Key key}) : super(key: key);

  @override
  _MotivationalTypePageState createState() => _MotivationalTypePageState();
}

class _MotivationalTypePageState extends State<MotivationalTypePage> {
  ResourceParameter resourceParameter;
  List<Terapia> terapias;
  int terapiaPosActual;
  File _imageFile;
  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController _controller;
  String _retrieveDataError;


  Future<void> _playVideo(File file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      _controller = VideoPlayerController.file(file);
      await _controller.setVolume(0.0);
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {});
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isVideo) {
      final File file = await ImagePicker.pickVideo(source: source);
      await _playVideo(file);
    } else {
      try {
        _imageFile = await ImagePicker.pickImage(source: source);
        setState(() {});
      } catch (e) {
        _pickImageError = e;
      }
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller.dispose();
      _controller = null;
    }
  }

  Widget _previewVideo() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return FlatButton(
        padding: EdgeInsets.only(top: 80.0, bottom: 80.0),
        onPressed: (){
          isVideo = true;
          _onImageButtonPressed(ImageSource.gallery);
        },
        child: Icon(Icons.video_library, color: Colors.grey, size: 100.0,),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Container(
        child: Image.file(_imageFile), 
        padding: EdgeInsets.only(bottom: 20.0),
      );
    } else if (_pickImageError != null) {
      return FlatButton(
        onPressed: (){
          isVideo = false;  
          _onImageButtonPressed(ImageSource.gallery);
        },
        child: Icon(Icons.photo_library, color: Colors.blue,),
      );
    } else {
      return FlatButton(
        padding: EdgeInsets.only(top: 80.0, bottom: 80.0),
        onPressed: (){
          isVideo = false;
          _onImageButtonPressed(ImageSource.gallery);
        },
        child: Icon(Icons.photo_library, color: Colors.grey, size: 100.0,),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    resourceParameter = ModalRoute.of(context).settings.arguments;
    terapias = resourceParameter.terapias;
    terapiaPosActual = resourceParameter.terapiaPosActual;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _createAppBar(),
        backgroundColor: Colors.white,
        body: TabBarView(children: [
          _selectImage(),
          _selectVideo()
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _createStartTerapiaButton(),
      ),
    );
  }

  Widget _createAppBar(){
    return AppBar(
      brightness: Brightness.light,
      leading: BackButton(color: Colors.blue),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.blue),
          tooltip: 'Agregar',
          onPressed: (){
            setState(() {
              _imageFile = null;
              _controller = null;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.info, color: Colors.blue),
          tooltip: 'Ayuda',
          onPressed: (){
            _showDialog(context);
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: TabBar(
        indicatorPadding: EdgeInsets.symmetric(horizontal: 100.0),
        unselectedLabelColor: Colors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.blue),
      tabs: [
        Tab(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.blue, width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Text("Imagen"),
            ),
          ),
        ),
        Tab(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.blue, width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Text("Video"),
            ),
          ),
        ),
      ]
      ),
    );
  }

  _showDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          title: Text('Información'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.photo_library),
              Text('Presione en los iconos y seleccione una imagen/video.', textAlign: TextAlign.center,),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: ()=>Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }

  Widget _selectImage(){
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _getImage(),
          _createTitle('Terapia actual: ' + terapias[terapiaPosActual].getNameFromTerapiaType()),
          _createSubtitle('Presione el icono superior y elija una imagen.'),
        ],
      ),
    );
  }

  Widget _selectVideo(){
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _getVideo(),
          _createTitle('Terapia actual: ' + terapias[terapiaPosActual].getNameFromTerapiaType()),
          _createSubtitle('Presione el icono superior y elija una video.')
        ],
      ),
    );
  }

  Widget _getImage(){
    return Center(
      child: Platform.isAndroid
        ? FutureBuilder<void>(
            future: retrieveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text(
                    'Aún no ha seleccionado una imagen.',
                    textAlign: TextAlign.center,
                  );
                  case ConnectionState.done:
                    return _previewImage();
                  default:
                  if (snapshot.hasError) {
                    return Text(
                      'Pick image/video error: ${snapshot.error}}',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const Text(
                      'Aún no ha seleccionado una imagen.',
                      textAlign: TextAlign.center,
                    );
                  }
              }
            },
        )
      : _previewImage(),
    );
  }

  Widget _getVideo(){
    return Center(
      child: Platform.isAndroid
        ? FutureBuilder<void>(
            future: retrieveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text(
                    'Aún no ha seleccionado un video.',
                    textAlign: TextAlign.center,
                  );
                  case ConnectionState.done:
                    return _previewVideo();
                  default:
                  if (snapshot.hasError) {
                    return Text(
                      'Pick video error: ${snapshot.error}}',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const Text(
                      'Aún no ha seleccionado un video.',
                      textAlign: TextAlign.center,
                    );
                  }
              }
            },
        )
      : _previewVideo(),
    );
  }
  Widget _createStartTerapiaButton(){
    return FloatingActionButton.extended(
      onPressed: (_imageFile == null && _controller == null || (_imageFile != null && _controller != null)) ? (null) : (){
        resourceParameter.image = _imageFile;
        resourceParameter.videoPlayerController = _controller;
        Navigator.pushNamed(context, 'terapia', arguments: resourceParameter);
      },
      backgroundColor: (_imageFile == null && _controller == null || (_imageFile != null && _controller != null))
          ? (Colors.grey) : Colors.blue,
      label: Text('Iniciar terapia'),
      tooltip: (_imageFile == null && _controller == null || (_imageFile != null && _controller != null)) 
        ? 'Debe seleccionar unicamente una opción' : 'Iniciar terapia'
    );
  }

  Widget _createTitle(String title){
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        ),
      ),
    );
  }
  Widget _createSubtitle(String subtitle){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0
        ),
      ),
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.initialized) {
      initialized = controller.value.initialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
