import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int valueA;
  int valueB;
  String operator;
  var sbValue = new StringBuffer();

  @override
  void initState() {
    super.initState();
    sbValue.write("0");
    operator = "";
  }

  void appendValue(String str) => setState(() {
        bool isDoCalculate = false;
        if (str == "=") {
          isDoCalculate = true;
        } else if (str == "/" || str == "x" || str == "-" || str == "+") {
          if (operator.isEmpty) {
            operator = str;
          } else {
            isDoCalculate = true;
          }
        }

        if (!isDoCalculate) {
          if (sbValue.toString() == "0" && str != "0") {
            sbValue.clear();
          }
          sbValue.write(str);
        } else {
          List<String> values = sbValue.toString().split(operator);
          if (values.length == 2 &&
              values[0].isNotEmpty &&
              values[1].isNotEmpty) {
            valueA = int.parse(values[0]);
            valueB = int.parse(values[1]);
            sbValue.clear();
            int total = 0;
            switch (operator) {
              case "/":
                total = valueA ~/ valueB;
                break;
              case "x":
                total = valueA * valueB;
                break;
              case "-":
                total = valueA - valueB;
                break;
              case "+":
                total = valueA + valueB;
            }
            sbValue.write(total);
            if (str == "/" || str == "x" || str == "-" || str == "+") {
              operator = str;
              sbValue.write(str);
            } else {
              operator = "";
            }
          } else {
            String strValue = sbValue.toString();
            String lastCharacter = strValue.substring(strValue.length - 1);
            if (str == "/" || str == "x" || str == "-" || str == "+") {
              sbValue.clear();
              sbValue
                  .write(strValue.substring(0, strValue.length - 1) + "" + str);
              operator = str;
            } else if (str == "=" &&
                (lastCharacter == "/" ||
                    lastCharacter == "x" ||
                    lastCharacter == "-" ||
                    lastCharacter == "+")) {
              sbValue.clear();
              sbValue.write(strValue.substring(0, strValue.length - 1));
            }
          }
        }
      });

  void deleteValue() => setState(() {
        String strValue = sbValue.toString();
        if (strValue.length > 0) {
          String lastCharacter = strValue.substring(strValue.length - 1);
          if (lastCharacter == "/" ||
              lastCharacter == "x" ||
              lastCharacter == "-" ||
              lastCharacter == "+") {
            operator = "";
          }
          strValue = strValue.substring(0, strValue.length - 1);
          sbValue.clear();
          sbValue.write(strValue.length == 0 ? "0" : strValue);
        }
      });

  void clearValue() => setState(() {
        operator = "";
        sbValue.clear();
        sbValue.write("0");
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Theme.of(context).primaryColor,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                sbValue.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Colors.white),
              ),
            ),
          )),
          GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorLight,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: 'C',
                ontap: () {
                  setState(() {
                    clearValue();
                  });
                },
              ),
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorLight,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '+/-',
                ontap: () {},
              ),
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorLight,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '%',
                ontap: () {
                  appendValue("%");
                },
              ),
              Calculatebutton.Icon(
                  backgroundcolor: Theme.of(context).primaryColorDark,
                  foregroundcolor: Theme.of(context).primaryColorLight,
                  text: 'Backspace',
                  icon: Icons.backspace,
                  ontap: () {
                    deleteValue();
                  }),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '7',
                ontap: () {
                  setState(() {
                    appendValue("7");
                  });
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '8',
                ontap: () {
                  setState(() {
                    appendValue("8");
                  });
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '9',
                ontap: () {
                  setState(() {
                    appendValue("9");
                  });
                },
              ),
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorDark,
                foregroundcolor: Theme.of(context).primaryColorLight,
                text: '/',
                ontap: () {
                  setState(() {
                    appendValue("/");
                  });
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '4',
                ontap: () {
                  appendValue("4");
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '5',
                ontap: () {
                  appendValue("5");
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '6',
                ontap: () {
                  appendValue("6");
                },
              ),
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorDark,
                foregroundcolor: Theme.of(context).primaryColorLight,
                text: 'x',
                ontap: () {
                  appendValue("x");
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '1',
                ontap: () {
                  appendValue("1");
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '2',
                ontap: () {
                  appendValue("2");
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '3',
                ontap: () {
                  appendValue('3');
                },
              ),
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorDark,
                foregroundcolor: Theme.of(context).primaryColorLight,
                text: '-',
                ontap: () {
                  appendValue("-");
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '0',
                ontap: () {
                  appendValue("0");
                },
              ),
              Calculatebutton(
                backgroundcolor: Colors.white,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '.',
                ontap: () {
                  appendValue(".");
                },
              ),
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorLight,
                foregroundcolor: Theme.of(context).primaryColorDark,
                text: '=',
                ontap: () {
                  appendValue("=");
                },
              ),
              Calculatebutton(
                backgroundcolor: Theme.of(context).primaryColorDark,
                foregroundcolor: Theme.of(context).primaryColorLight,
                text: '+',
                ontap: () {
                  appendValue("+");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Calculatebutton extends StatelessWidget {
  final Function ontap;
  final Color backgroundcolor;
  final Color foregroundcolor;
  final String text;
  IconData icon;

  Calculatebutton(
      {@required this.backgroundcolor,
      @required this.foregroundcolor,
      @required this.text,
      @required this.ontap});

  Calculatebutton.Icon({
    @required this.backgroundcolor,
    @required this.foregroundcolor,
    @required this.icon,
    @required this.text,
    @required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        color: backgroundcolor,
        child: Center(
            child: icon == null
                ? Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: foregroundcolor),
                  )
                : Icon(
                    icon,
                    color: foregroundcolor,
                  )),
      ),
    );
  }
}
