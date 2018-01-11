SELECT
STR_TO_DATE(CONCAT(tb.cohort, ' Monday'), '%X-%V %W') as date,
size,
w1,
w2,
w3,
w4,
w5,
w6,
w7
FROM (
  SELECT u.cohort,
    IFNULL(SUM(s.Offset = 0), 0) w1,
    IFNULL(SUM(s.Offset = 1), 0) w2,
    IFNULL(SUM(s.Offset = 2), 0) w3,
    IFNULL(SUM(s.Offset = 3), 0) w4,
    IFNULL(SUM(s.Offset = 4), 0) w5,
    IFNULL(SUM(s.Offset = 5), 0) w6,
    IFNULL(SUM(s.Offset = 6), 0) w7
  FROM (
   SELECT
      UserId,
      DATE_FORMAT(AddedDate, "%Y-%u") AS cohort
    FROM users
  ) as u
  LEFT JOIN (
      SELECT DISTINCT
      payments.UserId,
      FLOOR(DATEDIFF(payments.PaymentDate, users.AddedDate)/7) AS Offset
      FROM payments
      LEFT JOIN users ON (users.UserId = payments.UserId)
  ) as s ON s.UserId = u.UserId
  GROUP BY u.cohort
) as tb
LEFT JOIN (
  SELECT DATE_FORMAT(AddedDate, "%Y-%u") dt, COUNT(*) size FROM users GROUP BY dt
) size ON tb.cohort = size.dt
