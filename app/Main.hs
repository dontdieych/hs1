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

import Data.Time.Clock
import Database.SQLite.Simple
import Database.SQLite.Simple.QQ
import Protolude

db = "ildang.db"

main :: IO ()
main = do
    args <- getArgs
    print args
    print "working ..."
    -- conn <- open db
    -- createTables conn
    -- close conn

data Works = Works
    { id :: Integer
    , date_time_start :: UTCTime
    , date_time_end :: UTCTime
    , client :: Integer
    , receivable :: Integer
    , tax_rate :: Double
    , inserted_at :: UTCTime
    , updated_at :: UTCTime
    }
    deriving (Generic, Show)

deriving anyclass instance FromRow Works
deriving anyclass instance ToRow Works


createTables conn sql_file =

-- insertFakeData conn = _

-- stmt <- prepare conn "INSERT INTO books (book_id, book_name, author) VALUES (?, ?, ?)"
-- replicateM_ 100000 $ do
--   book_id <- randomRIO (1, 1000000 :: Int)
--   book_name <- randomRIO (1, 1000000 :: Int) >>= return . ("book" ++) . show
--   author <- randomRIO (1, 1000000 :: Int) >>= return . ("author" ++) . show
--   execute stmt (book_id :: Int, book_name :: String, author :: String)

-- table = head $ getArgs

-- 위 코드는 books.db라는 SQLite 데이터베이스를 생성하고 books 테이블을 만듭니다. 그리고 books 테이블에 랜덤한 데이터를 삽입합니다. 이 코드를 실행하면 books.db 파일이 생성되고 books 테이블에 랜덤한 데이터가 삽입됩니다.

-- 위 코드에서는 book_id, book_name, author 컬럼에 랜덤한 값을 삽입하고 있습니다. book_id는 1부터 1000000까지의 랜덤한 정수 중 하나를 선택합니다. book_name과 author는 "book"과 "author" 문자열에 랜덤한 정수를 붙인 문자열을 선택합니다.

-- 위 코드에서는 execute 함수를 사용하여 SQL 쿼리를 실행합니다. 이 함수는 SQL 쿼리와 파라미터를 받아서 SQL 쿼리를 실행합니다.

-- 위 코드에서는 prepare 함수를 사용하여 SQL 쿼리를 준비합니다. 이 함수는 SQL 쿼리를 받아서 준비된 SQL 문장을 반환합니다.

-- 위 코드에서는 replicateM_ 함수를 사용하여 반복 작업을 수행합니다. 이 함수는 지정된 횟수만큼 지정된 작업을 반복합니다.

-- 위 코드에서는 randomRIO 함수를 사용하여 랜덤한 값을 생성합니다. 이 함수는 지정된 범위 내에서 랜덤한 값을 생성합니다.
