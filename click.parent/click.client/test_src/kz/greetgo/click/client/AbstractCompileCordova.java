package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.DirOperations;

import java.io.IOException;

public abstract class AbstractCompileCordova {
  protected final DirOperations clickClient;

  {
    try {

      clickClient = Util.clickClientDir();

    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  protected void addPluginPickcontact() throws IOException, InterruptedException {
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/kolwit/com.kolwit.pickcontact.git#64eafca2b31e4294ff26900291937eb9640067f9");
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/Telerik-Verified-Plugins/Keyboard");
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/greetgo/cordova-plugin-finger-print.git#v1.0.0");
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/greetgo/cordova-plugin-contacts.git#2.3.1_fix");
    clickClient.cd("cordova").cmd("cordova plugin add cordova-fabric-plugin --variable FABRIC_API_KEY=b91233b294510c31b5a63f7df073309196a2eb31 --variable FABRIC_API_SECRET=b796827322b60d795776e34d1950f35281a29d8c4a171eb6128d86ee627faaf6");
    clickClient.cmd("cp www/index-stand-demo.html cordova/www");
  }
}
