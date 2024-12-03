# AOC 24

## Day 1 - 2

see aoc.hs

## Day 3

```sh
grep -oP 'mul\(\d{1,3},\d{1,3}\)' mul.txt > mul-clean.txt
```

```python
>>> x = """mul(2,4)
... mul(5,5)
... mul(11,8)
... mul(8,5)"""
>>> 
>>> x
'mul(2,4)\nmul(5,5)\nmul(11,8)\nmul(8,5)'
>>> 
>>> x.split("\n")
['mul(2,4)', 'mul(5,5)', 'mul(11,8)', 'mul(8,5)']
>>> 
>>> [e[3:] for e in x.split("\n")]
['(2,4)', '(5,5)', '(11,8)', '(8,5)']
>>>
>>> 
>>> [e[4:-1] for e in x.split("\n")]
['2,4', '5,5', '11,8', '8,5']
>>> 
>>> [map(lambda j: int(j), e[4:-1].split(",")) for e in x.split("\n")]
[<map object at 0x...>, <map object at 0x...>, <map object at 0x...>, <map object at 0x...>]
>>>  
>>> 
>>> from functools import reduce
>>> 
>>> [reduce(lambda a, b: a*b, map(lambda j: int(j), e[4:-1].split(","))) for e in x.split("\n")]
[8, 25, 88, 40]
>>> 
>>> sum(reduce(lambda a, b: a*b, map(lambda j: int(j), e[4:-1].split(","))) for e in x.split("\n"))
161
>>> 
```
