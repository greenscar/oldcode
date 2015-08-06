<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml"/>

<xsl:template match="/" xml:space="preserve"><xsl:apply-templates select="*|@*|text()"/></xsl:template>

<xsl:template match="*|@*|text()" priority="-1">
    <xsl:copy><xsl:apply-templates select="*|@*|text()"/></xsl:copy>
</xsl:template>  

<xsl:template match="calculation" xml:space="preserve">
        <script language="javascript1.2" xml:space="preserve">
                <xsl:comment>DBForm.<xsl:apply-templates select="@target"/>.value=<xsl:value-of select="."/>;</xsl:comment>
        </script>
</xsl:template>  

<xsl:template match="function" xml:space="preserve">
        <script language="javascript1.2" xml:space="preserve">
                <xsl:comment>function <xsl:apply-templates select="@name"/> {DBForm.<xsl:value-of select="@target"/>.value=<xsl:value-of select="."/>;}</xsl:comment>
        </script>
</xsl:template>                       

<xsl:template match="display" xml:space="preserve">
        <script language="javascript1.2" xml:space="preserve">
                <span id="displayValue"><xsl:comment>document.write(DBForm.<xsl:value-of select="@target"/>.value=<xsl:value-of select="."/>);</xsl:comment></span>
        </script>
</xsl:template>                       

<xsl:template match="page" xml:space="preserve">
	<h3><xsl:value-of select="@title"/></h3><xsl:apply-templates select="*|@*|text()"/>
</xsl:template>                       

<xsl:template match="repeat|RepeatInstance|refDefault|refX|template|submission|xml" xml:space="preserve">
	<xsl:apply-templates select="*|@*|text()"/>
</xsl:template>                       

<xsl:template match="RepeatTemplate|Iterations|selection|excluded"/>

<xsl:template match="textarea" xml:space="preserve">
	<table id="FormerTextArea"><tr><td><xsl:value-of select="."/></td></tr></table>
</xsl:template>                       

<xsl:template match="select" xml:space="preserve">
	<span id='show'><xsl:value-of select="option[@selected]"/></span>
</xsl:template>                       

<xsl:template match="input[@type='text']" xml:space="preserve">
	<span id='show'><xsl:value-of select="@value"/></span>
</xsl:template>                       
<xsl:template match="input[@type='hidden']" xml:space="preserve">
	<span id='show'><xsl:value-of select="@value"/></span>
</xsl:template>                       
<xsl:template match="input[@type='radio']" xml:space="preserve">
	<xsl:choose>
		<xsl:when test="@checked=1">
			<span id='show'>X</span>
		</xsl:when>
		<xsl:otherwise>
			<span id="show" style="color: white;">_</span>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>                       
<xsl:template match="input[@type='checkbox']" xml:space="preserve">
	<xsl:choose>
		<xsl:when test="@checked=1">
			<span id='show'>X</span>
		</xsl:when>
		<xsl:otherwise>
			<span id="show" style="color: white;">_</span>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>                       

</xsl:stylesheet>
