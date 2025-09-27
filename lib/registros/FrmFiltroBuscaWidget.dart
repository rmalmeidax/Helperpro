import 'package:flutter/material.dart';

class FrmFiltroBuscaWidget extends StatefulWidget {
  const FrmFiltroBuscaWidget({Key? key}) : super(key: key);

  static String routeName = 'FrmFiltroBusca';
  static String routePath = '/frmBuscaFiltro';

  @override
  State<FrmFiltroBuscaWidget> createState() => _FrmFiltroBuscaWidgetState();
}

class _FrmFiltroBuscaWidgetState extends State<FrmFiltroBuscaWidget>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Controllers
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final FocusNode textFieldFocusNode1 = FocusNode();
  final FocusNode textFieldFocusNode2 = FocusNode();

  // Form values
  String? dropDownValue1;
  String? dropDownValue2;
  double sliderValue = 5.0;

  // Checkbox values
  bool checkboxValue1 = true;
  bool checkboxValue2 = true;
  bool checkboxValue3 = true;
  bool checkboxValue4 = true;
  bool checkboxValue5 = true;
  bool checkboxValue6 = true;
  bool checkboxValue7 = true;

  // Skill checkboxes
  bool chkDrywallValue1 = false;
  bool chkDrywallValue2 = false;
  bool chkDrywallValue3 = false;
  bool chkDrywallValue4 = false;
  bool chkDrywallValue5 = false;
  bool chkDrywallValue6 = false;
  bool chkDrywallValue7 = false;
  bool chkDrywallValue8 = false;
  bool chkDrywallValue9 = false;
  bool chkDrywallValue10 = false;
  bool chkDrywallValue11 = false;
  bool chkDrywallValue12 = false;
  bool chkDrywallValue13 = false;
  bool chkDrywallValue14 = false;
  bool chkDrywallValue15 = false;
  bool chkDrywallValue16 = false;
  bool chkDrywallValue17 = false;
  bool chkDrywallValue18 = false;
  bool chkDrywallValue19 = false;
  bool chkDrywallValue20 = false;
  bool chkDrywallValue21 = false;
  bool chkDrywallValue22 = false;

  // Animation controllers
  late AnimationController _containerAnimationController;
  late AnimationController _textField1AnimationController;
  late AnimationController _textField2AnimationController;
  late AnimationController _rowAnimationController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _containerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _textField1AnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _textField2AnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _rowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Start animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _containerAnimationController.forward();
      Future.delayed(const Duration(milliseconds: 170), () {
        _textField1AnimationController.forward();
        _textField2AnimationController.forward();
      });
      Future.delayed(const Duration(milliseconds: 380), () {
        _rowAnimationController.forward();
      });
    });
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
    _containerAnimationController.dispose();
    _textField1AnimationController.dispose();
    _textField2AnimationController.dispose();
    _rowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[50],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 3,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 1.001,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.92,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 44, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Header Row
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filtro',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.0,
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              color: Colors.grey[600],
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Animated gradient container
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 16),
                      child: AnimatedBuilder(
                        animation: _containerAnimationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: Tween<double>(begin: 0.4, end: 1.0)
                                .animate(CurvedAnimation(
                              parent: _containerAnimationController,
                              curve: Curves.easeInOut,
                            ))
                                .value,
                            child: Transform.translate(
                              offset: Tween<Offset>(
                                begin: const Offset(0, 30),
                                end: const Offset(0, 0),
                              ).animate(CurvedAnimation(
                                parent: _containerAnimationController,
                                curve: Curves.easeInOut,
                              )).value,
                              child: Opacity(
                                opacity: _containerAnimationController.value,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 6,
                                        color: Color(0x4B1A1F24),
                                        offset: Offset(0.0, 2),
                                      )
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [Colors.white, Colors.blueAccent],
                                      stops: [0, 1],
                                      begin: AlignmentDirectional(0.94, -1),
                                      end: AlignmentDirectional(-0.94, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Work selection dropdown
                    const Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Selecione o Trabalho',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: DropdownButtonFormField<String>(
                              value: dropDownValue1,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                              ),
                              items: const <DropdownMenuItem<String>>[],
                              onChanged: (String? value) {
                                setState(() {
                                  dropDownValue1 = value;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey[600],
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Help type dropdown
                    const Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Tipo de ajuda',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: DropdownButtonFormField<String>(
                              value: dropDownValue2,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Option 1', child: Text('Ajudante')),
                                DropdownMenuItem(value: 'Option 2', child: Text('Profissional Diaria')),
                                DropdownMenuItem(value: 'Option 3', child: Text('Profissional SubContrato')),
                                DropdownMenuItem(value: '3', child: Text('Todos')),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  dropDownValue2 = value;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey[600],
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Scrollable content
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          // Price range text fields
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 20),
                                  child: AnimatedBuilder(
                                    animation: _textField1AnimationController,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scaleY: _textField1AnimationController.value,
                                        child: Transform.translate(
                                          offset: Tween<Offset>(
                                            begin: const Offset(0, 80),
                                            end: const Offset(0, 0),
                                          ).animate(CurvedAnimation(
                                            parent: _textField1AnimationController,
                                            curve: Curves.easeInOut,
                                          )).value,
                                          child: Opacity(
                                            opacity: _textField1AnimationController.value,
                                            child: TextFormField(
                                              controller: textController1,
                                              focusNode: textFieldFocusNode1,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: '\$ Diaria de',
                                                labelStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey[300]!,
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 24, 10),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 20),
                                  child: AnimatedBuilder(
                                    animation: _textField2AnimationController,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scaleY: _textField2AnimationController.value,
                                        child: Transform.translate(
                                          offset: Tween<Offset>(
                                            begin: const Offset(0, 80),
                                            end: const Offset(0, 0),
                                          ).animate(CurvedAnimation(
                                            parent: _textField2AnimationController,
                                            curve: Curves.easeInOut,
                                          )).value,
                                          child: Opacity(
                                            opacity: _textField2AnimationController.value,
                                            child: TextFormField(
                                              controller: textController2,
                                              focusNode: textFieldFocusNode2,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: '\$ Diaria Ate',
                                                labelStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey[300]!,
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 24, 10),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Distance slider
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Slider(
                                      activeColor: Colors.blueAccent,
                                      inactiveColor: Colors.grey[300],
                                      min: 0,
                                      max: 100,
                                      value: sliderValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          sliderValue = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  const Text(
                                    'XXX Milhas',
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey[300],
                              ),

                              // Commercial data section
                              Text(
                                'Dados Comerciais',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey[300],
                              ),

                              // Commercial checkboxes
                              Row(
                                children: [
                                  Checkbox(
                                    value: checkboxValue1,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue1 = value!;
                                      });
                                    },
                                    activeColor: Colors.blueAccent,
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                                    child: Text('Empresa'),
                                  ),
                                  Checkbox(
                                    value: checkboxValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue2 = value!;
                                      });
                                    },
                                    activeColor: Colors.blueAccent,
                                  ),
                                  const Text('Work Compensation'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: checkboxValue3,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue3 = value!;
                                      });
                                    },
                                    activeColor: Colors.blueAccent,
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
                                    child: Text('Seguro'),
                                  ),
                                  Checkbox(
                                    value: checkboxValue4,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue4 = value!;
                                      });
                                    },
                                    activeColor:  Colors.blueAccent,
                                  ),
                                  const Text('Liability'),
                                ],
                              ),

                              Divider(
                                thickness: 2,
                                color: Colors.grey[300],
                              ),

                              // Qualifications section
                              Text(
                                'Qualificação',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey[300],
                              ),

                              // Skills checkboxes
                              _buildSkillRow('Drywall', chkDrywallValue1, chkDrywallValue2, (val1, val2) {
                                setState(() {
                                  chkDrywallValue1 = val1;
                                  chkDrywallValue2 = val2;
                                });
                              }),
                              _buildSkillRow('Madeira', chkDrywallValue3, chkDrywallValue4, (val1, val2) {
                                setState(() {
                                  chkDrywallValue3 = val1;
                                  chkDrywallValue4 = val2;
                                });
                              }),
                              _buildSkillRow('Encanador', chkDrywallValue5, chkDrywallValue6, (val1, val2) {
                                setState(() {
                                  chkDrywallValue5 = val1;
                                  chkDrywallValue6 = val2;
                                });
                              }),
                              _buildSkillRow('Pintura', chkDrywallValue7, chkDrywallValue8, (val1, val2) {
                                setState(() {
                                  chkDrywallValue7 = val1;
                                  chkDrywallValue8 = val2;
                                });
                              }),
                              _buildSkillRow('Frame', chkDrywallValue9, chkDrywallValue10, (val1, val2) {
                                setState(() {
                                  chkDrywallValue9 = val1;
                                  chkDrywallValue10 = val2;
                                });
                              }),
                              _buildSkillRow('Tile', chkDrywallValue11, chkDrywallValue12, (val1, val2) {
                                setState(() {
                                  chkDrywallValue11 = val1;
                                  chkDrywallValue12 = val2;
                                });
                              }),
                              _buildSkillRow('Tile Piscina', chkDrywallValue13, chkDrywallValue14, (val1, val2) {
                                setState(() {
                                  chkDrywallValue13 = val1;
                                  chkDrywallValue14 = val2;
                                });
                              }),
                              _buildSkillRow('Roof', chkDrywallValue15, chkDrywallValue16, (val1, val2) {
                                setState(() {
                                  chkDrywallValue15 = val1;
                                  chkDrywallValue16 = val2;
                                });
                              }),
                              _buildSkillRow('Brick', chkDrywallValue17, chkDrywallValue18, (val1, val2) {
                                setState(() {
                                  chkDrywallValue17 = val1;
                                  chkDrywallValue18 = val2;
                                });
                              }),
                              _buildSkillRow('Eletricista', chkDrywallValue19, chkDrywallValue20, (val1, val2) {
                                setState(() {
                                  chkDrywallValue19 = val1;
                                  chkDrywallValue20 = val2;
                                });
                              }),
                              _buildSkillRow('Handyman', chkDrywallValue21, chkDrywallValue22, (val1, val2) {
                                setState(() {
                                  chkDrywallValue21 = val1;
                                  chkDrywallValue22 = val2;
                                });
                              }),

                              Divider(
                                thickness: 2,
                                color: Colors.grey[300],
                              ),

                              // Licenses section
                              Text(
                                'Licenças',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:  Colors.blueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey[300],
                              ),

                              // License checkboxes
                              Row(
                                children: [
                                  Checkbox(
                                    value: checkboxValue5,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue5 = value!;
                                      });
                                    },
                                    activeColor: Colors.blueAccent,
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                    child: Text('Encanador'),
                                  ),
                                  Checkbox(
                                    value: checkboxValue6,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue6 = value!;
                                      });
                                    },
                                    activeColor: Colors.blueAccent,
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                    child: Text('Telhado'),
                                  ),
                                  Checkbox(
                                    value: checkboxValue7,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue7 = value!;
                                      });
                                    },
                                    activeColor: Colors.blueAccent,
                                  ),
                                  const Text('Eletrecista'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Filter button
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _rowAnimationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: Tween<double>(begin: 0.4, end: 1.0)
                          .animate(CurvedAnimation(
                        parent: _rowAnimationController,
                        curve: Curves.bounceOut,
                      ))
                          .value,
                      child: Opacity(
                        opacity: _rowAnimationController.value,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Navigate to search results
                            // Navigator.pushNamed(context, '/search-results');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(230, 50),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Filtrar',
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillRow(String skillName, bool skillValue, bool toolValue,
      Function(bool, bool) onChanged) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Checkbox(
            value: skillValue,
            onChanged: (value) {
              onChanged(value!, toolValue);
            },
            activeColor: Colors.blueAccent,
          ),
        ),
        Text(skillName),
        Expanded(child: Container()),
        Checkbox(
          value: toolValue,
          onChanged: (value) {
            onChanged(skillValue, value!);
          },
          activeColor: Colors.blueAccent,
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
          child: Text('Possui ferramenta'),
        ),
      ],
    );
  }
}