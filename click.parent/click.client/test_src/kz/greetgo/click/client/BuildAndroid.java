package kz.greetgo.click.client;

public class BuildAndroid {
  public static void main(String[] args) throws Exception {
    DirOperations clientDir = ClientUtil.inDir(ClientUtil.getClientDir());

    if (!clientDir.file("cordova/platforms/android").exists()) {
      clientDir.cd("cordova").cmd("cordova platforms add android");
    }

    clientDir.cd("cordova").cmd("cordova prepare");
    clientDir.cd("cordova").cmd("cordova build android");
  }
}
