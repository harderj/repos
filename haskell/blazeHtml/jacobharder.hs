{-# LANGUAGE OverloadedStrings #-} -- (?)

import Control.Monad (forM_)
import Text.Blaze.Html5
import Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.String (renderHtml)

main = do
  putStrLn $ renderHtml $ firstHaskellWebsite
  writeFile "index.html" $ renderHtml $ firstHaskellWebsite

firstHaskellWebsite :: Html
firstHaskellWebsite = H.html $ do
  H.head $ do
    H.title "J.Harder"
  body $ do
    p "Welcome."
    simpleImage

numbers :: Int -> Html
numbers n = H.html $ do
  H.head $ do
    H.title "Natural numbers"
  body $ do
    p "A list of natural numbers:"
    ul $ forM_ [1..n] (li . toHtml)

simpleImage :: Html
simpleImage = sImg "signature.png"

sImg s = img ! src s ! alt s

data User = User
            { getUserName :: String
            , getPoints   :: Int }

userInfo :: Maybe User -> Html
userInfo u = H.div ! A.id "user-info" $ case u of
  Nothing ->
    a ! href "/login" $ "Please login."
  Just user -> do
    "Logged in as "
    toHtml $ getUserName user
    ". Your points: "
    toHtml $ getPoints user

somePage :: Maybe User -> Html
somePage u = html $ do
  H.head $ do
    H.title "Some page."
  body $ do
    userInfo u
    "The rest of the page."