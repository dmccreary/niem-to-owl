niem-to-owl
===========

Convert the National Information Exchange Model XML Schema to OWL.

This is an XQuery script designed to demonstrate how to convert the NIEM XML Schema to OWL format.

I have tested this script using the eXist native XML database.  To use the script you must:

# download the NIEM XML Schema and find the niem-core.xsd file
# upload the XSD files into eXist in /db/niem-to-owl/data/niem-core.xsd
# upload the XQuery
# run the script
# load the resulting transform into your OWL tool

I originally created this as a way to validate that my transforms to a sub-schema were correct.

The script is quite limited now and only converts classes and properties.  It does not deal with enumerations.
