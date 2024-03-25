USE TSQL2012;

if not exists (select 1 from sys.schemas as s where s.name = 'dbo')
begin
    exec('create schema dbo')
end

if object_id('dbo.SKU', 'U') is null
begin
    create table dbo.SKU
    (
        ID int not null identity,
        Code AS 's' + cast(ID as varchar(10)) not null,
        Name varchar(255) not null,
        constraint PK_SKU primary key clustered (ID)
    )
    alter table dbo.SKU add constraint UK_SKU_Code unique (Code)
end
    
if object_id('dbo.Family', 'U') is null
begin
    create table dbo.Family
    (
        ID int not null identity, 
        SurName varchar(255) not null, 
        BudgetValue decimal(18, 2) not null,
        constraint PK_Family primary key clustered (ID)
    )
end 
    
if object_id('dbo.Basket', 'U') is null
begin
    create table dbo.Basket
    (
        ID int not null identity,
        ID_SKU int not null,
        ID_Family int not null,
        Quantity int not null,
        Value decimal(18, 2) not null,
        PurchaseDate datetime not null,
        DiscountValue decimal(18, 2) not null,
        constraint PK_Basket primary key clustered (ID)
    )
    alter table dbo.Basket add constraint check_Basket_Quantity check (Quantity > 0)
    alter table dbo.Basket add constraint check_Basket_Value check (Value > 0)
    alter table dbo.Basket add constraint DF_Basket_PurchaseDate default getdate() for PurchaseDate
    alter table dbo.Basket add constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID)
    alter table dbo.Basket add constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID)
end



