package kz.greetgo.click.client;

public class SenchaAppRefresh {
  public static void main(String[] args) throws Exception {
    DirOperations clientDir = ClientUtil.inDir(ClientUtil.getClientDir());

    System.out.println(System.getenv("PATH"));

    System.out.println(clientDir.cd("www").pwd());

    clientDir.cd("www").cmd("sencha app refresh");
  }
}
