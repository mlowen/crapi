<cfcomponent output="false">
	<cffunction name="default" access="public" returntype="array">
		<cfargument name="id" type="numeric" required="false" default="1" />
		
		<cfscript>
			ret = [];
			
			for(i = 1; i lte arguments.id; i++)
				ArrayAppend(ret, "hello");
			
			return ret;
		</cfscript>
	</cffunction>
</cfcomponent>