
<!--- Empty Incidents Table --->
<cfquery datasource="slareporting" name="clearDB">
	delete from incidents 
</cfquery>

<!--- Read Current Spreadsheet (Cleaned UP) --->
<cfspreadsheet 
        action 		=	"read" 
        src			=	"C:\ColdFusion9\wwwroot\slareporting\db\incidents.xls" 
        query		=	"excelSpreadsheet" 
        sheet		=	"1" 
        rows		=	"2-1000000" 
        columns		=	"1,2,3,4,5,6,7,8">
</cfspreadsheet>

<!--- Get Distinct Excel Categories
<cfquery dbtype="query" name="qSpreadsheet">
    select distinct(excelSpreadsheet.col_2) from excelSpreadsheet
</cfquery>
<cfdump var="#qSpreadsheet#">
<cfabort/> --->

<table border="1" cellpadding="10">
<cfoutput query="excelSpreadsheet" startrow="1" maxrows="#excelSpreadsheet.recordcount#">
	
	<cfswitch expression="#excelSpreadsheet.col_2#">
		<cfcase value="555 IVR">
			<cfset iPlatformID = "27">
		</cfcase>
		<cfcase value="CCGW">
			<cfset iPlatformID = "28">
		</cfcase>
		<cfcase value="ECC Application (ALL)">
			<cfset iPlatformID = "6">
		</cfcase>
		<cfcase value="ECC Application (WSDL/DB)">
			<cfset iPlatformID = "6">
		</cfcase>
		<cfcase value="ECC Application (secure)">
			<cfset iPlatformID = "7">
		</cfcase>
		<cfcase value="ECC Application (secure2)">
			<cfset iPlatformID = "8">
		</cfcase>
		<cfcase value="ECC Application (secure3)">
			<cfset iPlatformID = "9">
		</cfcase>
		<cfcase value="ECC CSC interface">
			<cfset iPlatformID = "9">
		</cfcase>
		<cfcase value="ECC Production DB">
			<cfset iPlatformID = "10">
		</cfcase>
		<cfcase value="Genesys systems">
			<cfset iPlatformID = "22">
		</cfcase>
		<cfcase value="Optus CDR Delivery">
			<cfset iPlatformID = "18">
		</cfcase>
		<cfcase value="Optus WSG & Downstream">
			<cfset iPlatformID = "16">
		</cfcase>
		<cfcase value="Sensis">
			<cfset iPlatformID = "23">
		</cfcase>
		<cfcase value="Spectrum">
			<cfset iPlatformID = "24">
		</cfcase>
		<cfcase value="Temando">
			<cfset iPlatformID = "25">
		</cfcase>
		<cfcase value="Web Application">
			<cfset iPlatformID = "13">
		</cfcase>
	</cfswitch>
	
	
	
	<!--- Insert Data ---> 
    <cfquery datasource="slareporting" name="InsertData">
		insert into incidents(dtDateCreated, dtDateStarted, dtDateEnded, iPlatformID, sIncidentDetails)		
		values(#CreateODBCDateTime(excelSpreadsheet.col_1)#,
			   #CreateODBCDateTime(excelSpreadsheet.col_3)#,
			   <cfif isDate(excelSpreadsheet.col_4)>
				 	#CreateODBCDateTime(excelSpreadsheet.col_4)#
			   <cfelse>
			   		#CreateODBCDateTime(DateAdd('n',10,excelSpreadsheet.col_3))#
			   </cfif>,
			   #iPlatformID#,
			   '#excelSpreadsheet.col_7#');
    </cfquery>
	<!--- Display Data --->
	<tr>
	    <td>#excelSpreadsheet.col_1#</td>
	   	<td>#excelSpreadsheet.col_2#</td>
	    <td>#excelSpreadsheet.col_3#</td>
	    <td>#excelSpreadsheet.col_4#</td>
	    <td>#excelSpreadsheet.col_5#</td>
	    <td>#excelSpreadsheet.col_6#</td>
	    <td>#excelSpreadsheet.col_7#</td>
	    <td>#excelSpreadsheet.col_8#</td>
	</tr>	   
</cfoutput>
</table>

<!--- Get Start & End Times --->
<cfquery datasource="slareporting" name="getTimes">
	select iIncidentID, dtDateStarted, dtDateEnded
	from incidents 
	order by iIncidentID
</cfquery>
<cfoutput query="getTimes">	
	<!--- If both dates valid calc total minutes down time and update iTotalMinutes Column--->
	<cfif isDate(dtDateStarted) AND isDate(dtDateEnded)>		
		<cfset iTotalMinutes = DateDiff("n",dtDateStarted,dtDateEnded)>		
		<cfquery datasource="slareporting" name="insertTotalMinutes">
			update incidents 
			set iTotalMinutes = #iTotalMinutes#
			where iIncidentID = #iIncidentID#
		</cfquery>				
	</cfif>
</cfoutput>

<cfdump var="#excelSpreadsheet#" expand="false">
