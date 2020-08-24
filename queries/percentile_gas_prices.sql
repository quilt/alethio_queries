USE mainnet_v2;

SELECT gasPrice
FROM (
  SELECT
    gasPrice,
    PERCENT_RANK() OVER (ORDER BY gasPrice) as rank
  FROM (
    SELECT
      MIN(gasPrice) as gasPrice,
      blockNumber
    FROM (
      SELECT
        gasPrice,
        blockNumber,
        PERCENT_RANK() OVER(PARTITION BY blockNumber ORDER BY gasPrice) as rank
      FROM tx
      WHERE blockNumber >= 9977042 and
        txHash != "0xfd10c9a4507c4ebf1db9f71e05ba8ea09f3603c9012c24195d731a1fadfa14d9"
        and txHash != "0xca8f8c315c8b6c48cee0675677b786d1babe726773829a588efa500b71cbdb65"
        and txHash != "0xc215b9356db58ce05412439f49a842f8a3abe6c1792ff8f2c3ee425c3501023c"
    )
    WHERE rank >= 0.95
    GROUP BY blockNumber
  )
)
WHERE rank >= {}