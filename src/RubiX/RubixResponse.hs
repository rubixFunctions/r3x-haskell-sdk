{-# language FlexibleInstances #-}
{-# language OverloadedStrings #-}
{-# language UndecidableInstances #-}
{-# language RankNTypes #-}
module RubiX.RubixResponse
  ( ToResponse(..)
  , Json(..)
  , respond
  , respondWith
  ) where

import Data.Function ((&))
import Control.Monad.Except
import qualified Data.Text as DT
import qualified Data.Text.Lazy as DTL
import Data.Aeson as Aeson

import Network.Wai as NW
import Network.HTTP.Types.Status

import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.Text (renderHtml)

import RubiX.Utils
import RubiX.Types

-- values should be JSON encoded sent with the "application/json"
newtype Json a = Json a
  deriving Show

-- This class represents all types which can be converted into a valid Response
class ToResponse c where
  toResponse :: c -> NW.Response

-- The following functions were inspried by Happstack server response
instance ToResponse Aeson.Value where
    toResponse = makeResponse ok200 "application/json" . fromLazyByteString . encode
  
instance ToResponse String where
  toResponse = makeResponse ok200 "text/plain" . DT.pack

instance ToResponse DT.Text where
  toResponse = makeResponse ok200 "text/plain"

instance ToResponse Html where
  toResponse = makeResponse ok200 "text/html" . DTL.toStrict . renderHtml

instance (ToJSON a) => ToResponse (Json a) where
  toResponse (Json obj) = toResponse (toJSON obj)

instance ToResponse NW.Response where
  toResponse = id

instance (ToResponse b) => ToResponse (b, Status) where
  toResponse (b, status) = toResponse (b, status, mempty :: HeaderMap)

instance (ToResponse b) => ToResponse (b, Status, HeaderMap) where
  toResponse (b, status, hm) =
        toResponse b
      & mapResponseStatus (const status)
      & mapResponseHeaders (++ fromHeaderMap hm)

makeResponse :: Status -> ContentType -> DT.Text -> NW.Response
makeResponse status contentType body =
  NW.responseLBS status [makeHeader "Content-Type" contentType] (toLazyByteString body)

respond :: ToResponse a => a -> App ()
respond =  throwError . toResponse

respondWith :: ToResponse a => Handler a -> App ()
respondWith handler = runHandler handler >>= respond
