# DataStructures

Data structures like Linked Lists, Stacks, Queues, Sort and Search algorithms etc. (More comming...)

The swift standard library does not provide a linked list imeplementation so this framework implements it and also provides Stack, Queue implementation based on linked list. If you prefer an array implementation feel free to use standard `Array` which contains `first`, `list`, `push`, `pop` like methods. DataStructures interfaces and implementations are inspired by C# .Net and Java SE implementations.

<img src="https://img.shields.io/badge/Jazzy-docs-brightgreen.svg" />
<img src="https://img.shields.io/badge/coverage-99%25-brightgreen.svg" />

## Big O Notation

Complexity of each method in this framework is documented. Below table can be used to compare/see them all.

| Algorithm | Summary | Time Complexity Worst case | TC Average | TC Best Case | Space Complexity |
|---|---|---|---|---|---|
| Bubble Sort | Compare everything with everything | O(*n^2*) | ? | O(*n*) | O(1) |
| Insertion Sort | Take one by one and insert it | O(*n^2*) | ? | O(*n*) | O(1) |
| Binary Insertion Sort | Same as Insertion Sort but use binary search for insertion | O(*n* log *n*) | O(*n*^2) | O(*n*) | O(1) |
| Quick Sort | Divide and Conquer. Select pivot and partition, do same for each partition | O(*n*^2) | ? | O(*n* log *n*) | O(1) |
| Merge Sort | Divide and Conquer. Divide into two halves then sort each. Merge sorted arrays. | O(*n* log *n*) | O(*n* log *n*) | O(*n* log *n*) | O(*n*) |
| Linear Search | Compare all, one by one | O(*n*) | O(*n*) | O(1) | O(1) |
| Binary Search | Compare medium, then medium of rest, then medium of rest, ... | O(log *n*) | O(log *n*) | O(1) | O(1) |
| Linked List Item Removal/Addition |(Does not include searching item)| O(1) | O(1) | O(1) | O(1) |
| Priority Queue Item Removal/Addition | (Rebuild tree) | O(log *n* ) | O(1) | O(1) | O(1) |
| Heap sort | Build a max heap, then extract one by one | O(*n* log *n*) | O(*n* log *n*) | O(*n* log *n*) | O(1) | 


### Refreshers:

- Logarithm definition: `log2 (64) => 6`, as `2^6 => 64`
- Minimum depth of binary tree of length `n` is  `1 + floor(log2(n))`
- Base does not matter. `log2(n)=>log(n)/log(2)` and  `log10(n)=log(n)/log(10)` so both are  `O(log(n))`.
- Various functions comparison (`e`, `n^3`, `n^2`, `n log n`, `n`, `log n`):<br> <img width=400 src="https://runestone.academy/runestone/static/pythonds/_images/newplot.png" />

## Documentation

Each method and symbol is documented. HTML documentation can be geneated using `jazzy` command.

    swift package generate-xcodeproj
    jazzy -x -scheme,DataStructures-Package -m DataStructures
    open -a /Applications/Google\ Chrome.app docs/index.html


## Develop

Open package in Xcode 11 or higher and develop as usual.

    open package.swift

## TODOs

- Rethink naming for sorting methods. Specially `(by:)` does not sound OK.
- Add list property to LinkedListNode as C# implementation. It should help avoid infinite, loops and other weird cases. (Two lists with the same node, etc)
- Improve documentation specially in sort methods. Mention Order/Space Complexity, better, worst, average case too.
- Add more sort methods; Shell sort?
- Add More graph theory structures
- Add more search methods (Breadth First Search (BFS), depth First Search (DFS) )
- Implement much more stuff from ["Top Algorithms/Data Structures/Concepts every computer science student should know"](https://link.medium.com/i99SUWm4GX)
- Show code coverage graphically
- Get a CI (Circle CI? or Travis?, I would like to use Xcode11)
