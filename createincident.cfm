
<cfparam name="iPlatformID" default="0">
<cfparam name="sFreeText" default="">

<cfscript>
	getIncidents = application.objIncidents.getAllIncidents(FORM);
</cfscript>

<cfset sPageName = "Incidents">

<cfinclude template="includes/inc_incident_action.cfm">
<cfinclude template="includes/inc_header.cfm">

<script>
	

</script>
        
<!-- Example row of columns -->
<div class="row">
	<!-- Tabs -->
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">Create Incident</a></li>
		</ul>
		<div id="tabs-1">
			<cfinclude template="includes/inc_incident_addedit.cfm">
		</div>
	</div>	
</div>

<cfinclude template="includes/inc_footer.cfm">