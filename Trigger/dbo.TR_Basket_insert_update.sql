use database;

create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert, update
as
begin
    set nocount on
    declare 
        @ID_SKU int
        ,@RowCount int
