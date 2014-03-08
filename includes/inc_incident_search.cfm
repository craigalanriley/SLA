
<cfparam name="FORM.sSearchText" default="">
<cfparam name="FORM.iSearchPlatformID" default="0">
<cfparam name="FORM.dSearchStarted" default="">
<cfparam name="FORM.dSearchEnded" default="">

<div class="container">
	<form action="incidents.cfm" method="post" name="SearchForm">
		<cfoutput>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Details</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-4"><input type="text" name="sSearchText" class="form-control" placeholder="Keyword" value="#FORM.sSearchText#"></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Platform</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-4">
				<cfscript>
				    // getPlatforms = application.objPlatforms.getPlatforms();
				    arrPlatforms = application.objPlatforms.getPlatformTree(); // writeDump(getPlatforms);
				</Cfscript>
				<select name="iSearchPlatformID" class="form-control">
					<option value="">Any Platform</option>
					<cfloop from="1" to="#ArrayLen(arrPlatforms)#" index="p">
						<option value="#arrPlatforms[p][1]#" <cfif FORM.iSearchPlatformID EQ arrPlatforms[p][1]> selected</cfif>>
							<cfif arrPlatforms[p][3]>&nbsp;&nbsp;&nbsp;</cfif> #arrPlatforms[p][2]#
						</option>						
					</cfloop>
				</select>	
			</div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Date Range</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-2"><input type="text" id="dSearchStarted" name="dSearchStarted" class="form-control" value="#FORM.dSearchStarted#" placeholder="#application.sDateFormat#"></div>
			<div class="col-lg-2"><input type="text" id="dSearchEnded" name="dSearchEnded" class="form-control" value="#FORM.dSearchEnded#" placeholder="#application.sDateFormat#"></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
        
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">&nbsp;</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-2"><input type="submit" name="Search" value="Search Incidents" class="form-control btn btn-primary"></div>
			</form>
			<form action="incidents.cfm##tabs-2" method="post">	
			<div class="col-lg-2"><input type="submit" name="Search" value="Clear Form" class="form-control btn btn-danger"></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>		
		</cfoutput>	
	</form>
</div>