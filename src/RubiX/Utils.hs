{-# language OverloadedStrings #-}
module RubiX.Utils where

import Data.Bifunctor
import Data.Maybe
import qualified Data.Map as M
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Encoding as LT
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.CaseInsensitive as CI

import qualified Network.HTTP.Types.Header as HTTP
import Network.HTTP.Types.URI

import RubiX.Types

toByteString :: T.Text -> BS.ByteString
toByteString = T.encodeUtf8

toLazyByteString :: T.Text -> LBS.ByteString
toLazyByteString = LT.encodeUtf8 . LT.fromStrict

fromByteString :: BS.ByteString -> T.Text
fromByteString = T.decodeUtf8

fromLazyByteString :: LBS.ByteString -> T.Text
fromLazyByteString = LT.toStrict . LT.decodeUtf8

makeHeader :: T.Text -> T.Text -> HTTP.Header
makeHeader headerName headerVal = (CI.mk (toByteString headerName), toByteString headerVal)

fromHeaderMap :: HeaderMap -> HTTP.ResponseHeaders
fromHeaderMap hm = do
  (headerName, values) <- M.toList hm
  [(CI.map toByteString headerName, toByteString value) | value <- values]
