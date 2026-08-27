import java.util.*;

class Solution {
    static class Edge {
		int to, cost;
		Edge(int t, int c) { to=t; cost=c; }
	}
    
	static int n;
	static List<Edge>[] graph;
    public int solution(int _n, int s, int a, int b, int[][] fares) {
        int ans = Integer.MAX_VALUE; s= s-1; a=a-1;b=b-1;
        n = _n;
        graph = new List[n];
        for(int i=0;i<n;i++) graph[i] = new ArrayList<>();
        for(int [] fare: fares) {
        	int from = fare[0]-1, to=fare[1]-1, cost=fare[2];      
        	graph[from].add(new Edge(to, cost));
        	graph[to].add(new Edge(from, cost));
        }
        
        int[] sDist = dijkstra(s);
        int[] aDist = dijkstra(a);
        int[] bDist = dijkstra(b);
        
        for(int x = 0;x<n;x++) ans = Math.min(ans, sDist[x]+aDist[x]+bDist[x]);
        
        return ans;       
    }
    
    int[] dijkstra(int from) {
    	int[] dist = new int[n];
    	for(int i = 0; i<n;i++) dist[i] = Integer.MAX_VALUE;
    	dist[from] = 0;
    	Queue<Edge> pq = new PriorityQueue<>((lhs, rhs) -> lhs.cost -rhs.cost);
    	pq.offer(new Edge(from,0));

        while(!pq.isEmpty()) {
    		Edge cur = pq.poll();
    		if (cur.cost!=dist[cur.to]) continue;
    		for(Edge next: graph[cur.to]) {
    			int nextCost = next.cost + dist[cur.to];
    			if(nextCost>=dist[next.to]) continue;
    			dist[next.to] = nextCost;
    			pq.offer(new Edge(next.to, nextCost));
    		}
    	}
    	return dist;
    }
}
