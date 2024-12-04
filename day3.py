#!/usr/bin/env python3

from functools import reduce
import re

with open("mul.txt", "r") as f:
	fc = f.read()

# - - - - v1 - - - -

def day3_v1(fc: str) -> int:
	""" gets file content `fc` and returns sum of mul ops """

	xs_v1 = re.findall(r"mul\(\d{1,3},\d{1,3}\)", fc)

	return sum(reduce(
			lambda a, b: a * b,
			map(int, e[4:-1].split(",")))
		for e in xs_v1)

print(day3_v1(fc))

# - - - - v2 - - - -

# https://en.wikipedia.org/wiki/Regular_expression#Assertions

xs = fc.split("don't()")

new_xs = [xs[0]] + ["".join(x.split("do()")[1:]) for x in xs[1:]]

print(day3_v1("".join(new_xs)))
