import 'package:get/get.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/repositories/download_file_repository.dart';
import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;
  final DownloadFileRepository _downloadFileRepository;

  final _name = "".obs;
  String get name => _name.value;

  final _phone = "".obs;
  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;
  String get profilePictureUrl => _profilePictureUrl.value;

  ProfileController({
    required UserRepository userRepository,
    required DownloadFileRepository downloadFileRepository,
  })  : _userRepository = userRepository,
        _downloadFileRepository = downloadFileRepository;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;
        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick() async {
    const fileUrl =
        'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf';
    final fileName = fileUrl.split('/').last;

    try {
      final filePath =
          await _downloadFileRepository.downloadFile(fileUrl, fileName);
      SnackbarWidget.showSuccessSnackbar('File berhasil diunduh: $filePath');
    } catch (e) {
      SnackbarWidget.showFailedSnackbar('Gagal mengunduh file: $e');
    }
  }

  onOpenWebPageClick() async {
    const url = 'https://www.youtube.com/watch?v=lpnKWK-KEYs';
    Get.toNamed(RouteName.webview, arguments: {'url': url});
  }

  void doLogout() async {
    await _userRepository.logout();
    Get.offAllNamed(RouteName.login);
  }
}
