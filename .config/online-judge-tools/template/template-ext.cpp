<%!
    from datetime import datetime
%>\
<%
    now = datetime.now()
    current_time = now.strftime("%d-%m-%Y %H:%M:%S")
%>\
/**
 *   author: brongulus
 *   created: ${current_time}
**/
#include <bits/stdc++.h>

using namespace std;

#ifdef LOCAL
#include "algo/debug.h"
#else
#define debug(...) 42
#endif

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  
  return 0;
}
