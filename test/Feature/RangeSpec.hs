{-# LANGUAGE OverloadedStrings, QuasiQuotes #-}
module Feature.RangeSpec where

import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.JSON

import Dbapi (AppConfig(..), app)

main :: IO ()
main = hspec spec

cfg :: AppConfig
cfg = AppConfig "postgres://postgres:@localhost:5432/dbapi_test" 9000

spec :: Spec
spec = with (return $ app cfg) $ do
  describe "GET /" $ do
    it "responds with 200" $ do
      get "/" `shouldRespondWith` 200

  it "responds with 'hello'" $ do
    get "/" `shouldRespondWith` [json|
      [{"schema":"1","name":"auto_incrementing_pk","insertable":true}]
    |]