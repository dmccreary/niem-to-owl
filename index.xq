xquery version "1.0";
declare option exist:serialize "method=html media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'NIEM Transform Library'

return
<html>
   <head>
     <title>{$title}</title>
     <style><![CDATA[
     h1 {color:blue;}
     a {margin-left: 10px;}
     ]]></style>
   </head>
   <body>
        <h1>{$title}</h1>
        
        <h2>Views</h2>
        <a href="views/niem-to-html.xq">NIEM to HTML</a><br/>
        <a href="views/niem-to-owl.xq">NIEM to OWL</a><br/>
     
        <h2>Data Source</h2>
        <a href="data/niem-core.xsd">niem-core.xsd</a><br/>
    </body>
</html>