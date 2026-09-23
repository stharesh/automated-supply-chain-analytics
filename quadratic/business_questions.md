# Quadratic AI Analysis

## Objective

The processed supply-chain data was connected to Quadratic AI for spreadsheet-based analysis and KPI generation.

Natural-language prompts were used to answer business questions related to order fulfillment and customer performance. The KPI calculations in this project were generated through Quadratic AI; they are not presented as hand-written SQL analysis.

## Key Performance Indicators

The analysis included:

- Total Order Lines
- Total Orders
- Line Fill Rate
- Volume Fill Rate
- On-Time Delivery %
- In-Full Delivery %
- On-Time-In-Full (OTIF) %

## Business Questions

### Overall Performance

1. What is the total number of orders?
2. What is the total number of order lines?
3. What is the overall On-Time Delivery percentage?
4. What is the overall In-Full Delivery percentage?
5. What is the overall OTIF percentage?

### Customer Performance

6. Which customers have the highest order value?
7. Which customers have the lowest OTIF performance?
8. Which customers have the highest On-Time performance?
9. Which customers have the highest In-Full performance?

### Target Performance

10. Which customers are below their OTIF target?
11. Which customers are meeting or exceeding their OTIF target?
12. Which customers have the largest gap between actual OTIF and target OTIF?

### Supply Chain Insights

13. What are the major fulfillment performance gaps?
14. Which customers should be prioritized for improvement?
15. What patterns can be identified from customer-level fulfillment performance?

### Currency-Normalized Analysis

16. Retrieve the current USD-to-INR exchange rate from the Open Exchange Rates API using the app ID configured in Quadratic.
17. Convert USD-denominated values to INR for comparable cross-region analysis.
18. Which customer or regional value metrics change most after currency normalization?

## Live-rate note

The exchange rate is retrieved at analysis time. It is not stored as a historical exchange-rate table in this project, so converted results can vary as live rates change. API credentials are configured in Quadratic and are not included in this repository.
