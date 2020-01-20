import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/resource_parameter.dart';
import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/motivational_type_page.dart';
import 'package:flutter_bluetooth_serial_example/src/services/terapia_service.dart';
import 'package:photo_view/photo_view.dart';
class HeroPhotoViewWrapper extends StatefulWidget {
  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final ResourceParameter resourceParameter;

  HeroPhotoViewWrapper({Key key, this.imageProvider, this.loadingChild, this.backgroundDecoration, this.minScale, this.maxScale, this.resourceParameter}) : super(key: key);
  
  @override
  _HeroPhotoViewWrapperState createState() => _HeroPhotoViewWrapperState();
}

class _HeroPhotoViewWrapperState extends State<HeroPhotoViewWrapper> {
  int terapiaPosActual;


  @override
  Widget build(BuildContext context) {
    terapiaPosActual = widget.resourceParameter.terapiaPosActual - 1;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: (widget.resourceParameter.videoPlayerController == null) ? PhotoView(
          imageProvider: widget.imageProvider,
          loadingChild: widget.loadingChild,
          backgroundDecoration: widget.backgroundDecoration,
          minScale: widget.minScale,
          maxScale: widget.maxScale,
          heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
        )
        :
        AspectRatioVideo(widget.resourceParameter.videoPlayerController),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _createContinueButton(context),
    );
  }

  Widget _createContinueButton(BuildContext context){
    return FloatingActionButton.extended(
      onPressed: _checkIfIsLastTerapia() 
      ? (){ // Si es la ultima terapia de la lista avanzo a la ventana de observaciones
        ResourceParameter newResource = widget.resourceParameter;
        if(newResource.terapias[terapiaPosActual].completado){
          saveTerapia(widget.resourceParameter.terapias[terapiaPosActual], context);
        }
        Future.delayed(Duration(milliseconds: 500),(){
          Navigator.pushNamed(context, 'resultado_terapia', arguments: newResource);
        });
      } 
      : (){ // Si no es la ultima continuo con las demas listas
        if(widget.resourceParameter.terapias[terapiaPosActual].completado){
          saveTerapia(widget.resourceParameter.terapias[terapiaPosActual], context);
        }
        Navigator.pushNamed(context, 'motivational_type', arguments: widget.resourceParameter);
      },
      backgroundColor: Colors.blue,
      label: _checkIfIsLastTerapia() ? Text('Finalizar') : Text('Continuar')
    );
  }

  bool _checkIfIsLastTerapia(){
    if(widget.resourceParameter.terapiaPosActual >=_countTerapias()){
      return true; // Si es ultima terapia
    }else{
      return false; // No es ultima terapia
    }
  }

  saveTerapia(Terapia terapia, BuildContext context) async{
    print(terapia);
    await TerapiaService.addTerapia(terapia);
  }

  int _countTerapias(){
    int contador = 0;
    widget.resourceParameter.terapias.forEach((f) => {
      contador = contador + 1
    });
    return contador;
  }
}