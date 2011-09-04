<cfcomponent output="false">
	<cffunction name="default" access="public" returntype="array">
		<cfargument name="id" type="numeric" required="false" default="1" />
		
		<cfscript>
			ret = [];
			
			req = GetHttpRequestData();
			
			WriteDump(req);
			
			for(i = 1; i lte arguments.id; i++)
				ArrayAppend(ret, "hello");
			
			return ret;
		</cfscript>
	</cffunction>
	
	<cffunction name="name" access="public" returntype="any" crapi:method="post">
		<cfargument name="id" type="numeric" required="false" default="1" />
		
		<cfscript>
			ret = [];
			
			if(Len(cgi.CONTENT_LENGTH) eq 0)
				throw(type = "crapi", errorcode = 400, message = "No name supplied.");
			
			req = GetHttpRequestData();
			
			name = DeserializeJSON(req.content);
			
			if(IsStruct(name) or IsArray(name))
				throw(type = "crapi", errorcode = 400, message = "Invalid data supplied.");
			
			for(i = 1; i lte arguments.id; i++)
				ArrayAppend(ret, "hello #name#");
			
			return ret;
		</cfscript>
	</cffunction>
</cfcomponent>