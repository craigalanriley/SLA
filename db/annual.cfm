
<cfloop from="1" to="5" index="pltfm">
	<cfquery name="qGetPlatformName" datasource="slareporting">
		SELECT sPlatform 
		FROM platforms
		WHERE iPlatformID = <cfqueryparam value="#pltfm#" cfsqltype="cf_sql_integer">			
	</cfquery>
     <table cellpadding="3" cellspacing="0" border="1">
     <tr><th colspan="6">PLATFORM: <span style="color: red"><cfoutput>#qGetPlatformName.sPlatform#</cfoutput></span></th></tr>
     <tr>
         <th>Offset</th>
         <th>Date</th>
         <th>Total Days</th>
         <th>Total Minutes</th>
         <th>Total Downtime</th>
         <th>SLA</th>
     </tr>
     <cfloop from="0" to="12" index="mth">
         <tr>
             <cfset tDate 			= DateFormat(DateAdd("m", -mth, now()),"dd mmm yyyy")>
             <cfset DaysInMonth 	= DaysInMonth(tDate)>
             <cfset totalMins 		= DaysInMonth * 60 * 24>
             <cfset iTotalOutage 	= application.objPlatforms.getMonthsTotalOutage(pltfm,-mth)>
             <cfset iCurrentSLA 	= application.objPlatforms.getCurrentSLA(pltfm,-mth)>
             <cfoutput>
	             <td>-#mth#</td>
	             <td>#Year(tDate)# #MonthAsString(Month(tDate))#</td>
	             <td>#DaysInMonth#</td>
	             <td>#totalMins#</td>
	             <td>#iTotalOutage#</td>
	             <td>#iCurrentSLA#</td>
             </cfoutput>	
         </tr>	
     </cfloop>
     </table>
     <br />
</cfloop>
