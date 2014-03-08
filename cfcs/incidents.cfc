<cfcomponent output="true">

	<cffunction name="getAllIncidents" returntype="any">

		<cfargument name="stForm" type="any" required="no" default="0">
			
			<cfparam name="arguments.stForm.iSearchPlatformID" default="">
			<cfscript>
				var iParentID = 0;
				if (len(arguments.stForm.iSearchPlatformID)){
					iParentID = Application.objPlatforms.getParent(arguments.stForm.iSearchPlatformID); // 				
					};
			</cfscript>

			<cfquery name="qGetIncidents" datasource="#application.DSN#">
				SELECT 	incidents.iIncidentID, incidents.dtDateCreated, incidents.dtDateStarted, incidents.dtDateEnded, incidents.iTotalMinutes, incidents.sIncidentDetails,
					  	platforms.sPlatform
              	FROM 	incidents
              	INNER JOIN platforms ON incidents.iPlatformID = platforms.iPlatformID
				WHERE 1 = 1
				<cfif isDefined("arguments.stForm.sSearchText") AND len(arguments.stForm.sSearchText)>
					AND  incidents.sIncidentDetails LIKE '%#arguments.stForm.sSearchText#%'
				</cfif>
				<cfif isDefined("arguments.stForm.dSearchStarted") AND isDate(arguments.stForm.dSearchStarted)>
					AND  incidents.dtDateStarted > #CreateODBCDateTime(arguments.stForm.dSearchStarted)#
				</cfif>
				<cfif isDefined("arguments.stForm.dSearchEnded") AND isDate(arguments.stForm.dSearchEnded)>
					AND  incidents.dtDateEnded < #CreateODBCDateTime(arguments.stForm.dSearchEnded)#
				</cfif>
				<!---  --->
				<cfif arguments.stForm.iSearchPlatformID GT 0>
					<cfif iParentID>
						<!--- IF parent isn't top level (0) then get all incidents with selected iPlatformID --->
						AND incidents.iPlatformID = <cfqueryparam value="#arguments.stForm.iSearchPlatformID#" cfsqltype="cf_sql_integer">
					<cfelse>
						<!--- If parent is null it's top level and therefore doesn' have direct incidents so get incidents with matching parent --->
						AND platforms.iParentID = <cfqueryparam value="#arguments.stForm.iSearchPlatformID#" cfsqltype="cf_sql_integer">
					</cfif>
				</cfif>
             	ORDER BY iIncidentID DESC
			</cfquery>				

		<cfreturn qGetIncidents />

	</cffunction>
	
	<cffunction name="getIncidentCount" returntype="any">
		<cfargument name="iPlatformID" 	type="numeric" required="yes">
		<cfargument name="iParentID" 	type="numeric" required="yes">

			<!--- If Platform is top level we need to count all child incidents, else just count sub platform incidents  --->
			<cfquery name="qIncidentCount" datasource="#application.DSN#">
				SELECT 	count(iIncidentID) AS iTotalIncidents
				FROM 	incidents
				<cfif arguments.iParentID EQ 0>
					INNER JOIN platforms ON incidents.iPlatformID = platforms.iPlatformID
					WHERE platforms.iParentID = <cfqueryparam value="#arguments.iPlatformID#" cfsqltype="cf_sql_integer">
				<cfelse>
					WHERE 	incidents.iPlatformID = <cfqueryparam value="#arguments.iPlatformID#" cfsqltype="cf_sql_integer">
				</cfif>
			</cfquery>

		<cfreturn qIncidentCount.iTotalIncidents />
	</cffunction>


	<cffunction name="getIncident" returntype="any">
		<cfargument name="iIncidentID" type="numeric" required="yes" default="0">

			<cfquery name="qGetIncident" datasource="#application.DSN#">
				SELECT 	*
				FROM incidents
				WHERE iIncidentID = <cfqueryparam value="#arguments.iIncidentID#" cfsqltype="cf_sql_integer">
			</cfquery>

		<cfreturn qGetIncident />
	</cffunction>


	<cffunction name="createIncident" returntype="any">
		<cfargument name="stForm" type="any" required="yes">

			<cfscript>
				// Calc total outage time in minutes if both dates valid				
				var iTotalMinutes	= 0;
				if (isDate(arguments.stForm.dtEnded))
					{	
					iTotalMinutes = calcTotalMinutes(arguments.stForm.dtStarted, arguments.stForm.dtEnded); 
					};									
			</cfscript>
			
			<cftransaction>
				<cfquery name="qCreateIncident" datasource="#application.DSN#">
					INSERT INTO incidents(dtDateCreated, dtDateStarted, dtDateEnded, iPlatformID, iTotalMinutes, iImpact, sIncidentDetails)
					VALUES(	<cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" value="#now()#">,
							<cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" value="#arguments.stForm.dtStarted#">,
							<cfif isDate(arguments.stForm.dtEnded)>	
								<cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" value="#arguments.stForm.dtEnded#">,
							<cfelse>
								<cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" null="yes">,
							</cfif>
							<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.stForm.iPlatformID#">,
							<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#iTotalMinutes#">,
							<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.stForm.iImpact#">,					
							<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.stForm.sIncidentDetails#">)
				</cfquery>
				<cfquery name="qGetNewID" datasource="#application.DSN#">
					SELECT max(iIncidentID) AS iIncidentID
					FROM incidents
				</cfquery>
			</cftransaction>

		<cfreturn qGetNewID.iIncidentID />
	</cffunction>


	<cffunction name="updateIncident" returntype="any">		
		<cfargument name="stForm" type="any" required="yes">
		
			<cfscript>
				// Calc total outage time in minutes if both dates valid				
				var iTotalMinutes	= 0;
				if (isDate(arguments.stForm.dtEnded))
					{	
					iTotalMinutes = calcTotalMinutes(arguments.stForm.dtStarted, arguments.stForm.dtEnded); 
					};									
			</cfscript>			
			<cfquery name="qUpdateIncident" datasource="#application.DSN#">
				UPDATE 	incidents
				SET 	dtDateStarted 		= <cfqueryparam value="#dtStarted#" CFSQLType="CF_SQL_TIMESTAMP">,
						<cfif isDate(arguments.stForm.dtEnded)>	
							dtDateEnded		= <cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" value="#arguments.stForm.dtEnded#">,							
						<cfelse>
							dtDateEnded		= <cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" null="yes">,
						</cfif>
						iPlatformID 		= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.stForm.iPlatformID#">,
						iTotalMinutes		= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#iTotalMinutes#">,
						iImpact				= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#iImpact#">,
						sIncidentDetails	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.stForm.sIncidentDetails#">
				WHERE	iIncidentID			= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#iIncidentID#">
			</cfquery>
			
		<cfreturn />	
	</cffunction>
	
	<cffunction name="calcTotalMinutes" returntype="numeric">	
		<cfargument name="dtStarted" 	type="date" 	required="yes">
		<cfargument name="dtEnded" 		type="date" 	required="yes">
						
           	<cfscript>				
				var iTotalMinutes = 0; // writeDump("calcTotalMinutes");           		
           	</cfscript>			
			<cfset iTotalMinutes = DateDiff("n", arguments.dtStarted, arguments.dtEnded)>
	
		<cfreturn iTotalMinutes />	
	</cffunction>


	<cffunction name="deleteIncident" returntype="any">	
		<cfargument name="iIncidentID" type="numeric" required="yes">
			<cfquery name="qDeleteIncident" datasource="#application.DSN#">
				DELETE FROM incidents
				WHERE iIncidentID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.iIncidentID#">
			</cfquery>
		<cfreturn />
	</cffunction>

</cfcomponent>