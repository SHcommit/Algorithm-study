import java.util.stream.IntStream;
import java.util.Scanner;
import java.util.Arrays;

public class 평등주의3814 {
    public static void main(String args[]) throws Exception {
        Scanner sc = new Scanner(System.in);
        int tcN = sc.nextInt();
        sc.nextLine();

        for(int tc = 0; tc<tcN;tc++) {
            int n = sc.nextInt(), k = sc.nextInt();
            int[] seq = IntStream.rangeClosed(0,n-1).map( e -> sc.nextInt()).toArray();

            System.out.printf("#%d %d\n", tc+1 ,binarySearch(seq, k));
        }
    }

    public  static int  binarySearch(int [] seq, int k) {
        int max = Arrays.stream(seq).max().orElse(1);
        int l = 0, r = max, m = 0;
        while(l<r) {
            m=(l+r)/2;
            if (isPossible(seq, m, k)) {
                r = m; continue;
            }
            l = m +1;
        }
        if (l == 0) return 1;
        return l;
    }

    public  static  boolean isPossible(int [] seq, int target, int k) {
        int [] modified = new int[seq.length];
        long cnt = 0;

        modified[0] = seq[0];
        for(int i=1;i<seq.length;i++) {
            if  (modified[i-1] + target < seq[i]) {
                modified[i] = modified[i-1] + target;
                cnt += seq[i] - modified[i];
                continue;
            }
            modified[i] = seq[i];
        }

        // 우에서 좌 하는게 빡셈
        for(int i=seq.length-2; i>=0;i--) {
            if (modified[i+1]+target < modified[i]) {
                int diff = modified[i] - (modified[i+1] + target);
                modified[i] = modified[i+1] + target;
                cnt += diff;
            }
        }
        return cnt <=k;
    }
}

