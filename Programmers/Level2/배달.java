import java.util.*;

class Solution {
	    static class Edge {
	        int to, cost;
	        Edge(int t, int c) {to=t;cost=c;}
	    }
	    
	    static List<Edge>[] graph;
	    static int n;
    
	    public int solution(int _n, int[][] road, int k) {
	        int ans = 0; n=_n;
	        graph = new List[n];
	        for(int i=0;i<n;i++) graph[i] = new ArrayList<>();
	        for(int[] edge : road) {
	        	int from = edge[0]-1, to=edge[1]-1, cost=edge[2];
	        	graph[from].add(new Edge(to, cost));
	        	graph[to].add(new Edge(from, cost));
	        }
	        
            int[] dist = dijkstra(0);
	        for(int i=0;i<n;i++) if (dist[i]<=k) ans++;
	        return ans;
	    }

		int[] dijkstra(int from) {
	    	int[] dist = new int[n];
	    	Arrays.fill(dist, Integer.MAX_VALUE);
	    	Queue<Edge> pq = new PriorityQueue<>((lhs,rhs) -> lhs.cost-rhs.cost);
	    	pq.offer(new Edge(from,0));
	    	dist[from] = 0;
	    	while(!pq.isEmpty()) {
	    		Edge cur = pq.poll();
	    		if(cur.cost!=dist[cur.to]) continue;
	    		for(Edge next: graph[cur.to]) {
	    			int nextCost = dist[cur.to] + next.cost;
	    			if(nextCost>=dist[next.to]) continue;
	    			dist[next.to]=nextCost;
	    			pq.offer(new Edge(next.to,nextCost));
	    		}
	    	}
	    	return dist;
	    }
	}

