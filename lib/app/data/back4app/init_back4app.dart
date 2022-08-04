import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class InitBack4app {
  InitBack4app() {
    // init();
  }

  Future<bool> init() async {
    const keyApplicationId = 'Y1ngM4pkO6KRQpHVxYbzTMUGcbDsvoGJtQFODxVY';
    const keyClientKey = 'ukQGO74fIqFGP2xoBwiZGLSNpFnNzItLIluoVjDa';
    const keyParseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
      debug: true,
    );
    return (await Parse().healthCheck()).success;
  }
}
