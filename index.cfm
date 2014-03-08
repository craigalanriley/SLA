
<cfparam name="currentMonth" default="0">
<cfset previousMonth 	= Evaluate(currentMonth-1)>

<cfset dCurrent 		= DateAdd("m", currentMonth, now())>
<cfset dCurrent 		= DateFormat(dCurrent, "dd mmmm yyyy")>
<cfset sCurrentSLADate	= right(dCurrent, evaluate(len(dCurrent)-3))>

<cfset dPrevious 		= DateAdd("m", previousMonth, now())>
<cfset sPreviousSLADate	= right(DateFormat(dPrevious, "dd mmm yy"), 7)>

<cfset sPageName = "Dashboard">

<cfinclude template="includes/inc_header.cfm">

<br />
<div class="row" style="text-align:margin-left:auto; margin-right:auto">
	<div class="col-lg-4"></div>
    <div class="col-lg-4">
        <ul class="pager">
            <cfoutput>
                <li class="previous"><a href="?currentMonth=#Evaluate(currentMonth-1)#">&larr; Older</a></li>
               <li style="font-weight:bold; font-size:18px; color: ##666666">#sCurrentSLADate#</li>
               <li class="next <cfif currentMonth EQ 0>disabled</cfif>"><a href="?currentMonth=#Evaluate(currentMonth+	1)#">Newer &rarr;</a></li>
           </cfoutput>
        </ul>
    </div>
    <div class="col-lg-4"></div>
</div>
<table class="table table-hover" id="testTable">
<cfoutput>
<thead>
	<tr style="color: ##FFFFFF; background-color: ##AAAAAA" class="info">
		<th><strong>Platform</strong></th>
		<th><strong>Previous SLA</strong></th>
		<th><strong>Current SLA</strong></th>
		<th><strong>Current Outage</strong></th>
		<th>&nbsp;</th>
	</tr>
</thead>
</cfoutput>
<tbody>
<cfscript>
	getAllPlatforms = application.objPlatforms.getAllPlatforms(iParentID=0,isActive=1); // writeDump(getAllPlatforms);
</cfscript>
<cfoutput query="getAllPlatforms">
	<cfset nCurrPercent 		= application.objPlatforms.getCurrentSLA(iPlatformID,currentMonth)>
	<cfset nPrevPercent 		= application.objPlatforms.getCurrentSLA(iPlatformID,previousMonth)>
	<cfset sCurrClass 			= application.objFormat.getPercentClass(nCurrPercent)>
	<cfset sPrevClass 			= application.objFormat.getPercentClass(nPrevPercent)>
	<cfset sMonthsTotalOutage 	= application.objPlatforms.getMonthsTotalOutage(iPlatFormID,currentMonth)>
	<cfscript>
		iIncidentCount = application.objIncidents.getIncidentCount(iPlatFormID, iParentID); // writeDump(iIncidentCount);
	</cfscript>
    <tr class="priRow">
        <td width="20%" style="vertical-align: middle !important;"><a href="##">#sPlatform#</a></td>
        <td width="20%" style="vertical-align: middle !important;" class="#sPrevClass#">#nPrevPercent# % </td>
        <td width="20%" style="vertical-align: middle !important;" class="#sCurrClass#">#nCurrPercent# % </td>
        <td width="20%" style="vertical-align: middle !important;">#sMonthsTotalOutage# mins</td>
        <td width="20%" style="vertical-align: middle !important;" align="right">
			<a href="incidents.cfm?iSearchPlatformID=#iPlatformID#">
				<button class="btn btn-xs btn-primary" type="button" style="width: 135px; margin:3px; text-align: left; padding: 3px 0 3px 10px !important">
					View Incidents <span class="badge" style="background-color: white; color: ##2D6CA2 ">#iIncidentCount#</span>
				</button>
			</a>
        </td>
    </tr>
	<cfscript>
		subPlatforms = application.objPlatforms.getAllPlatforms(iParentID=#iPlatformID#,isActive=1); // writeDump(subPlatforms);
	</cfscript>
	<cfif subPlatforms.RecordCount>
        <cfloop query="subPlatforms">
            <cfset nCurrPercent 		= application.objPlatforms.getCurrentSLA(iPlatformID,currentMonth)>
            <cfset nPrevPercent 		= application.objPlatforms.getCurrentSLA(iPlatformID,previousMonth)>
            <cfset sCurrClass 			= application.objFormat.getPercentClass(nCurrPercent)>
            <cfset sPrevClass 			= application.objFormat.getPercentClass(nPrevPercent)>	
            <cfset sMonthsTotalOutage 	= application.objPlatforms.getMonthsTotalOutage(iPlatFormID,currentMonth)>				
            <cfscript>
                iIncidentCount = application.objIncidents.getIncidentCount(iPlatFormID, iParentID); // writeDump(iIncidentCount);
            </cfscript>
            <tr class="secRow">
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#sPlatform#</td>
                <td class="#sPrevClass#">#nPrevPercent# % </td>
                <td class="#sCurrClass#">#nCurrPercent#</td>
                <td>#sMonthsTotalOutage# mins</td>
                <td align="right">											
                    <a href="incidents.cfm?iSearchPlatformID=#iPlatformID#">
                        <button class="btn btn-xs btn-primary" type="button" style="width: 135px; margin:3px; text-align: left; padding: 3px 0 3px 10px !important">
                            View Incidents <span class="badge" style="background-color: white; color: ##2D6CA2">#iIncidentCount#</span>
                        </button>
                    </a>
                </td>
            </tr>
      	</cfloop>
    </cfif>
</cfoutput>
</tbody>
</table>
<br/>
<script>
	// Set Active Primary Nav	
	$("#navHome").addClass("active");
	
	// Hide Sub Platforms
	$(".secRow").hide();
	// Show child rows when parent row clicked		
	$(".priRow").click(function()
		{
		$(this).nextUntil('tr.priRow').fadeToggle(400);
		});
</script>

<cfinclude template="includes/inc_footer.cfm">
