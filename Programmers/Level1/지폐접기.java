class Solution {
    public int solution(int[] wallet, int[] bill) {
        
		int ans = 0;
		while(true) {
			if(wallet[0] - bill[0] >= 0  && wallet[1] - bill[1] >= 0)
				return ans;
			if(wallet[0] - bill[1] >= 0 && wallet[1]-bill[0] >= 0)
				return ans;
			
			if(bill[0] - bill[1] > 0) {
				bill[0] = bill[0]/2;
			} else {
				bill[1] = bill[1]/2;
			}
			++ans;
		}
    }
}
