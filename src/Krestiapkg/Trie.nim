const R = 256

type
   Node[Value] = ref object
      value: Value
      next: array[0..R, Node[Value]]
   
   TrieST*[Value] = ref object
      root: Node[Value]

proc newTrie*[Value](): TrieST[Value] = TrieST[Value](root: nil)

proc get[Value](node: Node[Value], key: string, depth: int): Node[Value] =
   if isNil(node):
      return nil
   if depth == key.len():
      return node
   let c: char = key[depth]
   return get(node.next[int(c)], key, depth + 1)

proc get*[Value](trie: TrieST[Value], key: string): Value =
   let x = get(trie.root, key, 0)
   if x.isNil:
      return nil
   return x.value
