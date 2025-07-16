import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test/controller/second_screen/second_screen_controller.dart';
import 'package:test/view/second_screen/widget/error_user_widget.dart';
import 'package:test/view/second_screen/widget/no_more_user_widget.dart';
import 'package:test/view/second_screen/widget/shimmer_user_item_widget.dart';
import 'package:test/view/second_screen/widget/shimmer_user_widget.dart';

class ChooseUserWidget extends StatefulWidget {
  const ChooseUserWidget({super.key});

  @override
  State<ChooseUserWidget> createState() => _ChooseUserWidgetState();
}

class _ChooseUserWidgetState extends State<ChooseUserWidget> {
  late final ScrollController _scrollController;
  late final SecondScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<SecondScreenController>();
    _scrollController = ScrollController();
    _controller.fetchUsers();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _controller.fetchUsers(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.purple),
        ),
        centerTitle: true,
        title: const Text(
          'Third Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (_controller.isLoading.value && _controller.users.isEmpty) {
            return const ShimmerUserWidget();
          }

          if (_controller.hasError.value && _controller.users.isEmpty) {
            return const ErrorUserWidget();
          }

          if (_controller.users.isEmpty && !_controller.isLoading.value) {
            return const Center(
              child: Text(
                'No users found',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _controller.refreshUsers,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount:
                  _controller.users.length +
                  (_controller.hasMore.value || _controller.isLoadingMore.value
                      ? 1
                      : 1),
              itemBuilder: (ctx, index) {
                if (index < _controller.users.length) {
                  final user = _controller.users[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.selectUser(user);
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: user.avatar,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) => Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${user.firstName} ${user.lastName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    user.email,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 0.5,
                      ),
                    ],
                  );
                }

                if (_controller.isLoadingMore.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const ShimmerUserItemWidget(),
                  );
                }

                if (!_controller.hasMore.value &&
                    _controller.users.isNotEmpty) {
                  return const NoMoreUserWidget();
                }

                return const SizedBox.shrink();
              },
            ),
          );
        }),
      ),
    );
  }
}
