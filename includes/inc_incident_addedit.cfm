
<cfparam name="iIncidentID" default="0">
<cfparam name="VARIABLES.ErrorList" default="1">

<cfparam name="FORM.dStarted" default="">
<cfparam name="FORM.tStarted" default="">
<cfparam name="FORM.dEnded" default="">
<cfparam name="FORM.tEnded" default="">

<cfparam name="FORM.iPlatformID" default="">
<cfparam name="FORM.iTotalMinutes" default="">
<cfparam name="FORM.iImpact" default="0">
<cfparam name="FORM.sIncidentDetails" default="">

<cfscript>
	// writeDump(FORM);
	
	if (iIncidentID) 
		{
	    qGetData = application.objIncidents.getIncident(iIncidentID); // writeDump(qGetData);
	    
	    FORM.dStarted 			= DateFormat(qGetData.dtDateStarted, application.sDateFormat);
	    FORM.tStarted 			= TimeFormat(qGetData.dtDateStarted,"HH:mm");
	    FORM.dEnded 			= DateFormat(qGetData.dtDateEnded, application.sDateFormat);
	    FORM.tEnded				= TimeFormat(qGetData.dtDateEnded,"HH:mm");
	    FORM.iPlatformID 		= qGetData.iPlatformID;
	    FORM.iTotalMinutes 		= qGetData.iTotalMinutes;
	    FORM.iImpact 			= qGetData.iImpact;
	    FORM.sIncidentDetails	= qGetData.sIncidentDetails;
		};
</cfscript>

<div class="container">	
	<cfoutput>
	<form action="?##tabs-3" method="post">
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Total Outage (Mins)</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-2"><input type="text" name="iTotalMinutes" class="form-control" value="#FORM.iTotalMinutes#" readonly></div>
			<div class="col-lg-7"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Incident Start</div>
			<div class="col-lg-1" style="text-align:right">*</div>
			<div class="col-lg-2 <cfif ListFind(VARIABLES.ErrorList,'dtStarted')>has-error</cfif>"><input type="text" id="dStarted" name="dStarted" class="form-control" value="#FORM.dStarted#" placeholder="#application.sDateFormat#"></div>
			<div class="col-lg-2 <cfif ListFind(VARIABLES.ErrorList,'dtStarted')>has-error</cfif>"><input type="text" id="tStarted" name="tStarted" class="form-control" value="#FORM.tStarted#" placeholder="#application.sTimeFormat#"></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Incident End</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-2 <cfif ListFind(VARIABLES.ErrorList,'dEnded')>has-error</cfif>"><input type="text" id="dEnded" name="dEnded" class="form-control" value="#FORM.dEnded#" placeholder="#application.sDateFormat#"></div>
			<div class="col-lg-2 <cfif ListFind(VARIABLES.ErrorList,'tEnded')>has-error</cfif>"><input type="text" id="tEnded" name="tEnded" class="form-control" value="#FORM.tEnded#" placeholder="#application.sTimeFormat#"></div>
			<div class="col-lg-5"><cfif ListFind(VARIABLES.ErrorList,'dtEnded')><p class="text-danger">This date/time must be after the start date/time</p></cfif><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2 has-error">Platform</div>
			<div class="col-lg-1" style="text-align:right">*</div>
			<div class="col-lg-4 <cfif ListFind(VARIABLES.ErrorList,'iPlatformID')>has-error</cfif>">				
				<cfscript>
				    // getPlatforms = application.objPlatforms.getPlatforms();
				    arrPlatforms = application.objPlatforms.getPlatformTree(); // writeDump(getPlatforms);
				</Cfscript>
				<select name="iPlatformID" class="form-control">
					<option value="">Any Platform</option>
					<cfloop from="1" to="#ArrayLen(arrPlatforms)#" index="p">
						<option value="#arrPlatforms[p][1]#" <cfif NOT arrPlatforms[p][3]>disabled="yes"</cfif><cfif FORM.iPlatformID EQ arrPlatforms[p][1]> selected</cfif>>
							<cfif arrPlatforms[p][3]>&nbsp;&nbsp;&nbsp;</cfif>#arrPlatforms[p][2]#
						</option>						
					</cfloop>
				</select>
			</div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Impact (%)</div>
			<div class="col-lg-1" style="text-align:right">*</div>
			<div class="col-lg-1 <cfif ListFind(VARIABLES.ErrorList,'iImpact')>has-error</cfif>"><input type="text" name="iImpact" class="form-control" value="#FORM.iImpact#" placeholder="0"></div>
			<div class="col-lg-8"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Details</div>
			<div class="col-lg-1" style="text-align:right">*</div>
			<div class="col-lg-4 <cfif ListFind(VARIABLES.ErrorList,'sIncidentDetails')>has-error</cfif>"><textarea rows="4" name="sIncidentDetails" class="form-control" placeholder="Incident description...">#FORM.sIncidentDetails#</textarea></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">&nbsp;</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<cfif iIncidentID>
				<div class="col-lg-2">
					<input type="hidden" name="sAction" value="Update">
					<input type="hidden" name="iIncidentID" value="#iIncidentID#">
					<input type="submit" name="Update" value="Update Incident" class="form-control btn btn-primary">
					</form>
				</div>
				<div class="col-lg-2">
					<form action="?##tabs-1" method="post">
						<input type="hidden" name="sAction" value="Delete">
						<input type="hidden" name="iIncidentID" value="#iIncidentID#">
						<input type="submit" name="Delete" value="Delete Incident" class="form-control btn btn-danger">
					</form>
				</div>
			<cfelse>
				<div class="col-lg-4">
					<input type="hidden" name="sAction" value="Create">
					<input type="submit" name="Create" value="Create Incident" class="form-control btn btn-primary">
					</form>
				</div>
			</cfif>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
	</cfoutput>
</div>