# ``DataStructures``

二重連結リスト、スタック、キュー、グラフ、 優先キュー、 LFUCache, LRUCache, 基本的なソートと検索アルゴリズムが実装されています。

## 概要

このフレームワークでは（Swift言語標準ライブラリにない）二重連結リストを定義します。これを用いて　スタック、キュー、グラフ、LFUCache, LRUCacheなど他のアルゴリズムを実装します.

> ここで二重連結リストを用いたアプローチで様々なデータ構造を実装しています。配列を使ったアプローチの方が望ましい場合は　通常のArray構造体を使うことで大抵に実現可能。Arrayの`first`, `last`, `push`, `pop`, などのような関数で同等のことが可能。大きな違いはメモリの使用の仕方。remove/modification/additionの操作をする際に　オブジェクトの走査に必要な時間とオブジェクトへの挿入・削除の時間が変わってくる。

### ビッグオー表記法

各メソッドのドキュメントに計算量 (Complexity)が記述されている。以下は比較表。

| アルゴリズム | 概要 | 時間計算量 (Time Complexity) 最悪の場合 | 時間計算量　平均 | 時間計算量　最良 | 空間計算量 (Space Complexity) |
|---|---|---|---|---|---|
| Bubble Sort | Compare everything with everything | O(*n^2*) | О(n2) | O(*n*) | O(1) |
| Insertion Sort | Take one by one and insert it | O(*n^2*) | O(*n^2*) | O(*n*) | O(1) |
| Binary Insertion Sort | Same as Insertion Sort but use binary search for insertion | O(*n* log *n*) | O(*n*^2) | O(*n*) | O(1) |
| Quick Sort | 分割統治. Select pivot and partition, do same for each partition | O(*n*^2) | O(*n* log *n*) | O(*n* log *n*) | O(1) |
| Merge Sort | 分割統治. Divide into two halves then sort each. Merge sorted arrays. | O(*n* log *n*) | O(*n* log *n*) | O(*n* log *n*) | O(*n*) |
| Linear Search | 一個一個全て比較 | O(*n*) | O(*n*) | O(1) | O(1) |
| Binary Search | 中央値を比較して　残りの中央値を比較して、残りの中央値を比較して ... | O(log *n*) | O(log *n*) | O(1) | O(1) |
| Linked List Item Removal/Addition |(Does not include searching item)| O(1) | O(1) | O(1) | O(1) |
| Priority Queue Item Removal/Addition | (Rebuild tree) | O(log *n* ) | O(1) | O(1) | O(1) |
| Heap sort | max heapを構築し、それから一個一個抽出 | O(*n* log *n*) | O(*n* log *n*) | O(*n* log *n*) | O(1) | 
| LFU Cache | 使用頻度最も少ないものを削除 | O(1) | O(1) | O(1)| O(*n*) | 
| LRU Cache | 最近最も使われなかったものを削除 | O(1) | O(1) | O(1)| O(*n*) |

### Concepts refreshers:

| 概念 | |
|---|---|
| Logarithm definition | `log2 (64) => 6`, as `2^6 => 64` |
| Minimum depth of binary tree of length `n` | `1 + floor(log2(n))` |
| 対数の底は関係ない Base does not matter | `log2(n)=>log(n)/log(2)` and  `log10(n)=log(n)/log(10)` so both are  `O(log(n))`. |
| 様々な関数比較 | (`e`, `n^3`, `n^2`, `n`, sqrt(n), `n log n`, , `log n`) ![functions comparison](time-complexity) ([Credits to medium - @frankadamicoaf](https://medium.com/@frankadamicoaf/big-o-time-complexity-48bb5896b036)))| 
