module Main where

import System.Environment
import System.Console.Terminfo

getArgsDefault :: [String] -> IO [String]
getArgsDefault def = do
  a <- getArgs
  return (if null a then def else a)

main :: IO ()
main = do
  term <- setupTerm "vt100"

  let cols =
        case getCapability term (tiGetNum "cols") of
          Nothing -> 80
          Just n  -> n

  mapM_ (putStrLn . take cols . cycle) =<< getArgsDefault ["="]

