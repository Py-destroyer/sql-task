use database;

create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert, update
as
begin
    declare 
        @ID_SKU int
        ,@RowCount int

    select @ID_SKU = ID_SKU
    from inserted;

    
