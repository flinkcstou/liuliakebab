package kz.greetgo.click.client;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class ClientUtil {
  public static File getClientDir() throws IOException {
    {
      File dir = new File(".").getAbsoluteFile().getCanonicalFile();
      if (dir.exists() && "click.client".equals(dir.getName())) return dir;
    }
    {
      File dir = new File("click.client").getAbsoluteFile().getCanonicalFile();
      if (dir.exists() && "click.client".equals(dir.getName())) return dir;
    }

    throw new RuntimeException("Cannot find client dir");
  }

  public static void removeFile(File file) {
    if (file.isDirectory()) {
      File[] files = file.listFiles();
      if (files != null) Arrays.stream(files).forEach(ClientUtil::removeFile);
    }
    file.delete();
  }

  public static DirOperations inDir(File parent) {
    return new DirOperations(parent);
  }

  public static void copyFileToDir(File file, File destinationDir) {
    File destFile = destinationDir.toPath().resolve(file.getName()).toFile();

    if (file.isDirectory()) {
      File[] subFiles = file.listFiles();
      if (subFiles == null) return;
      Arrays.stream(subFiles).forEach(subFile -> copyFileToDir(subFile, destFile));
      return;
    }

    destFile.getParentFile().mkdirs();
    copyFile(file, destFile);
  }

  private static final int STD_BUFFER_SIZE = 1024 * 8;

  public static void copyFile(File from, File to) {
    try {
      copyFileEx(from, to, STD_BUFFER_SIZE);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  public static void copyFileEx(File from, File to, int bufferSize) throws IOException {
    try (FileInputStream in = new FileInputStream(from)) {
      try (FileOutputStream out = new FileOutputStream(to)) {

        copyStreams(bufferSize, in, out);

      }
    }
  }

  private static void copyStreams(int bufferSize, InputStream in, OutputStream out) throws IOException {
    final byte buffer[] = new byte[bufferSize];
    while (true) {
      int count = in.read(buffer);
      if (count < 0) return;
      out.write(buffer, 0, count);
    }
  }

  public static String fileToStr(File file) {
    try {
      return fileToStrEx(file);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  public static String fileToStrEx(File file) throws IOException {
    ByteArrayOutputStream out = new ByteArrayOutputStream((int) file.length());
    try (FileInputStream in = new FileInputStream(file)) {
      copyStreams(STD_BUFFER_SIZE, in, out);
    }
    return new String(out.toByteArray(), StandardCharsets.UTF_8);
  }

  public static void strToFile(String str, File file) {
    try {
      strToFileEx(str, file);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  public static void strToFileEx(String str, File file) throws IOException {
    try (FileOutputStream out = new FileOutputStream(file)) {
      out.write(str.getBytes(StandardCharsets.UTF_8));
    }
  }

  public static void copyDirContentNoReplace(File dirFrom, File dirTo) {
    File[] files = dirFrom.listFiles();
    if (files == null) throw new IllegalArgumentException("No dir " + dirFrom);
    Arrays.stream(files).forEach(fromFile -> {
      File toFile = new File(dirTo.getPath() + '/' + fromFile.getName());
      if (fromFile.isDirectory()) {
        copyDirContentNoReplace(fromFile, toFile);
      } else if (!toFile.exists()) {
        toFile.getParentFile().mkdirs();
        copyFile(fromFile, toFile);
      }
    });
  }
}
