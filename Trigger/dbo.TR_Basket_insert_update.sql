use database;

create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert, update
as
begin
    declare 
        @ID_SKU int
        ,@RowCount int

    select @ID_SKU = ID
    from inserted;

    select @RowCount = count(*)
    from dbo.Basket
    where ID = @ID_SKU

    update b
    set DiscountValue = case
                            when @RowCount >= 2
                                then Value * 0.05
                            else 0
    from dbo.Basket as b
    where ID = @ID_SKU
end
