import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class FrmTrabalhosExecutadosWidget extends StatefulWidget {
  const FrmTrabalhosExecutadosWidget({super.key});

  static String routeName = 'FrmTrabalhosExecutados';
  static String routePath = '/frmTrabalhosExecutados';

  @override
  State<FrmTrabalhosExecutadosWidget> createState() =>
      _FrmTrabalhosExecutadosWidgetState();
}

class _FrmTrabalhosExecutadosWidgetState extends State<FrmTrabalhosExecutadosWidget>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Rating bar values
  double? ratingBarValue1;
  double? ratingBarValue2;
  double? ratingBarValue3;
  double? ratingBarValue4;
  double? ratingBarValue5;

  // Animation controller
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _moveAnimation = Tween<Offset>(
      begin: const Offset(0.0, 60.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    // Start animation after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Helper function for responsive visibility
  bool responsiveVisibility({required BuildContext context, bool desktop = true}) {
    if (desktop) {
      return MediaQuery.of(context).size.width >= 768;
    } else {
      return MediaQuery.of(context).size.width < 768;
    }
  }

  // Helper function for safe setState
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF39D2C0), // FlutterFlow tertiary color
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (responsiveVisibility(
              context: context,
              desktop: false,
            ))
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.translate(
                      offset: _moveAnimation.value,
                      child: Transform.scale(
                        scaleY: _scaleAnimation.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Header Section
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Card(
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              color: const Color(0xFF39D2C0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(40),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/DSC_0021.jpg',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Container(
                                                        color: Colors.grey[300],
                                                        child: const Icon(Icons.person, size: 40),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Luiz Fernando',
                                                    style: GoogleFonts.lexend(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 0.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                child: Text(
                                                  'Tile',
                                                  style: GoogleFonts.lexend(
                                                    color: const Color(0xFF101213),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Section Title
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Ultimos Trabalhos',
                                    style: GoogleFonts.lexend(
                                      color: const Color(0xFF57636C),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Work Item 1 - James
                            _buildWorkItem(
                              name: 'James',
                              service: 'Banheiro',
                              price: 'Diaria:\$250.00',
                              dates: 'Start:12/05/23  Done:24/05/23',
                              rating: ratingBarValue1 ??= 4.5,
                              onRatingUpdate: (newValue) => safeSetState(() => ratingBarValue1 = newValue),
                            ),
                            // Work Item 2 - Frank Will (with double rating)
                            _buildWorkItemWithDoubleRating(
                              name: 'Frank Will',
                              service: 'Banheiro',
                              price: 'Diaria:\$250.00',
                              dates: 'Start:00/00/00 Done:00/00/00',
                              rating2: ratingBarValue2 ??= 5,
                              rating3: ratingBarValue3 ??= 3,
                              onRatingUpdate2: (newValue) => safeSetState(() => ratingBarValue2 = newValue),
                              onRatingUpdate3: (newValue) => safeSetState(() => ratingBarValue3 = newValue),
                              onTap: () {
                                // Navigation to ZtransferCompleteCopyWidget
                                // context.pushNamed(ZtransferCompleteCopyWidget.routeName);
                              },
                            ),
                            // Work Item 3 - Will
                            _buildWorkItem(
                              name: 'Will',
                              service: 'Piso',
                              price: 'Diaria:\$250.00',
                              dates: 'Start:00/00/00 Done:00/00/00',
                              rating: ratingBarValue4 ??= 3,
                              onRatingUpdate: (newValue) => safeSetState(() => ratingBarValue4 = newValue),
                            ),
                            // Work Item 4 - Ross
                            _buildWorkItem(
                              name: 'Ross',
                              service: 'Blaksplash',
                              price: 'Repasse:\$700.00',
                              dates: 'Start:00/00/00 Done:00/00/00',
                              rating: ratingBarValue5 ??= 4,
                              onRatingUpdate: (newValue) => safeSetState(() => ratingBarValue5 = newValue),
                              hasPadding: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            // OK Button
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 70),
              child: ElevatedButton(
                onPressed: () async {
                  // Navigation to FrmPrincipalWidget
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B39EF), // Primary color
                  minimumSize: const Size(130, 50),
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  'Okay',
                  style: GoogleFonts.lexend(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkItem({
    required String name,
    required String service,
    required String price,
    required String dates,
    required double rating,
    required Function(double) onRatingUpdate,
    bool hasPadding = false,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.92,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF), // Primary background
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: hasPadding ? const EdgeInsets.all(2) : EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          service,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        onRatingUpdate: onRatingUpdate,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star_rounded,
                          color: Color(0xFF39D2C0),
                        ),
                        direction: Axis.horizontal,
                        initialRating: rating,
                        unratedColor: const Color(0xFFE0E3E7),
                        itemCount: 5,
                        itemSize: 20,
                        glowColor: const Color(0xFF39D2C0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.lexend(
                        color: const Color(0xFF39D2C0),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        dates,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkItemWithDoubleRating({
    required String name,
    required String service,
    required String price,
    required String dates,
    required double rating2,
    required double rating3,
    required Function(double) onRatingUpdate2,
    required Function(double) onRatingUpdate3,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.92,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          service,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        onRatingUpdate: onRatingUpdate2,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star_rounded,
                          color: Color(0xFF39D2C0),
                        ),
                        direction: Axis.horizontal,
                        initialRating: rating2,
                        unratedColor: const Color(0xFFE0E3E7),
                        itemCount: 5,
                        itemSize: 2, // Very small rating bar as in original
                        glowColor: const Color(0xFF39D2C0),
                      ),
                      RatingBar.builder(
                        onRatingUpdate: onRatingUpdate3,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star_rounded,
                          color: Color(0xFF39D2C0),
                        ),
                        direction: Axis.horizontal,
                        initialRating: rating3,
                        unratedColor: const Color(0xFFE0E3E7),
                        itemCount: 5,
                        itemSize: 20,
                        glowColor: const Color(0xFF39D2C0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.lexend(
                        color: const Color(0xFF39D2C0),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        dates,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}