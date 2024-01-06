import 'package:flutter/material.dart';
import 'package:flutter_assignment_pranad/transporters/data/datasources/transporters_remote_data_source.dart';
import 'package:flutter_assignment_pranad/transporters/data/repo/transporter_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transporters/view_model/transporters_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: ((_) => TransportersBloc(
                TransporterRepository(
                  TransporterRemoteDataSource(),
                ),
              )),
          child: const TransporterListWidget(),
        ),
      ),
    );
  }
}

class TransporterListWidget extends StatefulWidget {
  const TransporterListWidget({super.key});

  @override
  TransporterListWidgetState createState() => TransporterListWidgetState();
}

class TransporterListWidgetState extends State<TransporterListWidget> {
  final TextEditingController _searchController = TextEditingController();
  late TransportersBloc _transporterBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transporterBloc = BlocProvider.of<TransportersBloc>(context);

    _searchController.addListener(() {
      final query = _searchController.text;
      if (query.length > 2) {
        _transporterBloc.add(SearchTransporters(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Enter a place or city or country.',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        BlocBuilder<TransportersBloc, TransportersState>(
          builder: (context, state) {
            if (state is TransportersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransportersLoaded) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.transporters.length,
                  itemBuilder: (context, index) {
                    final transporter = state.transporters[index];
                    return ListTile(
                      title: Text(transporter.transporterName),
                      subtitle: Text('ID: ${transporter.transporterId}'),
                    );
                  },
                ),
              );
            } else if (state is TransportersError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
