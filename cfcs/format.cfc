<cfcomponent output="true">
	
	<cffunction name="getPercentClass" description="Set bootstrap class depending on percentage">		
		<cfargument name="nPercent" 	required="yes" />
		
			<cfscript>
				var sClass = "";	
				
				if (arguments.nPercent GTE 99)
					{								
					sClass = "text-success"; // Green	
					}
				else if((arguments.nPercent LT 99) AND (arguments.nPercent GTE 95))
					{								
					sClass = "text-warning"; // Amber
					}
				else{								
					sClass = "text-danger"; // Red	
					};							
			</cfscript>
			
		<cfreturn sClass />		
	</cffunction>	

</cfcomponent>