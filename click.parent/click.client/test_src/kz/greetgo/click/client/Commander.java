package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.Cordosencha;
import kz.greetgo.cordosencha.gradle.CordosenchaCommander;
import kz.greetgo.cordosencha.gradle.CordosenchaConfig;

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
