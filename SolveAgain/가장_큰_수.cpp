#include <string>
#include <vector>
#include <algorithm>
#include <numeric>
#include <iterator>

using namespace std;

auto comparator = [](string lhs, string rhs) { return lhs+rhs > rhs+lhs; };
auto accumulator = [](string acc, string element) { return acc + element; };

string solution(vector<int> numbers) {
    
    // vector<string> mapped;
    // transform(numbers.begin(), numbers.end(), back_inserter(mapped), [](int element) {return to_string(element);});
    
    // or 
    vector<string> mapped(numbers.size());
    transform(numbers.begin(), numbers.end(), mapped.begin(), [](int element) {return to_string(element);});
    
    sort(mapped.begin(), mapped.end(), comparator);
    string ans = accumulate(mapped.begin(), mapped.end(), string(""), accumulator);
    return (ans[0] == '0') ? "0" : ans;
};