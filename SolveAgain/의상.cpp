#include <string>
#include <vector>
#include <algorithm>
#include <unordered_map>
#include <numeric>

using namespace std;

/// unordered_map은 데이터 없으면 기본값 부어. int는 default 0
/// 그래서 만약 값을 한번도 넣지 않았담녀? seq.find() == seq.end() 이 경우 값을 한 번도 안 넣은 거로 간주
int solution(vector<vector<string>> clothes) {
    unordered_map<string, int> dict(clothes.size());
    for (const auto& cloth : clothes) {
        dict[cloth[1]]++;
    }
    return accumulate(dict.begin(), dict.end(), 1, [](int acc, const auto& e) {
        return acc * (e.second + 1)
    }) - 1;
}