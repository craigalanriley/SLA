<cfcomponent output="true">
	
	<!--- Application name, should be unique --->
	<cfset this.name = "SLA Reporting">
	<!--- How long application vars persist --->
	<cfset this.applicationTimeout = createTimeSpan(0,0,0,0)>
	<!--- Where should cflogin stuff persist --->
	<cfset this.loginStorage = "session">
	<!--- Should we even use sessions? --->
	<cfset this.sessionManagement = true>
	<!--- How long do session vars persist? --->
	<cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
	<!--- Should we set cookies on the browser? --->
	<cfset this.setClientCookies = true>


	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="true">
		<cfscript>  
	  		// Datasource
	  		application.DSN				= "slareporting";
	  		// Login Details
	  		application.sUserName 		= "Amaysim";
	  		application.sPassword 		= "shamazing";
			// Objects
			application.objPlatforms	= CreateObject("cfcs.platforms");
			application.objIncidents	= CreateObject("cfcs.incidents");
			application.objValidation	= CreateObject("cfcs.validation");
			application.objFormat		= CreateObject("cfcs.format");
			// Standardized Date/Time Formats
			application.sDateFormat 	= "yy/mm/dd";
			application.sTimeFormat 	= "hh:mm";
		</cfscript>		
		<cfreturn true>
	</cffunction>

	<!--- Run when application stops --->
	<cffunction name="onApplicationEnd" returnType="void" output="true">
		<cfargument name="applicationScope" required="true">
		
	</cffunction>

	<!--- Fired when user requests a CFM that doesn't exist. --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="true">
		<cfargument name="targetpage" required="true" type="string">
		
		<cfreturn true>
	</cffunction>
	
	<!--- Run before the request is processed --->
	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument name="thePage" type="string" required="true">

			<cfscript>
				// If user not logged in redirect to login page
				if (NOT isDefined("Session.bLoggedIn"))
					{
					// location(url="login.cfm", addtoken=false);
					include "login.cfm";
					abort;
					};
				if (isDefined("URL.bLogOut"))
					{
					StructClear(Session);
					};
				// Logout
					
			</cfscript>

		<cfreturn true>
	</cffunction>

	<!--- Runs at end of request --->
	<cffunction name="onRequestEnd" returnType="void" output="true">
		<cfargument name="thePage" type="string" required="true">
		
		<cfif isDefined("URL.sDump")>
			<cfdump var="#Evaluate(URL.sDump)#">
		</cfif>
		
	</cffunction>

	<!--- Runs on error --->
	<cffunction name="onError" returnType="void" output="true">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
	
			<cfscript>
				// If error redirect to error page
				// location(url="error.cfm", addtoken=false);
				// Log errors if time...				
			</cfscript>			
			<cfdump var="#arguments#">
			
		<cfabort>
	</cffunction>

	<!--- Runs when your session starts --->
	<cffunction name="onSessionStart" returnType="void" output="true">
	</cffunction>

	<!--- Runs when session ends --->
	<cffunction name="onSessionEnd" returnType="void" output="true">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
		
	</cffunction>
	
</cfcomponent>