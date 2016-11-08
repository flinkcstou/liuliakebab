package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.Cordosencha;
import kz.greetgo.cordosencha.gradle.core.CordosenchaCommander;
import kz.greetgo.cordosencha.gradle.core.CordosenchaConfig;

public class Commander {
  public static void main(String[] args) throws Exception {
    new CordosenchaCommander(new Cordosencha(new CordosenchaConfig() {
      @Override
      public String clientModuleName() {
        return "click.client";
      }

      @Override
      public String parameterX() {
        return "X";
      }
    })).executeFromArgs(args);
  }
}
