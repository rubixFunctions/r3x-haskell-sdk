module Rubix 
    ( 
    execute,
    App,
    Handler,
    HeaderMap,
    route,
    runHandler,
    getPath,
    getPathInfo,
    getMethod,
    getQueryString,
    getQueries,
    getQueriesMulti,
    getQuery,
    getQueryMulti,
    getHeaders,
    getBody,
    checkSecure,
    waiRequest,
    matchPaths,
    ToResponse(..),
    respond,
    respondWith,
    Json(..)
    ) where

import qualified Network.Wai.Handler.Warp as W
import qualified Network.Wai as W
import Network.HTTP.Types.Status

import Control.Monad.Reader
import Control.Monad.Except

import RubiX.Types
import RubiX.Utils
import RubiX.RubixRequest
import RubiX.RubixHandler
import RubiX.RubixResponse

-- Execute the app monad
execute :: W.Port -> App() -> IO ()
execute port app = W.run port warpApp
      where
        warpApp :: W.Request -> (W.Response -> IO W.ResponseReceived) -> IO W.ResponseReceived
        warpApp req res = runRubix app req >>= res

-- Run the app monad on a wai request to obtain a wai response
runRubix :: App () -> W.Request -> IO W.Response
runRubix app req = either id (const notFoundResp) <$> runExceptT unpackApp
        where 
          unpackApp = do
            reqBody <- fmap fromLazyByteString . liftIO $ W.strictRequestBody req
            runReaderT app ReqContext{request = req, requestBody = reqBody}

-- Default 404 response
notFoundResp :: W.Response
notFoundResp = undefined