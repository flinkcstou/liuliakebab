package kz.greetgo.click.client;

public class CompileCordovaIos extends AbstractCompileCordova {
  public static void main(String[] args) throws Exception {
    new CompileCordovaIos().execute();
  }

  private void execute() throws Exception {
    if (!clickClient.file("cordova/platforms/ios").exists()) {
      clickClient.cd("cordova").cmd("cordova platform add ios");
    }
    
    addPluginPickcontact();

    clickClient.cd("cordova").cmd("cp www/index-stand-demo.html platforms/ios/www");
    //clickClient.cd("cordova").cmd("cordova plugin add https://github.com/Rohfosho/CordovaCallNumberPlugin.git");
  }
}
