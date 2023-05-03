{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE StandaloneDeriving #-}
-- {-# LANGUAGE FlexibleContexts #-}

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

main :: IO ()
main = do
    args <- getArgs
    print args
    print "working ..."

class ToRow a => CRUD a where
    i :: a -> Query
    -- d :: a -> IO ()
    -- u :: a -> IO ()
    -- s :: a -> IO [r]

data Client = Client
    { clientId :: Maybe Integer
    , clientName :: Text 
    , clientPhones :: Maybe Text
    , clientManagerName :: Maybe Text
    , clientManagerPhones :: Maybe Text
    , clientBankAccountName :: Maybe Text
    , clientPaymentPlan :: Maybe Integer
    , clientCreatedAt :: Maybe UTCTime
    , clientUpdatedAt :: Maybe UTCTime
    } deriving (Generic, Show, Eq)
deriving anyclass instance FromRow Client
deriving anyclass instance ToRow Client

instance CRUD Client where
    i (Client _ name phones mname mphones bankaccount paymentplan _ _)
        =   [sql|
                insert into clients (
                    name
                    , phones
                    , manager_name
                    , manager_phones
                    , bank_account_name
                    , payment_plan
                )
                values
            |] <> "( " <> (Query $ toS $ intercalate ", "
            [ show name
            , maybe "NULL" show phones
            , maybe "NULL" show mname
            , maybe "NULL" show mphones
            , maybe "NULL" show bankaccount
            , maybe "NULL" show paymentplan
             ] :: Query) <> " )"

data Work = Work
    { workId :: Integer
    , workStartAt :: UTCTime
    , workEndAt :: UTCTime
    , workSite :: Maybe Integer
    , workClient :: Maybe Integer
    , workPayment :: Maybe Integer
    , workCreatedAt :: UTCTime
    , workUpdatedAt :: UTCTime
    } deriving (Generic, Show, Eq)
deriving anyclass instance FromRow Work
deriving anyclass instance ToRow Work

data Site = Site
    { siteId :: Integer
    , siteName  :: Text
    , siteAddress  :: Maybe Text
    , siteLatitude  :: Maybe Text
    , siteLongitude  :: Maybe Text
    , siteCreatedAt  :: UTCTime
    , siteUpdatedAt  :: UTCTime
    } deriving (Generic, Show, Eq)
deriving anyclass instance FromRow Site
deriving anyclass instance ToRow Site

data Payment = Payment
    { paymentId  :: Integer
    , paymentWork  :: Integer
    , paymentClient  :: Integer
    , paymentReceivable  :: Maybe Integer
    , paymentTaxRate :: Maybe Double
    , paymentCreatedAt :: UTCTime
    , paymentUpdatedAt :: UTCTime
    } deriving (Generic, Show, Eq)
deriving anyclass instance FromRow Payment
deriving anyclass instance ToRow Payment

data PaymentPlan = PaymentPlan
    { paymentPlanId  :: Integer
    , paymentPlanPlan  :: Maybe Text
    , paymentPlanCreatedAt :: UTCTime
    , paymentPlanUpdatedAt :: UTCTime
    } deriving (Generic, Show, Eq)
deriving anyclass instance FromRow PaymentPlan
deriving anyclass instance ToRow PaymentPlan

dbFile = "ildang.db"

withConn = withConnection dbFile

ins :: CRUD r => [r] -> IO ()
ins rows = withConn $ \conn -> execute_ conn $ mconcat $ fmap i rows

