package kz.greetgo.click.client;

import kz.greetgo.cordosencha.gradle.core.DirOperations;
import kz.greetgo.cordosencha.gradle.util.OperationUtil;

import java.io.IOException;

public class Util {
  public static DirOperations clickClientDir() throws IOException {
    return OperationUtil.inDir(OperationUtil.getClientDir("click.client"));
  }
}
