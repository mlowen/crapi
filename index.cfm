<html>
	<head>
		<title>CRAPI</title>
	</head>
	<body>
		<cftry>
			<cfscript>
					
				if(StructKeyExists(url, "reset")) {
					ApplicationStop();
					Location(url = "/", addtoken = false);
				}				
				
				route = "/{controller}/{action}";
				regex = "^" & REReplaceNoCase(route, "{([a-z0-9]+)}", "([a-z0-9]+)", "all");
				
				WriteDump(REMatchNoCase(regex, "/foo/bar"))
				
				
				/*
				crapi = new crapi.Core();
				crapi.addRoute(route = "/{controller}/{action}");
				
				route = crapi.GetRoute(cgi.PATH);
				
				// Create the Controller
				controller = CreateObject("component", "controllers.#route.controller#");
				
				if(not StructKeyExists(controller, route.action))
					Throw(type = "crapi", errorcode = 404, message = "Unable to find handler.");
				
				meta = GetMetaData(controller[route.action]);
				methods = [ "get" ];
				
				if(StructKeyExists(meta, "crapi:method"))
					methods = ListToArray(lcase(meta["crapi:method"]));
								
				if(not ArrayContains(methods, lcase(cgi.REQUEST_METHOD)))
					throw(type = "crapi", errorcode = 405, message = "Handler does not accept that HTTP method.");
				*/
				
				// Now we know that the call exists and is good.
			</cfscript>
			
			<cfcatch type="any">
				<cfset errorCode = 500 />
				<cfif cfcatch.type eq "crapi">
					<cfset errorCode = cfcatch.ErrorCode />
				</cfif>
				
				<cfoutput>Error Code: #errorCode#</cfoutput>
				<cfdump var="#cfcatch#" />
			</cfcatch>
		</cftry>
	</body>
</html>