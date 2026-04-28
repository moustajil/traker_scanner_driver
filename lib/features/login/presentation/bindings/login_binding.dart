import 'package:get/get.dart';

import '../../data/datasources/login_remote_data_source.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../domain/repositories/login_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl());
    Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find()));
    Get.lazyPut<LoginController>(
      () => LoginController(loginUseCase: Get.find()),
    );
  }
}
