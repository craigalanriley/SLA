<cfset sPageName = "Error">

<cfinclude template="includes/inc_header.cfm">

<div class="row">
	<cfoutput>
	<div class="col-lg-3"></div>
	<div class="col-lg-6">
		<div class="panel panel-danger" style="margin: 100px 0 150px 0">
		  	<div class="panel-heading">
		    	<h3 class="panel-title"><strong>OOPS</strong> - Something went wrong!</h3>
		  	</div>
		  	<div class="panel-body">
			  				  	
			  	<p><h5>99% of the code on this page ran perfectly, there's always one that lets you down!</h5></p>
			  	<br/>		  	
				<div class="progress progress-striped active">
					<div class="progress-bar progress-bar-danger"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:99%">
						<span class="sr-only">99% Complete</span>
					</div>
				</div>
			  	<br/>
				<p><h6><strong>Note:</strong> Unfortunately you will not be able to report this incident via the SLA reporting tool.</h6></p>		  		  	
  	
		  	</div>
		</div>
	</div>
	<div class="col-lg-3"></div>
	</cfoutput>
</div>
<script>
	// $(".incidentDetails").hide();
</script>

<cfinclude template="includes/inc_footer.cfm">