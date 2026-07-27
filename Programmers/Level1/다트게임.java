import java.util.*;

class Solution {
    public int solution(String dartResult) {
        Map<String, Integer> dic = Map.of("S",1, "D",2, "T",3);
        int answer = 0;

        String[] input = dartResult.split("");
        int [] darts = new int[3];
        int dartIdx = 0;
        String prevNum = "";

        for (int i =0; i<dartResult.length();i++) {
            String e = input[i];
            if ("SDT".contains(e)) {
                int point = Integer.parseInt(prevNum);
                darts[dartIdx++] = (int) Math.pow(point, dic.get(e));
                prevNum="";
            } else if ("#*".contains(e)) {
                if (e.equals("#")) {
                    darts[dartIdx-1]*=-1;
                    continue;
                }
                darts[dartIdx-1]*=2;
                if (dartIdx>1)
                    darts[dartIdx-2]*=2;
            } else {
                prevNum += e;
            }
        }
        return Arrays.stream(darts).sum();
    }   
}
