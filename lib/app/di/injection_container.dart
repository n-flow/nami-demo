import 'package:get_it/get_it.dart';
import 'package:smart_attend/app/data/network/socket.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerLazySingleton(() => Socket());
}
