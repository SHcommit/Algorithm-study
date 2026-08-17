import java.util.Arrays;
import java.util.Scanner;
class Solution {
    static int[] cache;
    static int[] seq;
    // 가중치최악 *v개 생각
    // 음의 경우..  
    public static void main(String a[]) throws Exception {
        Scanner sc = new Scanner(System.in);
        int t = sc.nextInt();
        for(int tc = 1; tc <= t; tc++) {
            int v = sc.nextInt(), c = sc.nextInt();
            int input[][] = new int[c][3];
             
            for(int i=0;i<c*3;i++) input[i/3][i%3] = sc.nextInt();
            Arrays.sort(input, ((lhs, rhs) -> lhs[2]-rhs[2]));
             
            cache = new int[v+1];
            seq = new int[v+1];
            long ans = 0;
             
            for(int i=1;i<=v;i++) cache[i]=i;
            for(int i=0;i<c;i++) {
                int from = input[i][0], to = input[i][1], cost = input[i][2];
                if(!union(from,to)) continue;
                ans+= cost;
            }
            System.out.printf("#%d %d\n", tc, ans);
        }
    }
    public static boolean union(int a, int b) {
        a = find(a);
        b = find(b);
        if(a==b) return false;
        cache[b]=a;
        return true;
    }
    public static int find(int node) {
        if(cache[node]==node) return node;
        return cache[node] = find(cache[node]);
    }
}
