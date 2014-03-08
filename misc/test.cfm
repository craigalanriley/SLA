<cfset sPageName = "Test Page">

<cfscript>


</cfscript>

<cfinclude template="includes/inc_header.cfm">

<table class="table table-hover" id="testTable">
<cfoutput>
<thead>
	<tr style="color: ##666666">
		<th>#UCase("Platform")#</th>
		<th>#UCase("SLA")#</th>
		<th>#UCase("SLA")#</th>
		<th>#UCase("Outage")#</th>
		<th>&nbsp;</th>
	</tr>
</thead>
<tbody>
	<cfloop from="1" to="5" index="x">
		<tr class="priRow">
			<td width="20%" style="vertical-align: middle !important;"><a href="##">Platform</a></td>
			<td width="20%" style="vertical-align: middle !important;">#x#</td>
			<td width="20%" style="vertical-align: middle !important;">#x#</td>
			<td width="20%" style="vertical-align: middle !important;">#x#</td>
			<td width="20%" style="vertical-align: middle !important;" align="right">									
				<a href="incidents.cfm?iSearchPlatformID=1">
					<button class="btn btn-xs btn-primary" type="button" style="width: 135px; margin:3px; text-align: left; padding: 4px 0 4px 10px !important">
						View Incidents <span class="badge" style="background-color: white; color: ##2D6CA2 ">15</span>
					</button>
				</a>
			</td>
		</tr>
		<div style="display:none">
		<cfloop from="1" to="3" index="x">
			<tr class="secRow">
				<td><a href="##">Hidden Platform</a></td>
				<td>#x#</td>
				<td>#x#</td>
				<td>#x#</td>
				<td align="right">						
					<a href="incidents.cfm?iSearchPlatformID=1">
						<button class="btn btn-xs btn-primary" type="button" style="width: 135px; margin:3px; text-align: left; padding: 4px 0 4px 10px !important">
							View Incidents <span class="badge" style="background-color: white; color: ##2D6CA2 ">15</span>
						</button>
					</a>
				</td>
			</tr>								
		</cfloop>
		</div>
	</cfloop>
</tbody>
</cfoutput>
</table>

<script>
	// Hide Sub Platforms
	$(".secRow").hide();
	// Show child rows when parent row clicked		
	$(".priRow").click(function()
		{
		$(this).nextUntil('tr.priRow').fadeToggle(400);
		});
</script>

<cfinclude template="includes/inc_footer.cfm">


