xquery version "1.0";

(:
    Author:Dan McCreary
    Copyright: 2010 Dan McCreary & Associates, All Rights Reserved
    License: Apache 2.0
    Version History:
    Version 1: Writting for GJXDM 1.0
    Version 2: Updated for NIEM
    Version 3: Updated for NIEM 2.1
	
	This file was created from a report directly from the NIEM XML Schema.
:)
		
import module namespace style = "http://style.syntactica.com/web" at "../../../modules/style.xqm";
declare namespace s="http://niem.gov/niem/structures/2.0";
declare namespace nc="http://niem.gov/niem/niem-core/2.0";
declare namespace niem-xsd="http://niem.gov/niem/proxy/xsd/2.0";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace j="http://niem.gov/niem/domains/jxdm/4.0";
declare namespace i="http://niem.gov/niem/appinfo/2.0";

let $file-path := '/db/org/syntactica/apps/niem/data/niem-core.xsd'
let $doc := doc($file-path)

return
<rdf:rdf  
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
xmlns:owl="http://www.w3.org/2002/07/owl#" 
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
>
	<!-- This XQuery Script Transforms NIEM Core Elements from input XML Schema file to a flat listing of
	     OWL Classes and the properties for each class.
	
	    Author:Dan McCreary
	    Copyright: Dan McCreary & Associates, All Rights Reserved
	    License: Apache 2.0
	    Version History:
	    Version 1: Writting for GJXDM 1.0
	    Version 2: Updated for NIEM
	    Version 3: Updated for NIEM 2.1
		
		This file was created from a report directly from the NIEM XML Schema.
		
		I have used data element conventions outlined in the National Information Exchange Model (NIEM.gov)
		
		This was originally done as part of a demo for the 2006 Semantic Technology Conference:
		   
		   Here is the URL for that presentation:
		   
		   http://www.danmccreary.com/presentations/semweb2006/
		
		   This link includes a discussion of OWL and NIEM and the use of NIEM for K-12 education
	
	   For support questions please contact:
	
	      dan@danmccreary.com
	
		Good Luck! - Dan
	-->
	
    {
    (: We first get all the complex elements in the file.  For each complex element create an owl class. :)
    for $complex-element at $count in $doc//xsd:complexType[@name]
        let $name := string($complex-element/@name)
        order by $name
          return
          (
             (: for each class, put the class name in and put the parent class in the subclass element :)
             <owl:class rdf:about="#{$name}">
                <rdfs:subclassof>
                   <owl:class rdf:about="http://www.w3.org/2002/07/owl#{string($complex-element//xsd:extension/@base)}"/>
                 </rdfs:subclassof>
                 <owl:label>{$complex-element/xsd:annotation/xsd:documentation/text()}</owl:label>
             </owl:class>,
             
             (: now create a sequence of the sorted properties of the class :)
             let $sorted-sub-elements := 
                for $element at $count in $complex-element//xsd:element
                   let $name := string($element/@ref)
                   order by $name
                   return $element
              
              (: Now for each sub-element in the class, create a datatypeproperty.
              I am omiting the owl label for simplicity and to keep the file size small :)
              for $sub-element in $sorted-sub-elements
                 let $name := substring-after($sub-element/@ref, "nc:")
              return
              <owl:datatypeproperty rdf:id="{$name}">
                <rdfs:domain rdf:resource="#{$name}"/>
              </owl:datatypeproperty>
         )              
    }
</rdf:rdf>