xquery version "1.0";

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
declare option exist:serialize "method=html media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'NIEM Classes to HTML'

(: This is the file path.  Change this line if you put the file into another location :)
let $file-path := '/db/apps/niem-to-owl/data/niem-core.xsd'
let $doc := doc($file-path)

return
<html>
   <head>
     <title>{$title}</title>
     <style><![CDATA[
     .niem-class {color:blue;}
     .property {color:black; margin-left: 10px;}
     ]]></style>
   </head>
   <body>
   <h1>NIEM Core Classes to HTML</h1>
      {
        (: We first get all the complex elements in the file.  For each complex element create an owl class. :)
        for $complex-element at $count in $doc//xsd:complexType[@name]
            let $name := string($complex-element/@name)
            order by $name
              return
                 (: for each class, put the class name in and put the parent class in the subclass element :)
                 <div class="niem-class">
                    <div class="nime-class-name">Class: {$name}</div>
                     Sub class of: {string($complex-element//xsd:extension/@base)}<br/>
                     Documentation: {$complex-element/xsd:annotation/xsd:documentation/text()}<br/>
                     Properties:
                     {
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
                            <div class="property">{$name}</div>
                      }
             </div>     
     }
   </body>
</html>