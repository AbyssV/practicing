USE [X_Debug]
GO
/****** Object:  StoredProcedure [ETL].[A111_Invoice_Detail_MLD_Monthly]    Script Date: 5/13/2020 2:24:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [ETL].[A111_Invoice_Detail_MLD_Monthly]
	--@BatchGUID uniqueidentifier = '00000000-0000-0000-0000-000000000000',
    @PostingStartDate DATE=NULL,
    @PostingEndDate DATE=NULL
AS
    -- Set default date to last month first day and last day
    IF @PostingStartDate IS NULL
        SET @PostingStartDate = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)
    IF @PostingEndDate IS NULL
        SET @PostingEndDate = DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)
    -- Create TMP DB For All Records
    IF object_id('tempdb..#tmp_mld') is not null
    DROP TABLE #tmp_mld
    SELECT [Company],[DocumentNo],[LineNo],[EndUserContactNo],[PostingDate],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],cast(NULL as CHAR(2)) as MLD_OrderType,cast(NULL as date) as MIN_LSD, cast(NULL as date) as MAX_LED, Quantity * SeatsQty as Seats
    INTO #tmp_mld
    FROM [X_Debug].[REV].[Invoice_Detail]
    WHERE 1=1
	AND [PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate
    AND [DocumentType] = 'Posted Invoice'
	AND [MarketSegment] IN ('Enterprise', 'Small')
    AND [ordertype] <> ''

    --AND documentno = 'SPIVT-19020130'
    ----------------------------------------------------
    ------------------Process XR Type-------------------
    ----------------------------------------------------
    DECLARE NType CURSOR FOR 
    select [Company],[DocumentNo],[EndUserContactNo],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[Seats] 
    from #tmp_mld 
    where OrderType <> 'R'
    AND [PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate
    --AND documentno = 'SPIVT-19020130'
    OPEN NType
    DECLARE @Company VARCHAR(20)
            ,@Quantity INT
            ,@SeatsQty INT
            ,@Next_Begin_Date DATE
            ,@MLD_OrderType VARCHAR(2)
            ,@MIN_LSD DATE
            ,@MAX_LED DATE
            ,@DocumentNo VARCHAR(20)
            ,@EndUserContactNo VARCHAR(20)
            ,@OrderType VARCHAR(2)
            ,@ProductID6 CHAR(6)
            ,@TotalSeats INT
            ,@RemainSeats INT
            ,@LicenseStartingDate DATE
            ,@LicenseExpiryDate DATE
            ,@FetchFlag BIT=0
    -- Fetch data for None-R orders
    FETCH NEXT FROM NType INTO @Company,@DocumentNo,@EndUserContactNo,@OrderType,@ProductID6,@Quantity,@SeatsQty,@LicenseStartingDate,@LicenseExpiryDate,@TotalSeats
        WHILE @@fetch_status=0
        BEGIN
            --Init variable ...
    		SET @Next_Begin_Date = DATEADD(dd, 1, @LicenseExpiryDate)
            SET @MIN_LSD = @LicenseStartingDate
            SET @MLD_OrderType = NULL
            --Process  Seats = TotalSeats
            WHILE EXISTS(select * from #tmp_mld where [PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate AND EndUserContactNo=@EndUserContactNo AND ProductID6=@ProductID6 AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date AND MLD_OrderType IS NULL AND Seats=@TotalSeats)
            BEGIN
                --Reset RemainSeats
                SET @RemainSeats = @TotalSeats
    			--Create CURSOR for R Type Orders
    			DECLARE RType CURSOR FOR 
                SELECT [Company],[DocumentNo],[EndUserContactNo],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[Seats]
                FROM #tmp_mld 
                WHERE [PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate AND EndUserContactNo=@EndUserContactNo AND ProductID6=@ProductID6 AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date AND MLD_OrderType IS NULL AND Seats=@TotalSeats
    			OPEN RType
    			DECLARE @NewCompany VARCHAR(20)
                        ,@NewQuantity INT
                        ,@NewSeatsQty INT
                        ,@NewDocumentNo VARCHAR(20)
                        ,@NewEndUserContactNo VARCHAR(20)
                        ,@NewOrderType VARCHAR(2)
                        ,@NewProductID6 CHAR(6)
                        ,@NewLicenseStartingDate DATE
                        ,@NewLicenseExpiryDate DATE
                        ,@NewTotalSeats INT            
                -- Fetch data for R orders
                FETCH NEXT FROM RType INTO @NewCompany,@NewDocumentNo,@NewEndUserContactNo,@NewOrderType,@NewProductID6,@NewQuantity,@NewSeatsQty,@NewLicenseStartingDate,@NewLicenseExpiryDate,@NewTotalSeats
                WHILE @@fetch_status=0
                BEGIN
                    IF (@RemainSeats - @NewTotalSeats>= 0)
                    BEGIN
                        SET @FetchFlag=1
                        SET @RemainSeats = @RemainSeats - @NewTotalSeats
                        SET @MAX_LED = @NewLicenseExpiryDate
                        SET @MLD_OrderType = @OrderType + 'R'
                        UPDATE #tmp_mld SET MLD_OrderType = @MLD_OrderType, MIN_LSD = @MIN_LSD, MAX_LED= '1900-01-01' WHERE CURRENT OF RType
                    END
                    FETCH NEXT FROM RType INTO @NewCompany,@NewDocumentNo,@NewEndUserContactNo,@NewOrderType,@NewProductID6,@NewQuantity,@NewSeatsQty,@NewLicenseStartingDate,@NewLicenseExpiryDate,@NewTotalSeats    
                END
    			CLOSE RType
    			DEALLOCATE RType
                SET @Next_Begin_Date = DATEADD(dd, 1, @NewLicenseExpiryDate)
            END
             --Process  Seats < TotalSeats
            WHILE EXISTS(select * from #tmp_mld where [PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate AND EndUserContactNo=@EndUserContactNo AND ProductID6=@ProductID6 AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date AND MLD_OrderType IS NULL AND Seats<@TotalSeats)
            BEGIN
                --Reset RemainSeats
                SET @RemainSeats = @TotalSeats
    			--Create CURSOR for R Type Orders
    			DECLARE RType CURSOR FOR 
                SELECT [Company],[DocumentNo],[EndUserContactNo],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[Seats]
                FROM #tmp_mld 
                WHERE [PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate AND EndUserContactNo=@EndUserContactNo AND ProductID6=@ProductID6 AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date AND MLD_OrderType IS NULL AND Seats<@TotalSeats
    			OPEN RType
    			-- DECLARE @NewCompany VARCHAR(20)
                --         ,@NewQuantity INT
                --         ,@NewSeatsQty INT
                --         ,@NewDocumentNo VARCHAR(20)
                --         ,@NewEndUserContactNo VARCHAR(20)
                --         ,@NewOrderType VARCHAR(2)
                --         ,@NewProductID6 CHAR(6)
                --         ,@NewLicenseStartingDate DATE
                --         ,@NewLicenseExpiryDate DATE
                --         ,@NewTotalSeats INT            
                -- Fetch data for R orders
                FETCH NEXT FROM RType INTO @NewCompany,@NewDocumentNo,@NewEndUserContactNo,@NewOrderType,@NewProductID6,@NewQuantity,@NewSeatsQty,@NewLicenseStartingDate,@NewLicenseExpiryDate,@NewTotalSeats
                WHILE @@fetch_status=0
                BEGIN
                    IF (@RemainSeats - @NewTotalSeats>= 0)
                    BEGIN
                        SET @FetchFlag=1
                        SET @RemainSeats = @RemainSeats - @NewTotalSeats
                        SET @MAX_LED = @NewLicenseExpiryDate
                        SET @MLD_OrderType = @OrderType + 'R'
                        UPDATE #tmp_mld SET MLD_OrderType = @MLD_OrderType, MIN_LSD = @MIN_LSD, MAX_LED= '1900-01-01' WHERE CURRENT OF RType
                    END
                    FETCH NEXT FROM RType INTO @NewCompany,@NewDocumentNo,@NewEndUserContactNo,@NewOrderType,@NewProductID6,@NewQuantity,@NewSeatsQty,@NewLicenseStartingDate,@NewLicenseExpiryDate,@NewTotalSeats    
                END
    			CLOSE RType
    			DEALLOCATE RType
                SET @Next_Begin_Date = DATEADD(dd, 1, @NewLicenseExpiryDate)
            END
            IF @FetchFlag=1
            BEGIN
                SET @FetchFlag=0
    	        UPDATE #tmp_mld SET MLD_OrderType = @MLD_OrderType, MIN_LSD = @MIN_LSD, MAX_LED = @MAX_LED WHERE CURRENT OF NType
                UPDATE #tmp_mld SET MAX_LED = @MAX_LED WHERE MAX_LED='1900-01-01'
            END
            FETCH NEXT FROM NType INTO @Company,@DocumentNo,@EndUserContactNo,@OrderType,@ProductID6,@Quantity,@SeatsQty,@LicenseStartingDate,@LicenseExpiryDate,@TotalSeats
        END
    CLOSE NType
    DEALLOCATE NType

    ----------------------------------------------------
    ------------------Process RR Type-------------------
    ----------------------------------------------------
    --IF object_id('tempdb..#tmp_mld_R') is not null  
    --DROP TABLE #tmp_mld_R
    IF object_id('tempdb..#tmp_mld_RKEY') is not null  
    DROP TABLE #tmp_mld_RKEY
    ;WITH
    [RDocs]
    AS
    (SELECT EndUserContactNo,ProductID6 FROM  #tmp_mld WHERE [PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate AND ordertype = 'R' AND MLD_OrderType IS NULL group by EndUserContactNo,ProductID6 having count(1)>1 ),
    [ARDocs]
    AS
    (SELECT a.* FROM #tmp_mld a INNER JOIN [RDocs] b ON a.ordertype = 'R' AND a.MLD_OrderType IS NULL AND a.EndUserContactNo = b.EndUserContactNo AND a.ProductID6 = b.ProductID6)
    SELECT *,RANK() OVER (PARTITION BY EndUserContactNo,ProductID6 ORDER BY [LicenseStartingDate]) AS [RANK]
    INTO #tmp_mld_RKEY
    FROM [ARDocs]

    -- Declare RKEY Cursor
    DECLARE RKEY CURSOR FOR
    SELECT A.Company,A.DocumentNo,A.EndUserContactNo,A.OrderType,A.ProductID6,A.Quantity,A.SeatsQty,A.LicenseStartingDate,A.LicenseExpiryDate,A.Seats
    FROM [#tmp_mld] A 
    INNER JOIN #tmp_mld_RKEY B 
    ON B.[RANK] = 1 AND A.MLD_OrderType IS NULL AND A.[Company]=B.[Company] AND A.[DocumentNo] = B.[DocumentNo] AND A.[LineNo]=B.[LineNo]
    OPEN RKEY
    DECLARE @Company_R VARCHAR(20)
            ,@Quantity_R INT
            ,@SeatsQty_R INT
            ,@Next_Begin_Date_R DATE
            ,@MLD_OrderType_R VARCHAR(2)
            ,@MIN_LSD_R DATE
            ,@MAX_LED_R DATE
            ,@DocumentNo_R VARCHAR(20)
            ,@LineNo_R INT
            ,@EndUserContactNo_R VARCHAR(20)
            ,@OrderType_R VARCHAR(2)
            ,@ProductID6_R CHAR(6)
            ,@TotalSeats_R INT
            ,@RemainSeats_R INT
            ,@LicenseStartingDate_R DATE
            ,@LicenseExpiryDate_R DATE
            ,@FetchFlag_R BIT=0
    FETCH NEXT FROM RKEY INTO @Company_R,@DocumentNo_R,@EndUserContactNo_R,@OrderType_R,@ProductID6_R,@Quantity_R,@SeatsQty_R,@LicenseStartingDate_R,@LicenseExpiryDate_R,@TotalSeats_R
        WHILE @@fetch_status=0
        BEGIN
            --Init variable ...
    		SET @Next_Begin_Date_R = DATEADD(dd, 1, @LicenseExpiryDate_R)
            SET @MIN_LSD_R = @LicenseStartingDate_R
            SET @MLD_OrderType_R = NULL
             --Process  Seats = TotalSeats
            WHILE EXISTS(SELECT * FROM #tmp_mld where EndUserContactNo=@EndUserContactNo_R AND ProductID6=@ProductID6_R AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date_R AND MLD_OrderType IS NULL AND Seats=@TotalSeats_R)
            BEGIN
                --Reset RemainSeats
                SET @RemainSeats_R = @TotalSeats_R
    			DECLARE RSUBKEY CURSOR FOR SELECT [Company],[DocumentNo],[EndUserContactNo],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[Seats]
                FROM #tmp_mld 
                WHERE EndUserContactNo=@EndUserContactNo_R AND ProductID6=@ProductID6_R AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date_R AND MLD_OrderType IS NULL AND Seats=@TotalSeats_R
    			OPEN RSUBKEY
                DECLARE @NewCompany_R VARCHAR(20)
                        ,@NewQuantity_R INT
                        ,@NewSeatsQty_R INT
                        ,@NewDocumentNo_R VARCHAR(20)
                        ,@NewEndUserContactNo_R VARCHAR(20)
                        ,@NewOrderType_R VARCHAR(2)
                        ,@NewProductID6_R CHAR(6)
                        ,@NewLicenseStartingDate_R DATE
                        ,@NewLicenseExpiryDate_R DATE
                        ,@NewTotalSeats_R INT
                FETCH NEXT FROM RSUBKEY INTO @NewCompany_R,@NewDocumentNo_R,@NewEndUserContactNo_R,@NewOrderType_R,@NewProductID6_R,@NewQuantity_R,@NewSeatsQty_R,@NewLicenseStartingDate_R,@NewLicenseExpiryDate_R,@NewTotalSeats_R
                WHILE @@fetch_status=0
                BEGIN
                    IF (@RemainSeats_R - @NewTotalSeats_R>= 0)
                    BEGIN
                        SET @FetchFlag_R=1
                        SET @RemainSeats_R = @RemainSeats_R - @NewTotalSeats_R
                        SET @MAX_LED_R = @NewLicenseExpiryDate_R
                        SET @MLD_OrderType_R = 'RR'
                        update #tmp_mld set MLD_OrderType = @MLD_OrderType_R, MIN_LSD = @MIN_LSD_R, MAX_LED= '1900-01-01' WHERE CURRENT OF RSUBKEY
                    END
                    FETCH NEXT FROM RSUBKEY INTO @NewCompany_R,@NewDocumentNo_R,@NewEndUserContactNo_R,@NewOrderType_R,@NewProductID6_R,@NewQuantity_R,@NewSeatsQty_R,@NewLicenseStartingDate_R,@NewLicenseExpiryDate_R,@NewTotalSeats_R
                END
    			CLOSE RSUBKEY
    			DEALLOCATE RSUBKEY
                SET @Next_Begin_Date_R = DATEADD(dd, 1, @NewLicenseExpiryDate_R)
            END
            --Process  Seats < TotalSeats
            WHILE EXISTS(SELECT * FROM #tmp_mld where EndUserContactNo=@EndUserContactNo_R AND ProductID6=@ProductID6_R AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date_R AND MLD_OrderType IS NULL AND Seats<@TotalSeats_R)
            BEGIN
                --Reset RemainSeats
                SET @RemainSeats_R = @TotalSeats_R
    			DECLARE RSUBKEY CURSOR FOR SELECT [Company],[DocumentNo],[EndUserContactNo],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[Seats]
                FROM #tmp_mld 
                WHERE EndUserContactNo=@EndUserContactNo_R AND ProductID6=@ProductID6_R AND OrderType ='R' AND LicenseStartingDate = @Next_Begin_Date_R AND MLD_OrderType IS NULL AND Seats<@TotalSeats_R
    			OPEN RSUBKEY
                -- DECLARE @NewCompany_R VARCHAR(20)
                --         ,@NewQuantity_R INT
                --         ,@NewSeatsQty_R INT
                --         ,@NewDocumentNo_R VARCHAR(20)
                --         ,@NewEndUserContactNo_R VARCHAR(20)
                --         ,@NewOrderType_R VARCHAR(2)
                --         ,@NewProductID6_R CHAR(6)
                --         ,@NewLicenseStartingDate_R DATE
                --         ,@NewLicenseExpiryDate_R DATE
                --         ,@NewTotalSeats_R INT
                FETCH NEXT FROM RSUBKEY INTO @NewCompany_R,@NewDocumentNo_R,@NewEndUserContactNo_R,@NewOrderType_R,@NewProductID6_R,@NewQuantity_R,@NewSeatsQty_R,@NewLicenseStartingDate_R,@NewLicenseExpiryDate_R,@NewTotalSeats_R
                WHILE @@fetch_status=0
                BEGIN
                    IF (@RemainSeats_R - @NewTotalSeats_R>= 0)
                    BEGIN
                        SET @FetchFlag_R=1
                        SET @RemainSeats_R = @RemainSeats_R - @NewTotalSeats_R
                        SET @MAX_LED_R = @NewLicenseExpiryDate_R
                        SET @MLD_OrderType_R = 'RR'
                        update #tmp_mld set MLD_OrderType = @MLD_OrderType_R, MIN_LSD = @MIN_LSD_R, MAX_LED= '1900-01-01' WHERE CURRENT OF RSUBKEY
                    END
                    FETCH NEXT FROM RSUBKEY INTO @NewCompany_R,@NewDocumentNo_R,@NewEndUserContactNo_R,@NewOrderType_R,@NewProductID6_R,@NewQuantity_R,@NewSeatsQty_R,@NewLicenseStartingDate_R,@NewLicenseExpiryDate_R,@NewTotalSeats_R
                END
    			CLOSE RSUBKEY
    			DEALLOCATE RSUBKEY
                SET @Next_Begin_Date_R = DATEADD(dd, 1, @NewLicenseExpiryDate_R)
            END
            -- Update When Fetch Data Successful
            IF @FetchFlag_R=1
            BEGIN
                SET @FetchFlag_R=0
    	        update #tmp_mld set MLD_OrderType = @MLD_OrderType_R, MIN_LSD = @MIN_LSD_R, MAX_LED = @MAX_LED_R WHERE CURRENT OF RKEY
                update #tmp_mld set MAX_LED = @MAX_LED_R WHERE MAX_LED='1900-01-01'
            END
            FETCH NEXT FROM RKEY INTO @Company_R,@DocumentNo_R,@EndUserContactNo_R,@OrderType_R,@ProductID6_R,@Quantity_R,@SeatsQty_R,@LicenseStartingDate_R,@LicenseExpiryDate_R,@TotalSeats_R
        END
    CLOSE RKEY
    DEALLOCATE RKEY
	----------------------------------------------------------------------
    ------------------Insert Data To INVOICE_DETAIL_MLD-------------------
    ----------------------------------------------------------------------
	IF object_id('REV.INVOICE_DETAIL_MLD')  is null
	BEGIN
	    SELECT [Company],[DocumentNo],[LineNo],[EndUserContactNo],[PostingDate],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[MLD_OrderType],[MIN_LSD],[MAX_LED],cast(NULL as nvarchar(max)) as [Note]
	    INTO REV.INVOICE_DETAIL_MLD
	    FROM #tmp_mld
	    WHERE MLD_OrderType IS NOT NULL
	END
	ELSE
	BEGIN
	    --Delete Records before update.
	    ;WITH
	    [UPDATETEMP]
	    AS
	    (SELECT [Company],[DocumentNo],[LineNo] FROM #tmp_mld WHERE MLD_OrderType IS NOT NULL)
	    Delete A FROM REV.INVOICE_DETAIL_MLD A INNER JOIN [UPDATETEMP] B ON A.[Company]=B.[Company] AND A.[DocumentNo]=B.[DocumentNo] AND A.[LineNo]=B.[LineNo]
	    --Update Records from #TMP_MLD
	    INSERT INTO REV.INVOICE_DETAIL_MLD
		([Company],[DocumentNo],[LineNo],[EndUserContactNo],[PostingDate],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[MLD_OrderType],[MIN_LSD],[MAX_LED])
	    SELECT [Company],[DocumentNo],[LineNo],[EndUserContactNo],[PostingDate],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[MLD_OrderType],[MIN_LSD],[MAX_LED]
	    FROM #tmp_mld
	    WHERE MLD_OrderType IS NOT NULL
	END
	----CR MEMO Process
	--Drop #tmp_mld_crmemo temp DB.
	IF object_id('tempdb..#tmp_mld_crmemo') is not null  
	DROP TABLE #tmp_mld_crmemo
	;With
	[CRMEMO]
	AS
	(select * from [REV].[Sales Cr_Memo] where [ORIGINAL invoice number]<>''),
	[INVJOINCRMEMO]
	AS
	(
	Select A.[Company]
	,A.[DocumentNo]
	,A.[LineNo]
	,A.[EndUserContactNo]
	,A.[PostingDate]
	,A.[OrderType]
	,A.[ProductID6]
	,A.[Quantity]
	,A.[SeatsQty]
	,A.[LicenseStartingDate]
	,A.[LicenseExpiryDate]
	,B.[Document No_]
	,B.[Line No_]
	FROM [REV].[Invoice_Detail] A INNER JOIN [CRMEMO] B
	ON A.[Company]=B.[Company]
	AND A.[DOCUMENTNO]=B.[Original Invoice Number]
	AND A.[LINENO]=B.[Original Invoice Line No_]
	AND A.[PostingDate] BETWEEN @PostingStartDate AND @PostingEndDate
	)
	SELECT A.[Company],A.[Document No_] AS [DocumentNo],A.[Line No_] AS [LineNo],A.[EndUserContactNo],A.[PostingDate],A.[OrderType],A.[ProductID6],A.[Quantity],A.[SeatsQty],A.[LicenseStartingDate],A.[LicenseExpiryDate],B.[MLD_ORDERTYPE],B.[MIN_LSD],B.[MAX_LED]
	INTO #tmp_mld_crmemo
	FROM [INVJOINCRMEMO] A
	inner join [REV].[INVOICE_DETAIL_MLD] B
	ON A.[Company] = B.[Company]
	AND A.[DocumentNo]=B.[DocumentNo]
	AND A.[LineNo]=B.[LineNo]
	--Deletes the data to be inserted 
	Delete A FROM REV.INVOICE_DETAIL_MLD A INNER JOIN #tmp_mld_crmemo B ON A.[Company]=B.[Company] AND A.[DocumentNo]=B.[DocumentNo] AND A.[LineNo]=B.[LineNo]
	--Insert data from #tmp_mld_crmemo
	INSERT INTO REV.INVOICE_DETAIL_MLD
	([Company],[DocumentNo],[LineNo],[EndUserContactNo],[PostingDate],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[MLD_OrderType],[MIN_LSD],[MAX_LED])
	SELECT [Company],[DocumentNo],[LineNo],[EndUserContactNo],[PostingDate],[OrderType],[ProductID6],[Quantity],[SeatsQty],[LicenseStartingDate],[LicenseExpiryDate],[MLD_OrderType],[MIN_LSD],[MAX_LED]
	FROM #tmp_mld_crmemo