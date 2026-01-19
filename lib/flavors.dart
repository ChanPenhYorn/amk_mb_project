enum Flavor { dev, staging, prod }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'AMK Dev';
      case Flavor.staging:
        return 'AMK Staging';
      case Flavor.prod:
        return 'AMK Prod';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://dev.example.com';
      case Flavor.staging:
        return 'https://staging.example.com';
      case Flavor.prod:
        return 'https://example.com';
    }
  }
}
