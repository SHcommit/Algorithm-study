import java.util.*;

class Solution {
    // 상 하 좌 우
    static int UP=0, DOWN=1, LEFT=2, RIGHT=3;
	static int[] dx = {0,0,-1,1};
	static int[] dy = {-1,1,0,0};
	static int n;
	class State {
        int x, y, cost, direction;
        State(int _x, int _y, int _cost, int d) { 
            x=_x; y=_y; cost = _cost; direction=d;
        }
    }
	boolean isOutOfBorder(int x, int y) { return x<0 || x>=n || y<0 || y>=n; }    
	public int solution(int[][] board) {
		n = board.length;	
		int[][][] dist = new int[4][n][n];
		for(int z=0;z<4;z++) {
			for(int y=0;y<n;y++) 
                Arrays.fill(dist[z][y], Integer.MAX_VALUE);
		}
		Queue<State> pq = new PriorityQueue<>((lhs, rhs) -> lhs.cost - rhs.cost);
		pq.offer(new State(0,0,0,DOWN));
		pq.offer(new State(0,0,0,RIGHT));
		dist[DOWN][0][0] = 0;
		dist[RIGHT][0][0] = 0;
		while(!pq.isEmpty()) {
            State curState = pq.poll();
            int cx = curState.x, cy = curState.y; 
            int curDirection = curState.direction, curCost = curState.cost;
            if (dist[curDirection][cy][cx]!= curCost) continue;
            if(cx == n-1 && cy==n-1) return curCost;
            for(int i=0;i<4;i++) {
                int _dx = dx[i], _dy=dy[i];
                boolean isSameDirection = i==curDirection;
                int nx = cx+_dx, ny = cy+_dy;
                if (isOutOfBorder(nx,ny)) continue;
                if (board[ny][nx]==1) continue;
                int nextCost = curCost + (isSameDirection ? 100 : 600);
                if(nextCost >= dist[i][ny][nx]) continue;
                dist[i][ny][nx] = nextCost;
                pq.offer(new State(nx,ny,nextCost, i));
            }
        }
        
	    return -7;
	    }
}
