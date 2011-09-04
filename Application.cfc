<cfcomponent output="false">
	<cffunction name="onApplicationStart" returntype="boolean" access="public">
		<cfscript>
			application.crapi = new crapi.Core();
			
			application.crapi.addRoute(route = "/{controller}");
			application.crapi.addRoute(route = "/{controller}/{id}");
			application.crapi.addRoute(route = "/{controller}/{id}/{action}");		
			
			return true;
		</cfscript>
	</cffunction>
</cfcomponent>