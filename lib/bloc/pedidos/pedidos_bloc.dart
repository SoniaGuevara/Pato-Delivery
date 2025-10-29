import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pato_delivery/bloc/pedidos/pedidos_event.dart';
import 'package:pato_delivery/bloc/pedidos/pedidos_state.dart';
import 'package:pato_delivery/models/pedido_model.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  PedidosBloc() : super(PedidosInicial()) {
    on<CargarPedidos>(_onCargarPedidos);
  }

  Future<void> _onCargarPedidos(
      CargarPedidos event, Emitter<PedidosState> emit) async {
    emit(PedidosCargando());

    try {
      // Simulación de carga (en el futuro vendrá de Firebase)
      await Future.delayed(const Duration(seconds: 1));

      final pedidos = [
        Pedido(
          id: '001',
          restaurante: 'Restaurante El Pato Feliz',
          items: ['Hamburguesa', 'Papas Fritas', 'Gaseosa'],
          estado: 'Entregado',
          direccion: 'Calle 123 #45-67',
          repartidor: 'Carlos Pérez',
          calificacion: 4.8,
          total: 25.0,
        ),
        Pedido(
          id: '002',
          restaurante: 'Sushi Zen',
          items: ['Roll California', 'Miso Soup'],
          estado: 'En camino',
          direccion: 'Av. Central 45',
          repartidor: 'Laura Gómez',
          calificacion: 4.5,
          total: 32.0,
        ),
      ];

      emit(PedidosCargados(pedidos));
    } catch (e) {
      emit(PedidosError('Error al cargar los pedidos'));
    }
  }
}
