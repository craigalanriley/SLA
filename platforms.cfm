
<cfset sPageName = "Platforms">

<cfinclude template="includes/inc_platform_action.cfm">
<cfinclude template="includes/inc_header.cfm">

<!-- Example row of columns -->
<div class="row">
	<!-- Tabs -->
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">Platforms</a></li>
           	<cfif isDefined("iPlatformID")>
				<li><a href="#tabs-2">Edit Platform</a></li>
			</cfif>
		</ul>
		<div id="tabs-1">
			<cfoutput>
         	<table class="table table-hover">
            	<thead>
                	<tr style="color: ##666666">
                       <th>#UCase("")#</th>
                       <th>#UCase("Platform")#</th>
                       <th>&nbsp;</th>
                  	</tr>
            	</thead>
				<cfscript>
                    arrPlatforms = application.objPlatforms.getPlatformTree();
              	</cfscript>
              	<tbody>
				<cfif arrayLen(arrPlatforms)>
					<cfloop from="1" to="#arrayLen(arrPlatforms)#" index="p">
                   		<tr>
                         	<td><!--- #arrPlatforms[p][4]# ---></td>
                         	<td width="100%" class="<cfif arrPlatforms[p][4]>text-primary<cfelse>text-muted</cfif>">
								<cfif arrPlatforms[p][3] EQ 0>
									<strong>#arrPlatforms[p][2]#</strong>
								<cfelse>									
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#arrPlatforms[p][2]#								
								</cfif>
							</td>
                        	<td align="right">
								<a href="platforms.cfm?iPlatformID=#arrPlatforms[p][1]###tabs-2" class="viewDetails">
									<button type="button" class="btn btn-xs btn-primary">Edit</button>
								</a>
							</td>
                    	</tr>
                	</cfloop>
	              	</tbody>
	        		</table>
					<div class="container text-center text-primary">Showing #arrayLen(arrPlatforms)# Results</div>
            	<cfelse>
	              	</tbody>
	        		</table>
					<div class="container text-center text-primary" style="margin-top:200px">Showing #arrayLen(arrPlatforms)# Results</div>
            	</cfif>
           	</cfoutput>
		</div>
       	<cfif isDefined("iPlatformID")>
          	<div id="tabs-2">
             	<cfinclude template="includes/inc_platform_addedit.cfm">
          	</div>
       	</cfif>
	</div>
</div>

<script>	
	// $(".incidentDetails").hide();	
</script>

<cfinclude template="includes/inc_footer.cfm">
