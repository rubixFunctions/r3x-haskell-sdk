{-# language OverloadedStrings #-}
module Main where

import Rubix
import qualified Data.Text as T

-- Start the server
main :: IO ()
main = execute 8080 app

-- Define a route
app :: App ()
app = do
  route "/" rubixHandler

-- Define a response handler
rubixHandler :: Handler T.Text
rubixHandler = do
  return "{message: \"Hello RubiX\"}"

