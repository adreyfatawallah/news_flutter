import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/features/auth/presentation/widgets/language_widget.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(context.getString.lbl_language),
                trailing: const LanguageWidget(),
              ),
              const Divider(),
              SwitchListTile(
                secondary: Icon(
                  state.theme == Brightness.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: Text(context.getString.lbl_theme),
                value: state.theme == Brightness.dark,
                onChanged: (isDark) {
                  context.read<SettingsCubit>().changeTheme(
                    isDark ? Brightness.dark : Brightness.light,
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<SettingsCubit>().setAuth(false);
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
