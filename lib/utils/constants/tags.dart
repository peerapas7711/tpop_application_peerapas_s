// ignore_for_file: constant_identifier_names

const String tagsStorageName = 'Tags';

final Tags tags = Tags();

class Tags {
  static final Tags _tags = Tags._i();

  factory Tags() {
    return _tags;
  }

  Tags._i();

  static const String LANG = 'lang';
  static const String LOCALELANG = 'localelang';
  static const String LOCALE = 'locale';
  static const String LOCALE_LABEL = 'localeLabel';
}
