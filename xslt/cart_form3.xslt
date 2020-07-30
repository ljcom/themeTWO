<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
  
    <section class="mainContent clearfix cartListWrapper" >
      <div class="container">
        <div class="row">
          <div class="col-xs-12">
            <div class="cartListInner">
              <div class="table-responsive" id="contentcart">
                Loading
              
              </div>
              <div class="totalAmountArea">
                <div class="col-sm-4 col-sm-offset-8 col-xs-12">
                  <ul class="list-unstyled">
                    <li>
                      Total (Include PPN) <span>Rp.  <xsl:value-of select="format-number(sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection/formCols/formCol/formRows/formRow[@rowNo='2']/fields/field/textBox/value/., '#,##0', 'dot-dec')" /></span>
                    </li>
                    <!--<li>
                      UK Vat <span>Rp. xxx</span>
                    </li>
                    <li>
                      Grand Total <span class="grandTotal">Rp. xxx.xxx</span>
                    </li>-->
                  </ul>
                </div>
              </div>
			  <div class="totalAmountArea">
			  Your order will be stock confirming by our system. If the stock avaiable, your order can be proceed to the delivery steps.
			  Are you sure to continue?
			  </div>
              <div class="checkBtnArea" id="checkoutbutton">
				<a data-toggle="modal" href="#" onclick="SaveData('taPCSd', 'formpayment', 'index.aspx?code=tapcsd', '', '1', 'tapcso')" 
					class="btn btn-primary btn-block">
                  <span>CONFIRM</span>
                  <ix class="fa fa-arrow-circle-right" aria-hidden="true"></ix>
                </a>
                <a href="#" 
                   onclick="goToProductBrowse()"
                   class="btn btn-primary " style="position:absolute;left:50px; width:250px;">
                    <ix class="fa fa-arrow-circle-left" aria-hidden="true">&#xA0;</ix>
                  <span> CONTINUE SHOPPING</span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <script>
      var GUIDs = '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/." />'
      LoadNewPart('cart_browse_child', 'contentcart', 'tapcs1deta', "parentdocguid='"+GUIDs+"'", '', 1, 200);
    </script>

  </xsl:template>
  
</xsl:stylesheet>
