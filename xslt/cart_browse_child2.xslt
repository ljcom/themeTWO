<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">

    <input type="hidden" id="cfunctionlist"/>
    <table class="table">
      <thead>
        <tr>
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column" />
        </tr>
      </thead>
      <tbody>
        <tr>
          <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
        </tr>
      </tbody>
    </table>

    

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column">

    <xsl:choose>
      <xsl:when test="(@fieldName)!='TotalSales' and (@fieldName)!='TotalQty' and (@fieldName)!='EVENPSKUGUID'">
        <th style="width:{@width}px">
          <xsl:value-of select="translate(titleCaption/., $smallcase, $uppercase)" />
        </th>
      </xsl:when>
	  <xsl:otherwise>
	  </xsl:otherwise>

    </xsl:choose>


  </xsl:template>

  <!--Data Content-->

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr>
      <xsl:apply-templates select="fields" />
    </tr>

  </xsl:template>

  <xsl:template match="fields">
        <td class="col-xs-2">
          <span class="cartImage" style="height:70px;" >
            <img src="ophcore/api/msg_download.aspx?imageName=OPHContent/documents/{/sqroot/header/info/account/.}/{field[@caption = 'productphotos']/.}&amp;size=130" 
				onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'"
				alt="image" style="height:100%; width:auto; margin:0 auto;" />
          </span>
        </td>
		<td id="{field[@caption = 'productname']/@caption}">
          <xsl:value-of select="field[@caption = 'productname']/." />
		</td>
        <td style="text-align:center">
          <xsl:value-of select="format-number(field[@caption = 'Price']/., '#,##0', 'dot-dec')" />
        </td>
        <td class="col-xs-2" style="text-align:center" id="{field[@caption = 'Qty']/@caption}">
          <xsl:value-of select="format-number(field[@caption = 'Qty']/., '#,##0', 'dot-dec')" />
        </td>
        <td style="text-align:center">
			<xsl:choose>
				<xsl:when test="(field[@caption = 'QtyConfirm']/.)!=''">
					<xsl:value-of select="format-number((field[@caption = 'QtyConfirm']/.), '#,##0', 'dot-dec')" />
				</xsl:when>
			</xsl:choose>
        </td>
        <td style="text-align:center">
          <xsl:value-of select="format-number(field[@caption = 'TotalPrice']/., '#,##0', 'dot-dec')" />
        </td>
    <script>
		var basket = document.getElementById('BASKET').value
		document.getElementById('BASKET').value = basket + '<xsl:value-of select="field[@caption = 'productname']/." />'
			+ ','+'<xsl:value-of select="field[@caption = 'Qty']/." />'
			+ ','+<xsl:value-of select="format-number(field[@caption = 'Price']/., '#.00')" />
			+ ','+<xsl:value-of select="format-number(field[@caption = 'TotalPrice']/., '#.00')" />+';';
		document.getElementById('BASKETTOTAL').value = parseInt(document.getElementById('BASKETTOTAL').value) 
			+ <xsl:value-of select="format-number(field[@caption = 'TotalPrice']/., '0')"/>;
      
    </script>

  </xsl:template>
</xsl:stylesheet>
