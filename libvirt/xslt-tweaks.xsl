<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/domain/devices/graphics[@type='vnc']">
    <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xsl:attribute name="websocket">-1</xsl:attribute>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/domain/devices">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <tpm model='tpm-tis'>
        <backend type='emulator' version='2.0'/>
        <alias name='tpm0'/>
      </tpm>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
