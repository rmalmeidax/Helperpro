import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

// Import da tela de pesquisa
import 'FrmPesquisaAbaListaWidget.dart';

class FrmBuscaMapWidget extends StatefulWidget {
  const FrmBuscaMapWidget({super.key});

  @override
  State<FrmBuscaMapWidget> createState() => _FrmBuscaMapWidgetState();
}

class _FrmBuscaMapWidgetState extends State<FrmBuscaMapWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GoogleMapController _mapController;

  LatLng _currentPosition = const LatLng(-23.55052, -46.633308);

  final List<Map<String, dynamic>> _items = [
    {"name": "Local 1", "type": "Tipo A", "rating": 4.5},
    {"name": "Local 2", "type": "Tipo B", "rating": 3.0},
    {"name": "Local 3", "type": "Tipo C", "rating": 5.0},
    {"name": "Local 4", "type": "Tipo D", "rating": 2.5},
  ];

  int _cadastroCounter = 1; // contador para cadastro de 1 a 5

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _determinePosition();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    if (_mapController != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLng(_currentPosition),
      );
    }
  }

  void _abrirPesquisa() {
    if (_cadastroCounter > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Máximo de 5 cadastros atingido!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FrmPesquisaAbaListaWidget(),
      ),
    );

    setState(() {
      _cadastroCounter++;
    });
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
            title: Text(item['name'], style: const TextStyle(color: Colors.white)),
            subtitle: Row(
              children: [
                Text(item['type'], style: const TextStyle(color: Colors.white70)),
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
    return GoogleMap(
      initialCameraPosition:
      CameraPosition(target: _currentPosition, zoom: 14),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (controller) {
        _mapController = controller;
      },
      markers: _items
          .map(
            (item) => Marker(
          markerId: MarkerId(item['name']),
          position: _currentPosition,
          infoWindow: InfoWindow(title: item['name']),
        ),
      )
          .toSet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUSCA'),
        bottom: TabBar(
          controller: _tabController,
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
