{-# language NamedFieldPuns #-}
module RubiX.Types where

import Control.Monad.Reader
import Control.Monad.Except
import qualified Network.Wai as W
import qualified Data.Text as T
import qualified Data.Map as M
import qualified Data.CaseInsensitive as CI

-- The main application definition monad
type App a = ReaderT ReqContext (ExceptT W.Response IO) a

-- Handler is an alias for App type
type Handler a = ReaderT ReqContext IO  a

-- Context provided when handling any request
data ReqContext = ReqContext
  { requestBody :: T.Text
  , request :: W.Request
  }

-- Runs a handler within an App WITHOUT rendering the response
runHandler :: Handler r -> App r
runHandler handler = ask >>= liftIO . runReaderT handler

-- A map of case insensitive header names to all provided values for that header.
type HeaderMap = M.Map (CI.CI T.Text) [T.Text]

-- A map of query parameter names to all values provided for that parameter
type MultiQueryMap = M.Map T.Text [T.Text]

-- A map of query parameter names to the last-provided value for that parameter
type QueryMap = M.Map T.Text T.Text

-- A request or response's Content-Type value
type ContentType = T.Text

-- A regex pattern for route matching.
type Pattern = T.Text

-- A route as Text
type Route = T.Text
