import 'package:get/get.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final String type; // 'info', 'warning', 'success', 'error'
  final bool isRead;
  final String? imageUrl;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
    this.imageUrl,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? time,
    String? type,
    bool? isRead,
    String? imageUrl,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class NotifikasiController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'all'.obs; // 'all', 'unread', 'read'

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Load dummy notifications
  void loadNotifications() {
    isLoading.value = true;
    
    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      notifications.value = [
        NotificationItem(
          id: '1',
          title: 'Selamat Datang!',
          message: 'Terima kasih telah bergabung dengan aplikasi kami. Jangan lupa untuk melengkapi profil Anda.',
          time: '2 menit yang lalu',
          type: 'success',
          isRead: false,
        ),
        NotificationItem(
          id: '2',
          title: 'Update Keamanan',
          message: 'Kami telah memperbarui sistem keamanan aplikasi. Pastikan untuk mengupdate aplikasi ke versi terbaru.',
          time: '1 jam yang lalu',
          type: 'warning',
          isRead: false,
        ),
        NotificationItem(
          id: '3',
          title: 'Promo Spesial',
          message: 'Dapatkan diskon 50% untuk pembelian pertama Anda. Gunakan kode: WELCOME50',
          time: '3 jam yang lalu',
          type: 'info',
          isRead: true,
        ),
        NotificationItem(
          id: '4',
          title: 'Pembayaran Berhasil',
          message: 'Pembayaran Anda sebesar Rp 150.000 telah berhasil diproses.',
          time: '1 hari yang lalu',
          type: 'success',
          isRead: true,
        ),
        NotificationItem(
          id: '5',
          title: 'Gagal Login',
          message: 'Terdapat percobaan login yang gagal pada akun Anda. Jika bukan Anda, segera ubah password.',
          time: '2 hari yang lalu',
          type: 'error',
          isRead: false,
        ),
        NotificationItem(
          id: '6',
          title: 'Maintenance Terjadwal',
          message: 'Aplikasi akan mengalami maintenance pada tanggal 25 Mei 2025 pukul 02:00 - 04:00 WIB.',
          time: '3 hari yang lalu',
          type: 'info',
          isRead: true,
        ),
      ];
      isLoading.value = false;
    });
  }

  // Get filtered notifications
  List<NotificationItem> get filteredNotifications {
    switch (selectedFilter.value) {
      case 'unread':
        return notifications.where((n) => !n.isRead).toList();
      case 'read':
        return notifications.where((n) => n.isRead).toList();
      default:
        return notifications.toList();
    }
  }

  // Get unread count
  int get unreadCount {
    return notifications.where((n) => !n.isRead).length;
  }

  // Mark notification as read
  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      notifications.refresh();
    }
  }

  // Mark all as read
  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      if (!notifications[i].isRead) {
        notifications[i] = notifications[i].copyWith(isRead: true);
      }
    }
    notifications.refresh();
  }

  // Delete notification
  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  // Clear all notifications
  void clearAllNotifications() {
    notifications.clear();
  }

  // Set filter
  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  // Refresh notifications
  void refreshNotifications() {
    loadNotifications();
  }
}