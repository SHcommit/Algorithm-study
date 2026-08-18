import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Stack;

public class Solution {
    public String[] solution(String[] s) {
        String[] answer = new String[s.length];
        for (int tc = 0; tc < s.length; tc++) {
            String origin = s[tc];
            int n = origin.length();
            char[] seq = new char[n];
            int numberOf110s = 0;
            int index = 0;
            for (int i = 0; i < n; i++) {
                seq[index++] = origin.charAt(i);
                if (index < 3 || seq[index-1] != '0') continue;
                if (seq[index - 3] != '1' || seq[index - 2] != '1') continue;
                index -= 3;
                numberOf110s++;
            }
            int zeroIndex = -1;
            for (int i = index - 1; i >= 0; i--) {
                if (seq[i] == '0') {
                    zeroIndex = i;
                    break;
                }
            }
            StringBuilder sb = new StringBuilder();
            sb.append(seq, 0, zeroIndex + 1);
            while (numberOf110s-- > 0) sb.append("110");
            sb.append(seq, zeroIndex + 1, index - (zeroIndex + 1));
            answer[tc] = sb.toString();
        }
        return answer;
    }
}
