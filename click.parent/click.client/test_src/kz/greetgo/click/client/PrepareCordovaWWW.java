package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.DirOperations;
import kz.greetgo.cordosencha.gradle.util.OperationUtil;

public class PrepareCordovaWWW {
  public static void main(String[] args) throws Exception {
    String indexName = args[0];
    DirOperations dir = OperationUtil.inDir(OperationUtil.getClientDir("click.client"));
    dir.cd("cordova").delete("www");
    
    System.out.println("indexName = " + indexName);
  }
}
