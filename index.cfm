<cfscript>
	try {
		if(StructKeyExists(url, "reset")) {
			ApplicationStop();
			Location(url = "/", addtoken = false);
		}
		
		route = application.crapi.GetRoute(cgi.PATH_INFO);
													
		// Ensure that the controller exists				
		if(not FileExists("#ExpandPath('/')#/controllers/#route.controller#.cfc"))
			throw(type = "crapi", errorcode = 404, message = "Controller does not exist.");
		
		// Create the Controller
		controller = CreateObject("component", "controllers.#route.controller#");
		
		if(not StructKeyExists(controller, route.action))
			Throw(type = "crapi", errorcode = 404, message = "Unable to find handler.");
		
		call = controller[route.action];
		meta = GetMetaData(call);
		methods = [ "get"];
		
		if(StructKeyExists(meta, "crapi:method"))
			methods = ListToArray(lcase(meta["crapi:method"]));
						
		if(not ArrayContains(methods, lcase(cgi.REQUEST_METHOD)))
			throw(type = "crapi", errorcode = 405, message = "Handler does not accept that HTTP method.");
		
		// Now we know that the call exists and is good.				
		returnType = "void";
		
		if(StructKeyExists(meta, "returntype"))
			returnType = meta.returntype;
		
		if(returnType eq "void") {
			if(StructIsEmpty(route.args))
				call();
			else
				call(argumentcollection = route.args);
			
			context = GetPageContext().GetResponse();
			context.GetResponse().SetStatus(204);
		} else {
			result = "";
			
			if(StructIsEmpty(route.args))
				result = call();
			else
				result = call(argumentcollection = route.args);
			
			formatter = application.crapi.GetFormatter("application/json");
			
			WriteOutput(formatter.Serialize(result));
		}			
	} catch(Any ex) {
		errorCode = 500;
		
		if(ex.type eq "crapi")
			errorCode = ex.ErrorCode;
		
		context = GetPageContext().GetResponse();
		context.GetResponse().SetStatus(errorCode);

		formatter = application.crapi.GetFormatter("application/json");
		
		WriteOutput(formatter.Serialize(ex.message));
	}
</cfscript>