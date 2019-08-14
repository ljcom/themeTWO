<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
	<xsl:apply-templates select="sqroot/body/bodyContent/browse/info/filters/comboFilter" />
	
  </xsl:template>
<!--filters-->
  <xsl:template match="sqroot/body/bodyContent/browse/info/filters/comboFilter">
    <div class="panel panel-default">
      <div class="panel-heading"><xsl:value-of select="@caption" /></div>
      <div class="accordian-body collapse in top-menu-div product-menu" id="demo5">
        <div class="panel-group" id="accordion2">
          <!-- SIDEBAR -->
          <!--<xsl:apply-templates select="sqroot/header/menus/menu[@code='catagory']/submenus/submenu" />-->
          <div id="{@id}_Menu" class="sidebar_cascade">
            <script>
              if (getQueryVariable("GUID") == undefined){
                //var xslfile = '<xsl:value-of select="@caption" />';
                var id = '<xsl:value-of select="@id" />'+'_Menu';
                var colkey = '<xsl:value-of select="@id" />';
                var prnt = '<xsl:value-of select="@Parent" /> is null';
                //LoadNewPart('catagory', id, getCode(), prnt, '', '1', '200', 'id asc');
				LoadFilter('category', id, getCode(), colkey, '00000000-0000-0000-0000-000000000000');
              }
            </script>       
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  
  </xsl:stylesheet>