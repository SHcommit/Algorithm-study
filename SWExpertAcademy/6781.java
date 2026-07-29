import java.util.Map;
import java.util.HashMap;
import java.util.Scanner;

// 지금 문제풀면서 느끼는게, 토익 셤볼때.. 지문 한번에 이해안가고 3~4번씩 보고 답찾고 이렇게하면은..
// 시간 부족해서 문제 다 못품..
// 백준도 마찬가지로 최대한 한번 읽으면 .. 그 한번엔에 조건들을 잘 정리해서 그거만 보도록 하는 습관을 기르자.

public class 삼성6781 {
    public static void main(String[] args) {
        Map<Character,Integer> mapper = new HashMap<>();
        mapper.put('R',0); mapper.put('G',1); mapper.put('B',2);
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(); sc.nextLine();

        for(int tc=1;tc<=n; tc++) {
            int[][] cache = new int[3][10];
            char[][] inputs = {sc.nextLine().toCharArray(), sc.nextLine().toCharArray()};

            for(int i = 0; i <9 ; i++) {
                int num = inputs[0][i] - '0';
                char col = inputs[1][i];
                cache[mapper.get(col)][num]++;
            }
            boolean res = dfs(cache[0]) && dfs(cache[1]) && dfs(cache[2]);
            System.out.printf("#%d %s\n", tc, res ? "Win" : "Continue" );
        }
    }
    static boolean dfs(int []seq) {
        int entry = 0;
        while( entry < 10 && seq[entry] == 0) { entry++; }
        if (entry==10) return true;
        if (seq[entry] >=3) {
            seq[entry]-=3;
            if(dfs(seq)) return true;
            seq[entry]+=3;
        }
        if (entry <= 7 && seq[entry] > 0 && seq[entry+1] >0 && seq[entry+2]>0) {
            seq[entry]--;
            seq[entry+1]--;
            seq[entry+2]--;
            if (dfs(seq)) return true;
        }
        return false;
    }
}
