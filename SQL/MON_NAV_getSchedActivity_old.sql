CREATE PROCEDURE dbo.MON_NAV_getSchedActivity
	@company VARCHAR(3), -- CZ, EP, SK
	@applServerName VARCHAR(10)
AS
    -- EFEX, a_s_
    IF @company = 'CZ'
		SELECT MIN(CASE
					 WHEN (GETDATE() <= DATEADD(mi, +10,job.LastActivity) AND job.RunStatus = 0) -- 10
					   OR (GETDATE() <= DATEADD(mi,+120,job.LastActivity) AND job.RunStatus = 1) THEN 0 -- 120
					 WHEN (GETDATE() <= DATEADD(mi, +30,job.LastActivity) AND job.RunStatus = 0) -- 30
					   OR (GETDATE() <= DATEADD(mi,+240,job.LastActivity) AND job.RunStatus = 1) THEN 1 -- 240
					 ELSE 2
				   END) AS Result,
			   CONCAT('Last active job time: ', CONVERT(varchar, MAX(job.LastActivity),121)) AS LastActivity,
			   CASE
				 WHEN MAX(RunStatus) = 0 THEN 'finished' -- status is measured on the finished job
				 ELSE 'running' -- status is measured on the running job
			   END AS Status
		  FROM (SELECT l.[Parameter Appl_ Server],
		               s.[Run Status] AS RunStatus,
		               CASE
					     WHEN s.[Run Status] = '0' THEN MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000'))
						 WHEN s.[Run Status] = '1' THEN MAX(s.[Last Date Checked - start]+(s.[Last Time Checked - start]-'1754-01-01 00:00:00.000'))
					   END AS LastActivity
				  FROM (SELECT TOP(50000) * FROM [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Log] ORDER BY [Entry No_] DESC) l
				  JOIN [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Setup] s ON (s.ID = l.[Job Scheduler ID]
				                                                                                     AND s.Enabled = 1
																									 AND (s.[Last Date Checked - start] <> '1753-01-01 00:00:00.000'
                                                                                                          OR s.[Last Time Checked - start] <> '1753-01-01 00:00:00.000'))
				 GROUP BY l.[Parameter Appl_ Server], s.[Run Status]
				) job
		  WHERE job.[Parameter Appl_ Server] = @applServerName;
    -- EP
    ELSE IF @company = 'EP'
		SELECT MIN(CASE
					 WHEN (GETDATE() <= DATEADD(mi, +10,job.LastActivity) AND job.RunStatus = 0) -- 10
					   OR (GETDATE() <= DATEADD(mi,+120,job.LastActivity) AND job.RunStatus = 1) THEN 0 -- 120
					 WHEN (GETDATE() <= DATEADD(mi, +30,job.LastActivity) AND job.RunStatus = 0) -- 30
					   OR (GETDATE() <= DATEADD(mi,+240,job.LastActivity) AND job.RunStatus = 1) THEN 1 -- 240
					 ELSE 2
				   END) AS Result,
			   CONCAT('Last active job time: ', CONVERT(varchar, MAX(job.LastActivity),121)) AS LastActivity,
			   CASE
				 WHEN MAX(RunStatus) = 0 THEN 'finished' -- status is measured on the finished job
				 ELSE 'running' -- status is measured on the running job
			   END AS Status
		  FROM (SELECT l.[Parameter Appl_ Server],
		               s.[Run Status] AS RunStatus,
		               CASE
					     WHEN s.[Run Status] = '0' THEN MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000'))
						 WHEN s.[Run Status] = '1' THEN MAX(s.[Last Date Checked - start]+(s.[Last Time Checked - start]-'1754-01-01 00:00:00.000'))
					   END AS LastActivity
				  FROM (SELECT TOP(50000) * FROM [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Log] ORDER BY [Entry No_] DESC) l
				  JOIN [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Setup] s ON (s.ID = l.[Job Scheduler ID]
				                                                                                     AND s.Enabled = 1
																									 AND (s.[Last Date Checked - start] <> '1753-01-01 00:00:00.000'
                                                                                                          OR s.[Last Time Checked - start] <> '1753-01-01 00:00:00.000'))
				 GROUP BY l.[Parameter Appl_ Server], s.[Run Status]
				) job
		  WHERE job.[Parameter Appl_ Server] = @applServerName;
    -- SK EUR
    ELSE IF @company = 'SK'
		SELECT MIN(CASE
					 WHEN (GETDATE() <= DATEADD(mi, +10,job.LastActivity) AND job.RunStatus = 0) -- 10
					   OR (GETDATE() <= DATEADD(mi,+120,job.LastActivity) AND job.RunStatus = 1) THEN 0 -- 120
					 WHEN (GETDATE() <= DATEADD(mi, +30,job.LastActivity) AND job.RunStatus = 0) -- 30
					   OR (GETDATE() <= DATEADD(mi,+240,job.LastActivity) AND job.RunStatus = 1) THEN 1 -- 240
					 ELSE 2
				   END) AS Result,
			   CONCAT('Last active job time: ', CONVERT(varchar, MAX(job.LastActivity),121)) AS LastActivity,
			   CASE
				 WHEN MAX(RunStatus) = 0 THEN 'finished' -- status is measured on the finished job
				 ELSE 'running' -- status is measured on the running job
			   END AS Status
		  FROM (SELECT l.[Parameter Appl_ Server],
		               s.[Run Status] AS RunStatus,
		               CASE
					     WHEN s.[Run Status] = '0' THEN MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000'))
						 WHEN s.[Run Status] = '1' THEN MAX(s.[Last Date Checked - start]+(s.[Last Time Checked - start]-'1754-01-01 00:00:00.000'))
					   END AS LastActivity
				  FROM (SELECT TOP(50000) * FROM [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Log] ORDER BY [Entry No_] DESC) l
				  JOIN [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Setup] s ON (s.ID = l.[Job Scheduler ID]
				                                                                                     AND s.Enabled = 1
																									 AND (s.[Last Date Checked - start] <> '1753-01-01 00:00:00.000'
                                                                                                          OR s.[Last Time Checked - start] <> '1753-01-01 00:00:00.000'))
				 GROUP BY l.[Parameter Appl_ Server], s.[Run Status]
				) job
		  WHERE job.[Parameter Appl_ Server] = @applServerName;