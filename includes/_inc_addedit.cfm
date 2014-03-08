
<cfparam name="URL.iIncidentID" default="0">

<cfparam name="FORM.dtDateStarted" default="">
<cfparam name="FORM.tmDateStarted" default="">
<cfparam name="FORM.dtDateEnded" default="">
<cfparam name="FORM.tmDateEnded" default="">
<cfparam name="FORM.iPlatformID" default="">
<cfparam name="FORM.iImpact" default="">
<cfparam name="FORM.sIncidentDetails" default="">

<cfscript>

	// Get FORM Data
	if (URL.iIncidentID)
		{			
		writeDump("Here");
		abort();
	    qGetData = application.objIncidents.getIncident(URL.iIncidentID);
	    
	    FORM.dtDateStarted 		= DateFormat(qGetData.dtDateStarted, application.sDateFormat);
	    FORM.tmDateStarted 		= DateFormat(qGetData.dtDateStarted,"HH:mm");
	    FORM.dtDateEnded 			= DateFormat(qGetData.dtDateEnded, application.sDateFormat);
	    FORM.tmDateEnded			= DateFormat(qGetData.dtDateEnded,"HH:mm");
	    FORM.iPlatformID 			= qGetData.iPlatformID;
	    FORM.iImpact 				= qGetData.iImpact;
	    FORM.sIncidentDetails		= qGetData.sIncidentDetails;
		};
</cfscript>
<cfabort />
<div class="container">	
	<cfoutput>
	<form action="incidents.cfm?iIncidentID=#URL.iIncidentID###tabs-3" method="post">
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Incident Start</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-2"><input type="text" id="dtDateStarted" name="dtDateStarted" class="form-control" value="#FORM.dtDateStarted#" placeholder="#application.sDateFormat#"></div>
			<div class="col-lg-2"><input type="text" id="tmDateStarted" name="tmDateStarted" class="form-control" value="#FORM.tmDateStarted#" placeholder="#application.sTimeFormat#"></div>
			<div class="col-lg-5"><!--- Validation comments... ---><cfdump var="#FORM#"></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Incident End</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-2"><input type="text" id="dtDateEnded" name="dtDateEnded" class="form-control" value="#FORM.dtDateEnded#" placeholder="#application.sDateFormat#"></div>
			<div class="col-lg-2"><input type="text" id="tmDateEnded" name="tmDateEnded" class="form-control" value="#FORM.tmDateEnded#" placeholder="#application.sTimeFormat#"></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Platform</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-4">
				<cfscript>
				    getPlatforms = application.objPlatforms.getPlatforms(); // writeDump(getPlatforms);
				</Cfscript>
				<select name="iPlatformID" class="form-control">
					<option value="0">Any Platform</option>
					<cfloop query="getPlatforms">
						<option value="#iPlatformID#" <cfif FORM.iPlatformID EQ iPlatformID> selected</cfif>>#sPlatform#</option>
					</cfloop>
				</select>
			</div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Impact</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-1"><input type="text" name="iImpact" class="form-control" value="#FORM.iImpact#" placeholder="Mins"></div>
			<div class="col-lg-8"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Details</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-4"><textarea rows="4" name="sIncidentDetails" class="form-control" placeholder="Incident description...">#FORM.sIncidentDetails#</textarea></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">&nbsp;</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-4">
			<cfif iIncidentID>
				<input type="hidden" name="sAction" value="Update">
				<input type="hidden" name="iIncidentID" value="#URL.iIncidentID#">
				<input type="submit" name="Update" value="Update Incident" class="form-control btn btn-primary">
			<cfelse>
				<input type="hidden" name="sAction" value="Create">
				<input type="submit" name="Create" value="Create Incident" class="form-control btn btn-primary">
			</cfif>
			</div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
	</form>
	</cfoutput>
</div>