
<cfscript>
	getPlatform = application.objPlatforms.getPlatform();
</cfscript>

<cfset sPageName = "Create Platform">

<cfinclude template="includes/inc_platform_action.cfm">
<cfinclude template="includes/inc_header.cfm">
        

<!-- Example row of columns -->
<div class="row">
	<!-- Tabs -->
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1"><cfoutput>#sPageName#</cfoutput></a></li>
		</ul>
		<div id="tabs-1">
			<cfinclude template="includes/inc_platform_addedit.cfm">
		</div>
	</div>	
</div>


<cfinclude template="includes/inc_footer.cfm">