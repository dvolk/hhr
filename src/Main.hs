module Main where

import System.Environment
import System.Console.Terminfo

getArgsDefault :: IO [String]
getArgsDefault = do
  a <- getArgs
  return (if null a then ["="] else a)

main :: IO ()
main = do
  term <- setupTerm "vt100"
  let cols = getCapability term (tiGetNum "cols")

  case cols of
    Nothing -> error "unable to get terminal width"
    Just n  -> mapM_ (putStrLn . take n . cycle) =<< getArgsDefault

