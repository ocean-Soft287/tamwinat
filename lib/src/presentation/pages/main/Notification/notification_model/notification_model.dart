class NotificationsModel {
  final int id;
  final String message;

  NotificationsModel({required this.id, required this.message});
  factory NotificationsModel.fromJson({required Map data}) => NotificationsModel(
        id: data['ID'],
        message: data['MobileAppNotification'],
      );
}
