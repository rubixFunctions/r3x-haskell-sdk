{-# language OverloadedStrings #-}
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

import qualified Network.Wai.Handler.Warp as NW
import qualified Network.Wai as NW
import Network.HTTP.Types.Status
import qualified Data.Text as T

import Control.Monad.Reader
import Control.Monad.Except

import RubiX.Types
import RubiX.Utils
import RubiX.RubixRequest
import RubiX.RubixHandler
import RubiX.RubixResponse

-- Start server
execute :: ToResponse a => Handler a -> IO()
execute rubixHandler = do 
  putStrLn $ "RubiX Server starting to listen on port 8080"
  run 8080 $ rubixApp rubixHandler

-- Set Route and Handler
rubixApp :: ToResponse a => Handler a -> App()
rubixApp rubixHandler = do
  route "/" rubixHandler

-- Execute the app monad
run:: NW.Port -> App() -> IO ()
run port app = NW.run port warpApp
      where
        warpApp :: NW.Request -> (NW.Response -> IO NW.ResponseReceived) -> IO NW.ResponseReceived
        warpApp req res = runRubix app req >>= res

-- Run the app monad on a wai request to obtain a wai response
runRubix :: App () -> NW.Request -> IO NW.Response
runRubix app req = either id (const notFoundResp) <$> runExceptT unpackApp
        where 
          unpackApp = do
            reqBody <- fmap fromLazyByteString . liftIO $ NW.strictRequestBody req
            runReaderT app ReqContext{request = req, requestBody = reqBody}

-- Default 404 response
notFoundResp :: NW.Response
notFoundResp = undefined