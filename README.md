# DataStructures

Data structures like Linked Lists, Stacks, Queues, Sort algorithms etc. (More comming...)

<img src="https://img.shields.io/badge/Jazzy-docs-brightgreen.svg" />

## Documentation

Documentation can be geneated using `jazzy` command.

    swift package generate-xcodeproj
    jazzy -x -scheme,DataStructures-Package -m DataStructures
    open -a /Applications/Google\ Chrome.app docs/index.html

## Develop

Open package in Xcode 11 or higher and develop as usual.

    open package.swift

## TODOs

- Rethink naming for sorting methods. Specially `(by:)` does not sound OK.
- Make LinkedListNode next, prev, readonly. Only LinkedList should be able to modify them.
- Add list property to LinkedListNode as C# implementation. It should help avoid infinite, loops and other weird cases. (Two lists with the same node, etc)
- Improve documentation specially in sort methods. Mention Order/Space Complexity, better, worst, average case too.
- Implement more tests
- Add more sort methods; Heap Sort, Binary ...?
- Add More graph theory structures
- Add more search methods (linear and binary search, Breadth First Search (BFS), depth First Search (DFS) )
- Implement much more stuff from ["Top Algorithms/Data Structures/Concepts every computer science student should know"](https://link.medium.com/i99SUWm4GX)
- Show code coverage graphically
- Get a CI (Circle CI? or Travis?, I would like to use Xcode11)
