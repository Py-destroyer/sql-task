use TSQL2012; 

create function dbo.udf_GetSKUPrice(
    @ID_SKU int
)
returns decimal(18, 2)
as
begin
    declare @Price DECIMAL(18, 2);
    
    -- Рассчитываем стоимость продукта
    select @Price = sum(b.Value) / nullif(sum(b.Quantity), 0)
    from dbo.Basket as b
    where b.ID_SKU = @ID_SKU;
    
    return @Price;
end
