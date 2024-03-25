use TSQL2012;

create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert, update
as
begin
    declare 
        @ID_SKU int
        ,@RowCount int

    select @ID_SKU = ID_SKU
    from inserted;

    select @RowCount = count(*)
    from dbo.Basket
    where ID_SKU = @ID_SKU

    update b
    set DiscountValue = case
                            when @RowCount >= 2
                                then Value * 0.05
                            else 0
    from dbo.Basket as b
    where ID_SKU = @ID_SKU
end
