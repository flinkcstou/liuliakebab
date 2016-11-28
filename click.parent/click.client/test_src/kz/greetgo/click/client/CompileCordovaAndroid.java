package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.DirOperations;

public class CompileCordovaAndroid {
  public static void main(String[] args) throws Exception {
    DirOperations dir = Util.newDirOperations();
    
    if (!dir.file("cordova/platforms").exists()) {
      dir.cd("cordova").cmd("cordova platform add android");
    }

    dir.cd("cordova").cmd("cordova compile android");
  }
}
