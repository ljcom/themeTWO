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
        
        <div class="col-xs-12 col-sm-12 col-lg-12 col-md-12">
          <form action="#" method="post" id="productform">

            <input type="hidden" id="EVENPSKUGUID" name="EVENPSKUGUID" value="{../../../../../../info/GUID/.}" />
            <input type="hidden" id="cartID" name="cartID" value="" />
            <script>
              document.getElementById("cartID").value = getCookie("cartID");
              document.getElementById("productform").action = document.getElementById("productform").action+getCookie("cartID");
            </script>
			<div class="form-group">
				<label class="col-xs-12 col-md-12 col-sm-12 control-label" style="font-size:16px; color:black;">
				  Name : 
				</label>
				<div class="col-xs-12 col-md-12 col-sm-12 form-field">
					<input type="text" id="RefName" class="form-control" name="RefName" style="text-align:left" value="{sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='RefName']//value/.}" />
				</div>
			
				<label class="col-xs-12 col-md-12 col-sm-12 control-label" style="font-size:16px; color:black;">
					Email : 
				</label>
				<div class="col-xs-12 col-md-12 col-sm-12 form-field">
					<input type="text" id="RefEmail" class="form-control" name="RefEmail" style="text-align:left" value="{sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='RefEmail']//value/.}" />
				</div>
				
				<label class="col-xs-12 col-md-12 col-sm-12 control-label" style="font-size:16px; color:black;">
					SMS : 
				</label>
				<div class="col-xs-12 col-md-12 col-sm-12 form-field">
					<input type="text" id="RefSMS" class="form-control" name="RefSMS" style="text-align:left" value="{sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='RefSMS']//value/.}" />
				</div>
			</div>	
			<div class="form-group">
				<input type="hidden" name="isAgree" id="isAgree" class="form-field" value="{sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='isAgree']//value/.}"/>
				<div class="col-md-12 col-sm-12 input-group">
					<input type="checkbox" id="cbisAgree" class="form-control" name="cbisAgree" 
						style="text-align:left;width:60px" 
						onchange="checkCB('isAgree');">
						<xsl:if test="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='isAgree']//value/.=1">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>					
					</input>
					<label for="isAgree" style="padding-top:10px;font-size:16px;"><xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='isAgree']//titlecaption/." />					</label>	
				</div>

				
					
				
				
			</div>	
            <div class="btn-area form-field">
              <a class="btn btn-primary btn-block" onclick="saveThemeTWO('{sqroot/body/bodyContent/form/info/code/.}', '{sqroot/body/bodyContent/form/info/GUID/.}', '20', 'productform');">
                Save<span style="margin-left:50px; font-size:20px;">
                  <ix class="fa fa-angle-right" aria-hidden="true"></ix>
                </span>
              </a>
            </div>
          </form>
        </div>
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
