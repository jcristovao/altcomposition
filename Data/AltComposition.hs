module Data.AltComposition where

(%.**) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(f %.** g) x y = f (g x y)
infixr 9 %.**

(%.***) :: (d -> e) -> (a -> b -> c -> d) -> a -> b -> c -> e
(f %.*** g) x y z = f (g x y z)
infixr 9 %.***

(%*.*) :: (b -> c -> d) -> (a -> b) -> a -> c -> d
(f %*.* g) x y = f (g x) y
infixr 9 %*.*

(*%.*) :: (b -> c -> d) -> (a -> c) -> a -> b -> d
(f *%.* g) x y = f y (g x)
infixr 9 *%.*

(%**.*) :: (b -> c -> d -> e) -> (a -> b) -> a -> c -> d -> e
(f %**.* g) x y z = f (g x) y z
infix 9 %**.*

(*%*.*) :: (b -> c -> d -> e) -> (a -> c) -> a -> b -> d -> e
(f *%*.* g) x y z = f y (g x) z
infix 9 *%*.*

(**%.*) :: (b -> c -> d -> e) -> (a -> d) -> a -> b -> c -> e
(f **%.* g) x y z = f y z (g x)
infix 9 **%.*

(%*.**) :: (c -> d -> e) -> (a -> b -> c) -> a -> b -> d -> e
(f %*.** g) x y z = f (g x y) z
infixr 9 %*.**

(*%.**) :: (c -> d -> e) -> (a -> b -> d) -> a -> b -> c -> e
(f *%.** g) x y z = f z (g x y)
infixr 9 *%.**

(%*.***) :: (d -> e -> f) -> (a -> b -> c -> d) -> a -> b -> c -> e -> f
(f %*.*** g) x y w z = f (g x y w) z
infix 9 %*.***

(*%.***) :: (d -> e -> f) -> (a -> b -> c -> e) -> a -> b -> c -> d -> f
(f *%.*** g) x y w z = f z (g x y w)
infix 9 *%.***

(%**.**) :: (c -> d -> e -> f) -> (a -> b -> c) -> a -> b -> d -> e -> f
(f %**.** g) x y w z = f (g x y) w z
infix 9 %**.**

(*%*.**) :: (c -> d -> e -> f) -> (a -> b -> d) -> a -> b -> c -> e -> f
(f *%*.** g) x y w z = f w (g x y) z
infix 9 *%*.**

(**%.**) :: (c -> d -> e -> f) -> (a -> b -> e) -> a -> b -> c -> d -> f
(f **%.** g) x y w z = f w z (g x y)
infix 9 **%.**
