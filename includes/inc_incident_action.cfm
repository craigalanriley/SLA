
<cfparam name="FORM.sAction" default="">
<cfparam name="VARIABLES.ErrorList" default="">
<cfparam name="VARIABLES.ReqList" default="dtStarted,iPlatformID,iImpact,sIncidentDetails">

<cfscript>
	
	// writeDump(FORM);
	if (len(FORM.sAction))
		{		
		if (CompareNoCase(FORM.sAction,"Delete"))
			{
			// Not the bestest date formatting!
			FORM.dtStarted 	= dStarted & " " & tStarted;
			FORM.dtEnded	= dEnded & " " & tEnded;					
			// General field completed validation
			VARIABLES.ErrorList = Application.objValidation.genericValidation(VARIABLES.ReqList); // writeDump(VARIABLES.ErrorList);			
			// Validate dtDateEnded
			VARIABLES.ErrorList = Application.objValidation.checkDateRange(FORM.dtStarted, FORM.dtEnded, VARIABLES.ErrorList);
			
			// CRUD	
			switch(FORM.sAction) 
				{
				case "Create":
	
					if (NOT len(VARIABLES.ErrorList))
						{
						iIncidentID = application.objIncidents.createIncident(FORM);
						stAlert.sMessage 	= "<strong>Woohoo!</strong> - The incident has been created";
						stAlert.sClass 		= "alert-success";
						break;
						}
					else{
						stAlert.sMessage 	= "<strong>Oops!</strong> - Please complete all the required fields";
						stAlert.sClass 		= "alert-danger";
						break;
						}
	
				case "Update":
				
					if (NOT len(VARIABLES.ErrorList))
						{
					 	application.objIncidents.updateIncident(FORM); 
					  	stAlert.sMessage 	= "<strong>Hoorah!</strong> - The incident has been updated";
					  	stAlert.sClass 		= "alert-success";
				 		break;
						}
					else{
						stAlert.sMessage 	= "<strong>Oops!</strong> - Please complete all the required fields";
						stAlert.sClass 		= "alert-danger";
						break;
						}
				}			
			}
		else{
			// Delete incident
			application.objIncidents.deleteIncident(FORM.iIncidentID);
		  	stAlert.sMessage 	= "<strong>Hoorah!</strong> - The incident has been deleted";
		  	stAlert.sClass 		= "alert-success";
		  	location(url="incidents.cfm?",addtoken=false);
			};			
		};

</cfscript>