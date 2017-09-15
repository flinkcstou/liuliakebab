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
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/kolwit/com.kolwit.pickcontact.git");
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/Telerik-Verified-Plugins/Keyboard");
    clickClient.cmd("cp www/index-stand-demo.html cordova/www");
  }
}
