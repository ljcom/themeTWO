<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="code">
     <xsl:value-of select="sqroot/header/info/code/id/." />

  </xsl:variable>
  
  <xsl:template match="/">
    <xsl:apply-templates select="sqroot/options/option" />
  </xsl:template>
  
  <xsl:template match="sqroot/options/option">
        <xsl:if test="value/.!='NULL'">
			<div class="panel-group">
			  <div class="panel panel-default" style="border-radius:0; margin-top:0;" >
				<a id="{value/.}_a" class="top-envi" data-toggle="collapse" href="#{value}_submenu">
				  <!--span style="width:70%; display:inline-table; line-height:14px;"  onclick="loadProduct(null, 'All{/sqroot/colkey}=\'{value/.}\'');"-->
				  <span style="width:70%; display:inline-table; line-height:14px;"  onclick="loadProduct('{value/.}');">
					<xsl:value-of select="caption/." />
				  </span>
				  <span class="fa fa-plus plus-button" id="plus-button-{../../@GUID}" 
					style="position:absolute; right:15px; top:18px; font-size:12px; color:#4c4c4c"
					onclick="loadFilter_{translate(value/.,'-','')}()">&#xA0;</span>
				 </a>
				 <div class="panel-collapse collapse" id="{value/.}_submenu" style="padding-left:15px">
				 </div>
				<script>
					function loadFilter_<xsl:value-of select="translate(value/.,'-','')" />() {
						if (($('#<xsl:value-of select="value/." />_submenu').parent().parent().parent().hasClass('sidebar_cascade') ||
								$('#<xsl:value-of select="value/." />_submenu').parent().parent().parent().hasClass('in'))
							&#38;&#38; $('#<xsl:value-of select="value/." />_submenu').html()=='') {			
						
							var guid='<xsl:value-of select="value/." />';
							var id=guid+'_submenu';
							LoadFilter('category', id, getCode(), '<xsl:value-of select="/sqroot/colkey" />', guid);
						}
						else {
							$('#<xsl:value-of select="value/." />_submenu').find('span.fa').each(function(i) {
								eventFire(this, 'click');
							});
						}
					}
					
					loadFilter_<xsl:value-of select="translate(value/.,'-','')" />()
				</script>
			  </div>
			</div>  
        </xsl:if>


  </xsl:template>


</xsl:stylesheet>
