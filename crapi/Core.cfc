<cfcomponent>
	
	<!--- CRAPI Functions --->
	<cffunction name="init" access="public" returntype="any">
		<cfset this.routes = [] />
		<cfset this.formatters = {} />
		<cfset this.defaultFormat = "application/json" />
		
		<!--- Add the default formatters --->
		<cfset this.formatters["application/json"] = new crapi.formatters.JSONFormatter() />
		
		<cfreturn this />
	</cffunction>
	
	<!--- Routes --->
	<cffunction name="addRoute" access="public" returntype="void">
		<cfargument name="route" type="string" required="true" />
		<cfargument name="controller" type="string" required="false" default="{controller}" />
		<cfargument name="action" type="string" required="false" default="{action}" />
		
		<cfscript>
			var path = arguments.route;
			
			if(Right(path, 1) eq "/")
				path = Left(path, Len(path) - 1);
			
			var r = {
				controller = arguments.controller,
				action = arguments.action,
				regex = "^" & REReplaceNoCase(path, "{([a-z0-9]+)}", "([a-z0-9]+)", "all") & "$",
				parameters = { }
			};
			
			var parts = ListToArray(arguments.route, "/");
			
			for(i = 1; i lte ArrayLen(parts); i++) {
				if(left(parts[i], 1) eq "{" and right(parts[i], 1) eq "}") {
					var key = Mid(parts[i], 2, Len(parts[i]) - 2);
					
					if(StructKeyExists(r.parameters, key))
						throw(message = "Route cannot define the same parameter more than once.");
						
					r.parameters[key] = i;
				}
			}
			
			ArrayAppend(this.routes, r);
		</cfscript>
	</cffunction>
	
	<cffunction name="getRoute" access="public" returntype="struct">
		<cfargument name="path" type="string" required="true" />
		
		<cfscript>
			for(i = 1; i lte ArrayLen(this.routes); i++) {
				var matchPath = arguments.path;
				
				if(Right(matchPath, 1) eq "/")
					matchPath = Left(matchPath, Len(matchPath) - 1);
				
				var route = this.routes[i];
				var match = REMatchNoCase(route.regex, matchPath);
								
				if(ArrayLen(match) eq 1) {
					var r = {
						controller = route.controller,
						action = route.action,
						args = { }
					};
					
					var parts = ListToArray(match[1], "/");
					
					if(StructKeyExists(route.parameters, "controller"))
						r.controller = Trim(ReplaceNoCase(r.controller, "{controller}", parts[route.parameters.controller], "all"));
						
					if(StructKeyExists(route.parameters, "action"))
						r.action = Trim(ReplaceNoCase(r.action, "{action}", parts[route.parameters.action], "all"));
					
					var keys = StructKeyArray(route.parameters);
					
					for(i = 1; i lte ArrayLen(keys); i++) {
						var key = keys[i];
						
						if(key != "action" and key != "controller")
							r.args[key] = parts[route.parameters[key]];
					}
					
					if(Len(r.controller) eq 0 or FindNoCase(r.controller, "{controller}") gt 0)
						throw(message = "Unable to populate from matching route.");
					
					if(Len(r.action) eq 0 or r.action eq "{action}")
						r.action = "default";
					
					return r;
				}
			}
			
			throw(type = "crapi", message = "Unable to find matching route.", errorcode = 404);
		</cfscript>
	</cffunction>

	<!--- Formatters --->
	<cffunction name="getFormatter" access="public" returntype="any">
		<cfargument name="contentType" type="string" required="true" />
		
		<cfif StructKeyExists(this.formatters, arguments.contentType)>
			<cfreturn this.formatters[arguments.contentType] />
		</cfif>
		
		<cfthrow type="crapi" errorcode="415" message="Unknown format #arguments.contentType#." />
	</cffunction>
</cfcomponent>