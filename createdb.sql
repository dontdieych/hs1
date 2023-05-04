DROP TABLE IF EXISTS works;

CREATE TABLE works (
        id INTEGER PRIMARY KEY NOT NULL
        , start_at TEXT NOT NULL
        , end_at TEXT NOT NULL
        , site INTEGER
        , client INTEGER
        , payment INTEGER
        , created_at TEXT NOT NULL
        , updated_at TEXT NOT NULL
                CHECK ( created_at <= updated_at )

        , FOREIGN KEY(site) REFERENCES sites(id)
        , FOREIGN KEY(client) REFERENCES clients(id)
        , FOREIGN KEY(payment) REFERENCES payments(id)
) STRICT ;

DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
        id INTEGER PRIMARY KEY NOT NULL
        , name TEXT NOT NULL
        , phones TEXT
        , manager_name TEXT
        , manager_phones TEXT
        , bank_account_name TEXT
        , payment_plan INTEGER
        , created_at TEXT NOT NULL
        , updated_at TEXT NOT NULL
                CHECK ( created_at <= updated_at )

        , FOREIGN KEY(payment_plan) REFERENCES payment_plans(id)
) STRICT ;

DROP TABLE IF EXISTS sites;

CREATE TABLE sites (
        id INTEGER PRIMARY KEY NOT NULL
        , name TEXT NOT NULL
        , address TEXT
        , latitude TEXT
        , longitude TEXT
        , created_at TEXT NOT NULL
        , updated_at TEXT NOT NULL
                CHECK ( created_at <= updated_at )
) STRICT ;

DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
        id INTEGER PRIMARY KEY NOT NULL
        , work INTEGER NOT NULL
        , client INTEGER NOT NULL
        , receivable INTEGER
        , tax_rate REAL
        , created_at TEXT NOT NULL
        , updated_at TEXT NOT NULL
                CHECK ( created_at <= updated_at )

        , FOREIGN KEY(work) REFERENCES works(id)
        , FOREIGN KEY(client) REFERENCES clients(id)
) STRICT ;

DROP TABLE IF EXISTS payment_plans;

CREATE TABLE payment_plans (
        id INTEGER PRIMARY KEY NOT NULL
        , plan TEXT NOT NULL
        , created_at TEXT NOT NULL
        , updated_at TEXT NOT NULL
                CHECK ( created_at <= updated_at )
) STRICT ;
