import java.util.*;
class Solution {
    static List<Integer>[] graph;
    static int[] cache = new int[20001];
    static int maxCost = 0;
    public int solution(int n, int[][] edges) {
        graph = new ArrayList[n+1];
        for(int i=0;i<=n;i++) graph[i] = new ArrayList<>();
        for(int[] edge: edges) {
            int from = edge[0], to=edge[1];
            graph[from].add(to);
            graph[to].add(from);
        }
        int ans = 0;
        bfs();
        for(int i=1;i<=n;i++) if(cache[i]==maxCost)ans++;
        return ans;
    }
    void bfs() {
        Queue<Integer> queue = new ArrayDeque<>();
        queue.add(1);
        cache[1]=1;
        while(!queue.isEmpty()) {
            int cur = queue.poll();
            for(int next: graph[cur]) {
                if(cache[next]!=0) continue;
                int nextCost = cache[cur]+1;
                maxCost = Math.max(maxCost, nextCost);
                cache[next] = nextCost;
                queue.add(next);
            }
        }
    }
}
