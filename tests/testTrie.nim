# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import Krestiapkg/Trie

test "Int tree":
  let trie = newTrie[int]()
  trie.put("abc", 3)
  trie.put("a", 1)
  check trie.get("abc").value == 3
  check trie.get("ab").kind == absent