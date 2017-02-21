package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.DirOperations;

public class CompileCordovaAndroid {
  public static void main(String[] args) throws Exception {
    DirOperations clickClient = Util.clickClientDir();

    if (!clickClient.file("cordova/platforms/android").exists()) {
      clickClient.cd("cordova").cmd("cordova platform add android@6.1.0");
    }

    clickClient.cd("cordova").cmd("cordova compile android");

    clickClient.xmlFile("cordova/platforms/android/AndroidManifest.xml")
      .modify(xml -> xml.changeAttr("/manifest/application/activity[@name='MainActivity']", "android:windowSoftInputMode", "adjustPan"))
      .save();
    clickClient.cd("cordova").cmd("cordova plugin add https://github.com/kolwit/com.kolwit.pickcontact.git");


  }
}
