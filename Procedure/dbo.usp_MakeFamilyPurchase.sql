use TSQL2012;

if object_id('usp_MakeFamilyPurchase') is null
begin

    create procedure dbo.usp_MakeFamilyPurchase
        @FamilySurName varchar(255) out
    as
    set nocount on
    begin
        declare
        @ErrorMessage varchar(8000)
    
        -- Проверка на корректность загрузки
        if not exists (
            select 1 
            from dbo.Family as f
            where f.SurName = @FamilySurName
        )
        begin 
            set @ErrorMessage = 'Family does not exist'
            raiserror(@ErrorMessage, 16, 1)

        return
    end

    -- Подсчет всех покупок для переданной семьи
    declare 
    @TotalValue decimal(18, 2) = (
                                    select sum(b.Value) 
                                    from dbo.Basket as b 
                                    where b.ID_Family = (
                                                        select f.ID 
                                                        from dbo.Family as f
                                                        where f.SurName = @FamilySurName)
    )
    
    -- Обновление данных в таблице dbo.Family
    update f
    set BudgetValue = BudgetValue - @TotalValue
    from dbo.Family as f
    where f.Surname = @FamilySurName;
end
