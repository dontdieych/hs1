{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE StandaloneDeriving #-}

import Data.Time.Clock
import Database.SQLite.Simple
import Database.SQLite.Simple.QQ
import Protolude
import Database.SQLite.Simple.FromField (FromField(fromField))

default (Text)

main :: IO ()
main = do
  args <- getArgs
  print args
  print "working ..."

class ToRow r => CRUD r where
  insertRows :: [r] -> IO ()
  updateRows :: [r] -> IO ()

-- u :: a -> IO ()
-- s :: a -> IO [r]

data Client = Client
  { clientId :: Maybe Integer,
    clientName :: Maybe Text,
    clientPhones :: Maybe Text,
    clientManagerName :: Maybe Text,
    clientManagerPhones :: Maybe Text,
    clientBankAccountName :: Maybe Text,
    clientPaymentPlan :: Maybe Integer,
    clientCreatedAt :: Maybe UTCTime,
    clientUpdatedAt :: Maybe UTCTime
  }
  deriving (Generic, Show, Eq)

deriving anyclass instance FromRow Client

deriving anyclass instance ToRow Client

instance CRUD Client where
  insertRows rows = withConn $ \conn ->
    executeMany
      conn
      [sql|
        insert into clients
            ( id
            , name
            , phones
            , manager_name
            , manager_phones
            , bank_account_name
            , payment_plan
            , created_at
            , updated_at
            )
        values (?, ?, ?, ?, ?, ?, ?, ?, ?)
      |]
      rows

  -- updateRows rows = exeMany

-- updateRows [] = return ()

--     =   [sql|
--             update clients
--             set
--                 name = ?
--                 , phones = ?
--                 , manager_name = ?
--                 , manager_phones = ?
--                 , bank_account_name = ?
--                 , payment_plan = ?
--                 , updated_at = ?
--             where id == ?
--         |] <> "( " <> (Query $ toS $ intercalate ", "
--         [ show name
--         , maybe "NULL" show phones
--         , maybe "NULL" show mname
--         , maybe "NULL" show mphones
--         , maybe "NULL" show bankaccount
--         , maybe "NULL" show paymentplan
--         , maybe "NULL" show id
--         , maybe "NULL" show updatedat
--          ] :: Query) <> " )"

-- data Work = Work
--   { workId :: Integer,
--     workStartAt :: UTCTime,
--     workEndAt :: UTCTime,
--     workSite :: Maybe Integer,
--     workClient :: Maybe Integer,
--     workPayment :: Maybe Integer,
--     workCreatedAt :: UTCTime,
--     workUpdatedAt :: UTCTime
--   }
--   deriving (Generic, Show, Eq)

-- deriving anyclass instance FromRow Work

-- deriving anyclass instance ToRow Work

-- data Site = Site
--   { siteId :: Integer,
--     siteName :: Text,
--     siteAddress :: Maybe Text,
--     siteLatitude :: Maybe Text,
--     siteLongitude :: Maybe Text,
--     siteCreatedAt :: UTCTime,
--     siteUpdatedAt :: UTCTime
--   }
--   deriving (Generic, Show, Eq)

-- deriving anyclass instance FromRow Site

-- deriving anyclass instance ToRow Site

-- data Payment = Payment
--   { paymentId :: Integer,
--     paymentWork :: Integer,
--     paymentClient :: Integer,
--     paymentReceivable :: Maybe Integer,
--     paymentTaxRate :: Maybe Double,
--     paymentCreatedAt :: UTCTime,
--     paymentUpdatedAt :: UTCTime
--   }
--   deriving (Generic, Show, Eq)

-- deriving anyclass instance FromRow Payment

-- deriving anyclass instance ToRow Payment

-- data PaymentPlan = PaymentPlan
--   { paymentPlanId :: Integer,
--     paymentPlanPlan :: Maybe Text,
--     paymentPlanCreatedAt :: UTCTime,
--     paymentPlanUpdatedAt :: UTCTime
--   }
--   deriving (Generic, Show, Eq)

-- deriving anyclass instance FromRow PaymentPlan

-- deriving anyclass instance ToRow PaymentPlan

dbFile = "ildang.db"

withConn = withConnection dbFile

exe :: ToRow r => Query -> r -> IO ()
exe q r = withConn $ \conn -> execute conn q r

exeMany :: ToRow r => Query -> [r] -> IO ()
exeMany q rows = withConn $ \conn -> executeMany conn q rows

exe_ :: Query -> IO ()
exe_ q = withConn $ \conn -> execute_ conn q

resetDb :: IO ()
resetDb = do
  sql <- readFile "createdb.sql"
  exe_ $ Query sql
