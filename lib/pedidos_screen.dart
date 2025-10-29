import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pato_delivery/bloc/pedidos/pedidos_bloc.dart';
import 'package:pato_delivery/bloc/pedidos/pedidos_event.dart';
import 'package:pato_delivery/bloc/pedidos/pedidos_state.dart';
import 'package:pato_delivery/models/pedido_model.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PedidosBloc()..add(CargarPedidos()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Pedidos'),
          backgroundColor: Colors.amber[700],
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<PedidosBloc, PedidosState>(
          builder: (context, state) {
            if (state is PedidosCargando) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PedidosCargados) {
              return ListView.builder(
                itemCount: state.pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = state.pedidos[index];
                  return _buildPedidoCard(pedido);
                },
              );
            } else if (state is PedidosError) {
              return Center(child: Text(state.mensaje));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildPedidoCard(Pedido pedido) {
    return Card(
      color: Colors.black87,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pedido.restaurante,
                style: const TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            Text('Estado: ${pedido.estado}', style: const TextStyle(color: Colors.white70)),
            Text('Dirección: ${pedido.direccion}', style: const TextStyle(color: Colors.white70)),
            Text('Repartidor: ${pedido.repartidor}', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 6),
            Text('Total: \$${pedido.total.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
