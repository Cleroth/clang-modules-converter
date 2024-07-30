#!/usr/bin/env python

"""
Helper script to convert the log generated by '-debug-only=constraint-system'
to a Python script that uses Z3 to verify the decisions using Z3's Python API.

Example usage:

> cat path/to/file.log
---
x6 + -1 * x7 <= -1
x6 + -1 * x7 <= -2
sat

> ./convert-constraint-log-to-z3.py path/to/file.log > check.py && python ./check.py

> cat check.py
    from z3 import *
x3 = Int("x3")
x1 = Int("x1")
x2 = Int("x2")
s = Solver()
s.add(x1 + -1 * x2 <= 0)
s.add(x2 + -1 * x3 <= 0)
s.add(-1 * x1 + x3 <= -1)
assert(s.check() == unsat)
print('all checks passed')
"""


import argparse
import re


def main():
    parser = argparse.ArgumentParser(
        description="Convert constraint log to script to verify using Z3."
    )
    parser.add_argument(
        "log_file", metavar="log", type=str, help="constraint-system log file"
    )
    args = parser.parse_args()

    content = ""
    with open(args.log_file, "rt") as f:
        content = f.read()

    groups = content.split("---")
    var_re = re.compile("x\d+")

    print("from z3 import *")
    for group in groups:
        constraints = [g.strip() for g in group.split("\n") if g.strip() != ""]
        variables = set()
        for c in constraints[:-1]:
            for m in var_re.finditer(c):
                variables.add(m.group())
        if len(variables) == 0:
            continue
        for v in variables:
            print('{} = Int("{}")'.format(v, v))
        print("s = Solver()")
        for c in constraints[:-1]:
            print("s.add({})".format(c))
        expected = constraints[-1].strip()
        print("assert(s.check() == {})".format(expected))
    print('print("all checks passed")')


if __name__ == "__main__":
    main()
