module Rubix 
    ( 
    run,
    App,
    Handler
    ) where

import qualified Network.Wai.Handler.Warp as W
import qualified Network.Wai as W
import Network.HTTP.Types.Status

import Control.Monad.Reader
import Control.Monad.Except

import RubiX.Types

-- Execute the app monad
run :: W.Port -> App() -> IO ()
run port app = W.run port warpApp
      where
        warpApp :: W.Request -> (W.Response -> IO W.ResponseReceived) -> IO W.ResponseReceived
        warpApp req res = runRubix app req >>= res

-- Run the app monad on a wai request to obtain a wai response
runRubix :: App () -> W.Request -> IO W.Response
runRubix app req = undefined

-- Default 404 response
notFoundResp :: W.Response
notFoundResp = undefined