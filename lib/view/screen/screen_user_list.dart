/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_list_app/network/model/model_user_list.dart';
import 'package:user_list_app/view/custom_widget/custom_dialogue.dart';
import 'package:user_list_app/view/custom_widget/custom_text_form_field.dart';
import 'package:user_list_app/view/utility/app_color.dart';
import 'package:user_list_app/view/utility/app_size.dart';
import 'package:user_list_app/view/utility/app_text.dart';

import '../../bloc/bloc_get_user_list/bloc_get_user_list.dart';

class ScreenUserList extends StatefulWidget {
  const ScreenUserList({super.key});

  @override
  State<ScreenUserList> createState() => _ScreenUserListState();
}

class _ScreenUserListState extends State<ScreenUserList> {
  List<User> userList = [];
  List<User> queryUserList = [];

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchInitialList();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreUser();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void fetchInitialList() {
    context.read<BlocGetUserList>().add(EventGetUserList(pageNo: 1));
  }

  void loadMoreUser() {
    context.read<BlocGetUserList>().add(EventLoadMoreUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.userList),
        actions: [
          IconButton(
            onPressed: () => fetchInitialList(),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<BlocGetUserList, StateGetUserList>(
          listener: (context, state) {
            if (state is StateGetUserRetry) {
              if (ModalRoute.of(context)?.isCurrent == true) {
                CustomDialogue.result(
                  context: context,
                  onPressed: () {
                    fetchInitialList();
                    Navigator.pop(context);
                  },
                  message: state.message,
                  actionButtonText: AppText.retry,
                );
              }
            } else if (state is StateGetUserFail) {
              if (context.read<BlocGetUserList>().userList.isNotEmpty) {
                userList = context.read<BlocGetUserList>().userList;
                queryUserList = context.read<BlocGetUserList>().userList;
              }
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is StateLoadMoreRetry) {
              if (ModalRoute.of(context)?.isCurrent == true) {
                CustomDialogue.result(
                  context: context,
                  onPressed: () {
                    loadMoreUser();
                    Navigator.pop(context);
                  },
                  message: state.message,
                  actionButtonText: AppText.retry,
                );
              }
            } else if (state is StateLoadMoreFinish) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is StateGetUserPass) {
              userList = state.userList;
              queryUserList = state.userList;
            } else if (state is StateDevelopment) {
              if (ModalRoute.of(context)?.isCurrent == true) {
                CustomDialogue.result(
                  context: context,
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  message: state.message,
                  actionButtonText: AppText.okay,
                  isOnlyAction: true,
                );
              }
            }
          },
          builder: (context, state) {
            if (state is StateGetUserRetry ||
                state is StateGetUserInitial ||
                state is StateDevelopment) {
              return RefreshIndicator(
                color: AppColor.colorPrimary,
                onRefresh: () async {
                  fetchInitialList();
                  await Future.delayed(const Duration(milliseconds: 0));
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(25),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _loader();
                  },
                ),
              );
            }
            return RefreshIndicator(
              color: AppColor.colorPrimary,
              onRefresh: () async {
                fetchInitialList();
                await Future.delayed(const Duration(milliseconds: 0));
              },
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.all(25),
                physics: BouncingScrollPhysics(),
                children: [
                  CustomTextFormField(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    suffix: Icons.search,
                    hint: AppText.exampleName,
                    label: AppText.search,
                    onChanged: (value) {
                      final temporaryUserList =
                          queryUserList.where((element) {
                            final fullName =
                                "${element.firstName!.toLowerCase()} ${element.lastName!.toLowerCase()}";
                            return fullName.contains(value.toLowerCase());
                          }).toList();
                      setState(() {
                        userList = temporaryUserList;
                      });
                    },
                  ),
                  AppSize.gapH15,
                  ListView.builder(
                    // itemCount: userList.isEmpty ? 1 : userList.length,
                    itemCount: userList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return /*userList.isEmpty
                          ? _loader()
                          :*/ _userlistView(user: userList[index]);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _loader() {
    return Column(
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.colorPrimary, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: AppColor.colorLoader,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AppSize.gapW15,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.colorLoader,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.colorLoader,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSize.gapH15,
      ],
    );
  }

  Widget _userlistView({required User user}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.colorPrimary, width: 1),
          ),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: AppColor.colorPrimary, width: 1),
                ),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.avatar!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${user.firstName!} ${user.lastName!}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
        AppSize.gapH15,
      ],
    );
  }
}
