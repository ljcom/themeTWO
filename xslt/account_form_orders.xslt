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
			LoadNewPart('account_form_orders_child', 'orders', 'tapcs3deta', "parentdocguid='"+getGUID()+"'", '', 1, 200, 'productname asc');
		</script>
		<div class="col-xs-12">
			<div class="innerWrapper singleOrder">
				<div class="orderBox">
					<h4>
						Order No :   <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='DocNo']/textBox/value/." />
					</h4>
				</div>
				<div class="row">
					<div class="col-sm-6 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">Shipping Address</h4>
							</div>
							<div class="panel-body">
								<address>
									<strong id="">
										<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='CustomerName']/textBox/value/." />
									</strong>
									<br />
									<span id="PCSO_CustomerAddress_browse">
										<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='CustomerAddress']/textBox/value/." />
									</span>
									<br />
									<span id="PCSO_City_browse">
										<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='City']/textBox/value/." />
									</span>
									<br/>
									<span id="PCSO_Country_browse">
										<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='Country']/textBox/value/." />
									</span>
								</address>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">Payment Method</h4>
							</div>
							<div class="panel-body">
								<address>
									<span id="paymentName_browse">
										<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='PaymentName']/textBox/value/." />
									</span>
								</address>
							</div>
						</div>
					</div>
					<div class="col-xs-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">Order Details</h4>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-sm-4 col-xs-12">
										<address>
											<a href="#">
												Email:
												<span id="PCSO_personalEmail_browse">
													<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='personalEmail']/textBox/value/." />
												</span>
											</a> <br />
											Phone : +<span id="PCSO_Phone_browse">
												<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='phone']/textBox/value/." />
											</span>
										</address>
									</div>
									<div class="col-sm-8 col-xs-12">
										<address>
											<span>Additional Information: </span>
											<br />
											<p>For Additional Information</p>
										</address>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-12" style="margin-bottom:20px;">
						<div class="cartListInner">
							<div class="table-responsive" id="orders">
								Loading Please Wait...
							</div>
							<div class="totalAmountArea">
								<div class="col-sm-4 col-sm-offset-8 col-xs-12">
									<ul class="list-unstyled">
										<li>
											Sub Total <span>
												Rp.  <xsl:value-of select="format-number(sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='TotalSales']/textBox/value/., '#,##0', 'dot-dec')" />
											</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">STATUS</h4>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-sm-12 col-xs-12">
										<!--xsl:value-of select="comments" /-->
										<xsl:choose>
											<xsl:when test="sqroot/body/bodyContent/form/info/state/status=0">
												<strong>DRAFT</strong> - Your order stock will be checked before the payment process continue. Please click CONFIRM to let the order proceed.
											</xsl:when>
											<xsl:when test="sqroot/body/bodyContent/form/info/state/status=110">
												<strong>STOCK CONFIRMATION</strong> - Your order stock is on checking. Please wait.
											</xsl:when>
											<xsl:when test="sqroot/body/bodyContent/form/info/state/status=120">
												<strong>WAITING FOR PAYMENT</strong> - Your order stock has been confirmed. Please proceed for payment.
											</xsl:when>
											<xsl:when test="sqroot/body/bodyContent/form/info/state/status=410">
												<strong>WAITING FOR DELIVERY</strong> - Your order is proccesing. Please wait.
											</xsl:when>
                      <xsl:when test="sqroot/body/bodyContent/form/info/state/status=140">
                        <strong>ORDER EXPIRED</strong> - Your order is expired.
                      </xsl:when>
                      <xsl:when test="sqroot/body/bodyContent/form/info/state/status=300">
												<strong>ORDER EXPIRED</strong> - Your order is expired.
											</xsl:when>
											<xsl:when test="sqroot/body/bodyContent/form/info/state/status=420">
												<strong>GOODS ARRIVED</strong> - Your order is ready. Please pick up immediately.
											</xsl:when>
											<xsl:when test="sqroot/body/bodyContent/form/info/state/status=500">
												<strong>ORDER COMPLETED</strong> - Your order is completed. Thank you.
											</xsl:when>
                      <xsl:when test="sqroot/body/bodyContent/form/info/state/status=510">
                        <strong>ORDER EXPIRED</strong> - Your order is expired.
                      </xsl:when>
										</xsl:choose>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!--<div class="col-xs-12">
            <div class="btn-group" role="group" aria-label="...">
              <button type="button" class="btn btn-default">Print</button>
              <button type="button" class="btn btn-default">Save to pdf</button>
              <button type="button" class="btn btn-default">cancel order</button>
            </div>
          </div>-->
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
