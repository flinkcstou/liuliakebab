package kz.greetgo.click.client;

public class ClearClient {
  public static void main(String[] args) throws Exception {
    DirOperations clientDir = ClientUtil.inDir(ClientUtil.getClientDir());

    clientDir.delete("cordova/platforms");
    clientDir.delete("cordova/plugins");
    clientDir.delete("cordova/www");

    clientDir.delete("www/sass");
    clientDir.delete("www/build");
    clientDir.delete("www/bootstrap.js");
    clientDir.delete("www/bootstrap.json");
  }
}
