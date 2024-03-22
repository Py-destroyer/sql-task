use database; 

create function dbo.udf_GetSKUPrice(
    @ID_SKU int
)
returns decimal(18, 2)
as
begin
    declare @Price DECIMAL(18, 2);
    
    -- Рассчитываем стоимость продукта
    select @Price = sum(Value) / nullif(sum(Quantity), 0)
    from dbo.Basket
    where ID_SKU = @ID_SKU;
    
    return @Price;
end
