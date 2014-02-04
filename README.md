lpeg-labels
===========

A [LPeg](http://www.inf.puc-rio.br/~roberto/lpeg/) fork that intends
to implement exception handling for error reporting, but for now just
tracks the farthest failure position.
More precisely, this fork changes `lpeg.match` to return **nil** plus
a number when matching fails.
This number is the farthest failure position that the PEG reached on
the input string, and it is useful for adding error reporting while
using LPeg to implement parsers.

Example
-------

    local lpeg = require "lpeg-labels"

    print(lpeg.match(lpeg.P("a") * lpeg.P("a")^0, "ab")) -- 2, like the original LPeg
    print(lpeg.match(lpeg.P("a") * lpeg.P("a")^0 * -lpeg.P(1), "ab")) -- nil    2, unlike the original LPeg
