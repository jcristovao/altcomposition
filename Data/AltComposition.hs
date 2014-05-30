-- | Compose functions with higher arity.
--
-- Ever tried something like this:
--
-- > (length . (++)) stringA stringB
--
-- Only to find out that you can't? The second function takes two parameters,
-- and as such the simple function composition does not work.
--
-- A well known solution to this problem is this fun operator:
--
-- > (.).(.) :: (c -> d) -> (a -> b -> c) -> (a -> b -> d)
--
-- And it is quite general:
--
-- > ((.).(.).(.)) :: (d -> e) -> (a -> b -> c -> d) -> (a -> b -> c -> e)
--
-- See the following link to gain a intuition for how this works:
-- <https://stackoverflow.com/questions/17585649/composing-function-composition-how-does-work>
--
-- However, in real use these suffer from some problems, namely:
--
-- * They cannot be used infix, even with ticks (at least in ghci).
--
-- * They are quite verbose.
--
-- Then, someone thought about using a new symbol instead:
--
-- > (.:) :: (c -> d) -> (a -> b -> c) -> (a -> b -> d)
--
-- And for each new parameter, you would add a dot
--
-- > (.:.) :: (d -> e) -> (a -> b -> c -> d) -> (a -> b -> c -> e)
--
-- And so on, to @.::@, @.::.@, etc. This is the approach taken by
-- the "composition" package, which inspired this one. It can be found at:
--
-- <http://hackage.haskell.org/package/composition>
--
-- This package is included in (and re-exported from) this AltComposition.
--
-- So, why define a new package?
--
-- It does not scale well for other combinations. Let say I want @(+) . (*)@,
-- a function that takes three parameters, uses the first two in the multiplication,
-- and then adds the third parameter with the result.
-- And what if I want to feed to the first binary function as the second parameter of
-- the second function?
--
-- The scheme proposed here is a little more verbose than the one from the
-- "composition" package, but it allows for a precise indication of where the
-- result of the first function is applied on the second function using the
-- @%@ symbol (remember printf @%@). So, the following operator:
--
-- > *%*.**
--
-- Takes a binary function, and composes it with a ternary function,
-- aplying its result as the middle parameter.
--
-- Its all a matter of opinion, and I strongly recomend that you use standard
-- haskell syntax instead of these, for more portable code.
--
-- Also, many of these verbose operators have simpler counterparts.
-- This is either noted as Deprecation, or a single note.
--
-- However, I still find myself writing the @*%.***@ operators myself, and I trust
-- the deprecations to warn me about the simpler alternatives.
--
-- If you need even higher arity, first check your code, then refactor your code,
-- and if you still need it, please send a pull request!
--
module Data.AltComposition (
    module Data.Composition
  , (%.**)
  , (%.***)
  , (%.****)
  , (%*.*)
  , (%*.**)
  , (%*.***)
  {-, (%*.****)-}
  , (*%.*)
  , (*%.**)
  , (*%.***)
  {-, (*%.****)-}
  , (%**.*)
  , (%**.**)
  , (%**.***)
  {-, (%**.****)-}
  , (*%*.*)
  , (*%*.**)
  , (*%*.***)
  {-, (*%*.****)-}
  , (**%.*)
  , (**%.**)
  , (**%.***)
  {-, (**%.****)-}
  , (%***.*)
  , (%***.**)
  ) where

import Data.Composition

-- | Compose a binary function with a unitary function
--
-- /Note/: you should use idiomatic haskell instead
--
-- > (.).(.) :: (c -> d) -> (a -> b -> c) -> (a -> b -> d)
--
-- > (f %.** g) x y = f (g x y)
--
-- > (f .: g) x y = f (g x y)
(%.**) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(f %.** g) x y = f (g x y)
infixr 9 %.**

-- | Compose a ternary function with a unitary function
--
-- /Note/: you should use idiomatic haskell instead
--
-- > (.).(.).(.) :: (d -> e) -> (a -> b -> c -> d) -> (a -> b -> c -> e)
--
-- > (f %.*** g) x y z = f (g x y z)
--
-- > (f .:. g) x y z = f (g x y z)
(%.***) :: (d -> e) -> (a -> b -> c -> d) -> a -> b -> c -> e
(f %.*** g) x y z = f (g x y z)
infixr 9 %.***

