-- =========================================================
-- Supply Chain Analytics Queries
-- =========================================================


-- 1. Total Order Lines
SELECT COUNT(*) AS total_order_lines
FROM fact_order_line;


-- 2. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM fact_order_line;


-- 3. Volume Fill Rate
-- Delivered quantity / Ordered quantity
SELECT
    ROUND(
        SUM(delivery_qty)::NUMERIC
        / NULLIF(SUM(order_qty), 0) * 100,
        2
    ) AS volume_fill_rate
FROM fact_order_line;


-- 4. On-Time Delivery %
SELECT
    ROUND(
        AVG(on_time)::NUMERIC * 100,
        2
    ) AS on_time_delivery_pct
FROM fact_aggregate;


-- 5. In-Full Delivery %
SELECT
    ROUND(
        AVG(in_full)::NUMERIC * 100,
        2
    ) AS in_full_delivery_pct
FROM fact_aggregate;


-- 6. OTIF %
-- Orders delivered both on time and in full
SELECT
    ROUND(
        AVG(otif)::NUMERIC * 100,
        2
    ) AS otif_pct
FROM fact_aggregate;


-- 7. Customer-level fulfillment performance
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    ROUND(AVG(f.on_time)::NUMERIC * 100, 2) AS on_time_pct,
    ROUND(AVG(f.in_full)::NUMERIC * 100, 2) AS in_full_pct,
    ROUND(AVG(f.otif)::NUMERIC * 100, 2) AS otif_pct
FROM dim_customers c
JOIN fact_aggregate f
    ON c.customer_id = f.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city
ORDER BY otif_pct DESC;


-- 8. Compare customer OTIF against target
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(AVG(f.otif)::NUMERIC * 100, 2) AS actual_otif_pct,
    t."otif_target%" AS target_otif_pct,
    ROUND(
        AVG(f.otif)::NUMERIC * 100
        - t."otif_target%",
        2
    ) AS otif_gap
FROM dim_customers c
JOIN fact_aggregate f
    ON c.customer_id = f.customer_id
JOIN dim_targets_orders t
    ON c.customer_id = t.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    t."otif_target%"
ORDER BY otif_gap;