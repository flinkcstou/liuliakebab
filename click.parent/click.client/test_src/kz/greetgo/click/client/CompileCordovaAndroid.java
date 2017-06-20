package kz.greetgo.click.client;

import java.io.IOException;

public class CompileCordovaAndroid extends AbstractCompileCordova {
  public static void main(String[] args) throws Exception {
    new CompileCordovaAndroid().execute();
  }

  private void execute() throws Exception {
    if (!clickClient.file("cordova/platforms/android").exists()) {
      clickClient.cd("cordova").cmd("cordova platform add android@6.1.0");
    }

    clickClient.cd("cordova").cmd("cordova compile android");

    clickClient.xmlFile("cordova/platforms/android/AndroidManifest.xml")
      .modify(xml -> xml.changeAttr("/manifest/application/activity[@name='MainActivity']", "android:windowSoftInputMode", "adjustPan"))
      .modify(xml -> xml.changeAttr("/manifest/application/activity[@name='MainActivity']", "android:resizeableActivity", "false"))
      .save();

    addPluginPickcontact();
    
    clickClient.cd("cordova").cmd("cp www/index-stand-demo.html platforms/android/assets/www");

  }
}
