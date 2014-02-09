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

reduce :: [Either Operator Int] -> [Int] -> [Int]
reduce (x:xs) stack =
    case x of
      Left y -> reduce xs $ evaluate y (head stack) (head $ tail stack) : drop 2 stack
      Right y -> reduce xs $ y : stack
reduce [] stack = stack

main :: IO ()
main = do
    args <- getArgs
    print $ reduce (parse args) []
