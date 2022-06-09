ALTER PROCEDURE [dbo].[MON_IMP_getImpCZ]
	@fileType VARCHAR(4), -- TRL, BLT
	@checkType VARCHAR(6) -- import, valid, BLT
AS 
	DECLARE @trlImpWarningTime time

	DECLARE @trlValWarningTime time

	SET @trlImpWarningTime='08:00:00.0000000'

	SET @trlValWarningTime='08:00:00.0000000'

	-- kontrola BLT
	IF @fileType = 'BLT' AND @checkType = 'BLT'
		SELECT 
			CASE
				-- Job probìhl ètyøikrát za pøedchozí den.
				WHEN
						job.[Number of BLT Yesterday] >= 4
				THEN 0

				-- Job neprobìhl kolikrát mìl. Check musí bìžet ve 12:00
				WHEN	
						job.[Number of BLT Today] < 1
				THEN 1
				-- Job neprobìhl kolikrát mìl(4) za pøedchozí den.
				ELSE 2
			END AS Result,
			CASE
				-- 0
				WHEN	job.[Number of BLT Yesterday] >= 4
				THEN	'Blacklists were exported correctly for the previous day.'
				-- 1
				WHEN	job.[Number of BLT Today] < 1 AND job.[Number of BLT Yesterday] >= 4
				THEN	'Scheduler did not generate BLT today'

				ELSE	CONCAT('Number of BLT runs: ', CONVERT(VARCHAR, job.[Number of BLT Yesterday],121))
			END AS 'Message'
		FROM
		(
		SELECT A.[Number of BLT Yesterday], B.[Number of BLT Today]
		FROM
			(
				SELECT 1 AS JI,COUNT(*) AS 'Number of BLT Yesterday',
				[Date]             
				FROM [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Log] WITH (NOLOCK)
				WHERE [Job Scheduler ID] = '160_IMPCZ_BLL' AND [Date] = CAST(GETDATE()-1 as date) AND [Error Description] = ''-- only finished
				group by [Date]
			) A
		FULL OUTER JOIN
			(
				SELECT 1 AS JI,COUNT(*) AS 'Number of BLT Today',
					[Date]                     
				FROM [NAV_PROD].[dbo].[EFEX, a_s_$Job Scheduler Log] WITH (NOLOCK)
				WHERE [Job Scheduler ID] = '160_IMPCZ_BLL' AND [Date] = CAST(GETDATE() as date)  -- only finished
				group by [Date]
			) B
		ON (A.JI = B.JI)
		) job;
	
	IF @fileType = 'TRL' AND @checkType = 'import'
		SELECT
			CASE 
				-- Check importu souboru do EoD
				WHEN	(CAST(GETDATE() as date) = CAST(import.LastImportedFile as date))
				THEN 0
				-- Warning import Current day -1 od 8:00 - 24:00
				WHEN	CAST(GETDATE()-1 as date) = CAST(import.LastImportedFile as date)
						AND
						CAST(GETDATE() as time) >= @trlImpWarningTime
				THEN 1
				-- Soubor nebyl naimportován do 8 ráno druhého dne.
				ELSE 2
			END AS Result,
			CASE
				-- 0
				WHEN	(CAST(GETDATE() as date) = CAST(import.LastImportedFile as date))
				THEN	CONCAT('The last imported file was at: ', CONVERT(VARCHAR, import.LastImportedFile,121))
				-- 1
				WHEN	CAST(GETDATE()-1 as date) = CAST(import.LastImportedFile as date)
						AND
						CAST(GETDATE() as time) >= @trlImpWarningTime
				THEN	CONCAT('The last imported file was at: ', CONVERT(VARCHAR, import.LastImportedFile,121))

				ELSE	CONCAT('The last imported file was at: ', CONVERT(VARCHAR, import.LastImportedFile,121))
			END AS ImportTime
		FROM	( 
					-- Kontrola importu souboru.
					SELECT TOP(1) [Import DateTime] AS LastImportedFile
					FROM [NAV_PROD].[dbo].[Imp CZ - trans_ file (TRL)] WITH (NOLOCK)
					ORDER BY [No_] DESC 
				) import;

	IF @fileType = 'TRL' AND @checkType = 'valid'
		SELECT
			CASE 
				-- Check importu souboru do EoD
				WHEN	(CAST(GETDATE() as date) = CAST(val.LastValidatedFile as date))
				THEN 0
				-- Warning import Current day -1 od 8:00 - 24:00
				WHEN	CAST(GETDATE()-1 as date) = CAST(val.LastValidatedFile as date)
						AND
						CAST(GETDATE() as time) >= @trlValWarningTime
				THEN 1
				-- Soubor nebyl naimportován do 8 ráno druhého dne.
				ELSE 2
			END AS Result,
			CASE
				-- 0
				WHEN	(CAST(GETDATE() as date) = CAST(val.LastValidatedFile as date))
				THEN	CONCAT('Import DateTime: ', CONVERT(VARCHAR, val.LastValidatedFile,121))
				-- 1
				WHEN	CAST(GETDATE()-1 as date) = CAST(val.LastValidatedFile as date)
						AND
						CAST(GETDATE() as time) >= @trlValWarningTime
				THEN	CONCAT('Import DateTime: ', CONVERT(VARCHAR, val.LastValidatedFile,121))
				-- 2
				ELSE	CONCAT('Import DateTime: ', CONVERT(VARCHAR, val.LastValidatedFile,121))
			END AS ImportTime,
			CASE
				-- 0
				WHEN	(CAST(GETDATE() as date) = CAST(val.LastValidatedFile as date))
				THEN	CONCAT('The last validated file was at: ', CONVERT(VARCHAR, val.ValidationTime,121))
				-- 1
				WHEN	CAST(GETDATE()-1 as date) = CAST(val.LastValidatedFile as date)
						AND
						CAST(GETDATE() as time) >= @trlValWarningTime
				THEN	CONCAT('The last validated file was at: ', CONVERT(VARCHAR, val.ValidationTime,121))
				-- 2
				ELSE	CONCAT('The last validated file was at: ', CONVERT(VARCHAR, val.ValidationTime,121))
			END AS ValidationTime
		FROM	( 
					-- Kontrola validace souboru.
					SELECT TOP(1) [Import DateTime] AS LastValidatedFile,
					DATEADD(hh,+1,[Validated DateTime]) AS ValidationTime
					FROM [NAV_PROD].[dbo].[Imp CZ - trans_ file (TRL)] WITH (NOLOCK)
						WHERE [Validated] = 1
						ORDER BY [No_] DESC
				) val;