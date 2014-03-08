
<cfparam name="FORM.sAction" 		default="">
<cfparam name="VARIABLES.ErrorList" default="">
<cfparam name="VARIABLES.ReqList" 	default="iParentID,sPlatform,iStatus">

<cfscript>
	
	// writeDump(FORM);
	if (len(FORM.sAction))
		{
		if (CompareNoCase(FORM.sAction,"Delete"))
			{
			// General field completed validation
			VARIABLES.ErrorList = Application.objValidation.genericValidation(VARIABLES.ReqList); // writeDump(VARIABLES.ErrorList);

			// CRUD	
			switch(FORM.sAction) 
				{
				case "Create":
	
					if (NOT len(VARIABLES.ErrorList))
						{
						iPlatformID = application.objPlatforms.createPlatform(FORM);
						stAlert.sMessage 	= "<strong>Woohoo!</strong> - The platform has been created";
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
					 	application.objPlatforms.updatePlatform(FORM); 
					  	stAlert.sMessage 	= "<strong>Hoorah!</strong> - The platform has been updated";
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
			application.objPlatforms.deletePlatform(FORM.iPlatformID);
		  	stAlert.sMessage 	= "<strong>Hoorah!</strong> - The platform has been deleted";
		  	stAlert.sClass 		= "alert-success";
			};			
		};

</cfscript>