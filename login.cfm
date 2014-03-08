<cfset sPageName = "Login">

<cfparam name="FORM.sUsername" default="">
<cfparam name="FORM.sPassword" default=""> 

<cfscript>
	if (isDefined("FORM.tryLogin"))
		{
		// Dirty quick login functionality
		if((FORM.sUsername EQ Application.sUserName) AND (FORM.sPassword EQ Application.sPassword))
			{
			// set session & cflocation to dashboard
			Session.bLoggedIn = true;
			location(url="index.cfm",addtoken=false);
			}
		else{
			stAlert.sMessage 	= "<strong>Sorry</strong> - you appear to have forgotten your details so you can't come in!";
			stAlert.sClass		= "alert-danger";
			};
		}

</cfscript>

<cfinclude template="includes/inc_header.cfm">

<div class="row">
	<cfoutput>
	<div class="col-lg-3"></div>
	<div class="col-lg-6">
		<div class="panel panel-default" style="margin: 100px 0 150px 0">
		  	<div class="panel-heading">
		    	<h3 class="panel-title">LOGIN</h3>
		  	</div>
		  	<div class="panel-body">	  	
			  	
			  	<form method="post" action="login.cfm" name="loginForm">
				  	<div class="row">
						<div class="col-lg-2">&nbsp;</div>
						<div class="col-lg-2"><h5>Username:</h5></div>
						<div class="col-lg-6"><input type="text" name="sUsername" class="form-control" placeholder="Username" value="#FORM.sUsername#"></div>
						<div class="col-lg-2">&nbsp;</div>
			    	</div>		  	
				  	<div class="row"><div class="col-lg-12">&nbsp;</div></div>
				  	<div class="row">
						<div class="col-lg-2">&nbsp;</div>
						<div class="col-lg-2"><h5>Password:</h5></div>
						<div class="col-lg-6"><input type="password" name="sPassword" class="form-control" placeholder="Password" value="#FORM.sPassword#"></div>
						<div class="col-lg-2">&nbsp;</div>
			    	</div>  	
				  	<div class="row"><div class="col-lg-12">&nbsp;</div></div>
				  	<div class="row">
						<div class="col-lg-2">&nbsp;</div>
						<div class="col-lg-2">&nbsp;</div>
						<div class="col-lg-6"><input type="submit" name="tryLogin" value="Login" class="form-control btn btn-primary"></div>
						<div class="col-lg-2">&nbsp;</div>
			    	</div>
		    	</form>
		    	
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


