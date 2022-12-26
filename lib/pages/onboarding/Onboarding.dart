import 'package:globaluy_test_app/pages/onboarding/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void login() {
    /* Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginThreePage()));*/
    // Navigator.pushReplacementNamed(context, '/indexApp');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(),
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      'Omitir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      ),
                  height: size.height - 150,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 220,
                                child: const Image(
                                  image: AssetImage(
                                    'lib/resources/images/onboarding-3.png',
                                  ),
                                  height: 200.0,
                                  width: 300.0,
                                ),
                                padding: const EdgeInsets.only(bottom: 10.0),
                              ),
                              Text(
                                'Crea y envía link de pago a tus clientes fácilmente',
                                textAlign: TextAlign.center,
                                style: kTitleStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 220,
                                child: const Image(
                                  image: AssetImage(
                                    'lib/resources/images/onboarding-2.png',
                                  ),
                                  height: 200.0,
                                  width: 300.0,
                                ),
                                padding: const EdgeInsets.only(bottom: 10.0),
                              ),
                              Text(
                                'Cobra con POS Virtual y QR de manera práctica',
                                textAlign: TextAlign.center,
                                style: kTitleStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 220,
                                child: const Image(
                                  image: AssetImage(
                                    'lib/resources/images/onboarding-1.png',
                                  ),
                                  height: 200.0,
                                  width: 300.0,
                                ),
                                padding: const EdgeInsets.only(bottom: 10.0),
                              ),
                              Text(
                                'Visualiza tus transacciones en tiempo real',
                                textAlign: TextAlign.center,
                                style: kTitleStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ) /*,
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Siguiente',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),*/
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          color: Color(0xFF5B16D0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )))
          : Text(''),
    );
  }
}
