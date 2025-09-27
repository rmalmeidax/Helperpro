import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

// Import da tela de pesquisa
import 'FrmPesquisaAbaListaWidget.dart';
import 'FrmFiltroBuscaWidget.dart';

class FrmBuscaMapWidget extends StatefulWidget {
  const FrmBuscaMapWidget({super.key});

  @override
  State<FrmBuscaMapWidget> createState() => _FrmBuscaMapWidgetState();
}

class _FrmBuscaMapWidgetState extends State<FrmBuscaMapWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GoogleMapController? _mapController;

  LatLng _currentPosition = const LatLng(-23.55052, -46.633308); // São Paulo como padrão
  Set<Marker> _markers = <Marker>{};
  bool _locationLoaded = false;
  bool _isLoadingLocation = true;

  final List<Map<String, dynamic>> _items = [
    {"name": "Local 1", "type": "Tipo A", "rating": 4.5},
    {"name": "Local 2", "type": "Tipo B", "rating": 3.0},
    {"name": "Local 3", "type": "Tipo C", "rating": 5.0},
    {"name": "Local 4", "type": "Tipo D", "rating": 2.5},
  ];

  int _cadastroCounter = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeApp();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    // Primeiro carrega os marcadores com a posição padrão
    _createMarkers();

    setState(() {
      _locationLoaded = true;
    });

    // Depois tenta obter a localização real
    await _determinePosition();
  }

  void _createMarkers() {
    const double latIncrement = 0.005; // Menor incremento para melhor visualização
    const double lngIncrement = 0.005;

    _markers = _items.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> item = entry.value;

      // Calcular posições diferentes para cada marcador
      LatLng markerPosition = LatLng(
        _currentPosition.latitude + (index * latIncrement),
        _currentPosition.longitude + (index * lngIncrement),
      );

      return Marker(
        markerId: MarkerId('marker_${item['name']}'),
        position: markerPosition,
        infoWindow: InfoWindow(
          title: item['name'],
          snippet: '${item['type']} - ⭐ ${item['rating']}',
          onTap: () {
            _showLocationDetails(item);
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _getMarkerColor(item['rating']),
        ),
        onTap: () {
          _showLocationDetails(item);
        },
      );
    }).toSet();
  }

  double _getMarkerColor(double rating) {
    if (rating >= 4.0) return BitmapDescriptor.hueGreen;
    if (rating >= 3.0) return BitmapDescriptor.hueYellow;
    return BitmapDescriptor.hueRed;
  }

  void _showLocationDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.place, color: Colors.blue, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Tipo: ${item['type']}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Avaliação: ', style: TextStyle(fontSize: 16)),
                ...List.generate(
                  5,
                      (starIndex) => Icon(
                    starIndex < item['rating'].floor()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text('${item['rating']}', style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _abrirPesquisa,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Local'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _determinePosition() async {
    try {
      setState(() {
        _isLoadingLocation = true;
      });

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationError('Serviços de localização desabilitados');
        setState(() {
          _isLoadingLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationError('Permissão de localização negada');
          setState(() {
            _isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationError('Permissão de localização negada permanentemente');
        setState(() {
          _isLoadingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _isLoadingLocation = false;
        });

        // Recriar marcadores com nova posição
        _createMarkers();

        // Animar câmera para nova posição
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(_currentPosition),
        );
      }
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
      _showLocationError('Erro ao obter localização: $e');
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _showLocationError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.orange,
          action: SnackBarAction(
            label: 'Tentar novamente',
            textColor: Colors.white,
            onPressed: _determinePosition,
          ),
        ),
      );
    }
  }

  void _abrirPesquisa() {
    if (_cadastroCounter > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Máximo de 5 cadastros atingido!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FrmPesquisaAbaListaWidget(),
      ),
    ).then((_) {
      // Quando voltar da tela de pesquisa, pode recarregar os dados
      setState(() {
        _cadastroCounter++;
      });
    });
  }

  void _abrirFiltro() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FrmFiltroBuscaWidget(),
      ),
    );
  }

  Widget _buildListTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          color: Colors.blueAccent,
          child: ListTile(
            leading: const Icon(Icons.place, color: Colors.white),
            title: Text(
                item['name'],
                style: const TextStyle(color: Colors.white)
            ),
            subtitle: Row(
              children: [
                Text(
                    item['type'],
                    style: const TextStyle(color: Colors.white70)
                ),
                const SizedBox(width: 10),
                Row(
                  children: List.generate(
                    5,
                        (starIndex) => Icon(
                      starIndex < item['rating'].floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.yellow[600],
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: _abrirPesquisa,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMapTab() {
    if (!_locationLoaded) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Carregando mapa...'),
          ],
        ),
      );
    }

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 14.0,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          mapToolbarEnabled: false, // Remove toolbar para melhor UX
          zoomControlsEnabled: false, // Remove controles de zoom padrão
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          markers: _markers,
          onTap: (LatLng position) {
            debugPrint('Mapa tocado em: ${position.latitude}, ${position.longitude}');
          },
        ),

        // Indicador de carregamento de localização
        if (_isLoadingLocation)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 12),
                    const Text('Obtendo localização...'),
                  ],
                ),
              ),
            ),
          ),

        // Botão de localização personalizado
        Positioned(
          bottom: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: "location_btn",
                mini: true,
                onPressed: _determinePosition,
                backgroundColor: Colors.white,
                child: Icon(Icons.my_location, color: Colors.black12),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: "zoom_in_btn",
                mini: true,
                onPressed: () {
                  _mapController?.animateCamera(CameraUpdate.zoomIn());
                },
                backgroundColor: Colors.white,
                child: Icon(Icons.add, color: Colors.black12),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: "zoom_out_btn",
                mini: true,
                onPressed: () {
                  _mapController?.animateCamera(CameraUpdate.zoomOut());
                },
                backgroundColor: Colors.white,
                child: Icon(Icons.remove, color: Colors.black12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUSCA'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.white),
          onPressed: _abrirFiltro,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Lista', icon: Icon(Icons.list)),
            Tab(text: 'Mapa', icon: Icon(Icons.map)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListTab(),
          _buildMapTab(),
        ],
      ),
    );
  }
}