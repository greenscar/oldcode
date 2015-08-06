package wjhk.jupload.filepanel;

import java.util.Comparator;
import java.util.Vector;

public class ColumnComparator implements Comparator {
  protected int index;
  protected boolean ascending;

  public ColumnComparator(int index, boolean ascending) {
    this.index = index;
    this.ascending = ascending;
  }

  public int compare(Object one, Object two) {
    if (one instanceof Vector && two instanceof Vector) {
      Object eOne = ((Vector) one).elementAt(index);
      Object eTwo = ((Vector) two).elementAt(index);
      if (eOne instanceof Comparable && eTwo instanceof Comparable) {
        if (ascending) {
          return ((Comparable) eOne).compareTo(eTwo);
        } else {
          return ((Comparable) eTwo).compareTo(eOne);
        }
      }
    }
    return 0;
  }
}
