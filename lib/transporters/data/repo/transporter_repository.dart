import '../datasources/transporters_remote_data_source.dart';
import '../models/transproter.dart';

class TransporterRepository {
  final TransporterRemoteDataSource remoteDataSource;

  TransporterRepository(this.remoteDataSource);

  Future<List<Transporter>> getTransporters(String place) async =>

      // Call the remote data source to get the list of transporters
      await remoteDataSource.getTransporters(place);
}
