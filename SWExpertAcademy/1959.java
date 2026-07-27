import java.util.*;
import java.util.stream.*;
import java.io.*;
 
class Solution {
    public static void main(String args[]) throws Exception {
        Scanner sc = new Scanner(System.in);
        int T = sc.nextInt();
        sc.nextLine();
         
        for(int test_case = 1; test_case <= T; test_case++) {
            sc.nextLine();
            int[] lhs = Arrays.stream(sc.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray();
            int[] rhs = Arrays.stream(sc.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray();
            int res = lhs.length > rhs.length ? solve(lhs, rhs) : solve(rhs, lhs);
            System.out.println( "#" + test_case  + " " + res);
        }
    }
     
    static int solve(int[] baseSeq, int[] targetSeq) {
        int baseN = baseSeq.length;
        int targetN = targetSeq.length;
         
        return IntStream.range(0, baseN-targetN+1)
            .map(i -> IntStream.range(0,targetN).map(j -> baseSeq[i+j]*targetSeq[j]).sum())
            .max()
            .getAsInt();
    }
}
