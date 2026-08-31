import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/resources/dimens.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/core/widgets/filled_button.dart';
import 'package:news/core/widgets/network_image.dart';
import 'package:news/features/news/domain/entities/article.dart';
import 'package:news/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Nav.settings.path);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyNetworkImage(
              imageUrl: article.image,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              borderRadius: MyDimens.borderRadius,
            ),
            16.verticalSpace,
            Text(
              article.title,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            8.verticalSpace,
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16.sp,
                  color: context.colorScheme.primary,
                ),
                4.horizontalSpace,
                Expanded(
                  child: Text(
                    article.author.isEmpty ? "Unknown" : article.author,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                Text(
                  context.formatDate(article.date),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Text(
              article.desc,
              style: context.textTheme.bodyLarge,
            ),
            24.verticalSpace,
            MyFilledButton(
              label: "Baca Selengkapnya",
              isFillMaxWidth: true,
              onPressed: () async {
                debugPrint("Launching URL: ${article.url}");
                final url = Uri.tryParse(article.url);
                if (url == null) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("URL tidak valid")),
                    );
                  }
                  return;
                }
                try {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } catch (e) {
                  debugPrint("Could not launch $url: $e");
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Tidak dapat membuka link")),
                    );
                  }
                }
              },
            ),
            12.verticalSpace,
          ],
        ),
      ),
    );
  }
}
