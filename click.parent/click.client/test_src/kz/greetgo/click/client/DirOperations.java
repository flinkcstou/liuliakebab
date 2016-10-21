package kz.greetgo.click.client;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.stream.Collectors;

import static org.fest.assertions.api.Assertions.assertThat;

public class DirOperations {
  private final File parent;

  public DirOperations(File parent) {
    this.parent = parent;
  }

  public void delete(String path) {
    ClientUtil.removeFile(resolve(path));
  }

  private File resolve(String path) {
    return parent.toPath().resolve(path).toFile();
  }

  public void mkdirs(String path) {
    resolve(path).mkdirs();
  }

  public FileOperations file(String filePath) {
    return new FileOperations(resolve(filePath));
  }

  public void copyDirContentNoReplace(String dirFromPath, String dirToPath) {
    File dirFrom = resolve(dirFromPath);
    File dirTo = resolve(dirToPath);

    ClientUtil.copyDirContentNoReplace(dirFrom, dirTo);
  }

  public DirOperations cd(String path) {
    return new DirOperations(resolve(path));
  }

  public void cmd(String command) throws IOException, InterruptedException {
    System.out.println("RUN: " + command);
    run(command.split("\\s+"));
  }

  public void run(String... commandArray) throws IOException, InterruptedException {
    Process process = new ProcessBuilder(commandArray)
        .directory(parent)
        .inheritIO()
        .start();
    int exitCode = process.waitFor();
    if (exitCode == 0) return;
    throw new RuntimeException("Exit code = " + exitCode + " for: "
        + Arrays.stream(commandArray).collect(Collectors.joining(", ")));
  }

  public String pwd() {
    try {
      return parent.getAbsoluteFile().getCanonicalPath();
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  public class FileOperations {
    private final File file;

    public FileOperations(File file) {
      this.file = file;
    }

    public void copyTo(String destinationDirPath) {
      File destinationDir = resolve(destinationDirPath);

      ClientUtil.copyFileToDir(file, destinationDir);
    }

    public void copyAndRename(String renamedCopiedFilePath) {
      File renamedCopiedFile = resolve(renamedCopiedFilePath);

      renamedCopiedFile.getParentFile().mkdirs();
      ClientUtil.copyFile(file, renamedCopiedFile);
    }

    public void changeNameTo(String newFileName) {
      File newFile = new File(file.getParentFile().toPath().toString() + '/' + newFileName);

      assertThat(file.renameTo(newFile)).isTrue();
    }

    public void replaceText(String regexp, String replacement) {
      String str = ClientUtil.fileToStr(file);
      str = str.replaceAll(regexp, replacement);
      ClientUtil.strToFile(str, file);
    }

    public boolean exists() {
      return file.exists();
    }
  }
}
