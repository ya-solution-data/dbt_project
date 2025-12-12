{% test is_greater_than(model, column_name, field) %}

    {{ config(severity = 'error') }}

    select *
    from {{ model }}
    where {{column_name}} > {{ field }}

{% endtest %}