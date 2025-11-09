import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pato_delivery/bloc/pedidos/pedidos_bloc.dart';
import 'package:pato_delivery/bloc/pedidos/pedidos_event.dart';
import 'package:pato_delivery/bloc/ranking/ranking_bloc.dart';
import 'package:pato_delivery/bloc/ranking/ranking_event.dart';
import 'package:pato_delivery/repositories/pedidos_repository.dart';
import 'package:pato_delivery/repositories/ranking_repository.dart';

// Importa todas las pantallas
import 'home_screen.dart';
import 'pedidos_screen.dart';
import 'perfil_screen.dart';
import 'ranking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const PedidosRepository()),
        RepositoryProvider(create: (_) => const RankingRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PedidosBloc(context.read<PedidosRepository>())
              ..add(CargarPedidos()),
          ),
          BlocProvider(
            create: (context) => RankingBloc(context.read<RankingRepository>())
              ..add(const CargarRanking()),
          ),
        ],
        child: MaterialApp(
          title: 'DeliveryExpress',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber,
              brightness: Brightness.light,
              primary: Colors.amber,
              secondary: Colors.amber.shade700,
              surface: Colors.grey.shade900, //fondo
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber,
              brightness: Brightness.dark,
              primary: Colors.amber,
              secondary: Colors.amber.shade700,
              background: Colors.black,
              surface: Colors.grey.shade900,
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onBackground: Colors.white,
              onSurface: Colors.white,
            ),
          ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}

// main_screen.dart - Pantalla principal con navegación
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

//Menu de items
class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeScreen(),
      PedidosScreen(),
      RankingPage(),
      PerfilScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
