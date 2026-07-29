// 아 문자열 비교하는거 ==로 하니까 ;,; equals로 해야함
class Solution {
public int solution(int [] mats, String [][] park) {
        int ans = -1;
        int width = park[0].length, height = park.length;
        for (int sy=0;sy<height;sy++) {
            for(int sx=0;sx<width;sx++) {
                if (!park[sy][sx].equals("-1")) continue;

                for (int mat :mats) {
                    if (sx+mat >width || sy+mat >height) continue;

                    boolean shouldRunning = true;
                    for (int cy =sy; cy<sy+mat; cy++) {
                        for(int cx =sx; cx< sx+mat; cx++) {
                            if (!shouldRunning) continue;
                            if (!park[cy][cx].equals("-1"))  shouldRunning = false;
                        }
                    }

                    if (shouldRunning) ans = Math.max(ans, mat);
                }

            }
        }

        return ans;
    }
}
