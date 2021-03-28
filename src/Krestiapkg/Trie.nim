import algorithm

const R = 256

type
   MaybeKind* = enum
      present,
      absent

   Maybe*[Value] = object
      case kind*: MaybeKind
      of present: value*: Value
      of absent: discard

   Node[Value] = ref object
      value: Maybe[Value]
      next: array[0..R, Node[Value]]
   
   TrieST*[Value] = ref object
      root: Node[Value]

proc just[Value](value: Value): Maybe[Value] =
   return Maybe[Value](kind: present, value: value)

proc none[Value](): Maybe[Value] =
   return Maybe[Value](kind: absent)

proc newTrie*[Value](): TrieST[Value] = TrieST[Value](root: nil)

proc newNode[Value](): Node[Value] =
   var node: Node[Value]
   new(node)
   var next {.noinit.}: array[0..R, Node[Value]]
   next.fill(nil)
   node.value = none[Value]()
   node.next = next
   return node

proc get[Value](node: Node[Value], key: string, depth: int): Node[Value] =
   if isNil(node):
      return nil
   if depth == key.len():
      return node
   let c: char = key[depth]
   return get(node.next[int(c)], key, depth + 1)

proc get*[Value](trie: TrieST[Value], key: string): Maybe[Value] =
   let x = get(trie.root, key, 0)
   return x.value

proc put[Value](root: Node[Value], key: string, value: Value, depth: int): Node[Value] =
   let target = if root.isNil: newNode[Value]() else: root
   if depth == key.len:
      target.value = just[Value](value)
      return target
   let c = int(key[depth])
   target.next[c] = put(target.next[c], key, value, depth + 1)
   return target

proc put*[Value](trie: TrieST[Value], key: string, value: Value) =
   trie.root = put(trie.root, key, value, 0)