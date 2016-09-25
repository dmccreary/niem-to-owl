xquery version "1.0-ml";

(:
This XQuery Script Transforms NIEM Core Elements from input XML Schema file into
an HTML file.
	     
    Author:Dan McCreary
    Copyright: 2013 Kelly-McCreary & Associates, All Rights Reserved
    License: Apache 2.0
    Version History:
		
:)
declare namespace s="http://niem.gov/niem/structures/2.0";
declare namespace nc="http://niem.gov/niem/niem-core/2.0";
declare namespace niem-xsd="http://niem.gov/niem/proxy/xsd/2.0";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace j="http://niem.gov/niem/domains/jxdm/4.0";
declare namespace i="http://niem.gov/niem/appinfo/2.0";

let $title := 'NIEM Classes to HTML'

(: This is the file path.  Change this line if you put the file into another location :)
let $file-path := '/data/niem/niem-core.xsd'
let $schema := doc($file-path)/xs:schema

let $set-html-content := xdmp:set-response-content-type("text/html")
(: setting this to be true slows down the report :)
let $defs := xs:boolean(xdmp:get-request-field('defs', 'false'))

let $named-complex-types := $schema//xsd:complexType[@name]
let $total-count := count($named-complex-types)

return
<html>
   <head>
     <title>{$title}</title>
     <link rel="stylesheet" href="/resources/css/site.css"/>

     <style><![CDATA[
     .niem-class {padding:5px;}
     .niem-class-name {color:blue; font-size: 14pt; margin-left: 5px;}
     .property {color:black; margin-left: 10px;}
     .field-label {color:gray;}
     ]]></style>
   </head>
   <body>
   <h1>NIEM Core Classes to HTML</h1>
   <span class="field-label">View Description: </span>A simple query of the niem-core.xsd file that lists all the named complex types.<br/>
   <span class="field-label">Number of Named Complex Types: </span> {$total-count}<br/>
   <span class="field-label">Order by: </span> name<br/>
   <span class="field-label">Target Namespace: </span>  {$schema/@targetNamespace/string()}<br/>
    <span class="field-label">Elapsed Time:</span> {xdmp:elapsed-time() div xs:dayTimeDuration('PT1S') } seconds.<br/>

      {
        (: We first get all the complex elements in the file.  For each complex element create an owl class. :)
        for $complex-element at $count in $named-complex-types
            let $name := string($complex-element/@name)
            let $parent := string($complex-element//xsd:extension/@base)
            let $parent-suffix := substring-after($parent, ':')
            let $properties := 
                for $element at $count in $complex-element//xsd:element
                    let $name := string($element/@ref)
                    order by $name
                    return $element
            let $property-count := count($properties)
            order by $name
              return
                 (: for each class, put the class name in and put the parent class in the subclass element :)
                 <div class="niem-class">
                    <a name="{$name}"/>
                    {$count}
                     <span class="field-label"> Class:</span>
                     <span class="niem-class-name">{$name}</span><br/>
                     <span class="field-label">Sub class of: </span>
                         {if (starts-with($parent, 'structures'))
                            then $parent
                            else
                              <a href="#{$parent-suffix}">{$parent}</a>
                         }
                     <br/>
                     Documentation: {$complex-element/xsd:annotation/xsd:documentation/text()}<br/>
                    
                    Property Count: {$property-count}<br/>
                    {for $property in $properties
                      let $element-name-suffix := substring-after($property//@ref/string(), 'nc:')
                      let $definition :=
                        if ($defs)
                           then $schema/xs:element[@name = $element-name-suffix]/xsd:annotation/xsd:documentation/text()
                           else ''
                           
                      return
                        <div class="property">
                           {$element-name-suffix}
                           - {$definition}
                        </div>
                                
                      }
             </div>     
     }
     
   </body>
</html>