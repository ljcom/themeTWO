<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">

    <!-- CONTENT SECTION -->
    <section class="content clearfix">
      <div class="container">

        <!-- FEATURE COLLECTION SECTION -->
        <div class="row featuredCollection version2 version3">
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='slider2']/submenus/submenu" />
        </div>
        <div class="categorySection">
          <div class="row" id="featurehome">
            <script>
              LoadNewPart('home_browse_feature2', 'featurehome', 'mactgrhome2', '', '');
              //LoadNewPart('home_browse_feature', 'featurehome', 'mactgrhome', '', '');
            </script>
          </div>
        </div>
      </div>
    </section>
  </xsl:template>
  

  
  <!--slider2-->
  <xsl:template match="sqroot/header/menus/menu[@code='slider2']/submenus/submenu">
    <xsl:variable name="oriDesc" select="MenuDescription/." />
	<input type="hidden" id="cartID" class="cartidclass" name="cartID" value="" />
    <div class="col-sm-6 col-xs-12" >
      <div style=" background:#F1E39A; padding:10px" class="banner2">
        <div class="row">
          <div class="col-sm-6" style="text-align:center;">
            <img src="OPHContent/documents/{/sqroot/header/info/account/.}/{pageURL/.}" onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="image" />
          </div>
          <div class="col-sm-6 col-xs-12" >
            <h3>
              <a href="{icon_url/.}" style="color:black; font-weight:bold;">
                <xsl:value-of select="caption/." />
              </a>
            </h3>
            <p>
              <xsl:choose>
                <xsl:when test="string-length(MenuDescription/.) &gt; 100">
                  <xsl:value-of select="concat(substring($oriDesc, 1, 100), '...')" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$oriDesc" />
                </xsl:otherwise>
              </xsl:choose>
            </p>
            <xsl:if test="link/. != ''">
              <a href="{link/.}" class="btn btn-border">Shop Now</a>
            </xsl:if>
          </div>
        </div>

      </div>
     
    </div>
  </xsl:template>
</xsl:stylesheet>
