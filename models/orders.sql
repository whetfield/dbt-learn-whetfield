with orders as ( 

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

), 


successful_payments as ( 

    select 
        o.order_id,
        o.customer_id,
        p.amount
    
    from orders o 
    left join payments p
        on o.order_id = p.order_id
    
    where p.status = 'success'


), 

final as (
select 
    order_id,
    customer_id,
    sum(amount) as amount_usd

    from successful_payments

    group by 1,2

)

select * from final


