import java.util.*;
class Solution {
    static List<Integer>[] graph;
    static int[] cache = new int[20001];
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
        int maxValue = 0;
        for(int i=1;i<=n;i++) maxValue = Math.max(cache[i], maxValue);
        for(int i=1;i<=n;i++) if(cache[i]==maxValue)ans++;
        return ans;
    }
    
    class Edge {
        int to, cost;
        Edge(int t, int c) { to=t; cost=c;}
    }
    
    void bfs() {
        Queue<Edge> queue = new ArrayDeque<>();
        queue.add(new Edge(1,1));
        cache[1]=1;
        while(!queue.isEmpty()) {
            Edge cur = queue.poll();
            for(int next: graph[cur.to]) {
                int nextCost = cur.cost+1;
                if(cache[next]!=0) continue;
                cache[next] = nextCost;
                queue.add(new Edge(next, nextCost));
            }
        }
    }
}
