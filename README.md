niem-to-owl
===========

# Convert the National Information Exchange Model XML Schema file to OWL file.

This is an XQuery script designed to demonstrate how to convert the NIEM XML Schema to OWL format.

I have tested this script using the eXist native XML database.  To use the script you must:

1. download the NIEM XML Schema and find the niem-core.xsd file
2. upload the XSD files into eXist in /db/niem-to-owl/data/niem-core.xsd
3. upload the XQuery
4. run the script
5. load the resulting transform into your OWL tool

I originally created this after a question on a webinar.
The normal way I did this was to convert the NIEM into a metadata registry and then generate the OWL file.
However since the core NIEM elements are in a single XSL file I pointed out the transform would
be easy.  I like OWL files because they were way to validate that my transforms to a sub-schema were correct and that all
classes and superclasses were included.

The script is quite limited now and only converts classes and properties.  It does not deal with enumerations.

Please contact me if you are interested in any enhancements.
