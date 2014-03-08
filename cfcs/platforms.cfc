<cfcomponent output="true">
	
	<cffunction name="getParent" returntype="any">
		<cfargument name="iPlatformID" 	type="any" required="yes">

			<cfquery name="qGetParent" datasource="#application.DSN#">
				SELECT 	iParentID
				FROM 	platforms
				WHERE 	iPlatformID = <cfqueryparam value="#arguments.iPlatformID#" cfsqltype="cf_sql_integer">
			</cfquery>

		<cfreturn qGetParent.iParentID />
	</cffunction>

	<!---  --->
	<cffunction name="getAllPlatforms" returntype="any">
		<cfargument name="iParentID" 	type="any" required="no" default="">
		<cfargument name="isActive" 	type="boolean" required="no" default="0">

			<cfquery name="qGetAllPlatforms" datasource="#application.DSN#">
				SELECT iPlatformID, iParentID, sPlatform, iStatus
				FROM platforms
				WHERE 1= 1
				<cfif len(arguments.iParentID)>
					AND iParentID = <cfqueryparam value="#arguments.iParentID#" cfsqltype="cf_sql_integer">
				</cfif>	
				<cfif arguments.isActive>
					AND iStatus = 1
				</cfif>	
			</cfquery>

		<cfreturn qGetAllPlatforms />
	</cffunction>

	<!--- Return Platforms as Tree Structure for select list  --->
	<cffunction name="getPlatformTree" returntype="any">
		<cfargument name="iStatus" type="boolean" required="no" default="0">	

			<cfscript>
				var x = 1;
				var arrPlatformTree = arrayNew(2);
				var qPlatforms = getAllPlatforms(0);
			</cfscript>
			<cfloop query="qPlatforms">
				<cfscript>
					arrPlatformTree[x][1] 	= qPlatforms.iPlatformID;
					arrPlatformTree[x][2] 	= qPlatforms.sPlatform;
					arrPlatformTree[x][3] 	= qPlatforms.iParentID;
					arrPlatformTree[x][4] 	= qPlatforms.iStatus;
					// Increment count
					x = x + 1;
					// Get Child Platforms
					var qSubPlatforms = getAllPlatforms(qPlatforms.iPlatformID);
				</cfscript>
				<cfloop query="qSubPlatforms">
					<cfscript>
						arrPlatformTree[x][1] 	= qSubPlatforms.iPlatformID;
						arrPlatformTree[x][2] 	= qSubPlatforms.sPlatform;
						arrPlatformTree[x][3] 	= qSubPlatforms.iParentID;
						arrPlatformTree[x][4] 	= qSubPlatforms.iStatus;			
						// Increment count
						x = x + 1;				
					</cfscript>
				</cfloop>
			</cfloop>
						
		<cfreturn arrPlatformTree />	
	</cffunction>

	<cffunction name="getPlatform" returntype="any">
		<cfargument name="iPlatformID" type="numeric" required="yes" default="0">

			<cfquery name="qGetPlatform" datasource="#application.DSN#">
				SELECT 	*
				FROM platforms
				WHERE iPlatformID = <cfqueryparam value="#arguments.iPlatformID#" cfsqltype="cf_sql_integer">
			</cfquery>

		<cfreturn qGetPlatform />
	</cffunction>
	
	<cffunction name="createPlatform" returntype="any">
		<cfargument name="stForm" type="any" required="yes">
			
			<cftransaction>
				<cfquery name="qCreatePlatform" datasource="#application.DSN#">
					INSERT INTO platforms(sPlatform, iParentID, iStatus)
					VALUES	(
							<cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#arguments.stForm.sPlatform#">,		
							<cfqueryparam CFSQLType="CF_SQL_INTEGER" 	value="#arguments.stForm.iParentID#">,
							<cfqueryparam CFSQLType="CF_SQL_BIT" 		value="#arguments.stForm.iStatus#">
							)
				</cfquery>
				<cfquery name="qGetNewID" datasource="#application.DSN#">
					SELECT max(iPlatformID) AS iPlatformID
					FROM platforms
				</cfquery>
			</cftransaction>

		<cfreturn qGetNewID.iPlatformID />
	</cffunction>


	<cffunction name="updatePlatform" returntype="any">		
		<cfargument name="stForm" type="any" required="yes">
				
			<cfquery name="qUpdateIncident" datasource="#application.DSN#">
				UPDATE 	platforms
				SET 	sPlatform 			= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#arguments.stForm.sPlatform#">,
						iParentID			= <cfqueryparam CFSQLType="CF_SQL_INTEGER" 	value="#iParentID#">,
						iStatus				= <cfqueryparam CFSQLType="CF_SQL_BIT" 		value="#iStatus#">
				WHERE	iPlatformID			= <cfqueryparam CFSQLType="CF_SQL_INTEGER" 	value="#iPlatformID#">
			</cfquery>
			
		<cfreturn />	
	</cffunction>

	<cffunction name="getMonthsTotalMinutes" returntype="numeric" output="true">
		<cfargument name="iMonthOffSet" type="any" required="no" default="0">

		<cfscript>

			var iTotalMinutes 				= 0;
			var currentDate					= now();

			if (arguments.iMonthOffSet == 0) // If offset is 0 then calc based on current day of month
				{
				var currentDay 				= Day(currentDate);
				var currentMonth 			= Month(currentDate);
				var currentYear 			= Year(currentDate);
				var currentHour 			= Hour(currentDate);
				var currentMinute 			= Minute(currentDate);
				var currentSecond 			= Second(currentDate);

				var currentMonthStart 		= CreateDateTime(currentYear, currentMonth, "01", "00", "00", "00");
				var currentMonthEnd 		= CreateDateTime(currentYear, currentMonth, currentDay, currentHour, currentMinute, currentSecond);

				iTotalMinutes				= DateDiff("n", currentMonthStart, currentMonthEnd);
				}
			else // Else calc the number of minutes in any historical month (current month - offset)
				{
				var offSetDate				= DateAdd("m", iMonthOffSet, currentDate);
				var iTotalDays				= DaysInMonth(offSetDate);

				iTotalMinutes				= Evaluate(iTotalDays * 60 * 24);
				}
		</cfscript>

		<cfreturn iTotalMinutes />
	</cffunction>

	<!-- Calculate SLA -->
	<cffunction name="getCurrentSLA" returntype="numeric">
		<cfargument name="iPlatFormID" 	type="numeric" required="no" default="0">
		<cfargument name="iMonthOffSet" type="numeric" required="no" default="0">

			<cfscript>				
				var iMonthsTotalOutage 		= getMonthsTotalOutage(arguments.iPlatFormID,arguments.iMonthOffSet);
				var iMonthsTotalMinutes 	= getMonthsTotalMinutes(arguments.iMonthOffSet);				
				var iTotalSLA 				= NumberFormat( Evaluate(100-(iMonthsTotalOutage / iMonthsTotalMinutes)*100), "___.__" );	
			</cfscript>
	
		<cfreturn iTotalSLA />	
	</cffunction>
    
    <!--- Calculate Current Months Total Down Time --->
	<cffunction name="getMonthsTotalOutage" returntype="any">	
		<cfargument name="iPlatFormID" 	type="numeric" required="no" default="0">
		<cfargument name="iMonthOffSet" type="numeric" required="no" default="0">
        
        	<cfscript>
				var currentDate	= now();
            	var offSetDate		= DateAdd("m", iMonthOffSet, currentDate);	 
          	</cfscript>

			<!-- Get total downtime for platform -->
			<cfquery name="qGetMonthsTotalOutage" datasource="#application.DSN#">
				SELECT COALESCE(SUM(iTotalMinutes), 0) AS iTotalDowntime	
				FROM incidents
				INNER JOIN platforms ON incidents.iPlatformID = platforms.iPlatformID
				<cfif arguments.iPlatFormID GT 5>
					WHERE platforms.iPlatformID = <cfqueryparam value="#arguments.iPlatformID#" cfsqltype="cf_sql_integer">
				<cfelse>
					WHERE platforms.iParentID = <cfqueryparam value="#arguments.iPlatformID#" cfsqltype="cf_sql_integer">		
				</cfif>
				
				<!--- Add Monthly Date Clause --->
				AND YEAR(dtDateStarted) 	= YEAR(#offSetDate#)
				AND MONTH(dtDateStarted) = MONTH(#offSetDate#)
			</cfquery>
            
		<cfreturn qGetMonthsTotalOutage.iTotalDowntime />	
	</cffunction>

</cfcomponent>