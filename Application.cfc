<cfcomponent output="false">
	<cffunction name="onApplicationStart" returntype="boolean" access="public">
		<cfset application.crapi = new crapi.Core() />
		
		<cfreturn true />
	</cffunction>
</cfcomponent>