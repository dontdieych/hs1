DROP TABLE IF EXISTS works;

CREATE TABLE works (
        id INTEGER PRIMARY KEY NOT NULL
        , start_datetime DATETIME NOT NULL DEFAULT current_timestamp
        , end_datetime DATETIME NOT NULL DEFAULT current_timestamp
        , site INTEGER
        , client INTEGER
        , payment INTEGER
        , created_at DATETIME NOT NULL DEFAULT current_timestamp
        , updated_at DATETIME NOT NULL DEFAULT current_timestamp

        , FOREIGN KEY(site) REFERENCES sites(id)
        , FOREIGN KEY(client) REFERENCES clients(id)
        , FOREIGN KEY(payment) REFERENCES payments(id)
);

DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
        id INTEGER PRIMARY KEY NOT NULL
        , client TEXT NOT NULL
        , client_phones TEXT
        , manager TEXT
        , manager_phones TEXT
        , bank_account_name TEXT
        , payment_plan INTEGER
        , created_at DATETIME NOT NULL DEFAULT current_timestamp
        , updated_at DATETIME NOT NULL DEFAULT current_timestamp

        , FOREIGN KEY(payment_plan) REFERENCES payment_plans(id)
);

DROP TABLE IF EXISTS sites;

CREATE TABLE sites (
        id INTEGER PRIMARY KEY NOT NULL
        , name TEXT NOT NULL
        , address TEXT
        , latitude TEXT
        , longitude TEXT
        , created_at DATETIME NOT NULL DEFAULT current_timestamp
        , updated_at DATETIME NOT NULL DEFAULT current_timestamp
);

DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
        id INTEGER PRIMARY KEY NOT NULL
        , work INTEGER NOT NULL
        , client INTEGER NOT NULL
        , receivable INTEGER
        , tax_rate REAL
        , created_at DATETIME NOT NULL DEFAULT current_timestamp
        , updated_at DATETIME NOT NULL DEFAULT current_timestamp

        , FOREIGN KEY(work) REFERENCES works(id)
        , FOREIGN KEY(client) REFERENCES clients(id)
);

DROP TABLE IF EXISTS payment_plans;

CREATE TABLE payment_plans (
        id INTEGER PRIMARY KEY NOT NULL
        , plan TEXT NOT NULL
        , created_at DATETIME NOT NULL DEFAULT current_timestamp
        , updated_at DATETIME NOT NULL DEFAULT current_timestamp
);
