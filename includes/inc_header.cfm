
<cfset sMessage = structNew()>

<cfparam name="stAlert.sMessage" 	default="">
<cfparam name="stAlert.sClass" 		default="">
<cfparam name="sPageName" 			default="">

<!doctype html>
<head> 
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>SLA Reporting - <cfoutput>#sPageName#</cfoutput></title> 
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width">
	
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<style>
	    body{
	        padding-top: 50px;
	        padding-bottom: 20px;
	    	}
	</style>
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/main.css">
	
	<script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>	
	
	<!-- Tabs -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	<!--- <link rel="stylesheet" href="/resources/demos/style.css">	 --->	
	<script>
    
		$(function() 
			{
			// Tabs
			$( "#tabs" ).tabs();			
			// Search Datepickers
			$("#dSearchStarted").datepicker({ dateFormat: "<cfoutput>#application.sDateFormat#</cfoutput>" });
   			$("#dSearchEnded").datepicker({ dateFormat: "<cfoutput>#application.sDateFormat#</cfoutput>" });
		 	// Add/Edit Datepickers
		 	$("#dStarted").datepicker({ dateFormat: "<cfoutput>#application.sDateFormat#</cfoutput>" });
		 	$("#dEnded").datepicker({ dateFormat: "<cfoutput>#application.sDateFormat#</cfoutput>" });			
			});
    
    </script>
</head> 
<body style="padding-top: 0px;">
<header style="margin-bottom:30px;">
	<div class="container">
		<div class="row"><img src="http://127.0.0.1:8500/slareporting/img/logo-2013.jpg" alt="Amaysim"></div>
   	</div>	
</header>

<div class="navbar navbar-inverse navbar-static-top" role="navigation">
	<div class="container" style="padding-left:0 !important; padding-right:0 !important">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<!--- <a class="navbar-brand" href="#">Project name</a> --->
		</div>
	  	<div class="navbar-collapse collapse" style="padding-left:0 !important">
			<ul class="nav navbar-nav">
				<li id="navHome"><a href="index.cfm">Dashboard</a></li>
				<li id="navPlatforms"><a href="platforms.cfm">Platforms</a></li>
				<li id="navIncidents"><a href="createplatform.cfm">Create Platform</a></li>
				<li id="navIncidents"><a href="incidents.cfm">Incidents</a></li>
				<li id="navIncidents"><a href="createincident.cfm">Create Incident</a></li>
				<!--- 
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li class="dropdown-header">Nav header</li>
						<li><a href="#">Separated link</a></li>
						<li><a href="#">One more separated link</a></li>
					</ul>
				</li>
				--->
			</ul>
			<ul class="nav navbar-nav" style="float:right!important">
				<li id="navIncidents" style="float:right!important"><a href="?bLogOut=true">LOGOUT</a></li>
			</ul>
	  	</div>
	</div>
</div>
<cfif len(stAlert.sMessage)> 
	<cfoutput>
        <div class="alert #stAlert.sClass#" style="text-align: center">#stAlert.sMessage#</div>		
    </cfoutput>
</cfif>		
<div class="container">