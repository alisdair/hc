module Main where

import System.Environment (getArgs)
import Control.Monad (liftM)
import Data.Maybe (fromMaybe)

type Function = (Int -> Int -> Int)

data Term = Operator Function | Number Int

function :: String -> Maybe Term
function "*" = Just $ Operator (*)
function "/" = Just $ Operator (div)
function "+" = Just $ Operator (+)
function "-" = Just $ Operator (-)
function _   = Nothing

parse :: [String] -> [Term]
parse = map go
  where go x = fromMaybe (Number $ read x) $ function x

reduce :: [Term] -> [Int] -> Int
reduce (Operator x:xs) (a:b:cs) = reduce xs $ x a b : cs
reduce (Number x:xs) stack      = reduce xs $ x : stack
reduce [] [x]                   = x
reduce (Operator x:xs) _        = error "Stack underflow"
reduce [] _                     = error "Operator missing"

calculate :: [String] -> Int
calculate = flip reduce [] . parse

main :: IO ()
main = liftM calculate getArgs >>= print
