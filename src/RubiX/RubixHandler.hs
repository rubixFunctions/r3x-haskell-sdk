{-# language OverloadedStrings #-}
{-# language FlexibleContexts #-}
module RubiX.RubixHandler
  ( route
  ) where

import RubiX.Types
import RubiX.RubixRequest
import RubiX.RubixResponse
import Control.Monad

-- Run a handler to match declared routes
route :: ToResponse a => Pattern -> Handler a -> App ()
route routePath handler = do
  doesPathMatch <- matchPaths routePath
  when doesPathMatch $ respondWith handler

