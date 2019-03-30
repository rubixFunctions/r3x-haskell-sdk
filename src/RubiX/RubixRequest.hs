{-# language OverloadedStrings #-}
{-# language FlexibleContexts #-}
{-# language ConstraintKinds #-}
{-# language RankNTypes #-}
{-# language ViewPatterns #-}
module RubiX.RubixRequest
  ( getPath
  , getPathInfo
  , getMethod
  , getQueryString
  , getQueries
  , getQueriesMulti
  , getQuery
  , getQueryMulti
  , getHeader
  , getHeaderMulti
  , getHeaders
  , getBody
  , checkSecure
  , waiRequest
  , matchPaths
  ) where

import Control.Monad.Reader
import Data.Maybe
import Data.Bifunctor
import qualified Data.Text as DT
import qualified Data.Map as DM
import qualified Data.CaseInsensitive as DCI
import Text.Regex.PCRE
import qualified Network.Wai as NW

import RubiX.Utils
import RubiX.Types

type ReqReader b = MonadReader ReqContext b

fromReq :: ReqReader b => (NW.Request -> a) -> b a
fromReq getter = asks (getter . request)

-- Gets the headers of the request
getHeader :: ReqReader b => DT.Text -> b (Maybe DT.Text)
getHeader key = undefined

-- Gets the headers of the request
getHeaderMulti :: ReqReader b => DT.Text -> b [DT.Text]
getHeaderMulti key = undefined

-- Gets the headers of the request
getHeaders :: ReqReader b => b HeaderMap
getHeaders = undefined

-- Gets path and returns the full path of the current request
getPath :: ReqReader b => b DT.Text
getPath = undefined

-- Gets the HTTP method of the current request
getMethod :: ReqReader b => b DT.Text
getMethod = undefined

-- Gets query string and returns the full path of the current request 
getQueryString :: ReqReader b => b DT.Text
getQueryString = undefined

-- Gets full body of the request
getBody  :: ReqReader b => b DT.Text
getBody = undefined

-- Calls through to 'W.isSecure'
checkSecure :: ReqReader b => b Bool
checkSecure = undefined

-- Returns the path's individual '/' separated chunks.
getPathInfo :: ReqReader b => b [DT.Text]
getPathInfo = undefined

-- Exposes the underlying 'W.Request'.
waiRequest :: ReqReader b =>  b NW.Request
waiRequest = undefined

-- Gets all key/values from the query string
getQueriesMulti :: ReqReader b => b MultiQueryMap
getQueriesMulti = undefined

-- Get the last set value for each query
getQueries :: ReqReader b => b QueryMap
getQueries = undefined

-- Gets all values provided for a given query key
getQueryMulti :: ReqReader b => DT.Text -> b [DT.Text]
getQueryMulti key = undefined

-- Get the value for a given query
getQuery :: ReqReader b => DT.Text -> b (Maybe DT.Text)
getQuery key = undefined

-- | Determine whether a route matches a pattern
matchPaths :: ReqReader b => Pattern -> b Bool
matchPaths pattern = checkMatch pattern <$> getPath 
  where
    checkMatch :: Pattern -> Route -> Bool
    checkMatch (DT.unpack -> pat) (DT.unpack -> rt) =  rt =~ ("^" ++ pat ++ "$")
