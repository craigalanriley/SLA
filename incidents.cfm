
<cfparam name="iPlatformID" default="0">
<cfparam name="sFreeText" default="">

<cfset sPageName = "Incidents">
<cfif isDefined("URL.iSearchPlatformID")>
	<cfset FORM.iSearchPlatformID = URL.iSearchPlatformID>
</cfif>

<cfinclude template="includes/inc_incident_action.cfm">
<cfinclude template="includes/inc_header.cfm">

<!-- Example row of columns -->
<div class="row">
	<!-- Tabs -->
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">Incidents</a></li>
			<li><a href="#tabs-2">Search</a></li>
           	<cfif isDefined("iIncidentID")>
				<li><a href="#tabs-3">Edit Incident</a></li>
           	</cfif>
		</ul>
		<div id="tabs-1">
			<cfoutput>
         	<table class="table table-hover">
            	<thead>
                	<tr style="color: ##666666">
                       <!--- <th>#UCase("Date Created")#</th> --->
                       <th>#UCase("Start Time")#</th>
                       <th>#UCase("End Time")#</th>
                       <th>#UCase("Platform")#</th>
                       <th>#UCase("Description")#</th>
                       <th>#UCase("Mins")#</th>
                       <th>&nbsp;</th>
                  	</tr>
            	</thead>
				<cfscript>
                    getIncidents = application.objIncidents.getAllIncidents(FORM);
              	</cfscript>
              	<tbody>
				<cfif getIncidents.RecordCount>
					<cfloop query="getIncidents">
                   		<tr>
                        	<!--- <td>#DateFormat(dtDateCreated,"dd/mm/yy")# @ #TimeFormat(dtDateCreated,"HH:mm")#</td> --->
                         	<td>#DateFormat(dtDateStarted, application.sDateFormat)# @ #TimeFormat(dtDateStarted,"HH:mm")#</td>
                         	<td>
							<cfif isDate(dtDateEnded)>
								#DateFormat(dtDateEnded, application.sDateFormat)# @ #TimeFormat(dtDateEnded,"HH:mm")#
							<cfelse>
								&nbsp;
							</cfif>
							</td>
                         	<td>#sPlatform#</td>
                         	<td><cfif len(sIncidentDetails) LT 50>#sIncidentDetails#<cfelse>#left(sIncidentDetails,50)#...</cfif></td>
                         	<td>#iTotalMinutes#</td>
                        	<td><a href="incidents.cfm?iIncidentID=#iIncidentID###tabs-3" class="viewDetails"><button type="button" class="btn btn-xs btn-primary">Edit</button></a></td>
                    	</tr>
                	</cfloop>
	              	</tbody>
	        		</table>
					<div class="container text-center text-primary">Showing #getIncidents.RecordCount# Results</div>
            	<cfelse>
	              	</tbody>
	        		</table>
					<div class="container text-center text-primary" style="margin-top:200px">Showing #getIncidents.RecordCount# Results</div>
            	</cfif>	
           	</cfoutput>          
		</div>
		<div id="tabs-2">
			<cfinclude template="includes/inc_incident_search.cfm">
		</div>
       	<cfif isDefined("iIncidentID")>
          	<div id="tabs-3">			
             	<cfinclude template="includes/inc_incident_addedit.cfm">
          	</div>
       	</cfif>
	</div>	
</div>

<script>	
	// $(".incidentDetails").hide();	
</script>

<cfinclude template="includes/inc_footer.cfm">


<!--- Div Layout
<div class="row">
    <cfoutput>
    <div class="col-lg-2"><strong>#UCase("Date Created")#</strong></div>
    <div class="col-lg-2"><strong>#UCase("Start Time")#</strong></div>
    <div class="col-lg-2"><strong>#UCase("End Time")#</strong></div>
    <div class="col-lg-2"><strong>#UCase("Platform")#</strong></div>
    <div class="col-lg-2" style="text-align:center"><strong>#UCase("Outage")# (Mins)</strong></div>
    <div class="col-lg-2">&nbsp;</div>
    </cfoutput>
</div>
<cfscript>
    getIncidents = application.objIncidents.getIncidents(URL.iPlatformID);
</cfscript>
<cfif getIncidents.RecordCount>
   <cfoutput query="getIncidents">
       <div class="row">
           <div class="col-lg-2">#DateFormat(dtDateCreated,"dd/mm/yy")# @ #TimeFormat(dtDateCreated,"HH:nn")#</div>
           <div class="col-lg-2">#DateFormat(dtDateStarted,"dd/mm/yy")# @ #TimeFormat(dtDateStarted,"HH:nn")#</div>
           <div class="col-lg-2">#DateFormat(dtDateEnded,"dd/mm/yy")# @ #TimeFormat(dtDateEnded,"HH:nn")#</div>
           <div class="col-lg-2">#sPlatform#</div>
         <div class="col-lg-2" style="text-align:center">12</div>
           <div class="col-lg-2" style="text-align:right"><a href="incidents.cfm?iPlatformID=#iPlatformID#">View Details</a></div>
        </div>
    </cfoutput>
<cfelse>
    <div class="container" style="text-align:center; padding:100px">No Results</div>
</cfif>
--->  

