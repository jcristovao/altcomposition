import Prelude
{-import Data.AltComposition-}

(%*.**) :: (c -> d -> e) -> (a -> b -> c) -> a -> b -> d -> e
(f %*.** g) x y z = f (g x y) z
infixr 9 %*.**

(%*-**) :: (c -> d -> e) -> (a -> b -> c) -> (a,b,d) -> e
(f %*-** g) (x,y,z) = f (g x y) z
infixr 9 %*-**


add :: Int -> Int -> Int
add x y = x + y

mult :: Int -> Int -> Int
mult x y = x * y

(§) :: (a -> b) -> a -> b
f § x =  f x
infixr 8 §

(*%.***) :: (d -> e -> f) -> (a -> b -> c -> e) -> a -> b -> c -> d -> f
(f *%.*** g) x y w z = f z (g x y w)
infixr 9 *%.***

{-(*§) :: ((a,b,c) -> d) -> a -> b -> c -> d-}
{-f *§ x y z = curry3 f-}
{-infixr 0 *§-}
{-xpto = uncurry3 *%.** ((,,))-}
{-xpto = uncurry *%.** (,)-}
(*§) :: (a -> b -> c -> d) -> a -> b -> c -> d
f *§ x y z = f x y z
{-uncurry3 *%.*** (,,)-}
infixl 5 *§


(§§) = curry . uncurry
infixr 8 §§

{-# INLINE curry3 #-}
curry3 :: ((a, b, c) -> d) -> a -> b -> c -> d
curry3 f a b c = f (a,b,c)

{-# INLINE uncurry3 #-}
uncurry3 :: (a -> b -> c -> d) -> ((a, b, c) -> d)
uncurry3 f ~(a,b,c) = f a b c

(§§§) = curry3 . uncurry3
infixr 9 §§§

main :: IO ()
main = do
  let a  = 5 :: Int
      b  = 7 :: Int
      fr = add %*.** mult
      r  = fr a b 3       -- 38
      -- r' = fr $ a b 3  -- invalid
      r' = add %*.** mult *§ a b 3
  print r
