{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE StandaloneDeriving #-}

-- {-# LANGUAGE UndecidableInstances #-}
-- {-# LANGUAGE DataKinds #-}
-- {-# LANGUAGE FlexibleInstances #-}
-- {-# LANGUAGE TemplateHaskell #-}
-- {-# LANGUAGE MultiParamTypeClasses #-}
-- {-# LANGUAGE TypeFamilies #-}
-- {-# LANGUAGE GADTs #-}
-- {-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- {-# LANGUAGE TypeApplications #-}
-- {-# LANGUAGE ScopedTypeVariables #-}

import Protolude
import Database.SQLite.Simple
import Database.SQLite.Simple.QQ
import Data.Time.Clock

db = "ildang.db"

main :: IO ()
main = do
    args <- getArgs
    print args
    print "working ..."

data Client = Client
    { clientId :: Integer
    , clientName :: Text 
    , clientPhones :: Text
    , clientManagerName :: Text
    , clientManagerPhones :: Text
    , clientBankAccountName :: Text
    , clientPaymentPlan :: Integer
    , clientCreatedAt :: UTCTime
    , clientUpdatedAt :: UTCTime
    } deriving (Generic, Show)
deriving anyclass instance FromRow Client
deriving anyclass instance ToRow Client

data Work = Work
    { workId :: Integer
    , workStartAt :: UTCTime
    , workEndAt :: UTCTime
    , workSite :: Integer
    , workClient :: Integer
    , workPayment :: Integer
    , workCreatedAt :: UTCTime
    , workUpdatedAt :: UTCTime
    } deriving (Generic, Show)
deriving anyclass instance FromRow Work
deriving anyclass instance ToRow Work

data Site = Site
    { siteId :: Integer
    , siteName  :: Text
    , siteAddress  :: Text
    , siteLatitude  :: Text
    , siteLongitude  :: Text
    , siteCreatedAt  :: UTCTime
    , siteUpdatedAt  :: UTCTime
    } deriving (Generic, Show)
deriving anyclass instance FromRow Site
deriving anyclass instance ToRow Site

data Payment = Payment
    { paymentId  :: Integer
    , paymentWork  :: Integer
    , paymentClient  :: Integer
    , paymentReceivable  :: Integer
    , paymentTaxRate :: Double
    , paymentCreatedAt :: UTCTime
    , paymentUpdatedAt :: UTCTime
    } deriving (Generic, Show)
deriving anyclass instance FromRow Payment
deriving anyclass instance ToRow Payment

data PaymentPlan = PaymentPlan
    { paymentPlanId  :: Integer
    , paymentPlanPlan  :: Text
    , paymentPlanCreatedAt :: UTCTime
    , paymentPlanUpdatedAt :: UTCTime
    } deriving (Generic, Show)
deriving anyclass instance FromRow PaymentPlan
deriving anyclass instance ToRow PaymentPlan

withConn = withConnection db

add :: ToRow a => a -> IO ()
add (Client _ name phones mname mphones bankaccount paymentplan _ _) = withConn $ flip execute_ [sql| |]
add (Work _ startat endat site client payment _ _) =
        withConn $ flip execute_ [sql|
        |]
add a = print "error"

-- createClient :: 
--            Text    -- clientName
--         -> Text    -- clientPhones
--         -> Text    -- clientManagerName
--         -> Text    -- clientManagerPhones
--         -> Text    -- clientBankAccountName
--         -> Integer -- clientPaymentPlan
--         -> UTCTime -- clientCreatedAt
--         -> UTCTime -- clientUpdatedAt
-- createClient = _
--
-- createSite :: Site
-- createSite = _
