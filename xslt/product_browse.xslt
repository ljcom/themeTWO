<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
	<script>
	var nbPages='<xsl:value-of select="sqroot/body/bodyContent/browse/info/nbPages" />';
	var curPg = parseInt('<xsl:value-of select ="sqroot/body/bodyContent/browse/info/pageNo"/>');

	setCookie('nbPages', nbPages, 0, 1, 0);
	nbPages=parseInt(nbPages);
	if (nbPages==0 || nbPages==curPg) {
		if (!$('#loadingnextpage').hasClass('hide')) $('#loadingnextpage').addClass('hide');
	}
	else {
		if ($('#loadingnextpage').hasClass('hide')) $('#loadingnextpage').removeClass('hide');
	}
	var nbRows=parseInt('<xsl:value-of select="sqroot/body/bodyContent/browse/info/nbRows/." />');
	var tRows=parseInt('<xsl:value-of select="sqroot/body/bodyContent/browse/info/TotalRows/." />');
	var cRows=parseInt($('#nbProd').html());
	if (curPg==1) cRows=0;
	if (isBigger(cRows+nbRows, tRows)) nbRows=tRows-cRows;
	$('#nbProd').html(cRows+nbRows);
	$('#ttlProd').html(tRows);
	</script>
      <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
  </xsl:template>
  
  <!--Data Content-->
  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <!--image src-->
    <xsl:variable name="imageprod">OPHContent/documents/<xsl:value-of select="/sqroot/header/info/account/."/>/<xsl:value-of select="fields/field[@caption = 'productphotos']/." /></xsl:variable>
    
    <div class="col-sm-6 col-md-4 col-xs-12">
      <div class="productBox">
        <div class="productImage clearfix">
          <div style="height:250px; text-align:center">
            <img style="max-height:200px;  width: auto;" src="{$imageprod}" onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="products-img" class="productgridimage"/>
          </div>
          <div class="productMasking">
            <ul class="list-inline btn-group" role="group" style="text-align:center">
              <!--<li><a data-toggle="modal" href=".login-modal" class="btn btn-default"><ix class="fa fa-heart"></ix></a></li>-->
              <li>
                <form method="post" id="productform_{@GUID}">
                  <!--untuk insert dipaksa ada input-->
                  <input type="hidden" class="cartidclass" name="cartID" value="" />
                  <input type="hidden" name="Availaible" value="1" />
                  <input type="hidden" name="EVENPSKUGUID" value="{@GUID}" />
                  <input type="hidden" value="{fields/field[@caption = 'PRODGUID']/.}" name="PRODGUID"/>
                  <input type="hidden" name="price" value="{fields/field[@caption = 'price']/.}" />
                  <!--btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'save');-->
                  <a onclick="saveThemeTWO('{../../info/code/.}', '{@GUID}', '', 'productform_{@GUID}');" class="btn btn-default" >
                    <ix class="fa fa-shopping-cart"></ix>
                  </a>
                </form>
               
              </li>
              <!--<li><a class="btn btn-default" data-toggle="modal" href=".quick-view" onclick="LoadNewPartView('product_form_quick_view', 'quickViewProd', 'maPRODFRON', '{@GUID}');" ><ix class="fa fa-eye"></ix></a></li>-->
              <li><a class="btn btn-default" onclick="showProduct('{@GUID}')"><ix class="fa fa-eye"></ix></a></li>
            </ul>
          </div>
        </div>
        <div class="productCaption clearfix">
          <a  href="#" onclick="showProduct('{@GUID}')">
            <h5 style="height:30px;">
              <xsl:value-of select="fields/field[@caption = 'id']/." /> - <xsl:value-of select="fields/field[@caption = 'Name']/." /><br />
            </h5>
          </a>
          <!--<p style="margin:0; padding:0;">
            Code : <xsl:value-of select="fields/field[@caption = 'ID']/." />
          </p>-->
          <p style="margin:5px 0 5px 0; padding:0;">
            <!--Division : <xsl:value-of select="fields/field[@caption = 'divisionName']/." />-->
            Signature : <xsl:value-of select="fields/field[@caption = 'SignatureName']/." />
          </p>
          <xsl:choose>
            <xsl:when test="(fields/field[@caption = 'evenname']/.)!='Website online'">
              <span class="sticker"><xsl:value-of select="fields/field[@caption = 'evenname']/." /></span>
            </xsl:when>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="(fields/field[@caption = 'evenname']/.)!='Website online'">
              <span class="sticker">
                <xsl:value-of select="fields/field[@caption = 'evenname']/." />
              </span>
            </xsl:when>
          </xsl:choose>
          <div style="height:40px;">
            <xsl:choose>
              <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
                <span style="text-decoration:line-through; font-size:12px;">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></span><br />
                <span style="font-size:20px; ">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
                  <span style="font-size:12px; color:white; padding:5px; margin-top:-30px !important; margin-left:10px; background:#47bac1;"><xsl:value-of select="fields/field[@caption = 'discount']/." />%</span><br />
                </span>
              </xsl:when>
              <xsl:when test="(fields/field[@caption = 'price']/.) != (fields/field[@caption = 'priceDiscount']/.)">
                <span style="text-decoration:line-through; font-size:12px;">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></span><br />
                 <span style="font-size:20px; ">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
                </span>
              </xsl:when>
              <xsl:otherwise>
                <span style="font-size:20px;">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></span><br />
              </xsl:otherwise>
            </xsl:choose>
            <!--<h3 style="font-size:20px;">
              Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
            </h3>-->
          </div>
        </div>
      </div>
    </div>

  </xsl:template>

</xsl:stylesheet>
