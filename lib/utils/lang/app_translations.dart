import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  static const fallbackLocale = Locale('en', 'US');
  static const supportedLocales = <Locale>[
    Locale('en', 'US'),
    Locale('th', 'TH'),
  ];

  static Locale resolveLocale(Locale? deviceLocale) {
    if (deviceLocale == null) {
      return fallbackLocale;
    }

    for (final locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode) {
        return locale;
      }
    }

    return fallbackLocale;
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'commonBrowsePlans': 'Browse plans',
      'commonEmptyTitle': 'No data available',
      'commonErrorTitle': 'Something went wrong',
      'commonLanguage': 'Language',
      'commonRetry': 'Try again',
      'subscriptionActivePlans': 'Current package',
      'subscriptionAccessPeriod': 'Access period',
      'subscriptionBuyNow': 'Buy now',
      'subscriptionEmptyDescription':
          'Packages will appear here once the catalog is ready.',
      'subscriptionEmptyTitle': 'No packages available',
      'subscriptionExpiredPackages': 'Expired packages',
      'subscriptionHistoryEmptyDescription':
          'Your active and expired packages will appear here after a purchase.',
      'subscriptionHistoryEmptyTitle': 'No purchase history',
      'subscriptionHistoryErrorDescription':
          'Please try again or review the current mock state.',
      'subscriptionHistoryErrorTitle': 'Unable to load history',
      'subscriptionHistoryHeadline': 'Track current and past packages',
      'subscriptionHistoryLoadingDescription':
          'Loading your package history and payment details.',
      'subscriptionHistorySubtitle':
          'Review purchased date, time, access period, and payment channel in one place.',
      'subscriptionHistoryTitle': 'Purchase History',
      'subscriptionIncludes': 'What you get',
      'subscriptionLoadingDescription': 'Preparing available packages for you.',
      'subscriptionMostPopular': 'Most popular',
      'subscriptionNoActivePlan': 'No active package',
      'subscriptionNoExpiredPlan': 'No expired packages',
      'subscriptionPaymentMethod': 'Payment method',
      'subscriptionPaymentSecure':
          'Responsive flow ready for staging and production setup',
      'subscriptionPerMonth': 'per month',
      'subscriptionPerYear': 'per year',
      'subscriptionPurchaseErrorDescription':
          'Please check the mock state or try loading again.',
      'subscriptionPurchaseErrorMessage':
          'Unable to complete purchase. Please try again.',
      'subscriptionPurchaseErrorTitle': 'Unable to load packages',
      'subscriptionPurchaseHeadline': 'Choose your subscription',
      'subscriptionPurchaseSuccessMessage':
          'Your package has been added to purchase history.',
      'subscriptionPurchaseSuccessTitle': 'Purchase completed',
      'subscriptionPurchaseSubtitle':
          'Compare benefits, prices, and start enjoying T-POP on mobile and iPad instantly.',
      'subscriptionPurchaseTitle': 'Purchase Package',
      'subscriptionPurchasedAt': 'Purchased at',
      'subscriptionSettingsAppVersion': 'App version',
      'subscriptionSettingsAppVersionDescription':
          'Current version installed on this device.',
      'subscriptionSettingsEnglish': 'English',
      'subscriptionSettingsHeadline': 'Manage your app preferences',
      'subscriptionSettingsLanguageDescription':
          'Choose the language used across the subscription flow.',
      'subscriptionSettingsSubtitle':
          'Update language preferences and review application details here.',
      'subscriptionSettingsThai': 'Thai',
      'subscriptionSettingsTitle': 'Settings',
      'subscriptionSettingsVersionUnavailable': 'Version unavailable',
      'subscriptionSelectPlan': 'Choose this plan',
      'subscriptionSelected': 'Currently selected',
      'subscriptionSelectedPlan': 'Selected plan',
      'subscriptionTabHistory': 'History',
      'subscriptionTabPackages': 'Packages',
      'subscriptionTabSettings': 'Settings',
      'subscriptionStatusActive': 'Active',
      'subscriptionStatusExpired': 'Expired',
      'paymentApplePay': 'Apple Pay',
      'paymentCreditCard': 'Credit card',
      'paymentGooglePlay': 'Google Play',
      'packagePinkPlusDescription':
          'Ad-free listening with offline access and early-release picks.',
      'packagePinkPlusFeature1': 'Unlimited music streaming',
      'packagePinkPlusFeature2': 'Offline downloads on 2 devices',
      'packagePinkPlusFeature3': 'Early access to selected releases',
      'packagePinkPlusFeature4': 'Priority in-app support',
      'packagePinkPlusSubtitle': 'Monthly starter for everyday listeners',
      'packagePinkPlusTitle': 'Pink Plus',
      'packageStagePassDescription':
          'Full access to exclusives, fan events, and premium streaming quality.',
      'packageStagePassFeature1': 'Everything in Pink Plus',
      'packageStagePassFeature2': '4K concert archive and backstage clips',
      'packageStagePassFeature3': 'Monthly fan mission rewards',
      'packageStagePassFeature4': 'Invites to exclusive ticket presales',
      'packageStagePassSubtitle': 'Annual premium for superfans',
      'packageStagePassTitle': 'Stage Pass',
    },
    'th_TH': {
      'commonBrowsePlans': 'ดูแพ็กเกจ',
      'commonEmptyTitle': 'ยังไม่มีข้อมูล',
      'commonErrorTitle': 'เกิดข้อผิดพลาด',
      'commonLanguage': 'ภาษา',
      'commonRetry': 'ลองใหม่',
      'subscriptionActivePlans': 'แพ็กเกจที่ใช้งานอยู่',
      'subscriptionAccessPeriod': 'ช่วงเวลาการใช้งาน',
      'subscriptionBuyNow': 'ซื้อเลย',
      'subscriptionEmptyDescription':
          'รายการแพ็กเกจจะปรากฏที่นี่เมื่อระบบเตรียมข้อมูลพร้อมแล้ว',
      'subscriptionEmptyTitle': 'ยังไม่มีแพ็กเกจให้ซื้อ',
      'subscriptionExpiredPackages': 'แพ็กเกจที่หมดอายุ',
      'subscriptionHistoryEmptyDescription':
          'ประวัติแพ็กเกจที่ใช้งานอยู่และหมดอายุแล้วจะแสดงที่นี่หลังมีการซื้อ',
      'subscriptionHistoryEmptyTitle': 'ยังไม่มีประวัติการซื้อ',
      'subscriptionHistoryErrorDescription':
          'กรุณาลองใหม่อีกครั้งหรือตรวจสอบ mock state ที่ใช้งานอยู่',
      'subscriptionHistoryErrorTitle': 'ไม่สามารถโหลดประวัติได้',
      'subscriptionHistoryHeadline': 'ติดตามแพ็กเกจปัจจุบันและแพ็กเกจที่ผ่านมา',
      'subscriptionHistoryLoadingDescription':
          'กำลังโหลดประวัติแพ็กเกจและรายละเอียดการชำระเงิน',
      'subscriptionHistorySubtitle':
          'ดูวันที่ เวลา ช่วงเวลาการใช้งาน และช่องทางชำระเงินได้ในที่เดียว',
      'subscriptionHistoryTitle': 'ประวัติการซื้อ',
      'subscriptionIncludes': 'สิ่งที่ได้รับ',
      'subscriptionLoadingDescription':
          'กำลังเตรียมรายการแพ็กเกจที่พร้อมใช้งานให้คุณ',
      'subscriptionMostPopular': 'แพ็กเกจยอดนิยม',
      'subscriptionNoActivePlan': 'ยังไม่มีแพ็กเกจที่ใช้งานอยู่',
      'subscriptionNoExpiredPlan': 'ยังไม่มีแพ็กเกจที่หมดอายุ',
      'subscriptionPaymentMethod': 'ช่องทางชำระเงิน',
      'subscriptionPaymentSecure':
          'รองรับ flow แบบ responsive และพร้อมต่อ staging / production',
      'subscriptionPerMonth': 'ต่อเดือน',
      'subscriptionPerYear': 'ต่อปี',
      'subscriptionPurchaseErrorDescription':
          'กรุณาตรวจสอบ mock state หรือลองโหลดใหม่อีกครั้ง',
      'subscriptionPurchaseErrorMessage':
          'ไม่สามารถทำรายการซื้อได้ กรุณาลองใหม่อีกครั้ง',
      'subscriptionPurchaseErrorTitle': 'ไม่สามารถโหลดแพ็กเกจได้',
      'subscriptionPurchaseHeadline': 'เลือกแพ็กเกจที่เหมาะกับคุณ',
      'subscriptionPurchaseSuccessMessage':
          'ระบบได้เพิ่มแพ็กเกจนี้เข้าไปในประวัติการซื้อแล้ว',
      'subscriptionPurchaseSuccessTitle': 'ซื้อแพ็กเกจสำเร็จ',
      'subscriptionPurchaseSubtitle':
          'เปรียบเทียบสิทธิประโยชน์ ราคา และเริ่มใช้งาน T-POP ได้ทันทีทั้งบนมือถือและ iPad',
      'subscriptionPurchaseTitle': 'ซื้อแพ็กเกจ',
      'subscriptionPurchasedAt': 'ซื้อเมื่อ',
      'subscriptionSettingsAppVersion': 'เวอร์ชันแอป',
      'subscriptionSettingsAppVersionDescription':
          'เวอร์ชันที่ติดตั้งอยู่บนอุปกรณ์เครื่องนี้',
      'subscriptionSettingsEnglish': 'English',
      'subscriptionSettingsHeadline': 'จัดการการตั้งค่าของแอป',
      'subscriptionSettingsLanguageDescription': 'เลือกภาษาที่ใช้แสดงผล',
      'subscriptionSettingsSubtitle':
          'ปรับภาษาและดูรายละเอียดของแอปได้จากหน้านี้',
      'subscriptionSettingsThai': 'ไทย',
      'subscriptionSettingsTitle': 'ตั้งค่า',
      'subscriptionSettingsVersionUnavailable': 'ไม่พบข้อมูลเวอร์ชัน',
      'subscriptionSelectPlan': 'เลือกแพ็กเกจนี้',
      'subscriptionSelected': 'กำลังเลือกอยู่',
      'subscriptionSelectedPlan': 'แพ็กเกจที่เลือก',
      'subscriptionTabHistory': 'ประวัติ',
      'subscriptionTabPackages': 'แพ็กเกจ',
      'subscriptionTabSettings': 'ตั้งค่า',
      'subscriptionStatusActive': 'กำลังใช้งาน',
      'subscriptionStatusExpired': 'หมดอายุ',
      'paymentApplePay': 'Apple Pay',
      'paymentCreditCard': 'บัตรเครดิต',
      'paymentGooglePlay': 'Google Play',
      'packagePinkPlusDescription':
          'ฟังแบบไม่มีโฆษณา ดาวน์โหลดออฟไลน์ได้ และเข้าถึงคอนเทนต์ที่ปล่อยก่อนใคร',
      'packagePinkPlusFeature1': 'สตรีมเพลงได้ไม่จำกัด',
      'packagePinkPlusFeature2': 'ดาวน์โหลดออฟไลน์ได้ 2 อุปกรณ์',
      'packagePinkPlusFeature3': 'เข้าถึงบางคอนเทนต์ก่อนใคร',
      'packagePinkPlusFeature4': 'รับการช่วยเหลือในแอปแบบลำดับความสำคัญ',
      'packagePinkPlusSubtitle': 'แพ็กเกจรายเดือนสำหรับการฟังทุกวัน',
      'packagePinkPlusTitle': 'Pink Plus',
      'packageStagePassDescription':
          'เข้าถึงคอนเทนต์พิเศษ งานแฟน และคุณภาพสตรีมระดับพรีเมียมได้ครบถ้วน',
      'packageStagePassFeature1': 'รับทุกอย่างจาก Pink Plus',
      'packageStagePassFeature2': 'เข้าคลังคอนเสิร์ต 4K และ backstage clips',
      'packageStagePassFeature3': 'รับรางวัลจาก fan mission รายเดือน',
      'packageStagePassFeature4': 'สิทธิ์ presale ตั๋วกิจกรรมพิเศษ',
      'packageStagePassSubtitle': 'แพ็กเกจรายปีสำหรับแฟนตัวจริง',
      'packageStagePassTitle': 'Stage Pass',
    },
  };
}
