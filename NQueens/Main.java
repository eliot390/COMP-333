import java.util.Arrays;

class NQueens {
  int Unassigned = -1;
  int NoPosAvail = -2;

  int n;
  int curcol;
  int[] queenPos; // row
  int[] nextAvail; // col

  public NQueens(int n) {
    this.n = n;
    this.curcol = 0;
    this.queenPos = new int[n];
    this.nextAvail = new int[n];

    // initialize arrays
    Arrays.fill(queenPos, Unassigned);
    Arrays.fill(nextAvail, 0);
  }

  public void solve() {
    while (curcol>=0) {
      if (curcol == n) {
        curcol--;
        queenPos[curcol] = Unassigned;
      } else {
        int pos = getNextAvail(curcol);
        if (pos == NoPosAvail) {
          queenPos[curcol] = Unassigned;
          nextAvail[curcol] = 0;
          curcol--;
        } else {
          queenPos[curcol] = pos;
          curcol++;
        }
      }
    }
  }

  // checks for conflicts with queens in previous columns
  public boolean nc(int col, int row) {
    /*for (int i = 0; i < col; i++) {
      // check for row and diagonal conflicts
      if (queenPos[i] == row || Math.abs(queenPos[i] - row) == Math.abs(i - col)) {
        return true;
      }
    }
    return false;*/
    for (int i=col-1; i>=0; i--){
      int prevPos = queenPos[i];
      if(row == prevPos){
        return true;
      }
      if(prevPos-row == prevPos-col){
        return true;
      }
    }
    return false;
  }

  public int getNextAvail(int curcol) {
    /*// try next row in current column
    nextAvail[curcol]++;

    // check if row is valid and has no conflicts
    if (nextAvail[curcol] >= n || nc(curcol, nextAvail[curcol+1])) {
      return nextAvail[curcol];
    }
    return NoPosAvail;*/
    int pos = nextAvail[curcol];

    while (true){
      if(pos == n){
        return NoPosAvail;
      }else if(nc(curcol, pos)){
        nextAvail[curcol]++;
        return pos;
      }else{
        nextAvail[curcol]++;
        pos = nextAvail[curcol];
      }
    }
  }

  public void printSolution() {
    System.out.print("   ");
    for (int i=0; i<n; i++){
      System.out.print(i+" ");
    }
    System.out.print("\n");
    for (int i=0; i<(n+1)*2; i++){
      System.out.print("_");
    }
    System.out.print("\n");
    for (int i = 0; i < n; i++) {
      System.out.print(i+": ");
      for (int j = 0; j < n; j++) {
        if (queenPos[i] == j) {
          System.out.print("Q ");
        } else {
          System.out.print("- ");
        }
      }
      System.out.println();
    }
  }

  public static void main(String[] args) {
    NQueens queens = new NQueens(8);
    queens.solve();
    queens.printSolution();
  }
}