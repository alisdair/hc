module Main where

import System.Environment (getArgs)

data Operator = Multiply | Divide | Add | Subtract
              deriving (Show,Eq)

operator :: String -> Maybe Operator
operator "*" = Just Multiply
operator "/" = Just Divide
operator "+" = Just Add
operator "-" = Just Subtract
operator _   = Nothing

evaluate :: Operator -> Int -> Int -> Int
evaluate op =
    case op of
      Multiply -> (*)
      Divide   -> (div)
      Add      -> (+)
      Subtract -> (-)

parse :: [String] -> [Either Operator Int] 
parse = map go
  where go x =
          case operator x of
            Just y  -> Left y
            Nothing -> Right $ read x

reduce :: [Either Operator Int] -> [Int] -> Int
reduce (Left x:xs) (a:b:cs) = reduce xs $ evaluate x a b : cs
reduce (Right x:xs) stack   = reduce xs $ x : stack
reduce [] [x]               = x
reduce (Left x:xs) _        = error "Stack underflow"
reduce [] _                 = error "Operator missing"

main :: IO ()
main = do
    args <- getArgs
    print $ reduce (parse args) []
