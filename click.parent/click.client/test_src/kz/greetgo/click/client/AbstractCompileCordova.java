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
    clickClient.cmd("cp www/index-stand-demo.html cordova/www");
  }
}