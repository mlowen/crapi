CRAPI
=====

_A Coldfusion REST API framework._

The Basics
----------

This framework was inspired by the MVC frameworks that I have had a chance to play around with and hopefully takes some of the good points from them.  One of the main ideas behind this framework was to be as lightweight and unobtrusive as possible, so you can get on and code.  To start using just drop the files into your project and start adding cfcs to the controllers directory.  When making any calls the path must be appended to the index.cfm, an example call which can be used to test the installation of crapi is:

`http://[site url]/index.cfm/hello`

If you want prettier URL's you can remove the index.cfm portion with rewrite rules easy enough.

### Routes

Routes are how the framework knows what functionality it should be executing.  There are three default routes which are predefined in crapi, they are:

* `/{controller}`
* `/{controller}/{id}`
* `/{controller}/{id}/{action}`

The controller keyword corresponds to a CFC in the controllers folder and the action keyword corresponds to the function which should be called.  In the cases where no function is specified then the framework falls back to calling a function called 'default' in the controller.

#### Custom Routes

Routes (including the predefined ones) can be added and modified, they are all defined in OnApplicationStart function of the base Application.cfc.  To add a route you call the addRoute function which can take the following 3 parameters:

* route - The string that the incoming URL has to match to.
* controller - The name of the controller that will be called, this has the default value of {controller}.
* action - The name of the action in the controller that will be executed, this has the default value of {action}.

In the route argument anything that is between a set of curly braces '{}' will be treated specially, these are treated as dynamic parts of the URL.  The values of the dynamic parts of the URL will be passed to the action as arguments, the two exceptions to this are the 'controller' and 'action' the values of these will be used to help populate the controller and action fields passed to the addRoute function replacing the '{controller}' and '{action}' place holders respectively.

### Controllers

Controllers are where the functionality of the API is defined and contains the code that the framework will call. By default every public function in the controller is accessible via only the GET method, to change this the following property 'crapi:methods' can be added to a function definition, the value of this property is a comma seperated list of the valid HTTP methods which can be used to access this call.

An example controller called hello.cfc can be found in the controllers directory which gives a brief example of how the API can be used.

Limitations/Notes
-----------------

* Has only been tested with CF9.
* Will only return JSON as it's return format.
* Does not set the content type header to be the appropriate value.
* Even worse Crapi only returns JSON as created by the built in Coldfusion serializeJSON function.
* Does not automatically deserialise any passed up content based on supplied content type.
* Crapi currently does not define or enforce any typing of the dynamic parts of a route.
* Various other things that I can't think of at the moment.

I hope to be addressing at least some of these limitations in the near future.

License
-------

Crapi is available under the MIT license which is as follows:

Copyright (c) 2011 Michael Lowen

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
