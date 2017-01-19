package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.DirOperations;

public class CompileCordovaAndroid {
  public static void main(String[] args) throws Exception {
    DirOperations dir = Util.newDirOperations();

    if (!dir.file("cordova/platforms/android").exists()) {
      dir.cd("cordova").cmd("cordova platform add android@6.1.0");
    }

    dir.cd("cordova").cmd("cordova compile android");

    dir.cmd("cp /home/chingis/IdeaProjects/click/click.parent/click.client/cordova/AndroidManifest.xml /home/chingis/IdeaProjects/click/click.parent/click.client/cordova/platforms/android");
  }
}
