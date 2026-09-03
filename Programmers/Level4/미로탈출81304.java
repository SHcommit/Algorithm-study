import java.util.*;

class Solution {
    static class Edge {
        int to, cost;
        boolean isOrigin;
        Edge(int t, int c, boolean o) {to=t;cost=c;isOrigin=o;}
    }
    // 여기가 이제 edge일필요가없는게 어차피 trap에 정보가 다있음.
    static class State {
        int node;
        int trap;
        int prefixCost;
        State(int _node, int t, int p) { node=_node; trap=t; prefixCost=p;}
    }
    
    static List<Edge>[] graph;
    static int[] trapToIndex;
    static int n;
    public int solution(int _n, int start, int end, int[][] roads, int[] traps) {
        n=_n;
        trapToIndex = new int[n+1];
        int pointer = 0;
        Arrays.fill(trapToIndex,-1);
        for(int trap: traps) trapToIndex[trap] = pointer++;
        graph = new ArrayList[n+1];
        for(int i=0;i<n+1;i++) graph[i] = new ArrayList<>();
        for(int[] road: roads) {
            int from = road[0], to=road[1], cost=road[2];
            graph[from].add(new Edge(to, cost, true));
            graph[to].add(new Edge(from,cost,false));
        }
        return escapeTheMaze(start, end);
    }
    
    boolean isTrap(int from) { return trapToIndex[from]!=-1;} 
    
    int escapeTheMaze(int from, int to) {
        Queue<State> pq = new PriorityQueue<>((lhs, rhs) -> lhs.prefixCost - rhs.prefixCost);
        int[][] dist = new int[1<<10][n+1];
        pq.offer(new State(from,0 , 0));
        for(int i=0;i<1<<10;i++) Arrays.fill(dist[i],Integer.MAX_VALUE);
        dist[0][from] = 0;
        
        while(!pq.isEmpty()) {
            State cur = pq.poll();
            if(dist[cur.trap][cur.node] != cur.prefixCost) continue;
            if(cur.node == to) return cur.prefixCost;
            boolean isCurTrap = isTrap(cur.node);
            boolean isCurTrapActivated = false;
            if (isCurTrap) isCurTrapActivated = (cur.trap&(1<<trapToIndex[cur.node])) !=0;
            
            for(Edge next: graph[cur.node]) {
                boolean isNextTrap = isTrap(next.to);
                boolean isNextTrapActivated = false;
                if(isNextTrap) isNextTrapActivated = (cur.trap&(1<<trapToIndex[next.to])) !=0;
                
                boolean areTrapsOpposite = isCurTrapActivated != isNextTrapActivated;
                if (next.isOrigin && areTrapsOpposite) continue;
                if(!next.isOrigin && !areTrapsOpposite) continue;
                
                int nextTrap = cur.trap;
                if(isNextTrap) nextTrap ^=(1<<trapToIndex[next.to]);
                int nextCost = cur.prefixCost + next.cost;
                if(nextCost>=dist[nextTrap][next.to]) continue;
                dist[nextTrap][next.to] = nextCost;
                pq.offer(new State(next.to, nextTrap, nextCost));
            }
            
        }
        return -111111;
    }
}
