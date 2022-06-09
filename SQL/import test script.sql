DECLARE @ctroImpWarningTime time
DECLARE @DatumImportu date
DECLARE @CasImportu time
DECLARE @CurrentTime time

SET @ctroImpWarningTime='08:00:00.0000000'

--testovac� prom�nn�
SET @DatumImportu='2019-11-11' --date of import
SET @CasImportu='09:00:00.0000000' --time of import
SET @CurrentTime='07:00:00.0000000' -- nastaven� aktu�ln�ho �asu

	SELECT
		CASE 
			-- Check importu souboru do EoD
			WHEN	(CAST(GETDATE() as date) = @DatumImportu)
					
			THEN 0

			-- Warning import Current day -1 od 8:00 - 24:00
			WHEN	CAST(GETDATE()-1 as date) = @DatumImportu
					AND
					@CurrentTime >= @ctroImpWarningTime
			THEN 1

			-- Soubor nebyl naimportov�n do 8 r�no druh�ho dne.
			ELSE 2
		END AS Result