import 'dart:async';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:url_launcher/url_launcher.dart';


String image;


class Detail extends StatefulWidget {

final String imagetype,url;

  @override
  _DetailPageState createState() => new _DetailPageState();

  Detail({this.imagetype,this.url}) {
    timeDilation = 1.0;
  }
}

class _DetailPageState extends State<Detail> {
  String text;
//url launcher method
  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget displayText() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: new Text(text,
          softWrap: true,
          style: TextStyle(
            
            fontFamily: 'Josefin Sans',
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
          )),
    );
  }

  Widget _raisedButton(String url) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: new RaisedButton(
        elevation: 10.0,
        color:const Color(0xFF6400df),
        splashColor: Colors.orange,
        shape: BeveledRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
        onPressed: () {
          _launchInBrowser('https://www.segredodediva.net/wp-content/uploads/2015/10/pagamento-paypal-confirmado.jpg');
        },
        child: new Text(
          "Confirmar pagamento",
          style: new TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void initState() {
    debugPrint(widget.imagetype);
    if (widget.imagetype == 'google') {
//    if (true) {
      if (widget.url=='https://adssettings.google.com/authenticated') {
         text ='\n Ao efetuar o pagamento já tera disponivel o acesso a escola onde realizara o exame.\n Fique esperto!! Notificaremos quando os resultados das provas sairem. \n';
      }
      image = 'assets/image/enem2.jpg';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = new Size(MediaQuery.of(context).size.width, 200.0);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new DetailBody(
                  size: size, xOffset: 0, yOffset: 0, color: Colors.red),
              new Opacity(
                opacity: 0.9,
                child: new DetailBody(
                  size: size,
                  xOffset: 50,
                  yOffset: 10,
                ),
              ),
            ],
          ),
          displayText(),
          _raisedButton(widget.url),
        ],
      ),
    );
  }
}

class DetailBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  DetailBody(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _DetailBodyState();
  }
}

class _DetailBodyState extends State<DetailBody> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(new Offset(
            i.toDouble() + widget.xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        Vector.degrees2Radians) *
                    20 +
                50 +
                widget.yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new ClipPath(
              child: widget.color == null
                  ? Image.asset(
                      image,
                      width: widget.size.width,
                      height: widget.size.height,
                      fit: BoxFit.cover,
                    )
                  : new Container(
                      width: widget.size.width,
                      height: widget.size.height,
                      color: widget.color,
                    ),
              clipper: new WaveClipper(animationController.value, animList1),
            ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
