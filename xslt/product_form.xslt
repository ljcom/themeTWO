<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>


  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <!-- MAIN CONTENT SECTION -->
    <section class="mainContent clearfix" style="padding-top:0;padding-bottom:0">
      <div class="row singleProduct">
        <div class="col-xs-12 col-sm-12 col-lg-5 col-md-5 productSlider" id="productsliders">
          <div class="item active" data-thumb="0" style="text-align:center !important; height:400px;">
            <img style="margin:0 auto;  height:100%;  width: auto;" 
				src="OPHContent/documents/{sqroot/header/info/account/.}/{sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'productphotos']/textBox/value/.}"
				onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="image" />
          </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-lg-7 col-md-7">
          <form action="#" method="post" id="productform">

            <input type="hidden" id="EVENPSKUGUID" name="EVENPSKUGUID" value="{../../../../../../info/GUID/.}" />
            <input type="hidden" id="cartID" name="cartID" value="" />
            <script>
              document.getElementById("cartID").value = getCookie("cartID");
              document.getElementById("productform").action = document.getElementById("productform").action+getCookie("cartID");
            </script>
            <h2 id="productNames">
              <!--<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'Name']/textBox/value/." />-->
              <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'id']/textBox/value/." />&#160;-&#160;<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'Name']/textBox/value/." />
            </h2>
            <p style="margin:0; padding:0;  font-size:20px; color:black; margin-bottom:10px;">
              Signature : <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'SignatureName']/textBox/value/." />
            </p>
            <p style="margin:0; padding:0;  font-size:20px; color:black; margin-bottom:10px;">
              Brand : <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'BrandName']/textBox/value/." />
            </p>
            <h3>
              Rp. <xsl:value-of select="format-number(sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'priceDiscount']/textBox/value/., '#,##0', 'dot-dec')" />
            </h3>
            <input type="hidden" id="price" name="price" value="{sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'price']/textBox/value/.}" />
            <p style="font-size:20px; color:black;">
              Description : <br/>
              <span style="font-size:16px; color:black;">
                <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'Description']/textBox/value/." />
              </span>
            </p>
            <p  style=" font-size:20px; color:black;">
              Stock Available : <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'Availaible']/textBox/value/." />
            </p>
            <input type="hidden" value="{sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'PRODGUID']/textBox/value/.}" id="PRODGUID" name="PRODGUID"/>
            <input type="hidden" value="{sqroot/header/info/GUID/.}" id="GUID" name="GUID"/>
            <div style="display:none" id="CTGRGUIDs">
              <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'CTGRGUID']/textBox/value/." />
            </div>
            <span class="input-group" style="margin-bottom:20px;">
              <input type="number" id="qty" class="form-control" name="qty" style="width:70px;text-align:center" value="1" min="1" />
            </span>
            <div class="btn-area form-field">
              <a class="btn btn-primary btn-block" onclick="AddToCart('{sqroot/body/bodyContent/form/info/state/code/.}', 'productform', '{sqroot/header/info/GUID/.}')">
                Add to cart <span style="margin-left:50px; font-size:20px;">
                  <ix class="fa fa-angle-right" aria-hidden="true"></ix>
                </span>
              </a>
            </div>
          </form>
        </div>
      </div>
      <div class="row productsContent" id="relatedProduct">
        <script>
          var x = document.getElementById("PageTitle");
          x.innerHTML = 'PRODUCT DETAIL';

        </script>
      </div>
    </section>

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/formPages/formPage">
    <xsl:apply-templates select="formSections/formSection" />
  </xsl:template>

  <xsl:template match="formSections/formSection">
    <xsl:apply-templates select="formCols/formCol" />
  </xsl:template>

  <xsl:template match="formCols/formCol">
  </xsl:template>

  <xsl:template match="formRows/formRow">
  </xsl:template>

  <!--Children-->
  <xsl:template match="sqroot/body/bodyContent/form/children">
    <script>
      //var filter = "<xsl:value-of select="child/parentkey/." /> = '"+  document.getElementById("PRODGUID").value +"'" ;
      //LoadNewPart('product_form_child', 'productsliders', 'maprodfronfoto', filter, '');
      <!--alert(filter);-->
    </script>
  </xsl:template>
</xsl:stylesheet>
