<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:template match="/">
    <script>
      <!--loadScript('https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/jquery-ui/jquery-ui.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.tools.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/rs-plugin/js/jquery.themepunch.revolution.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/selectbox/jquery.selectbox-0.1.3.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/countdown/jquery.syotimer.js');
      loadScript('OPHContent/themes/themeTWO/scripts/custom-me.js');-->

      loadScript('OPHContent/themes/themeTWO/scripts/bootstrap/js/bootstrap.min.js');
      loadScript('OPHContent/themes/themeTWO/scripts/owl-carousel/owl.carousel.js');
      loadScript('OPHContent/themes/themeTWO/scripts/js/custom.js');

      $('.homeslider').css('display', 'block');
      $('#loadingslider').remove();
    </script>
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
  </xsl:template>
  

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
   <div class="col-md-6 col-xs-12">
      <div class="category-content">
        <div class="category-top">
          <div class="category-menu text-center">
            <h2 class="category-title"><xsl:value-of select="fields/field[@caption = 'Name']/."/>  </h2>
            <ul id="{@GUID}_catagories">

              <xsl:variable name="ctgr">
                <xsl:value-of select="fields/field[@caption='subctgr']" />
              </xsl:variable>
              <xsl:choose>
                <xsl:when test="boolean($ctgr)">
                  <xsl:call-template name="tokenctgr">
                    <xsl:with-param name="list" select="$ctgr" />
                    <xsl:with-param name="delimiter" select="';'"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise/>
              </xsl:choose>

            </ul>
          </div>
          <div class="category-Slider" id="prod-feature_{@GUID}">
            <div class="owl-carousel categorySlider" >
              <div class="item" style="height:400px;">
                <img style="max-height:300px;  width:auto;  margin:0 auto; " src="OPHContent/themes/themeTWO/images/product/1_{fields/field[@caption = 'Name']/.}.jpg" onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="Image" />
              </div>
              <div class="item" style="height:400px;">
                <img style="max-height:300px; width:auto;  margin:0 auto;" src="OPHContent/themes/themeTWO/images/product/2_{fields/field[@caption = 'Name']/.}.jpg" onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="Image" />
              </div>
              <div class="item" style="height:400px;">
                <img style="max-height:300px; width:auto; margin:0 auto;" src="OPHContent/themes/themeTWO/images/product/3_{fields/field[@caption = 'Name']/.}.jpg" onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="Image" />
              </div>
            </div>
          </div>
          <div class="category-bottom" id="productfeature_{@GUID}">

            <xsl:variable name="prod">
              <xsl:value-of select="fields/field[@caption='products']" />
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="boolean($prod)">
                <xsl:call-template name="tokenprod">
                  <xsl:with-param name="list" select="$prod" />
                  <xsl:with-param name="delimiter" select="';'"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>


          </div>
          <script>
            //var search2 = '<xsl:value-of select="@GUID" />';
            //var id = 'productfeature_<xsl:value-of select="@GUID" />';
            //LoadNewPart('home_browse_feature_catagory', id, 'maprodfron', '', search2, '1', '3' , 'availaible desc');
          </script>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="tokenctgr">
    <!--passed template parameter -->
    <xsl:param name="list"/>
    <xsl:param name="delimiter"/>
    <xsl:choose>
      <xsl:when test="contains($list, $delimiter)">
        <xsl:variable name="ctgrguid">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'guid:'), ',')"/>
        </xsl:variable>
        <li>
          <a href="?code=maprodfron&amp;bSearchText={$ctgrguid}"><xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'name:'), ',')"/></a>
        </li>
        <xsl:call-template name="tokenctgr">
          <!-- store anything left in another variable -->
          <xsl:with-param name="list" select="substring-after($list,$delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$list = ''">
            <xsl:text/>
          </xsl:when>
          <xsl:otherwise>
            <color>
              <xsl:value-of select="$list"/>
            </color>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="tokenprod">
    <!--passed template parameter -->
    <xsl:param name="list"/>
    <xsl:param name="delimiter"/>
    <xsl:choose>
      <xsl:when test="contains($list, $delimiter)">
        <xsl:variable name="prodguid">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'guid:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="evenpskuguid">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'evenpskuguid:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="prodid">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'id:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="prodname">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'name:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="prodsignature">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'signature:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="prodphotos">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'photo:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="prodprice">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'price:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="prodpricedisc">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'pricedisc:'), ',')"/>
        </xsl:variable>
        <xsl:variable name="proddisc">
          <xsl:value-of select="substring-before(substring-after(substring-before($list,$delimiter),'disc:'), ',')"/>
        </xsl:variable>

        <div class="imageBox">
          <div class="productImage clearfix">
            <a href="single-product.html">
              <div style="height:150px; text-align:center;">
                <img style="max-height:130px; width:auto; margin:0 auto;" src="ophcore/api/msg_download.aspx?imageName=OPHContent/documents/{/sqroot/header/info/account/.}/{$prodphotos}" onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="Image" />
              </div>
            </a>
            <div class="productMasking">
              <ul class="list-inline btn-group" role="group" style="text-align:center">
                <!--<li><a data-toggle="modal" href=".login-modal" class="btn btn-default"><ix class="fa fa-heart"></ix></a></li>-->
                <li>
                  <form method="post" id="productform_{$prodguid}">
                    <!--untuk insert dipaksa ada input-->
                    <input type="hidden" id="cartID" class="cartidclass" name="cartID" value="" />
                    <input type="hidden" name="Availaible" value="1" />
                    <input type="hidden" name="EVENPSKUGUID" value="{$evenpskuguid}" />
                    <input type="hidden" value="{$prodguid}" name="PRODGUID"/>
                    <input type="hidden" name="price" value="{$prodprice}" />
                    <a onclick="AddToCart('{../../info/code/.}', 'productform_{$prodguid}')" class="btn btn-default">
                      <ix class="fa fa-shopping-cart"></ix>
                    </a>
                  </form>
                </li>
                <li>
                  <a data-toggle="modal" href="index.aspx?env=front&amp;code=maprodfron&amp;GUID={$prodguid}" class="btn btn-default">
                    <ix class="fa fa-search"></ix>
                  </a>
                </li>
              </ul>
            </div>
          </div>
          <div class="productCaption clearfix">
            <a href="index.aspx?env=front&amp;code=maprodfron&amp;GUID={$prodguid}">
              <h5 class="resize-font-8px" style="height:40px;">
                <xsl:value-of select="$prodid" /> - <xsl:value-of select="$prodname" /><br />
              </h5>
            </a>
            <!--<p style="margin:0; padding:0;">
            Code : <xsl:value-of select="fields/field[@caption = 'ID']/." />
            </p>-->
            <p class="resize-font-7px" style="margin:0; padding:0;  height:35px; line-height:13px;">
              <!--Division : <xsl:value-of select="fields/field[@caption = 'divisionName']/." />-->
              Signature :<br/> <xsl:value-of select="$prodsignature" />
            </p>
            <div style="height:40px;">
              <xsl:choose>
                <xsl:when test="($proddisc)!= '0'">
                  <span class="resize-font-7px"  style="text-decoration:line-through; font-size:0.750em;">
                    Rp. <xsl:value-of select="format-number($prodprice, '#,##0', 'dot-dec')" />
                  </span>
                  <br />
                  <span class="resize-font-8px"  style="font-size:1.375em; ">
                    Rp. <xsl:value-of select="format-number($prodpricedisc, '#,##0', 'dot-dec')" />
                    <span class="resize-font-7px bgThemeColor"  style="font-size:12px; color:white; padding:5px; margin-top:-30px !important; margin-left:10%;">
                      <xsl:value-of select="$proddisc" />%
                    </span><br />
                  </span>
                </xsl:when>
                <xsl:when test="($prodprice) != ($prodpricedisc)">
                  <span class="resize-font-7px"  style="text-decoration:line-through; font-size:0.750em;">
                    Rp. <xsl:value-of select="format-number($prodprice, '#,##0', 'dot-dec')" />
                  </span>
                  <br />
                  <span class="resize-font-8px"  style="font-size:1.375em; ">
                    Rp. <xsl:value-of select="format-number($prodpricedisc, '#,##0', 'dot-dec')" />
                  </span>
                </xsl:when>
                <xsl:otherwise>
                  <span class="resize-font-7px"  style="font-size:1.375em;">
                    Rp. <xsl:value-of select="format-number($prodprice, '#,##0', 'dot-dec')" />
                  </span>
                  <br />
                </xsl:otherwise>
              </xsl:choose>
              <!--<h3 style="font-size:20px;">
              Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
            </h3>-->
            </div>
          </div>
        </div>


        <xsl:call-template name="tokenprod">
          <!-- store anything left in another variable -->
          <xsl:with-param name="list" select="substring-after($list,$delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$list = ''">
            <xsl:text/>
          </xsl:when>
          <xsl:otherwise>
            <color>
              <xsl:value-of select="$list"/>
            </color>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
