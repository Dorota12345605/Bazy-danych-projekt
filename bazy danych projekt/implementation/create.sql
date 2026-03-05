USE [Gabinet dentystyczny];
GO

CREATE TABLE Osoba (
    Pesel          CHAR(11) PRIMARY KEY,
    Imie           VARCHAR(30) NOT NULL,
    Nazwisko       VARCHAR(30) NOT NULL,
    NrTelefonu     VARCHAR(15) NOT NULL UNIQUE,
    Email          VARCHAR(254) NOT NULL UNIQUE
);

CREATE TABLE Klient (
    Pesel              CHAR(11) PRIMARY KEY,
    DataUrodzenia      DATETIME NOT NULL,
    Adres              VARCHAR(255) NOT NULL,
    TypPowiadomienia   VARCHAR(30) NOT NULL,

    FOREIGN KEY (Pesel) REFERENCES Osoba(Pesel) ON DELETE CASCADE
);

CREATE TABLE Recepcjonista (
    Pesel       CHAR(11) PRIMARY KEY,
    Stanowisko  TEXT NOT NULL,

    FOREIGN KEY (Pesel) REFERENCES Osoba(Pesel)
);

CREATE TABLE Dentysta (
    Pesel       CHAR(11) PRIMARY KEY,
    Specjalizacja VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (Pesel) REFERENCES Osoba(Pesel)
);

CREATE TABLE Grafik (
    IdGrafiku              INT PRIMARY KEY,
    DniTygodnia            INT CHECK (DniTygodnia BETWEEN 1 AND 7),
    GodzinyRozpoczecia     TIME,
    GodzinyZakonczeniaPracy TIME,
    ObowiazujeDo           DATE,
    Pesel                  CHAR(11) NOT NULL,

    FOREIGN KEY (Pesel) REFERENCES Dentysta(Pesel),
    UNIQUE (Pesel, DniTygodnia)
);

CREATE TABLE Gabinet (
    IdGabinetu      INT PRIMARY KEY,
    NumerGabinetu   INT NOT NULL UNIQUE 
);

CREATE TABLE Usluga (
    IdUslugi        INT PRIMARY KEY,
    RodzajUslugi    VARCHAR(100) NOT NULL UNIQUE,
    Cena            DECIMAL(10,2) CHECK (Cena >= 0),
    CzasTrwania     INT CHECK (CzasTrwania > 0)
);

CREATE TABLE Rezerwacja (
    IdRezerwacji        INT PRIMARY KEY,
    DataRezerwacji      DATETIME NOT NULL,
    StatusRezerwacji    VARCHAR(50) NOT NULL
    CHECK (StatusRezerwacji IN ('Oczekuj¹ca', 'Anulowana', 'Potwierdzona', 'Odbyta')),
    CzasTrwaniaRezerwacji INT NOT NULL CHECK (CzasTrwaniaRezerwacji > 0),
    ZadowolenieKlienta VARCHAR(40) DEFAULT 'bardzo'
    CHECK (ZadowolenieKlienta IN ('bardzo', 'umierkowanie', 'niezadowolnoy')),

    PeselKlienta        CHAR(11) NOT NULL,
    PeselDentysty       CHAR(11) NOT NULL,
    PeselRecepcjonisty  CHAR(11) NOT NULL,
    IdGabinetu          INT NOT NULL,

    FOREIGN KEY (PeselKlienta)       REFERENCES Klient(Pesel) ON DELETE CASCADE,
    FOREIGN KEY (PeselDentysty)      REFERENCES Dentysta(Pesel),
    FOREIGN KEY (PeselRecepcjonisty) REFERENCES Recepcjonista(Pesel),
    FOREIGN KEY (IdGabinetu)         REFERENCES Gabinet(IdGabinetu)  ON UPDATE CASCADE,

    UNIQUE (DataRezerwacji, PeselDentysty)
);

CREATE TABLE WykonanaUsluga (
    IdWykonanaUsluga INT PRIMARY KEY,
    Opis             TEXT,
    NumerZeba        INT CHECK (NumerZeba >= 1 AND NumerZeba <= 88),
    IdUslugi         INT NOT NULL,
    IdRezerwacji     INT NOT NULL,

    FOREIGN KEY (IdUslugi) REFERENCES Usluga(IdUslugi),
    FOREIGN KEY (IdRezerwacji) REFERENCES Rezerwacja(IdRezerwacji) ON DELETE CASCADE
);

CREATE TABLE Platnosc (
    IdPlatnosci      INT PRIMARY KEY,
    FormaPlatnosci VARCHAR(20) NOT NULL DEFAULT 'Gotowka'
    CHECK (FormaPlatnosci IN ('Karta', 'Gotowka', 'Przelew', 'BLIK')),
    StatusPlatnosci VARCHAR(20) NOT NULL
    CHECK (StatusPlatnosci IN ('Oczekuje', 'Oplacona', 'Odrzucona', 'Anulowana')),
    Kwota DECIMAL(10,2),
    DataPlatnosci    DATETIME,

    IdRezerwacji     INT NOT NULL,
    FOREIGN KEY (IdRezerwacji) REFERENCES Rezerwacja(IdRezerwacji) ON DELETE CASCADE
);

GO