-- | Compose a quaternary function with a unitary function
--
-- /Note/: you should use idiomatic haskell instead
--
-- > (.).(.).(.).(.) :: (e -> f) -> (a -> b -> c -> d -> e) -> (a -> b -> c -> d -> f)
--
-- > (f %.**** g) w x y z = f (g w x y z)
--
-- > (f .:: g) w x y z = f (g w x y z)
(%.****) :: (e -> f) -> (a -> b -> c -> d -> e) -> a -> b -> c -> d -> f
(f %.**** g) w x y z = f (g w x y z)
infixr 9 %.****


-- | Compose a unary function with a binary function,
-- applying the result of the unary function as the
-- first parameter of the binary function.
--
-- /Note/: DO NOT USE. Equivalent to @.@.
--
-- > (f %*.* g) x y = f (g x) y <=> f . g
(%*.*) :: (b -> c -> d) -> (a -> b) -> a -> c -> d
(f %*.* g) x y = f (g x) y
infixr 9 %*.*
{-# DEPRECATED (%*.*) "This is the same as just (.)" #-}

-- | Compose a unary function with a binary function,
-- applying the result of the unary function as the
-- second parameter of the binary function.
--
-- /Note/: DO NOT USE. Equivalent to @flip f . g@.
--
-- > (f *%.* g) x y = f y (g x)
(*%.*) :: (b -> c -> d) -> (a -> c) -> a -> b -> d
(f *%.* g) x y = f y (g x)
infixr 9 *%.*

-- | Compose a unary function with a ternary function,
-- applying the result of the unary function as the
-- first parameter of the ternary function.
--
-- /Note/: DO NOT USE. Equivalent to @.@.
--
-- > (f %**.* g) x y z = f (g x) y z
(%**.*) :: (b -> c -> d -> e) -> (a -> b) -> a -> c -> d -> e
(f %**.* g) x y z = f (g x) y z
infix 9 %**.*
{-# DEPRECATED (%**.*) "This is the same as just (.)" #-}

-- | Compose a unary function with a ternary function,
-- applying the result of the unary function as the
-- second parameter of the ternary function.
--
-- > (f *%*.* g) x y z = f y (g x) z
(*%*.*) :: (b -> c -> d -> e) -> (a -> c) -> a -> b -> d -> e
(f *%*.* g) x y z = f y (g x) z
infix 9 *%*.*

-- | Compose a unary function with a ternary function,
-- applying the result of the unary function as the
-- third parameter of the ternary function.
--
-- > (f **%.* g) x y z = f y z (g x)
(**%.*) :: (b -> c -> d -> e) -> (a -> d) -> a -> b -> c -> e
(f **%.* g) x y z = f y z (g x)
infix 9 **%.*

-- | Compose a binary function with another binary function,
-- applying the result of the first binary function as the
-- first parameter of the second binary function.
--
-- /Note/: DO NOT USE. Equivalent to @flip f . g@.
--
-- > (f %*.** g) x y z = f (g x y) z
(%*.**) :: (c -> d -> e) -> (a -> b -> c) -> a -> b -> d -> e
(f %*.** g) x y z = f (g x y) z
infixr 9 %*.**
{-# DEPRECATED (%*.**) "Use f %.** g or .: instead" #-}

-- | Compose a binary function with another binary function,
-- applying the result of the first binary function as the
-- second parameter of the second binary function.
--
-- /Note/: DO NOT USE. Equivalent to @flip f .: g@ or @flip f %.** g@.
--
-- > (f *%.** g) x y z = f z (g x y)
(*%.**) :: (c -> d -> e) -> (a -> b -> d) -> a -> b -> c -> e
(f *%.** g) x y z = f z (g x y)
infixr 9 *%.**

-- | Compose a ternary function with a binary function,
-- applying the result of the ternary function as the
-- first parameter of the binary function.
--
-- > (f %*.*** g) x y w z = f (g x y w) z
(%*.***) :: (d -> e -> f) -> (a -> b -> c -> d) -> a -> b -> c -> e -> f
(f %*.*** g) x y w z = f (g x y w) z
infix 9 %*.***
{-# DEPRECATED (%*.***) "Use f %.*** g or f .:. instead" #-}

-- | Compose a ternary function with a binary function,
-- applying the result of the ternary function as the
-- second parameter of the binary function.
--
-- /Note/: DO NOT USE. Equivalent to @flip f .:. g@ or @flip f %.*** g@.
--
-- > (f *%.*** g) x y w z = f z (g x y w)
(*%.***) :: (d -> e -> f) -> (a -> b -> c -> e) -> a -> b -> c -> d -> f
(f *%.*** g) x y w z = f z (g x y w)
infix 9 *%.***

-- | Compose a binary function with a ternary function,
-- applying the result of the binary function as the
-- first parameter of the ternary function.
--
-- > (f %**.** g) x y w z = f (g x y) w z
(%**.**) :: (c -> d -> e -> f) -> (a -> b -> c) -> a -> b -> d -> e -> f
(f %**.** g) x y w z = f (g x y) w z
infix 9 %**.**
{-# DEPRECATED (%**.**) "Use f %.** g or f .: instead" #-}

-- | Compose a binary function with a ternary function,
-- applying the result of the binary function as the
-- second parameter of the ternary function.
--
-- /Note/: DO NOT USE. Equivalent to @flip f .: g@ or @flip f %.** g@.
--
-- > (f *%*.** g) x y w z = f w (g x y) z
(*%*.**) :: (c -> d -> e -> f) -> (a -> b -> d) -> a -> b -> c -> e -> f
(f *%*.** g) x y w z = f w (g x y) z
infix 9 *%*.**
{-# DEPRECATED (*%*.**) "Use f *%.** g instead" #-}

-- | Compose a binary function with a ternary function,
-- applying the result of the binary function as the
-- third parameter of the ternary function.
--
-- > (f **%.** g) x y w z = f w z (g x y)
(**%.**) :: (c -> d -> e -> f) -> (a -> b -> e) -> a -> b -> c -> d -> f
(f **%.** g) x y w z = f w z (g x y)
infix 9 **%.**

-- | Compose a ternary function with another ternary function,
-- applying the result of the first ternary function as the
-- first parameter of the last ternary function.
--
-- > (f %**.*** g) v w x y z = f (g v w x) y z
(%**.***) :: (f -> d -> e -> g) -> (a -> b -> c -> f) -> a -> b -> c -> d -> e -> g
(f %**.*** g) v w x y z = f (g v w x) y z
infix 9 %**.***
{-# DEPRECATED (%**.***) "Use f %.*** g or f .:. instead" #-}

-- | Compose a ternary function with another ternary function,
-- applying the result of the first ternary function as the
-- second parameter of the last ternary function.
--
-- /Note/: DO NOT USE. Equivalent to @flip f .:. g@ or @flip f %.*** g@.
--
-- > (f *%*.*** g) v w x y z = f y (g v w x) z
(*%*.***) ::  (d -> f -> e -> g) -> (a -> b -> c -> f) -> a -> b -> c -> d -> e -> g
(f *%*.*** g) v w x y z = f y (g v w x) z
infix 9 *%*.***
{-# DEPRECATED (*%*.***) "Use f *%.*** g instead" #-}

-- | Compose a ternary function with another ternary function,
-- applying the result of the first ternary function as the
-- third parameter of the last ternary function.
--
-- > (f **%.*** g) v w x y z = f y z (g v w x)
(**%.***) ::  (d -> e -> f -> g) -> (a -> b -> c -> f) -> a -> b -> c -> d -> e -> g
(f **%.*** g) v w x y z = f y z (g v w x)
infix 9 **%.***

-- | Compose a unary function with a quaternary function,
-- applying the result of the first unary function as the
-- first parameter of the quaternary function.
--
-- > (f %***.* g) w x y z = f (g w) x y z
(%***.*) ::  (f -> b -> c -> d -> g) -> (a -> f) -> a -> b -> c -> d -> g
(f %***.* g) w x y z = f (g w) x y z
infix 9 %***.*
{-# DEPRECATED (%***.*) "This is the same as just (.)" #-}

-- | Compose a binary function with a quaternary function,
-- applying the result of the first binary function as the
-- first parameter of the quaternary function.
--
-- > (f %***.** g) v w x y z = f (g v w) x y z
(%***.**) ::  (f -> c -> d -> e -> g) -> (a -> b -> f) -> a -> b -> c -> d -> e -> g
(f %***.** g) v w x y z = f (g v w) x y z
infix 9 %***.**
{-# DEPRECATED (%***.**) "This is the same as just %.** or .:" #-}
