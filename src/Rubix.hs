{-# LANGUAGE OverloadedStrings #-}

module Rubix 
    ( runServer
    ) where

import Network.Wai 
import Network.Wai.Handler.Warp 
import Network.HTTP.Types 
import Network.HTTP.Types.Header 

runServer = do
    let port = 8080
    putStrLn $ "RubiX Listening on port " ++ show port
    run port app

app :: Application
app req respond = respond $
    case requestMethod req of
        "POST" -> handleRes
        _ -> handlePortError

handleRes = responseLBS
    status200
    [("Content-Type", "application/json")]
    "{\"msg\":\"JSON, -- Do you speak it?\", \"val\": \"Hello RubiX\"}"

handlePortError = responseLBS
    status500
    [("Content-Type", "text/plain")]
    "500 Request Method not Supported"