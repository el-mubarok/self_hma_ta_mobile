class AppApiRoutes {
  // static const baseEndpoint = 'http://192.168.43.21:8100';
  static const baseEndpoint = 'https://hma.squidwarestudio.com/';
  static const apiEndpoint = '$baseEndpoint/api';

  static const pathGetUser = '$apiEndpoint/user';
  static const pathGetAdmin = '$apiEndpoint/admin';

  static const pathAddUser = '$apiEndpoint/user/add';
  static const pathEditUser = '$apiEndpoint/user/edit';
  static const pathDeleteUser = '$apiEndpoint/user/delete';
  static const pathRetrieveUser = '$apiEndpoint/user/retrieve';

  static const pathGetBilling = '$apiEndpoint/billing/session';
  static const pathCreateBilling = '$apiEndpoint/billing/session/create';
  static const pathEditBilling = '$apiEndpoint/billing/session/edit';
  //
  static const pathGetBillingTime = '$apiEndpoint/billing/session/time';
  static const pathCreateBillingTime =
      '$apiEndpoint/billing/session/time/create';
  static const pathEditBillingTIme = '$apiEndpoint/billing/session/time/edit';
  static const pathDeleteBillingTime =
      '$apiEndpoint/billing/session/time/delete';
  //
  static const pathGetActiveBilling = '$apiEndpoint/billing/session/active';
  static const pathGetActivePayment =
      '$apiEndpoint/billing/session/active/payment';

  static const pathCalculatePayment = '$apiEndpoint/payment/calculate';
  static const pathRequestPayment = '$apiEndpoint/payment/request';
  static const pathGetPaymentDetails = '$apiEndpoint/payment/details';
  static const pathGetPaymentHistory = '$apiEndpoint/payment/history';

  //
  /// Login
  /// POST
  /// params: username, password, device_id
  static const pathLogin = '$apiEndpoint/auth/login';
}
