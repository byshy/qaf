enum Env { production }

class Environment {
  final Env environment;
  late String baseURL;
  late int documentNO;
  late String testUserPass;

  Environment(this.environment) {
    switch (environment) {
      case Env.production:
        baseURL = 'https://paltel.myclinichub.com/frontend/web/';
        documentNO = 405134123;
        testUserPass = 'ab123456';
        break;
    }
  }
}
