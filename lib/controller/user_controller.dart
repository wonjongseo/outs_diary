import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/respository/user_respository.dart';

class UserController extends GetxController {
  late UserModel? userModel;

  void saveUser(UserModel userModel) {
    userModelRepository.saveUser(userModel);
    getUser();
  }

  UserModelRepository userModelRepository = UserModelRepository();

  List<String> get feals {
    return AppConstant.fealIconLists[userModel?.fealIconIndex ?? 0].iconPath;
  }

  void setBackgroundIndex(int index) {
    if (userModel == null) return;
    userModel!.backgroundIndex = index;
    userModelRepository.saveUser(userModel!);
    // saved IT and Get again
    getUser();
  }

  void setFealIconIndex(int index) {
    if (userModel == null) return;
    userModel!.fealIconIndex = index;
    userModelRepository.saveUser(userModel!);
    // saved IT and Get again
    getUser();
  }

  @override
  void onInit() async {
    getUser();
    // getBackgroundIndex();
    super.onInit();
  }

  void getUser() async {
    userModel = await userModelRepository.loadUser();
    print('userModel : ${userModel}');

    update();
  }
}
