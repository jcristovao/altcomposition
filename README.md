altcomposition
==============

Compose functions with higher arity.

Ever tried something like this:

```> (length . (++)) stringA stringB```

Only to find out that you can't? The second function takes two parameters,
and as such the simple function composition does not work.

A well known solution to this problem is this fun operator:

```> (.).(.) :: (c -> d) -> (a -> b -> c) -> (a -> b -> d)```

And this is quite general:

```> ((.).(.).(.)) :: (d -> e) -> (a -> b -> c -> d) -> (a -> b -> c -> e)```

See the following link to gain a intuition for how this works:
https://stackoverflow.com/questions/17585649/composing-function-composition-how-does-work

However, in real use these suffer from some problems, namely:

  * They cannot be used infix, even with ticks (at least in ghci).

  * They are quite verbose.

Then, someone thought about using a new symbol instead:

```> (.:) :: (c -> d) -> (a -> b -> c) -> (a -> b -> d)```

And for each new parameter, you would add a dot

```> (.:.) :: (d -> e) -> (a -> b -> c -> d) -> (a -> b -> c -> e)```

And so on, to ```.::```, ```.::.```, etc. This is the approach taken by
the "composition" package, which inspired this one. It can be found at:

<http://hackage.haskell.org/package/composition>

This package is included in (and re-exported from) this AltComposition.

So, why define a new package?

It does not scale well for other combinations. Let say I want ```(+) . (*)```,
a function that takes three parameters, uses the first two in the multiplication,
and then adds the third parameter with the result.
And what if I want to feed to the first binary function as the second parameter of
the second function?

The scheme proposed here is a little more verbose than the one from the
"composition" package, but it allows for a precise indication of where the
result of the first function is applied on the second function using the
```%``` symbol (remember printf ```%```). So, the following operator:

```*%*.** ```

Takes a binary function, and composes it with a ternary function,
aplying its result as the middle parameter.

Its all a matter of opinion, and I strongly recomend that you use standard
haskell syntax instead of these, for more portable code.

Also, many of these verbose operators have simpler counterparts.
This is either noted as Deprecation, or a single note.

However, I still find myself writing the ```*%.***``` operators myself, and I trust
the deprecations to warn me about the simpler alternatives.

If you need even higher arity, first check your code, then refactor your code,
and if you still need it, please send a pull request!

