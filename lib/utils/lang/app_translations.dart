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
      'commonCancel': 'Cancel',
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
          'Please try again and check your Firestore data or permissions.',
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
          'Responsive flow backed by Firestore with staging and production paths',
      'subscriptionPerMonth': 'per month',
      'subscriptionPerYear': 'per year',
      'subscriptionPurchaseErrorDescription':
          'Please try again and check your Firestore catalog or permissions.',
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
      'subscriptionSettingsClearHistoryButton': 'Clear purchase history',
      'subscriptionSettingsClearHistoryConfirmAction': 'Clear now',
      'subscriptionSettingsClearHistoryConfirmDescription':
          'This will permanently remove all active and expired package records from purchase history in this environment.',
      'subscriptionSettingsClearHistoryConfirmTitle': 'Clear purchase history?',
      'subscriptionSettingsClearHistoryDescription':
          'Delete all active and expired package records for the current environment.',
      'subscriptionSettingsClearHistoryErrorMessage':
          'Unable to clear purchase history. Please try again.',
      'subscriptionSettingsEnglish': 'English',
      'subscriptionSettingsHeadline': 'Manage your app preferences',
      'subscriptionSettingsLanguageDescription':
          'Choose the language used across the subscription flow.',
      'subscriptionSettingsClearHistoryProcessing': 'Clearing history...',
      'subscriptionSettingsClearHistorySuccessMessage':
          'Purchase history has been cleared.',
      'subscriptionSettingsClearHistorySuccessTitle': 'History cleared',
      'subscriptionSettingsClearHistoryTitle': 'Clear purchase history',
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
      'packageBackstageVipDescription':
          'The full fan experience with concierge perks and the best access to exclusive moments.',
      'packageBackstageVipFeature1': 'Everything in Stage Pass',
      'packageBackstageVipFeature2': 'VIP-only behind-the-scenes livestreams',
      'packageBackstageVipFeature3':
          'First-queue access for meet and greet events',
      'packageBackstageVipFeature4': 'Dedicated concierge support',
      'packageBackstageVipSubtitle': 'Ultimate annual access for superfans',
      'packageBackstageVipTitle': 'Backstage VIP',
      'packageFanClubDescription':
          'More artist perks, better downloads, and bonus rewards every month.',
      'packageFanClubFeature1': 'Everything in Pink Plus',
      'packageFanClubFeature2': 'Offline downloads on 4 devices',
      'packageFanClubFeature3': 'Monthly fan badge and points boost',
      'packageFanClubFeature4': 'Access to member-only live chats',
      'packageFanClubSubtitle': 'Monthly perks for dedicated fans',
      'packageFanClubTitle': 'Fan Club',
      'packagePinkLiteDescription':
          'Essential streaming for daily playlists at the lightest price.',
      'packagePinkLiteFeature1': 'Ad-free listening on mobile',
      'packagePinkLiteFeature2': 'High-quality audio streaming',
      'packagePinkLiteFeature3': 'Save favorite playlists',
      'packagePinkLiteFeature4': 'Offline downloads on 1 device',
      'packagePinkLiteSubtitle': 'Entry plan for casual listeners',
      'packagePinkLiteTitle': 'Pink Lite',
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
      'commonCancel': 'ยกเลิก',
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
          'กรุณาลองใหม่อีกครั้ง และตรวจสอบข้อมูลหรือสิทธิ์การเข้าถึง Firestore',
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
          'รองรับ flow แบบ responsive และแยก path Firestore สำหรับ staging / production',
      'subscriptionPerMonth': 'ต่อเดือน',
      'subscriptionPerYear': 'ต่อปี',
      'subscriptionPurchaseErrorDescription':
          'กรุณาลองใหม่อีกครั้ง และตรวจสอบ catalog หรือสิทธิ์การเข้าถึง Firestore',
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
      'subscriptionSettingsClearHistoryButton': 'เคลียร์ประวัติการซื้อ',
      'subscriptionSettingsClearHistoryConfirmAction': 'เคลียร์เลย',
      'subscriptionSettingsClearHistoryConfirmDescription':
          'รายการแพ็กเกจที่กำลังใช้งานและหมดอายุทั้งหมดในประวัติการซื้อของ environment นี้จะถูกลบอย่างถาวร',
      'subscriptionSettingsClearHistoryConfirmTitle':
          'ต้องการเคลียร์ประวัติการซื้อใช่ไหม',
      'subscriptionSettingsClearHistoryDescription':
          'ลบรายการแพ็กเกจที่กำลังใช้งานและหมดอายุทั้งหมดของ environment ปัจจุบัน',
      'subscriptionSettingsClearHistoryErrorMessage':
          'ไม่สามารถเคลียร์ประวัติการซื้อได้ กรุณาลองใหม่อีกครั้ง',
      'subscriptionSettingsEnglish': 'English',
      'subscriptionSettingsHeadline': 'จัดการการตั้งค่าของแอป',
      'subscriptionSettingsLanguageDescription': 'เลือกภาษาที่ใช้แสดงผล',
      'subscriptionSettingsClearHistoryProcessing': 'กำลังเคลียร์ประวัติ...',
      'subscriptionSettingsClearHistorySuccessMessage':
          'ล้างประวัติการซื้อเรียบร้อยแล้ว',
      'subscriptionSettingsClearHistorySuccessTitle': 'เคลียร์ประวัติสำเร็จ',
      'subscriptionSettingsClearHistoryTitle': 'เคลียร์ประวัติการซื้อ',
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
      'packageBackstageVipDescription':
          'ประสบการณ์แฟนแบบเต็มรูปแบบ พร้อมสิทธิพิเศษระดับ concierge และการเข้าถึงโมเมนต์เอ็กซ์คลูซีฟที่ดีที่สุด',
      'packageBackstageVipFeature1': 'รับทุกอย่างจาก Stage Pass',
      'packageBackstageVipFeature2': 'รับชมไลฟ์เบื้องหลังเฉพาะสมาชิก VIP',
      'packageBackstageVipFeature3': 'ได้คิวแรกสำหรับกิจกรรม meet and greet',
      'packageBackstageVipFeature4': 'มีผู้ช่วยดูแลแบบเฉพาะสมาชิก',
      'packageBackstageVipSubtitle': 'แพ็กเกจรายปีขั้นสุดสำหรับซูเปอร์แฟน',
      'packageBackstageVipTitle': 'Backstage VIP',
      'packageFanClubDescription':
          'เพิ่มสิทธิพิเศษของศิลปิน ดาวน์โหลดได้มากขึ้น และรับโบนัสรายเดือนทุกเดือน',
      'packageFanClubFeature1': 'รับทุกอย่างจาก Pink Plus',
      'packageFanClubFeature2': 'ดาวน์โหลดออฟไลน์ได้ 4 อุปกรณ์',
      'packageFanClubFeature3': 'รับตราแฟนและคะแนนโบนัสรายเดือน',
      'packageFanClubFeature4': 'เข้าห้องไลฟ์แชตเฉพาะสมาชิกได้',
      'packageFanClubSubtitle': 'สิทธิพิเศษรายเดือนสำหรับแฟนตัวยง',
      'packageFanClubTitle': 'Fan Club',
      'packagePinkLiteDescription':
          'ฟังเพลย์ลิสต์ประจำวันได้แบบคุ้มค่า พร้อมสิทธิ์พื้นฐานที่จำเป็นในราคาที่เบาที่สุด',
      'packagePinkLiteFeature1': 'ฟังบนมือถือได้แบบไม่มีโฆษณา',
      'packagePinkLiteFeature2': 'สตรีมเสียงคุณภาพสูง',
      'packagePinkLiteFeature3': 'บันทึกเพลย์ลิสต์โปรดได้',
      'packagePinkLiteFeature4': 'ดาวน์โหลดออฟไลน์ได้ 1 อุปกรณ์',
      'packagePinkLiteSubtitle': 'แพ็กเกจเริ่มต้นสำหรับคนฟังสบาย ๆ',
      'packagePinkLiteTitle': 'Pink Lite',
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
