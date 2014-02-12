module Main where

import System.Environment
import System.Console.Terminfo

main :: IO ()
main = do
  term <- setupTerm "vt100"
  let cols = getCapability term (tiGetNum "cols")

  case cols of
    Nothing -> error "unable to get terminal width"
    Just n  -> mapM_ (putStrLn . take n . cycle) =<< getArgs

