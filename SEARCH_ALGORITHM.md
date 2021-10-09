# How search works in this app ?

Each word of the messages is mapped with a map object with channels as keys and list of indexes at at which that particular word is present as value.
The code for this algorithm is available at lib/algorithm/index.dart .
The final indexed map is saved in assets/data/index.json .
To update the indexing (when you add new data) you just need to run index_test.


# Time complexity

As hashmap takes O(1) time to get value of a key the time complexity of searching is also almost O(1).

