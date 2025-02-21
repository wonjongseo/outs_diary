import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class PermissionService {
  void requestPermisson() async {
    // final permission = await PhotoManager.requestPermissionExtend();
    // if (!permission.isAuth) {}

    if (await Permission.mediaLibrary.isDenied &&
        !await Permission.mediaLibrary.isPermanentlyDenied) {
      await [Permission.mediaLibrary].request();
    }
  }

  void permissionWithNotification() async {
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
    }
  }
}
