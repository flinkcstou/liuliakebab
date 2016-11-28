package kz.greetgo.click.client;

import java.util.ArrayList;
import java.util.List;

import static java.util.Collections.unmodifiableList;

public class ArgsPCWWW {
  public static class CopyDir {
    public final String dirName;

    public CopyDir(String dirName) {
      this.dirName = dirName;
    }
  }

  public final List<CopyDir> copyDirList;

  public static class CopyNoReplace {
    public final String dirFrom, dirTo;

    public CopyNoReplace(String dirFrom, String dirTo) {
      this.dirFrom = dirFrom;
      this.dirTo = dirTo;
    }
  }

  public final List<CopyNoReplace> copyNoReplaceList;

  public static ArgsPCWWW parse(String[] args) {
    return new ArgsPCWWW(args);
  }

  private String indexName = null;

  public String indexName() {
    if (indexName == null) throw new NullPointerException("No indexName");
    return indexName;
  }

  private ArgsPCWWW(String[] args) {
    List<CopyDir> copyDirList = new ArrayList<>();
    List<CopyNoReplace> copyNoReplaceList = new ArrayList<>();

    int i = 0, n = args.length;
    WHILE:
    while (i < n) {
      String element = args[i++];

      if ("-copyDir".equals(element)) {
        copyDirList.add(new CopyDir(args[i++]));
        continue WHILE;
      }

      if ("-copyNoReplace".equals(element)) {
        String dirFrom = args[i++];
        String dirTo = args[i++];
        copyNoReplaceList.add(new CopyNoReplace(dirFrom, dirTo));
        continue WHILE;
      }

      if ("-indexName".equals(element)) {
        indexName = args[i++];
        continue WHILE;
      }

      throw new IllegalArgumentException("Unknown element " + element);
    }

    this.copyDirList = unmodifiableList(copyDirList);
    this.copyNoReplaceList = unmodifiableList(copyNoReplaceList);
  }
}
