<cfcomponent output="false">
	<cffunction name="Serialize" access="public" returntype="string">
		<cfargument name="data" type="any" required="true" />
		
		<cfreturn SerializeJSON(arguments.data) />
	</cffunction>
	
	<cffunction name="Deserialize" access="public" returntype="any">
		<cfargument name="data" type="string" required="true" />
		
		<cfreturn DeserializeJSON(arguments.data) />
	</cffunction>
</cfcomponent>