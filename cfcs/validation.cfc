<cfcomponent>

	<cffunction name="genericValidation" access="public" returntype="Any" hint="Leverages the power of strongly typed DB fields to ensure bullet proof server side validation. Hence shifting the business logic from the presentation layer! Boomshackalacka!">
	
		<cfargument name="ReqList" type="string" required="yes" default="">
		<cfargument name="ErrorList" type="string" required="no" default="">
		
		<cfloop list="#reqList#" index="i">
			
			<cfswitch expression="#Left(i,1)#">

				<!-- String -->
				<cfcase value="s">
					<!--- Need to check if Email here also --->
					<cfif NOT len(trim(Evaluate("FORM." & i)))>
						<cfset ErrorList = ListAppend(ErrorList,i)>
					</cfif>
				</cfcase>

				<!-- Int -->
				<cfcase value="i">
					<cfif NOT isNumeric(Evaluate("FORM." & i))>
						<cfset ErrorList = ListAppend(ErrorList,i)>
					</cfif>
				</cfcase>

				<!-- Boolean -->
				<cfcase value="b">
					<cfif NOT isBoolean(Evaluate("FORM." & i))>
						<cfset ErrorList = ListAppend(ErrorList,i)>
					</cfif>
				</cfcase>

				<!-- Date -->
				<cfcase value="d">
					<cfif NOT isDate(Evaluate("FORM." & i))>
						<cfset ErrorList = ListAppend(ErrorList,i)>
					</cfif>
				</cfcase>

				<!-- Money -->
				<cfcase value="m">
					<cfif NOT isNumeric(Evaluate("FORM." & i))>
						<cfset ErrorList = ListAppend(ErrorList,i)>								
					</cfif>
				</cfcase>

			</cfswitch>

		</cfloop>

		<cfreturn ErrorList>

	</cffunction>
	
	
	<cffunction name="checkDateRange">
		
		<cfargument name="dtStarted" 	required="yes" />
		<cfargument name="dtEnded" 		required="yes" />
		<cfargument name="ErrorList" 	required="no"	type="string"  default="">	
		
			<cfif isDate(arguments.dtStarted) AND isDate(arguments.dtEnded)>						
				<!--- Check if date 2 is after date 1 --->				
				<!--- <cfif DateDiff("n", sDateTimeStarted, sDateTimeEnded) GTE 0> --->
				<cfif DateCompare(arguments.dtStarted, arguments.dtEnded) GTE 0>
					<cfset ErrorList = ListAppend(ErrorList,"dtEnded")>	
				</cfif>				
			</cfif>
		
		<cfreturn ErrorList />
		
	</cffunction>
	
	
	
	
	

	<cffunction name="checkFilled">
		<cfargument name="formField" />
				
		<cfif not isDefined("arguments.formField") or trim(arguments.formfield) eq "">
			<cfreturn false />			
		<cfelse>
			<cfreturn true />		
		</cfif>	
	</cffunction>

	<cffunction name="checkFieldMatch">
		<cfargument name="formField" />		
		<cfargument name="formField2" />		
		<cfif arguments.formField neq arguments.formfield2>
			<cfreturn false />			
		<cfelse>
		 <cfreturn true />		
		</cfif>	
	</cffunction>

	<cffunction name="checkIsNumeric">
		<cfargument name="formField" />		
		<cfargument name="formField2" />
		<cfif not isNumeric(arguments.formField)>
			<cfreturn false />			
		<cfelse>
		 <cfreturn true />		
		</cfif>	
	</cffunction>

	<cffunction name="checkIsEmail">
		<cfargument name="ErrorList" type="string" required="no" default="">
		<cfargument name="formField" />	
		
		<cfif not isValid("email", arguments.formField)>
			<cfset ErrorList = ListAppend(ErrorList,"sEmail")>	
		</cfif>	
		<cfreturn ErrorList />
	</cffunction>	

	<cffunction name="checkFileExtension" output="true">
		<cfargument name="formField" />
		<cfargument name="extension" />		
		
		<cfoutput>#reverse(left(reverse(arguments.formField),4))#</cfoutput><br />
		<cfoutput>#arguments.extension#</cfoutput>
		<cfabort />
		<cfif reverse(left(reverse(arguments.formField),4)) neq arguments.extension>		
			<cfreturn false />			
		<cfelse>
		 <cfreturn true />		
		</cfif>	
	</cffunction>
	
	<cffunction name="checkCaptcha" output="true">
		<cfargument name="sCaptcha" />
		<cfargument name="sCaptchaHash" />
		<cfif hash(arguments.sCaptcha) neq arguments.sCaptchaHash>	
			<cfreturn false />	
		<cfelse>
			 <cfreturn true />
		</cfif>
	</cffunction>
	
	<cffunction name="checkPasswordComplexity" output="true">
		<cfargument name="sPassword" />

		<cfif reFind("^.*(?=.{6,})",arguments.sPassword)>
			<cfreturn true />
			<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
</cfcomponent>