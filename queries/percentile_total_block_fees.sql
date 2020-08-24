USE mainnet_v2;

SELECT
  blockNumber,
  fees,
  rank
FROM (
  SELECT
    blockNumber,
    fees,
    PERCENT_RANK() OVER(ORDER BY fees) as rank
  FROM (
    SELECT
      blockNumber,
      SUM(tx_fees) as fees
    FROM
      (
        SELECT
          blockNumber,
          gasUsed * gasPrice as tx_fees
        FROM tx 
        WHERE
          blockNumber >= 10622281 and
       )
    GROUP BY blockNumber
  )
)
WHERE rank >= {}
ORDER by rank asc;
