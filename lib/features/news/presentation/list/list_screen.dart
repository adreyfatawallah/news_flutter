import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/resources/dimens.dart';
import 'package:news/core/utils/const.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/core/widgets/filled_button.dart';
import 'package:news/core/widgets/network_image.dart';
import 'package:news/features/news/domain/entities/article.dart';
import 'package:news/features/news/presentation/list/cubit/list_cubit.dart';
import 'package:news/navigation.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyConst.appName),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Nav.settings.path);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          final bloc = context.read<ListCubit>();
          bloc.getNews();
          await bloc.stream.firstWhere(
            (state) =>
                state.maybeWhen(loading: () => false, orElse: () => true),
          );
        },
        child: BlocBuilder<ListCubit, ListState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => _defaultList(null),
              success: (news) {
                if (news.isEmpty) {
                  return _defaultList(
                    Center(
                      child: Text(
                        context.getString.lbl_news_empty,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: .all(16.r),
                  itemCount: news.length,
                  separatorBuilder: (context, index) => 14.verticalSpace,
                  itemBuilder: (context, index) {
                    final item = news[index];
                    return _itemNews(item);
                  },
                );
              },
              failure: () => _defaultList(
                Center(
                  child: MyFilledButton(
                    label: context.getString.btn_retry,
                    onPressed: () => _refreshKey.currentState?.show(),
                  ),
                ),
              ),
              orElse: () => _defaultList(null),
            );
          },
        ),
      ),
    );
  }

  Widget _defaultList(Widget? child) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 200.h),
        ?child,
      ],
    );
  }

  Widget _itemNews(Article item) {
    return InkWell(
      onTap: () {
        context.push(Nav.detail.path, extra: item);
      },
      borderRadius: BorderRadius.circular(MyDimens.borderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyNetworkImage(
            imageUrl: item.image,
            width: 120.w,
            height: 65.h,
            fit: BoxFit.cover,
            borderRadius: MyDimens.borderRadius,
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelLarge,
                ),
                4.verticalSpace,
                Text(
                  context.formatDate(item.date),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
