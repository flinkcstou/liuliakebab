package kz.greetgo.click.client;

public class PrepareCordovaStandWWW {
  public static void main(String[] args) throws Exception {
    DirOperations clientDir = ClientUtil.inDir(ClientUtil.getClientDir());

    clientDir.delete("cordova/www");
    clientDir.mkdirs("cordova/www");

    clientDir.file("www/.sencha").copyTo("cordova/www");
    clientDir.file("www/app").copyTo("cordova/www");
    clientDir.file("www/faked_db").copyTo("cordova/www");
    clientDir.file("www/resources").copyTo("cordova/www");
    clientDir.file("www/touch").copyTo("cordova/www");
    clientDir.file("www/app.js").copyTo("cordova/www");
    clientDir.file("www/bootstrap.js").copyTo("cordova/www");
    clientDir.file("www/bootstrap.json").copyTo("cordova/www");
    clientDir.file("www/index-stand.html").copyAndRename("cordova/www/index.html");

    clientDir.file("cordova/www/.sencha").changeNameTo("sencha");

    clientDir.file("cordova/www/index.html").replaceText("\"\\.sencha/app/microloader/", "\"sencha/app/microloader/");

    clientDir.copyDirContentNoReplace("cordova/www_cordova", "cordova/www");
  }
}
