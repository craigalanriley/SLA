
<cfparam name="FORM.sFreeText" default="">
<cfparam name="FORM.iSearchPlatformID" default="0">
<cfparam name="FORM.searchDateStarted" default="">
<cfparam name="FORM.searchDateEnded" default="">

<script>
	
    $(function(){
        $( "#searchDateStarted" ).datepicker();
        $( "#searchDateEnded" ).datepicker();
        });               
        
</script>

<div class="container">	
	<form action="incidents.cfm" method="post">	
		<cfoutput>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Keyword</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-4"><input type="text" name="sFreeText" class="form-control" placeholder="Free Text" value="#FORM.sFreeText#"></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Platform</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-4">
				<cfscript>
				    getPlatforms = application.objPlatforms.getPlatforms(); // writeDump(getPlatforms);
				</Cfscript>
				<select name="iSearchPlatformID" class="form-control">
					<option value="0">Any Platform</option>
					<cfloop query="getPlatforms">
						<option value="#iPlatformID#" <cfif iPlatformID EQ FORM.iPlatformID>selected</cfif>>#sPlatform#</option>
					</cfloop>
				</select>		
			</div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Date Range</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<div class="col-lg-2"><input type="text" id="searchDateStarted" name="searchDateStarted" class="form-control" value="#FORM.searchDateStarted#" placeholder="#application.sDateFormat#"></div>
			<div class="col-lg-2"><input type="text" id="searchDateEnded" name="searchDateEnded" class="form-control" value="#FORM.searchDateEnded#" placeholder="#application.sDateFormat#"></div>
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