{-# language NamedFieldPuns #-}
module RubiX.Types where

import Control.Monad.Reader
import Control.Monad.Except
import qualified Network.Wai as W
import qualified Data.Text as T

-- The main application definition monad
type App a = ReaderT ReqContext (ExceptT W.Response IO) a

-- Handler is an alias for App type
type Handler a = ReaderT ReqContext IO  a

-- Context provided when handling any request
data ReqContext = ReqContext
  { requestBody :: T.Text
  , request :: W.Request
  }
