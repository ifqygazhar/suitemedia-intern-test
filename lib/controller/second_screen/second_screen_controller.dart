import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test/model/user_model.dart';
import 'package:test/model/user_response_model.dart';

class SecondScreenController extends GetxController {
  final _dio = Dio();

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxBool hasError = false.obs;
  final RxInt currentPage = 1.obs;
  final RxString selectedUserName = 'Selected User Name'.obs;

  Future<void> fetchUsers({bool isLoadMore = false}) async {
    debugPrint("fetch");
    if (isLoading.value || isLoadingMore.value) return;
    if (isLoadMore && !hasMore.value) return;

    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        hasError.value = false;
        currentPage.value = 1;
        users.clear();
      }

      final response = await _dio.get(
        'https://reqres.in/api/users?page=${currentPage.value}&per_page=10',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'x-api-key': 'reqres-free-v1',
          },
        ),
      );

      if (response.statusCode == 200) {
        final userResponse = UserResponseModel.fromJson(response.data);

        users.addAll(userResponse.data);
        hasMore.value = currentPage.value < userResponse.totalPages;
        currentPage.value++;
        hasError.value = false;
      } else {
        hasError.value = true;
        Get.snackbar(
          'Error',
          'Failed to fetch users',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on DioException catch (e) {
      hasError.value = true;
      String errorMessage = 'Network error';

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Connection timeout';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection';
      } else if (e.response != null) {
        errorMessage = 'Server error: ${e.response!.statusCode}';
      }

      debugPrint('DioException: $e, statusCode: ${e.response?.statusCode}');

      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      hasError.value = true;
      debugPrint('Unexpected error: $e');
      Get.snackbar(
        'Error',
        'Unexpected error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void selectUser(UserModel user) {
    selectedUserName.value = '${user.firstName} ${user.lastName}';
  }

  Future<void> refreshUsers() async {
    currentPage.value = 1;
    hasMore.value = true;
    hasError.value = false;
    await fetchUsers();
  }
}
