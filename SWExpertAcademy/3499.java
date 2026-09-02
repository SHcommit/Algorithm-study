package Solution;
import java.util.*;

public class swea_3499_퍼펙트셔플 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int N = sc.nextInt();
        for(int testCase = 1; testCase <= N; testCase++)    {
            int n = sc.nextInt();
            String[] seq = new String[n];
            for(int i=0;i<n;i++) seq[i] = sc.next();
            String output= "#"+testCase+" ";
            int second = (n+1)/2;
            for(int i=0;i<n/2;i++) output+=seq[i]+ " " + seq[second+i] + " ";
            if (n%2==1) output+= seq[n/2];
            System.out.println(output);
        }
    }
}
