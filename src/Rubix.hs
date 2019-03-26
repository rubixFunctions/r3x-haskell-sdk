{-# LANGUAGE OverloadedStrings #-}

module Rubix 
    ( runServer
    ) where

import Network.Wai (responseLBS, Application)
import Network.Wai.Handler.Warp (run)
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header (hContentType)

runServer = do
    let port = 3000
    putStrLn $ "Listening on port " ++ show port
    run port app

app :: Application
app req f =
    f $ responseLBS status200 [(hContentType, "text/plain")] "Hello RubiX!"