niem-to-owl
===========

# Convert the National Information Exchange Model XML Schema file to OWL file.

This is an XQuery script designed to demonstrate how to convert the NIEM XML Schema to OWL format.

I have tested this script using the eXist native XML database.  To use the script you must:

## How to Use
1. download the NIEM XML Schema and find the niem-core.xsd file
2. create a collection /db/apps/niem-to-owl and add a data and views subfolders
2. upload the XSD files into eXist in /db/apps/niem-to-owl/data/niem-core.xsd
3. upload the XQuery into the /db/apps/niem-to-owl/views
4. run the script by putting http://localhost:8080/exist/rest/apps/niem-to-owl/views/niem-to-owl.xq into your browser
5. load the resulting transform into your OWL tool

I originally created this after a question on a webinar.
The normal way I did this was to convert the NIEM into a metadata registry and then generate the OWL file.
However since the core NIEM elements are in a single XSL file I pointed out the transform would
be easy.  I like OWL files because they were way to validate that my transforms to a sub-schema were correct and that all
classes and superclasses were included.

The script is quite limited now and only converts classes and properties.  It does not deal with enumerations.

Please contact me if you are interested in any enhancements.

I am considering several enhancements if there is interest

1. Create a EXPath package (xar file) to make it easy to use
2. Add an ant target to make it easy to download the current NIEM xsd
3. Add a HTTP GET function to load the data directly into eXist
4. Add HTML reports to show classes and properites

Please let me know if there is any interest in this topic.
