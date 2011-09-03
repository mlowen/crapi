<cfcomponent output="false">
	<!--- Properties --->
	<cfproperty name="routes" type="crapi.Routes" />
	<cfproperty name="formats" type="struct" />
	<cfproperty name="defaultFormat" type="string" />
	
	<!--- CRAPI Functions --->
	<cffunction name="init" access="public" returntype="any">
		<cfset this.routes = {} />
		
		<cfreturn this />
	</cffunction>
	
	<!--- Routes --->
	<cffunction name="addRoute" access="public" returntype="void">
		<cfargument name="route" type="string" required="true" />
		<cfargument name="controller" type="string" required="false" default="{controller}" />
		<cfargument name="action" type="string" required="false" default="{action}" />
		
		
	</cffunction>
	
	<cffunction name="getRoute" access="public" returntype="struct">
		<cfargument name="path" type="string" required="true" />
		
		<cfreturn { controller = "Test", action = "Hello", args = { }  } />
	</cffunction>
	
	<!--- Formatters --->
	<cffunction name="addFormatter" access="public" returntype="void">
		
	</cffunction>
	
	<cffunction name="setAuthCFC" access="public" returntype="void">
		<cfargument name="authCFCPath" type="string" required="true" />
		
		
	</cffunction>
</cfcomponent>