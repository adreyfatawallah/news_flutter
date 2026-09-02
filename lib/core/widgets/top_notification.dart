import 'package:flutter/material.dart';

class TopNotification {
  TopNotification._();

  /// Panggil fungsi ini dari mana saja untuk menampilkan notifikasi dari atas
  static void show(BuildContext context, String message, {bool isError = false, VoidCallback? onDismiss}) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return _TopNotificationWidget(
          message: message,
          isError: isError,
          onDismissed: () {
            overlayEntry.remove(); // Hapus widget dari memori setelah animasi selesai
            if (onDismiss != null && context.mounted) {
              onDismiss();
            }
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
  }
}

class _TopNotificationWidget extends StatefulWidget {
  final String message;
  final bool isError;
  final VoidCallback onDismissed;

  const _TopNotificationWidget({
    required this.message,
    required this.isError,
    required this.onDismissed,
  });

  @override
  State<_TopNotificationWidget> createState() => _TopNotificationWidgetState();
}

class _TopNotificationWidgetState extends State<_TopNotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    // Mengatur durasi animasi muncul dan hilang (200 milidetik)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Mengatur pergerakan dari luar layar atas (-1.0) ke dalam layar (0.0)
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    ));

    _showNotification();
  }

  Future<void> _showNotification() async {
    // 1. Jalankan animasi turun
    await _controller.forward();

    // 2. Tahan di layar selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    // 3. Pastikan widget masih ada di layar sebelum memutar animasi mundur
    if (mounted) {
      await _controller.reverse(); // Animasi naik
      widget.onDismissed(); // Beritahu Overlay untuk menghapus widget
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil jarak aman dari notch/status bar (SafeArea)
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 16, // Jarak dari atas layar
      left: 24,
      right: 24,
      child: Material(
        color: Colors.transparent, // Material wajib ada untuk mengatur Text dan shadow
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              // Gunakan warna tema atau warna khusus error
              color: widget.isError
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  widget.isError ? Icons.error_outline : Icons.check_circle_outline,
                  color: widget.isError
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: widget.isError
                          ? Theme.of(context).colorScheme.onError
                          : Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}