package Solution;

import java.util.*;

public class swea_1226_미로1 {    
    static int[] dx = new int[] {-1,1,0,0};
    static int[] dy = new int[] {0,0,1,-1};
    static String[][] graph = new String[16][16];
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        for(int testCase=1;testCase<=10;testCase++) {
            int _=sc.nextInt();
            int[] entry=null, end=null;
            
            for(int y=0;y<16;y++) {
                String[] splitted = sc.next().split("");
                for (int x=0;x<16;x++) {
                    graph[y][x] = splitted[x];
                    if(graph[y][x].equals("2")) entry = new int[] {x, y};
                    if(graph[y][x].equals("3")) end=new int[] {x,y};
                }
            }
            System.out.printf("#%d %d\n", testCase, bfs(entry, end));
        }
    }
    
    static int bfs(int[] from, int[] to) {
        int[] visited = new int[16];
        Queue<int[]> queue = new ArrayDeque<>();
        queue.add(from);
        visited[from[1]]^=(1<<from[0]);
        while(!queue.isEmpty()) {
            int[] cur = queue.poll();
            int cx = cur[0], cy = cur[1];
            if(cx == to[0] && cy== to[1]) return 1;
            for(int i =0;i<4;i++) {
                int nx = dx[i] + cx, ny=dy[i]+cy;                
                if(nx<0 || nx>=16 || ny<0||ny>=16) continue;
                if(graph[ny][nx].equals("1")) continue;
                if((visited[ny]&(1<<nx))!=0) continue;                
                visited[ny]^=(1<<nx);
                queue.add(new int[] {nx,ny});
            }
        }
        return 0;
    }

}
