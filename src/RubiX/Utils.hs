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

toBS :: T.Text -> BS.ByteString
toBS = T.encodeUtf8

toLBS :: T.Text -> LBS.ByteString
toLBS = LT.encodeUtf8 . LT.fromStrict

fromBS :: BS.ByteString -> T.Text
fromBS = T.decodeUtf8

fromLBS :: LBS.ByteString -> T.Text
fromLBS = LT.toStrict . LT.decodeUtf8