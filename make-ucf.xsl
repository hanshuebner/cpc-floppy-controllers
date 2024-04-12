<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <!-- Match "node" elements -->
  <xsl:template match="node[@ref='U2']">
    <xsl:text>PIN "</xsl:text>
    <xsl:variable name="name" select="replace(replace(lower-case(../@name), '~\{(.*)\}', '$1_n'), '^/', '')"/>
    <xsl:value-of select="$name" />
    <xsl:text>" LOC = P</xsl:text>
    <xsl:value-of select="@pin" />
    <xsl:text>;&#10;</xsl:text>
  </xsl:template>

  <!-- Default template -->
  <xsl:template match="text()|@*">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
