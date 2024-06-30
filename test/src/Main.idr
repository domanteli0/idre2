module Main

import Control.Automata
import Data.List
import Data.SOP
import Data.String
import Data.Vect
import Hedgehog

%default total

testingTesting : Property
testingTesting = property $ do
  "a" === "b"

aab_A : Automata SFin

aab : Property
aab = property $ do
    isMatch 

testingGroup : Group
testingGroup = MkGroup "Tests"
                   [ ("testingTesting", testingTesting)
                   ]

covering public export
main : IO ()
main = do ignore $ checkGroup testingGroup
