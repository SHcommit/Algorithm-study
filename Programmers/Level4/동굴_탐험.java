public boolean solution(int n, int[][] path, int[][] order) {
        // input
        List<Integer>[] graph  = new ArrayList[n];
        for(int i=0;i<n;i++) {
            graph[i] = new ArrayList<>();
        }
        for(int[] se: path) {
            graph[se[0]].add(se[1]);
            graph[se[1]].add(se[0]);
        }
        int [] required = new int[n];
        int [] whereToGo = new int[n];
        Arrays.fill(required,-1);
        Arrays.fill(whereToGo, -1);

        for (int [] se: order) {
            int prev = se[0];
            int next = se[1];
            required[next] = prev;
            whereToGo[prev] = next;
        }
        if(required[0] !=-1) return false;

        boolean [] visited = new boolean[n];
        boolean [] visitable = new boolean[n];
        int visitedCnt = 0;
        Queue<Integer> queue = new ArrayDeque<>();
        queue.offer(0);
        visited[0] = true;
        // entry
        while(!queue.isEmpty()) {
            int cur = queue.poll();
            visitedCnt++;
            if (visitedCnt==n) return true;

            int roomToGo = whereToGo[cur];
            if(roomToGo!=-1 && visitable[roomToGo]) {
                visitable[roomToGo] = false;
                visited[roomToGo] = true;
                queue.offer(roomToGo);
            }
            for(int next: graph[cur]) {
                if (visited[next]) continue;
                int requiredRoom = required[next];
                if (requiredRoom!=-1 && visited[requiredRoom] == false) {
                    visitable[next] = true;
                    continue;
                }
                // 그냥 사전방문 해야할거 필요없는 그냥 일반이면은 추가
                visited[next] = true;
                queue.offer(next);
            }
        }
        return visitedCnt == n;
    }
