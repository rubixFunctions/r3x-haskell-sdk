module Rubix 
    ( 
    run
    ) where

import qualified Network.Wai.Handler.Warp as W
import qualified Network.Wai as W
import Network.HTTP.Types.Status

import Control.Monad.Reader
import Control.Monad.Except

-- Execute the app monad
run ::  IO ()
run = undefined

-- Run the app monad on a wai request to obtain a wai response
runRubix :: App () -> W.Request -> IO W.Response
runRubix app req = undefined

-- Default 404 response
notFoundResp :: W.Response
notFoundResp = undefined