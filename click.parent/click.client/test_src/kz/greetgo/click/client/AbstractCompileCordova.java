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
//    clickClient.cmd("npm install");
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/kolwit/com.kolwit.pickcontact.git#64eafca2b31e4294ff26900291937eb9640067f9");
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/Telerik-Verified-Plugins/Keyboard");
    clickClient.cmd("cp www/index-stand-demo.html cordova/www");
    //a14a427f6ec8a75cd4ffca75afc8d69c3619331e
  }
}
