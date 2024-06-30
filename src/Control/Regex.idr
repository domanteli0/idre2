-- module Regex

import Decidable.Equality
import Data.List
import Data.List.Quantifiers
import Data.Nat

%default total

public export
data Progress = P | PFin

public export
IsMatch : Type
IsMatch = Bool

Fail : IsMatch
Fail = False

Ok : IsMatch
Ok = True

or' : (a -> Bool) -> (a -> Bool) -> a -> Bool
or' f g x = f x || g x

-- toIsMatch : Bool -> IsMatch
-- toIsMatch False = Fail
-- toIsMatch True = Ok

-- public export
-- data SType = SChar Char
--            | SFin

-- TODO: parametrise Automata by the value it's matching???
-- public export
-- data Automata : Type where
--      AVal  : (v : SType) -> Automata
--      AAlt   : Automata -> Automata -> Automata
--      ABind : Automata -> Automata -> Automata

-- data State : Progress -> Progress -> Type where
--      Fin   : State P PFin
--      Bind  : State p1 p2 -> State p2 p3 -> State p2 p3

data RegexCmd : ty -> Progress -> Progress -> Type where
     RChar : ty -> RegexCmd ty P P
     Fin   : RegexCmd ty P PFin
     Alt   : RegexCmd ty P P -> RegexCmd ty P P -> RegexCmd ty P P
     Bind  : RegexCmd IsMatch P P -> (IsMatch -> RegexCmd IsMatch P P) -> RegexCmd IsMatch P P

runRegexC : List e -> RegexCmd IsMatch p p' -> (IsMatch, List e)
runRegexC [] (RChar x) = (Fail, [])
runRegexC (y :: xs) (RChar x) = (?asdasd y x, xs)
runRegexC xs Fin = (isNil xs, xs)
runRegexC xs (Alt a1 a2) =
    let (is1, xs1) = runRegexC xs a1
        (is2, xs2) = runRegexC xs a2
    in case (is1, is2) of
            (False, False) => (Fail, xs)
            (False, True) => (Ok, xs1)
            (True, False) => (Ok, xs1)
            (True, True) => (Ok, xs1)
runRegexC xs (Bind re f) = 
    let (isMatch, xs') = runRegexC xs re
    in runRegexC xs' $ f isMatch

-- test
ab : List c -> IsMatch
ab xs = runRegexC xs ((RChar True) `Bind` (\isMatch => (RChar False) >>= Fin))

-- isMatchC : Automata -> List Char -> Bool
-- isMatchC (AVal SFin) [] = True
-- isMatchC _ [] = False
-- isMatchC (AVal SFin) _ = False
-- isMatchC a@(AVal (SChar c)) (c' :: cs) = c == c'
-- isMatchC a@(AAlt a1 a2) (c :: cs) = (isMatchC a1 [c] || isMatchC a2 [c] ) && isMatchC a cs
-- isMatchC (ABind a a') (c :: cs) = isMatchC a [c] && isMatchC a' cs

-- public export
-- isMatch : Automata -> String -> Bool
-- isMatch a = isMatchC a . unpack
