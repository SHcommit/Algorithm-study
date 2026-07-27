import java.util.*;

public class 붕대감기 {
    public int solution(int[] bandage, int health, int[][] attacks) {
        int lastAttackIdx = attacks[attacks.length-1][0];
        int h = health;
        int healPoint = 0;
        int attackIdx = 0;
        for (int i =1; i <=lastAttackIdx;i++) {
            if (attacks[attackIdx][0] == i) {
                healPoint = 0;
                h -= attacks[attackIdx][1];
                attackIdx++;
                if (h <=0) return -1;
                continue;
            }
            healPoint++;
            h+= bandage[1];
            if (healPoint == bandage[0]) {
                healPoint = 0;
                h += bandage[2];
            }
            if (h>=health) h = health;
        }
        return h <=0 ? -1 : h;
    }
}

