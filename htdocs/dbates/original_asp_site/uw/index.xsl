<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:variable name="Folder"/>

<xsl:template match="item" xml:space="preserve">
	<tr>
		<td class="dl"><xsl:value-of select="@time"/></td>
		<td class="dl"><a><xsl:attribute name="href">view.aspx?id=<xsl:value-of select="@file"/>&amp;UWROOT=<xsl:value-of select="$Folder"/></xsl:attribute><xsl:value-of select="@file"/></a></td>
		<td class="dl"><xsl:value-of select="@size"/></td>
		<td class="dl"><xsl:value-of select="."/></td>
		<td class="dl"><a><xsl:attribute name="href">recvd.asp?id=<xsl:value-of select="@file"/></xsl:attribute>DELETE</a></td>
	</tr>
</xsl:template>  

                
</xsl:stylesheet>