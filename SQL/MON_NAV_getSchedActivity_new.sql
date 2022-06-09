CREATE PROCEDURE dbo.MON_NAV_getSchedActivity
	@company VARCHAR(3), -- CZ, EP, SK
	@applServerName VARCHAR(10)
AS
    -- existing server name check
    DECLARE @serverExists VARCHAR(10)
    SET     @serverExists = NULL
    --
    SET @serverExists =  (SELECT DISTINCT [Parameter Appl_ Server]
                            FROM [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Setup]
                           WHERE Enabled = 1
                             AND [Parameter Appl_ Server] = @applServerName);
    --
    IF @serverExists IS NULL
        BEGIN
            SELECT 2 AS Result,
                     NULL AS LastActivity,
                     'not defined or not exists server' AS Status;
            RETURN
        END
    -- EFEX, a_s_
    ELSE IF @company = 'CZ'
        BEGIN
            SELECT CASE
                     WHEN (GETDATE() <= DATEADD(mi, +10,summary.LastActivity) AND summary.RunStatus = 0) -- 10
                           OR (GETDATE() <= DATEADD(mi,+120,summary.LastActivity) AND summary.RunStatus = 1) THEN 0 -- 120
                     WHEN (GETDATE() <= DATEADD(mi, +30,summary.LastActivity) AND summary.RunStatus = 0) -- 30
                           OR (GETDATE() <= DATEADD(mi,+240,summary.LastActivity) AND summary.RunStatus = 1) THEN 1 -- 240
                     WHEN (GETDATE() <= DATEADD(mi, +60,summary.LastActivity) AND summary.RunStatus > 1) THEN 0 -- 60
                     WHEN (GETDATE() <= DATEADD(mi, +90,summary.LastActivity) AND summary.RunStatus > 1) THEN 1 -- 60
                     ELSE 2
                   END AS Result,
                   CASE
                     WHEN summary.LastActivity IS NULL THEN NULL
                     ELSE CONCAT('The last active job time: ', CONVERT(VARCHAR, summary.LastActivity,121))
                   END AS LastActivity,
                   CASE
                     WHEN summary.RunStatus = 0 THEN 'finished' -- status is measured on the finished job
                     WHEN summary.RunStatus = 1 THEN 'running' -- status is measured on the running job
                     ELSE 'not in running or finished state (manual correction)'
                   END AS Status
              FROM (
                SELECT job.*,
                       RANK() OVER (PARTITION BY job.[Parameter Appl_ Server] ORDER BY job.LastActivity DESC) AS Rank
                  FROM (SELECT l.[Parameter Appl_ Server],
                               s.[Run Status] AS RunStatus,
                               CASE
                                 WHEN s.[Run Status] = 0 THEN MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000')) -- finished
                                 WHEN s.[Run Status] = 1 THEN MAX(s.[Last Date Checked - start]+(s.[Last Time Checked - start]-'1754-01-01 00:00:00.000')) -- running
                                 ELSE MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000')) -- other states
                               END AS LastActivity
                          FROM (SELECT TOP(50000) * FROM [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Log] ORDER BY [Entry No_] DESC) l
                          JOIN [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Setup] s ON (s.ID = l.[Job Scheduler ID]
                                                                                                             AND s.Enabled = 1
                                                                                                             AND (s.[Last Date Checked - start] <> '1753-01-01 00:00:00.000'
                                                                                                                  OR s.[Last Time Checked - start] <> '1753-01-01 00:00:00.000'))
                         GROUP BY l.[Parameter Appl_ Server], s.[Run Status]
                        ) job
                  WHERE job.[Parameter Appl_ Server] = @applServerName ) summary
            WHERE summary.Rank = 1;
        END
    -- EP
    ELSE IF @company = 'EP'
        BEGIN
            SELECT CASE
                     WHEN (GETDATE() <= DATEADD(mi, +10,summary.LastActivity) AND summary.RunStatus = 0) -- 10
                           OR (GETDATE() <= DATEADD(mi,+120,summary.LastActivity) AND summary.RunStatus = 1) THEN 0 -- 120
                     WHEN (GETDATE() <= DATEADD(mi, +30,summary.LastActivity) AND summary.RunStatus = 0) -- 30
                           OR (GETDATE() <= DATEADD(mi,+240,summary.LastActivity) AND summary.RunStatus = 1) THEN 1 -- 240
                     WHEN (GETDATE() <= DATEADD(mi, +60,summary.LastActivity) AND summary.RunStatus > 1) THEN 0 -- 60
                     WHEN (GETDATE() <= DATEADD(mi, +90,summary.LastActivity) AND summary.RunStatus > 1) THEN 1 -- 60
                     ELSE 2
                   END AS Result,
                   CONCAT('The last active job time: ', CONVERT(VARCHAR, summary.LastActivity,121)) AS LastActivity,
                   CASE
                     WHEN summary.RunStatus = 0 THEN 'finished' -- status is measured on the finished job
                     WHEN summary.RunStatus = 1 THEN 'running' -- status is measured on the running job
                     ELSE 'not in running or finished state (manual correction)'
                   END AS Status
              FROM (
                SELECT job.*,
                       RANK() OVER (PARTITION BY job.[Parameter Appl_ Server] ORDER BY job.LastActivity DESC) AS Rank
                  FROM (SELECT l.[Parameter Appl_ Server],
                               s.[Run Status] AS RunStatus,
                               CASE
                                 WHEN s.[Run Status] = 0 THEN MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000')) -- finished
                                 WHEN s.[Run Status] = 1 THEN MAX(s.[Last Date Checked - start]+(s.[Last Time Checked - start]-'1754-01-01 00:00:00.000')) -- running
                                 ELSE MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000')) -- other states
                               END AS LastActivity
                          FROM (SELECT TOP(50000) * FROM [NAV_PROD].[dbo].[EP$Job Scheduler Log] ORDER BY [Entry No_] DESC) l
                          JOIN [NAV_PROD].[dbo].[EP$Job Scheduler Setup] s ON (s.ID = l.[Job Scheduler ID]
                                                                                          AND s.Enabled = 1
                                                                                          AND (s.[Last Date Checked - start] <> '1753-01-01 00:00:00.000'
                                                                                               OR s.[Last Time Checked - start] <> '1753-01-01 00:00:00.000'))
                         GROUP BY l.[Parameter Appl_ Server], s.[Run Status]
                        ) job
                  WHERE job.[Parameter Appl_ Server] = @applServerName ) summary
            WHERE summary.Rank = 1;
        END
    -- SK EUR
    ELSE IF @company = 'SK'
        BEGIN
            SELECT CASE
                     WHEN (GETDATE() <= DATEADD(mi, +10,summary.LastActivity) AND summary.RunStatus = 0) -- 10
                           OR (GETDATE() <= DATEADD(mi,+120,summary.LastActivity) AND summary.RunStatus = 1) THEN 0 -- 120
                     WHEN (GETDATE() <= DATEADD(mi, +30,summary.LastActivity) AND summary.RunStatus = 0) -- 30
                           OR (GETDATE() <= DATEADD(mi,+240,summary.LastActivity) AND summary.RunStatus = 1) THEN 1 -- 240
                     WHEN (GETDATE() <= DATEADD(mi, +60,summary.LastActivity) AND summary.RunStatus > 1) THEN 0 -- 60
                     WHEN (GETDATE() <= DATEADD(mi, +90,summary.LastActivity) AND summary.RunStatus > 1) THEN 1 -- 60
                     ELSE 2
                   END AS Result,
                   CONCAT('The last active job time: ', CONVERT(VARCHAR, summary.LastActivity,121)) AS LastActivity,
                   CASE
                     WHEN summary.RunStatus = 0 THEN 'finished' -- status is measured on the finished job
                     WHEN summary.RunStatus = 1 THEN 'running' -- status is measured on the running job
                     ELSE 'not in running or finished state (manual correction)'
                   END AS Status
              FROM (
                SELECT job.*,
                       RANK() OVER (PARTITION BY job.[Parameter Appl_ Server] ORDER BY job.LastActivity DESC) AS Rank
                  FROM (SELECT l.[Parameter Appl_ Server],
                               s.[Run Status] AS RunStatus,
                               CASE
                                 WHEN s.[Run Status] = 0 THEN MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000')) -- finished
                                 WHEN s.[Run Status] = 1 THEN MAX(s.[Last Date Checked - start]+(s.[Last Time Checked - start]-'1754-01-01 00:00:00.000')) -- running
                                 ELSE MAX(l.[Date]+(l.[Time]-'1754-01-01 00:00:00.000')) -- other states
                               END AS LastActivity
                          FROM (SELECT TOP(50000) * FROM [NAV_PROD].[dbo].[SK EUR$Job Scheduler Log] ORDER BY [Entry No_] DESC) l
                          JOIN [NAV_PROD].[dbo].[SK EUR$Job Scheduler Setup] s ON (s.ID = l.[Job Scheduler ID]
                                                                                         AND s.Enabled = 1
                                                                                         AND (s.[Last Date Checked - start] <> '1753-01-01 00:00:00.000'
                                                                                              OR s.[Last Time Checked - start] <> '1753-01-01 00:00:00.000'))
                         GROUP BY l.[Parameter Appl_ Server], s.[Run Status]
                        ) job
                  WHERE job.[Parameter Appl_ Server] = @applServerName ) summary
            WHERE summary.Rank = 1;
        END
    ELSE
        BEGIN
            SELECT 2 AS Result,
                   NULL AS LastActivity,
                   'not defined or not exists company' AS Status;
        END