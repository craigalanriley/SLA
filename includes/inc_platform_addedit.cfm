
<cfparam name="VARIABLES.ErrorList" default="">

<cfparam name="iPlatformID" 	default="0">
<cfparam name="FORM.iPlatformID" 	default="0">
<cfparam name="FORM.iParentID" 		default="">
<cfparam name="FORM.sPlatform" 		default="">
<cfparam name="FORM.iStatus" 		default="">

<cfscript>
	// writeDump(FORM);
	
	if (iPlatformID) 
		{
	    qGetData = application.objPlatforms.getPlatform(iPlatformID); // writeDump(qGetData);

	    FORM.iPlatformID 	= qGetData.iPlatformID;
	    FORM.iParentID 		= qGetData.iParentID;
	    FORM.iStatus 		= qGetData.iStatus;
	    FORM.sPlatform		= qGetData.sPlatform;
		};
</cfscript>

<div class="container">
	<cfoutput>
	<form action="?##tabs-3" method="post">
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Parent Platform</div>
			<div class="col-lg-1" style="text-align:right">*</div>
			<div class="col-lg-4 <cfif ListFind(VARIABLES.ErrorList,'iParentID')>has-error</cfif>">
				<cfscript>
				    getAllParents = application.objPlatforms.getAllPlatforms(0);
				</Cfscript>
				<select name="iParentID" class="form-control">
					<option value=""></option>
					<option value="0" <cfif FORM.iParentID EQ 0>selected</cfif>>[No Parent]</option>
					<cfloop query="getAllParents">
						<option value="#iPlatformID#" <cfif FORM.iParentID EQ iPlatformID>selected</cfif>>#sPlatform#</option>
					</cfloop>
				</select>
			</div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Platform Name</div>
			<div class="col-lg-1" style="text-align:right">*</div>
			<div class="col-lg-4 <cfif ListFind(VARIABLES.ErrorList,'sPlatform')>has-error</cfif>"><input type="text" name="sPlatform" class="form-control" value="#FORM.sPlatform#" placeholder=""></div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">Status</div>
			<div class="col-lg-1" style="text-align:right">*</div>
			<div class="col-lg-4 <cfif ListFind(VARIABLES.ErrorList,'iStatus')>has-error</cfif>">
				<select name="iStatus" class="form-control">
					<option value=""></option>
					<option value="1" <cfif FORM.iStatus EQ 1>selected</cfif>>Active</option>
					<option value="0" <cfif FORM.iStatus EQ 0>selected</cfif>>Inactive</option>
				</select>
			</div>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
		<div class="row" style="padding: 5px 0 5px 0">
			<div class="col-lg-2">&nbsp;</div>
			<div class="col-lg-1" style="text-align:right"><!--- * ---></div>
			<cfif iPlatformID>
				<div class="col-lg-4">
					<input type="hidden" name="sAction" value="Update">
					<input type="hidden" name="iPlatformID" value="#iPlatformID#">
					<input type="submit" name="Update" value="Update Platform" class="form-control btn btn-primary">
					</form>
				</div>
				<!--- 
				<div class="col-lg-2">
					<form action="?##tabs-1" method="post">
						<input type="hidden" name="sAction" value="Delete">
						<input type="hidden" name="iPlatformID" value="#iPlatformID#">
						<input type="submit" name="Delete" value="Delete Platform" class="form-control btn btn-danger">
					</form>
				</div>
				--->
			<cfelse>
				<div class="col-lg-4">
					<input type="hidden" name="sAction" value="Create">
					<input type="submit" name="Create" value="Create Platform" class="form-control btn btn-primary">
					</form>
				</div>
			</cfif>
			<div class="col-lg-5"><!--- Validation comments... ---></div>
		</div>
	</cfoutput>
</div>