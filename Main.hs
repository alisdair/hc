module Main where

import System.Environment (getArgs)
import Control.Monad (liftM)

data Function = Multiply | Divide | Add | Subtract
              deriving (Show,Eq)

data Term = Operator Function | Number Int
          deriving (Show,Eq)

function :: String -> Maybe Function
function "*" = Just Multiply
function "/" = Just Divide
function "+" = Just Add
function "-" = Just Subtract
function _   = Nothing

evaluate :: Function -> Int -> Int -> Int
evaluate op =
    case op of
      Multiply -> (*)
      Divide   -> (div)
      Add      -> (+)
      Subtract -> (-)

parse :: [String] -> [Term]
parse = map go
  where go x =
          case function x of
            Just y  -> Operator y
            Nothing -> Number $ read x

reduce :: [Term] -> [Int] -> Int
reduce (Operator x:xs) (a:b:cs) = reduce xs $ evaluate x a b : cs
reduce (Number x:xs) stack      = reduce xs $ x : stack
reduce [] [x]                   = x
reduce (Operator x:xs) _        = error "Stack underflow"
reduce [] _                     = error "Operator missing"

calculate :: [String] -> Int
calculate = flip reduce [] . parse

main :: IO ()
main = liftM calculate getArgs >>= print
