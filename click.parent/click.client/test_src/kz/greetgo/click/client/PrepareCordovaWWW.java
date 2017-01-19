package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.DirOperations;

public class PrepareCordovaWWW {
  public static void main(String[] args) throws Exception {
    ArgsPCWWW a = ArgsPCWWW.parse(args);

    DirOperations dir = Util.clickClientDir();
    dir.cd("cordova").delete("www");

    String indexName = a.indexName();

    dir.mkdirs("cordova/www");
    dir.file("www/" + indexName).assemblingCopyTo("cordova/www/index.html");

    a.copyDirList.forEach(cd -> dir.file("www/" + cd.dirName).copyTo("cordova/www"));

    a.copyNoReplaceList.forEach(cnr -> dir.copyDirContentNoReplace(cnr.dirFrom, cnr.dirTo));
  }
}
