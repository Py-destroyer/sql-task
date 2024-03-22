use TSQL2012;

if object_id('dbo.vw_SKUPrice') is null
begin
    create view dbo.vw_SKUPrice 
    as
        select 
            SKU.*
            ,dbo.udf_GetSKUPrice(SKU.ID) as Price
        from dbo.SKU;
end
