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
                <script>
                  
                  var GUIDs = '<xsl:value-of select="sqroot/body/bodyContent/form/info/GUID/." />'
                  LoadNewPart('cart_childform', 'contentcart', 'tapcs1deta', "parentdocguid='"+GUIDs+"'", '', 1, 20);
                </script>
              </div>
              <div class="updateArea">
                <!--<div class="input-group">
                  <input type="text" class="form-control" placeholder="I have a discount coupon" aria-describedby="basic-addon2" />
                  <a href="#" class="btn input-group-addon" id="basic-addon2">apply coupon</a>
                </div>-->
                <a onclick="batchSave('taPCS1DETA')" class="btn">update cart</a>
              </div>

              <div class="totalAmountArea">
                <div class="col-sm-4 col-sm-offset-8 col-xs-12">
                  <ul class="list-unstyled">
                    <li>
                      Total (Include PPN) <span>Rp.  <xsl:value-of select="format-number(sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection/formCols/formCol/formRows/formRow[@rowNo='2']/fields/field/textBox/value/., '#,##0', 'dot-dec')" /></span>
                    </li>
					<li>
						Total Weight 
						<span>Rp.  <xsl:value-of select="format-number(sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='totalWeight']/textBox/value/., '#,##0.00', 'dot-dec')" />&#160;kg</span>
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
              <div class="checkBtnArea" id="checkoutbutton">
               <a id="checkoutbutton1" href="index.aspx?env=front&amp;code=tapcsd&amp;GUID={sqroot/body/bodyContent/form/info/GUID/.}" class="btn btn-primary btn-block">
                  <span>checkout </span>
                  <ix class="fa fa-arrow-circle-right" aria-hidden="true"></ix>
                </a>
                <a onclick="goToProductBrowse()" 
                   class="btn btn-primary " style="position:absolute;left:50px; width:250px;"