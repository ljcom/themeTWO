<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes"/>
	<xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
	<xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:template match="/">
		<script>
			loadScript('OPHContent/cdn/select2/select2.full.min.js');
			var deferreds = [];
			
			var code=getCode();
			if (code.toLowerCase()=='tapcsd') {
				gostep1();
			}
			else {
				$('#bar1').removeClass('active').addClass('complete').addClass('fullBar');
				$('#bar2').removeClass('disabled').addClass('active');
				$('#tab4default').addClass('active').addClass('in');
				$('#tab1default').removeClass('active').removeClass('in');
				$('.select2-selection').css('height', '50px').css('border-radius', '0').css('background-color', '#f0f0f0').css('border-color', '#f0f0f0');
				$('.select2-selection__arrow').css('height', '50px').css('width', '40px');
				$('.select2-selection__rendered').css('padding-top', '10px');
			}
			
			function gostep2() {
			if ($('#DeliveryFee').val()!='' &amp;&amp; $('#Address').val()!=''
				&amp;&amp; $('#CustomerName').val()!=''
				&amp;&amp; $('#PostalCode').val()!=''
				&amp;&amp; $('#Phone').val()!=''
				&amp;&amp; $('#provGUID').val()!=''
				&amp;&amp; $('#cityGUID').val()!=''
				&amp;&amp; $('#districtGUID').val()!=''
				&amp;&amp; $('#feeGUID').val()!='')
				
				{
					SaveData('taPCSd','formpayment', 'index.aspx?code=tapcsd&amp;GUID=<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', '0', '', '0', function() {
						window.location='index.aspx?code=taPCS2&amp;guid=<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>';
					});
					
					
				}
				else {
					showMessage('Please complete all the blank fields');
				}
			}
			
			function gostep1() {
				$('#bar2').removeClass('active').addClass('disabled');
				$('#bar1').addClass('active').removeClass('complete').removeClass('fullBar');
				$('#tab1default').addClass('active').addClass('in');
				$('#tab4default').removeClass('active').removeClass('in');
			}
		</script>
		<section class="mainContent clearfix stepsWrapper">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="panel with-nav-tabs innerWrapper clearfix stepsPage">
							<div class="panel-heading" style="border-bottom:0;">
								<ul class="nav nav-tabs" id="cart-tabs" style="border-bottom:0;">
									<div class="row progress-wizard" style="border-bottom:0; padding-bottom:20px;">
										<div id="bar1" class="col-xs-6 progress-wizard-step active">
											<div class="text-center progress-wizard-stepnum">Shipping Address</div>
											<div class="progress">
												<div class="progress-bar">&#160;</div>
											</div>
											<a href="#tab1default" data-toggle="tab" class="progress-wizard-dot" onclick="gostep1()">|</a>
										</div>
										<div id="bar2" class="col-xs-6 progress-wizard-step disabled">
											<div class="text-center progress-wizard-stepnum">Review</div>
											<div class="progress">
												<div class="progress-bar">&#160;</div>
											</div>
											<a data-toggle="tab" class="progress-wizard-dot" onclick="gostep2()">|</a>
										</div>
									</div>
								</ul>
							</div>
							<form role="form" id="formpayment" enctype="multipart/form-data" style="margin:0px;">
								<div class="panel-body">
									<div class="tab-content">
										<div id="tab1default">
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="sqroot/body/bodyContent/form/info/state/status=0">
														tab-pane fade in active
													</xsl:when>
													<xsl:otherwise>
														tab-pane fade in
													</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
											<!--form action="" class="row" method="POST" role="form"-->
											<xsl:apply-templates select="sqroot/body/bodyContent/form/formPages/formPage"/>
											<div class="col-xs-12">
												<div class="well well-lg clearfix">
													<ul class="pager">
														<li class="previous">
															<a href="?code=tapcs1&amp;GUID={sqroot/body/bodyContent/form/info/GUID/.}">back</a>
														</li>
														<li class="next">
															<a onclick="gostep2()">Continue</a>
														</li>
													</ul>
												</div>
											</div>
											<!--/form-->
										</div>
										<div id="tab4default">
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="sqroot/body/bodyContent/form/info/state/status=0">
														tab-pane fade
													</xsl:when>
													<xsl:otherwise>
														tab-pane fade in active
													</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
											<div class="col-xs-12">
												<div class="page-header">
													<h4>order review</h4>
												</div>
											</div>
											<div class="col-sm-6 col-xs-12">
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">Shipping Address</h4>
													</div>
													<div class="panel-body">
														<address>
															<strong id="documentnumber">
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='DocNo']/textBox/value/."/>
															</strong>
															<br/>
															<span id="PCSO_CustomerAddress_browse">
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='customerName']/textBox/value/."/>&#160;
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='Phone']/textBox/value/."/><br/>
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='Address']/textBox/value/."/>
															</span>
															<br/>
															<span id="PCSO_City_browse">
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='districtGUID']/autoSuggestBox/combovalue/."/>&#160;
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='cityGUID']/autoSuggestBox/combovalue/."/>
															</span>
															<br/>
															<span id="PCSO_City_browse">
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='provGUID']/autoSuggestBox/combovalue/."/>&#160;
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='PostalCode']/textBox/value/."/>
																
															</span>
															<br/>															
															<span id="PCSO_Country_browse">
																<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='Country']/textBox/value/."/>
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
															<!--<select style="width:300px;" name="guiest_id1" id="guiest_id1" class="select-drop" onchange="SortingBy('product', 'contentBrowse', getCode())">
                              <option value="name asc">Default sorting</option>
                              <option value="id asc">Order By Item Code</option>
                              <option value="priceDiscount Desc">Sort from the highest price</option>
                              <option value="priceDiscount Asc">Sort from the lowest price</option>
                            </select>-->
															<input type="hidden" value="{sqroot/body/bodyContent/form/info/GUID/.}" name="PCSOGUID"/>
															<input type="hidden" value="{sqroot/body/bodyContent/form/info/GUID/.}" name="cid"/>
															<xsl:apply-templates select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'PAYMGUID']/autoSuggestBox"/>
															<div style="margin-top:30px;">
																&#xA0;
															</div>
															<!--<a style="cursor:pointer; background:#47BAC1; color:white; padding:7px 15px; margin-top:15px; display:inline-block;" onclick="SaveData('taPCS2','formpayment', 'index.aspx?code=tapcs2&amp;GUID={sqroot/body/bodyContent/form/info/GUID/.}', '', '0')">Change Payment Type</a>-->
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
																			<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='PersonalEmail']/textBox/value/."/>
																		</span>
																	</a>
																	<br/>
																	Phone : +<span id="PCSO_Phone_browse">
																		<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='Phone']/textBox/value/."/>
																	</span>
																</address>
															</div>
															<div class="col-sm-8 col-xs-12">
																<address>
																	<span>Additional Information: </span>
																	<br/>
																	<p>For Additional Information</p>
																</address>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xs-12">
												<div class="cartListInner">
													<div class="table-responsive" id="contentcart">
														<script>
															var GUIDs = '<xsl:value-of select="sqroot/body/bodyContent/form/info/GUID/."/>';
															LoadNewPart('cart_browse_child2', 'contentcart', 'tapcs1deta', "parentdocguid='"+GUIDs+"'", '', 1, 200);
														</script>
													</div>
													<div class="totalAmountArea">
														<div class="col-sm-6 col-sm-offset-6 col-xs-12">
															<ul class="list-unstyled">
																<li>
																	Subtotal Rp.
																	<input id="Subtotal" value="{format-number(sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='Subtotal']/textBox/value/., '#,##0', 'dot-dec')}" readonly="" style="border-width:0;text-align:right" />
																	
																</li>
																<li>
																	Delivery Rp.
																	<input id="DeliveryFee" value="{format-number(sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='DeliveryFee']/textBox/value/., '#,##0', 'dot-dec')}" readonly="" style="border-width:0;text-align:right" />
																	
																</li>
																<li>
																	Total (Include PPN) Rp.
																	<input id="TotalAmount" value="{format-number(sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName='TotalSales']/textBox/value/., '#,##0', 'dot-dec')}" readonly="" style="border-width:0;text-align:right" />
																	
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
																<p>
																	<xsl:choose>
																		<xsl:when test="sqroot/body/bodyContent/form/info/state/status=0">
																			DRAFT - Your order is not submitted yet. Please click CONFIRM to let the order proceed.
																		</xsl:when>
																		<xsl:when test="sqroot/body/bodyContent/form/info/state/status=100">
																			ORDER SUBMITTED - Your order is delivering to SAP System. Please wait.
																		</xsl:when>
																		<xsl:when test="sqroot/body/bodyContent/form/info/state/status=110">
																			STOCK CONFIRMATION - Your order stock is on checking. Please wait.
																		</xsl:when>
																		<xsl:when test="sqroot/body/bodyContent/form/info/state/status=120">
																			WAITING FOR PAYMENT - Your order stock has been confirmed. Please proceed for payment.
																		</xsl:when>
																		<xsl:when test="sqroot/body/bodyContent/form/info/state/status=410">
																			WAITING FOR DELIVERY - Your order is on delivery. Please wait.
																		</xsl:when>
																		<xsl:otherwise>
																		</xsl:otherwise>
																	</xsl:choose>
																</p>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xs-12">
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">ATTENTION!</h4>
													</div>
													<div class="panel-body">
														<div class="row">
															<div class="col-sm-12 col-xs-12">
																<!--xsl:value-of select="comments" /-->
																<p style="color:red;">
																	By clicking <b>CONFIRM</b>, you are fully aware that the products you have purchased are not for resale and strictly for personal use (employee, families and friends).
																	If your purchase is found to be resold for commercial purposes– either <b>DIRECTLY</b> or <b>INDIRECTLY</b> – the Companies Policies will apply to such violation.
																	You can read the E-KITASHOP Policies (Terms of this purchase)  which available at E-KITASHOP homepage.<br/>
																	<br/>
																	By clicking <b>CONFIRM</b> you have read and understand to the Terms apply and wish to proceed the order.<br/>
																	<br/>
																	<br/>
																	Pesanan Anda akan dicek terlebih dahulu sebelum proses pembayaran dilanjutkan. Dengan mengklik <b>CONFIRM</b>, Anda sepenuhnya menyadari bahwa produk yang Anda telah beli tidak untuk dijual kembali dan hanya diperuntukkan untuk penggunaan pribadi (karyawan, keluarga, dan teman).
																	Jika pembelian Anda ditemukan dijual kembali untuk tujuan komersil– baik secara <b>LANGSUNG</b> maupun <b>TIDAK LANGSUNG</b> – Kebijakan Perusahaan akan berlaku untuk pelanggaran tersebut.
																	Anda dapat membaca Kebijakan E-KITASHOP (Syarat dan ketentuan pembelian) yang tersedia di E-KITASHOP homepage.<br/>
																	<br/>
																	Dengan mengklik <b>CONFIRM</b> berarti Anda telah membaca dan memahami syarat yang berlaku dan setuju untuk memproses pesanan.<br/>
																</p>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xs-12">
											</div>
											<div class="col-xs-12">
												<div class="well well-lg clearfix">
													<ul class="pager">
														<!--form id="cartForm" method="POST"-->
															
															<!--<input type="text" name="gross_amount" value="{format-number(floor(/sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection/formCols/formCol[@colNo='5']/formRows/formRow[@rowNo='2']/fields/field/textBox/value/.), '#')}" />-->
															<xsl:if test="sqroot/body/bodyContent/form/info/state/status=0 or sqroot/body/bodyContent/form/info/state/status=120">
																<li class="previous">
																	<a href="index.aspx?code=tapcsd&amp;guid={/sqroot/body/bodyContent/form/info/GUID/.}">back</a>
																</li>
															</xsl:if>
															<xsl:choose>
																<xsl:when test="sqroot/body/bodyContent/form/info/state/status=0">
																	<li class="next">
																		<a style="cursor:pointer;" onclick="SaveData('taPCS1', 'formpayment', 'index.aspx?code=tapcs4', '{/sqroot/body/bodyContent/form/info/GUID/.}', '1', 'tapcso')">Confirm</a>
																	</li>
																</xsl:when>
																<xsl:when test="sqroot/body/bodyContent/form/info/state/status=120">
																	<li class="next">
																		<a style="cursor:pointer;" onclick="SaveData('taPCS1', 'formpayment', 'index.aspx?code=tapcs4', getGUID(), '1', 'tapcso')">Payment</a>
																	</li>
																</xsl:when>
																<xsl:otherwise>
																</xsl:otherwise>
															</xsl:choose>
														<!--/form-->
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<form action="https://pay.doku.com/Suite/Receive" id="MerchatPaymentPage" name="MerchatPaymentPage" method="post">
				<table width="600" border="0" cellspacing="1" cellpadding="5" style="display:none;">
					<tr>
						<td width="100" class="field_label">BASKET</td>
						<td width="500" class="field_input">
							<input name="BASKET" type="text" id="BASKET" value="" size="1024"/>
						</td>
					</tr>
					<tr>
						<td width="100" class="field_label">BASKET TOTAL</td>
						<td width="500" class="field_input">
							<input name="BASKETTOTAL" type="text" id="BASKETTOTAL" value="0" size="100"/>
						</td>
					</tr>
					<tr>
						<td width="100" class="field_label">MALLID</td>
						<td width="500" class="field_input">
							<input name="MALLID" type="text" id="MALLID" value="3189" size="12"/>
						</td>
					</tr>
					<tr>
						<td width="100" class="field_label">CHAINMERCHANT</td>
						<td width="500" class="field_input">
							<input name="CHAINMERCHANT" type="text" id="CHAINMERCHANT" value="NA" size="12"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">CURRENCY</td>
						<td class="field_input">
							<input name="CURRENCY" type="text" id="CURRENCY" value="360" size="3" maxlength="3"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">PURCHASECURRENCY</td>
						<td class="field_input">
							<input name="PURCHASECURRENCY" type="text" id="PURCHASECURRENCY" value="360" size="3" maxlength="3"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">AMOUNT</td>
						<td class="field_input">
							<input name="AMOUNT" type="text" id="AMOUNT" value="10000.00" size="12"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">PURCHASEAMOUNT</td>
						<td class="field_input">
							<input name="PURCHASEAMOUNT" type="text" id="PURCHASEAMOUNT" value="10000.00" size="12"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">TRANSIDMERCHANT</td>
						<td class="field_input">
							<input name="TRANSIDMERCHANT" type="text" id="TRANSIDMERCHANT" size="16"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">WORDS</td>
						<td class="field_input">
							<input type="text" id="WORDS" name="WORDS" size="254"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">REQUESTDATETIME</td>
						<td class="field_input">
							<input name="REQUESTDATETIME" type="text" id="REQUESTDATETIME" size="14" maxlength="14"/>
							(YYYYMMDDHHMMSS)
						</td>
					</tr>
					<tr>
						<td class="field_label">SESSIONID</td>
						<td class="field_input">
							<input type="text" id="SESSIONID" name="SESSIONID" maxlength="48"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">PAYMENTCHANNEL</td>
						<td class="field_input">
							<select name="PAYMENTCHANNEL" id="PAYMENTCHANNEL">
								<option value="">None</option>
								<!--<option value="4">Doku Wallet</option>-->
								<option selected="selected" value="15">Credit Card</option>
								<option value="36">Bank Transfer</option>
								<!--<option value="2">Clickpay Mandiri</option>
				<option value="6">BRIPay</option>
				<option value="24">BCA KlikPay- DEBIT</option>
				<option value="5">ATM (Virtual Account)</option>-->
							</select>
						</td>
					</tr>
					<tr>
						<td width="100" class="field_label">EMAIL</td>
						<td width="500" class="field_input">
							<input name="EMAIL" type="text" id="EMAIL" value="marwandi@nsiapay.net" size="50"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">NAME</td>
						<td class="field_input">
							<input name="NAME" type="text" id="NAME" value="Doku Test" size="30" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">ADDRESS</td>
						<td class="field_input">
							<input name="ADDRESS" type="text" id="ADDRESS" value="Jl. jendral Sudirman Kav.5" size="50"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">COUNTRY</td>
						<td class="field_input">
							<input name="COUNTRY" type="text" id="COUNTRY" value="360" size="50" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">STATE</td>
						<td class="field_input">
							<input name="STATE" type="text" id="STATE" value="Jakarta" size="50" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">CITY</td>
						<td class="field_input">
							<input name="CITY" type="text" id="CITY" value="JAKARTA SELATAN" size="50" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">PROVINCE</td>
						<td class="field_input">
							<input name="PROVINCE" type="text" id="PROVINCE" value="JAKARTA" size="50" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">ZIPCODE</td>
						<td class="field_input">
							<input name="ZIPCODE" type="text" id="ZIPCODE" value="12000" size="6" maxlength="10"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">HOMEPHONE</td>
						<td class="field_input">
							<input name="HOMEPHONE" type="text" id="HOMEPHONE" value="0217998391" size="12" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">MOBILEPHONE</td>
						<td class="field_input">
							<input name="MOBILEPHONE" type="text" id="MOBILEPHONE" value="0217998391" size="12" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">WORKPHONE</td>
						<td class="field_input">
							<input name="WORKPHONE" type="text" id="WORKPHONE" value="0217998391" size="12" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<td class="field_label">BIRTHDATE</td>
						<td class="field_input">
							<input name="BIRTHDATE" type="text" id="BIRTHDATE" value="19880101" size="12" maxlength="20"/>
						</td>
					</tr>
				</table>
				<br/>
				<br/>
				<input name="submit" type="submit" class="bt_submit" id="submit" value="SUBMIT" style="display:none;"/>
			</form>
			<script>
				//genInvoice();
				getRequestDateTime();
				genSessionID();
				genDokuValues();
			</script>
		</section>
	</xsl:template>
	<xsl:template match="sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@fieldName = 'PAYMGUID']/autoSuggestBox">
		
		<label id="{../@fieldName}caption" style="margin:0;">
			<xsl:value-of select="titlecaption"/>
		</label>
		<xsl:if test="../@isNullable = 0">
			<span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
		</xsl:if>
		<div>
			<xsl:if test="button">
				<xsl:attribute name="class">input-group</xsl:attribute>
			</xsl:if>
			<select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}" data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}">
				<xsl:attribute name="onchange">
					autosuggest_onchange(this, '<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', 'formheader'); 
					SaveData('taPCS2','formpayment', 'index.aspx?code=tapcsd&amp;GUID=<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', '0', '', '0');
					genPaymentChannel();
				</xsl:attribute>
				<option/>
			</select>
			<xsl:if test="button">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" data-select2-open="multi-append">
						<span class="fa fa-plus"/>
					</button>
				</span>
			</xsl:if>
		</div>
		<script>
			setTimeout(function() {
			$("#<xsl:value-of select="../@fieldName"/>").select2({
			placeholder: 'Select <xsl:value-of select="titlecaption"/>',
			<xsl:if test="../@isEditable=0 or /sqroot/header/custompermissions/custompermission/allowchangepayment/.=0 or /sqroot/body/bodyContent/form/info/state/status>0">
				readOnly: true,
			</xsl:if>
			onAdd: function(x) {
			preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
			},
			onDelete: function(x) {
			preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
			},
			ajax: {
			url:"OPHCORE/api/msg_autosuggest.aspx",
			delay : 0,
			data: function (params) {
			var query = {
			code:"<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>",
			colkey:"<xsl:value-of select="../@fieldName"/>",
			search: params.term,
			wf1value: ('<xsl:value-of select='whereFields/wf1'/>'==''?'':$("#<xsl:value-of select='whereFields/wf1'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf1'/>").val()),
			wf2value: ('<xsl:value-of select='whereFields/wf2'/>'==''?'':$("#<xsl:value-of select='whereFields/wf2'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf2'/>").val()),
			page: params.page
			}
			return query;
			},
			dataType: 'json',
			}
			});
			}, 1000);
			<xsl:if test="value!=''">
				autosuggest_defaultValue('<xsl:value-of select="../@fieldName"/>',
				'<xsl:value-of select='value'/>','<xsl:value-of select='translate(combovalue, "&#39;", "\&#39;")'/>') 
				
			</xsl:if>
		</script>
	</xsl:template>
	<xsl:template match="sqroot/body/bodyContent/form/formPages/formPage">
		<xsl:if test="@pageNo = '1'">
			<xsl:apply-templates select="formSections/formSection"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="formSections/formSection">
		<div class="col-xs-12">
			<div class="page-header">
				<h4>
					<xsl:value-of select="@rowTitle"/>
				</h4>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<xsl:apply-templates select="formCols/formCol"/>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="formCols/formCol">
		<xsl:if test="@colNo = '1'">
			<div class="col-sm-6">
				<xsl:apply-templates select="formRows/formRow"/>
			</div>
		</xsl:if>
		<xsl:if test="@colNo = '2'">
			<div class="col-sm-6">
				<xsl:apply-templates select="formRows/formRow"/>
			</div>
		</xsl:if>
	</xsl:template>
	<xsl:template match="formRows/formRow">
		<xsl:apply-templates select="fields"/>
		<!--<div class="form-group  col-xs-12">
      <label>
        <xsl:value-of select="fields/field/textBox/titlecaption/." />
      </label>
      <input type="text" class="form-control" id="PCSO_{fields/field/@fieldName/.}" value="{fields/field/textBox/value/.}" readonly="" />
    </div>-->
	</xsl:template>
	<xsl:template match="fields">
		<xsl:apply-templates select="field"/>
	</xsl:template>
	<xsl:template match="field">
		<xsl:if test="../@isNullable = 0 and 
						((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
							or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
							or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
							or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
							or (../@isEditable='6' 
								  and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
								  and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
							or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
							or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
						)
				">
			<script>
				document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ', <xsl:value-of select="@fieldName"/>'
			</script>
		</xsl:if>
		<xsl:variable name="fieldEnabled">
			<xsl:choose>
				<xsl:when test="((@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
							or (@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
							or (@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
							or (@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
							or (../@isEditable='6' 
								  and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
								  and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
							or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
							or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500)))">enabled</xsl:when>
				<xsl:otherwise>disabled</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$fieldEnabled='disabled'">
			<script>
				$('#<xsl:value-of select="@fieldName"/>').attr('disabled', 'disabled');
				$('#cb<xsl:value-of select="@fieldName"/>').attr('disabled', 'disabled');
				$('#<xsl:value-of select="@fieldName"/>').prop('disabled', true);
				$('cb#<xsl:value-of select="@fieldName"/>').prop('disabled', true);
			</script>
		</xsl:if>
		<xsl:apply-templates select="textBox"/>
		<xsl:apply-templates select="textEditor"/>
		<xsl:apply-templates select="textArea"/>
		<xsl:apply-templates select="dateBox"/>
		<xsl:apply-templates select="dateTimeBox"/>
		<xsl:apply-templates select="timeBox"/>
		<xsl:apply-templates select="passwordBox"/>
		<xsl:apply-templates select="checkBox"/>
		<xsl:apply-templates select="mediaBox"/>
		<xsl:apply-templates select="autoSuggestBox"/>
		<xsl:apply-templates select="tokenBox"/>
		<xsl:apply-templates select="radio"/>
	</xsl:template>
	<xsl:template match="textBox">
		<div class="form-group col-xs-12">
			<label>
				<xsl:value-of select="titlecaption/."/>
			</label>
			<input type="text" class="form-control" id="{../@fieldName/.}" name="{../@fieldName/.}" value="{value/.}"/>
		</div>
	</xsl:template>
	<xsl:template match="autoSuggestBox">

		<label id="{../@fieldName}caption">
			<xsl:value-of select="titlecaption"/>
		</label>
		<xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
			<span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
		</xsl:if>
		<div>
			<xsl:if test="button">
				<xsl:attribute name="class">input-group</xsl:attribute>
			</xsl:if>
			<div class="form-group col-xs-12">
				<select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}" data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}">
					<xsl:attribute name="onchange">
						autosuggest_onchange(this, '<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', 'formheader'); 
						//SaveData('taPCSd','formpayment', 'index.aspx?code=tapcsd&amp;GUID=<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>', '0', '', '0');
					</xsl:attribute>
					<option/>
				</select>
			</div>
			<xsl:if test="button">
				<span class="input-group-btn">
					<button class="btn btn-default" type="button" data-select2-open="multi-append">
						<span class="fa fa-plus"/>
					</button>
				</span>
			</xsl:if>
		</div>
		<script>
			setTimeout(function() {
			$("#<xsl:value-of select="../@fieldName"/>").select2({
			placeholder: 'Select <xsl:value-of select="titlecaption"/>',
			<xsl:if test="../@isEditable=0 or /sqroot/header/custompermissions/custompermission/allowchangepayment/.=0 or /sqroot/body/bodyContent/form/info/state/status>0">
				readOnly: true,
			</xsl:if>
			onAdd: function(x) {
			preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
			},
			onDelete: function(x) {
			preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','formheader', this);
			},
			ajax: {
			url:"OPHCORE/api/msg_autosuggest.aspx",
			delay : 0,
			data: function (params) {
			var query = {
			code:"<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>",
			colkey:"<xsl:value-of select="../@fieldName"/>",
			search: params.term,
			wf1value: ('<xsl:value-of select='whereFields/wf1'/>'==''?'':$("#<xsl:value-of select='whereFields/wf1'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf1'/>").val()),
			wf2value: ('<xsl:value-of select='whereFields/wf2'/>'==''?'':$("#<xsl:value-of select='whereFields/wf2'/>").val() === undefined ? "" : $("#<xsl:value-of select='whereFields/wf2'/>").val()),
			page: params.page
			}
			return query;
			},
			dataType: 'json',
			}
			});
			}, 1000);
			<xsl:if test="value!=''">
				autosuggest_defaultValue('<xsl:value-of select="../@fieldName"/>',
				'<xsl:value-of select='value'/>','<xsl:value-of select='translate(combovalue, "&#39;", "\&#39;")'/>') 

			</xsl:if>
		</script>
	</xsl:template>
	<!--<xsl:template match="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='1']/formSections/formSection[@sectionNo='1']/formCols/formCol[@colNo='1']/formRows/formRow">
     
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/form/formPages/formPage[@pageNo='3']/formSections/formSection[@sectionNo='1']/formCols/formCol[@colNo='1']/formRows/formRow">
     <div class="form-group col-sm-6 col-xs-12">
        <label><xsl:value-of select="fields/field/textBox/titlecaption/." /></label>
        <input type="text" class="form-control" id="{fields/field/@fieldName/.}" value="{fields/field/textBox/value/.}" />
      </div>
  </xsl:template>-->
</xsl:stylesheet>
