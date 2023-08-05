import 'package:housing_management_mobile/config/assets.dart';

class AppDataPayment {
  List<Map<String, dynamic>> methodDummyVa = [
    {
      "id": 1,
      "type": 1,
      "label": 'Bank Central Asia',
      "label_abbr": 'BCA',
      "logo": AppAsset.paymentVaBcaSm,
      "message": null,
      "checked": false,
      "is_active": true,
      "ppn": 4000,
      "ppn_percentage": false,
      "code": 'BCA'
    },
    {
      "id": 2,
      "type": 1,
      "label": 'Bank Negara Indonesia',
      "label_abbr": 'BNI',
      "logo": AppAsset.paymentVaBniSm,
      "message": null,
      "checked": false,
      "is_active": true,
      "ppn": 4000,
      "ppn_percentage": false,
      "code": 'BNI'
    },
    {
      "id": 3,
      "type": 1,
      "label": 'Bank Rakyat Indonesia',
      "label_abbr": 'BRI',
      "logo": AppAsset.paymentVaBriSm,
      "message": null,
      "checked": false,
      "is_active": true,
      "ppn": 4000,
      "ppn_percentage": false,
      "code": 'BRI'
    },
    // {
    //   "id": 4,
    //   "type": 1,
    //   "label": 'Bank Syariah Indonesia',
    //   "label_abbr": 'BSI',
    //   "logo": AppAsset.paymentVaBsiSm,
    //   "message": null,
    //   "checked": false,
    //   "is_active": true,
    //   "ppn": 4000,
    //   "ppn_percentage": false,
    //   "code": 'BSI'
    // },
    // {
    //   "id": 5,
    //   "type": 1,
    //   "label": 'Bank CIMB Niaga',
    //   "label_abbr": null,
    //   "logo": AppAsset.paymentVaCimbSm,
    //   "message": null,
    //   "checked": false,
    //   "is_active": true,
    //   "ppn": 4000,
    //   "ppn_percentage": false,
    //   "code": 'CIMB'
    // },
    {
      "id": 6,
      "type": 1,
      "label": 'Bank Mandiri',
      "label_abbr": null,
      "logo": AppAsset.paymentVaMandiriSm,
      "message": null,
      "checked": false,
      "is_active": true,
      "ppn": 4000,
      "ppn_percentage": false,
      "code": 'MANDIRI'
    },
    // {
    //   "id": 7,
    //   "type": 1,
    //   "label": 'Bank Permata',
    //   "label_abbr": null,
    //   "logo": AppAsset.paymentVaPermataSm,
    //   "message": null,
    //   "checked": false,
    //   "is_active": true,
    //   "ppn": 4000,
    //   "ppn_percentage": false,
    //   "code": 'PERMATA'
    // },
  ];
  List<Map<String, dynamic>> methodDummyEwallet = [
    // {
    //   "id": 8,
    //   "type": 2,
    //   "label": 'OVO',
    //   "label_abbr": null,
    //   "logo": AppAsset.paymentEwalletOvoSm,
    //   "message": null,
    //   "checked": false,
    //   "is_active": true,
    //   'ppn': 1.5,
    //   "ppn_percentage": true,
    //   "code": 'ID_OVO'
    // },
    {
      "id": 9,
      "type": 2,
      "label": 'DANA',
      "label_abbr": null,
      "logo": AppAsset.paymentEwalletDanaSm,
      "message": null,
      "checked": false,
      "is_active": true,
      'ppn': 1.5,
      "ppn_percentage": true,
      "code": 'ID_DANA'
    },
    {
      "id": 10,
      "type": 2,
      "label": 'LinkAja',
      "label_abbr": null,
      "logo": AppAsset.paymentEwalletLaSm,
      "message": null,
      "checked": false,
      "is_active": true,
      'ppn': 1.5,
      "ppn_percentage": true,
      "code": 'ID_LINKAJA'
    },
    {
      "id": 11,
      "type": 2,
      "label": 'ShopeePay',
      "label_abbr": null,
      "logo": AppAsset.paymentEwalletSpSm,
      "message": 'Shopee mobile app must be installed',
      "checked": false,
      "is_active": true,
      'ppn': 2,
      "ppn_percentage": true,
      "code": 'ID_SHOPEEPAY'
    },
  ];
}
