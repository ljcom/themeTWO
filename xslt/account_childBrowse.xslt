<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes"/>
	<xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
	<xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:template match="/">
		<div class="col-xs-12">
			<div class="innerWrapper">
				<div class="orderBox">
					<h4>
						<xsl:value-of select="sqroot/body/bodyContent/browse/info/description"/>
					</h4>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column"/>
									<th height="1">Action</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
								<xsl:if test="sqroot/body/bodyContent/browse/info/TotalRows/.=0">
									<tr>
										<td colspan="10">No Data Available</td>
									</tr>
								</xsl:if>
							</tbody>
						</table>
					</div>
					<div class="row">
						<div class="col-md-6 btn-group align-middle" role="group" aria-label="..." style="margin-bottom:0;margin-top:10px">
							<xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowAdd/.=1">
								<a class="btn btn-default" onClick="showReferral('00000000-0000-0000-0000-000000000000')">ADD</a>
							</xsl:if>
							<!--xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowDelete/.=1">
								<a class="btn btn-default" onClick="#">DELETE</a>
							</xsl:if-->
						</div>
						<div class="col-md-6">
							<ul class="pagination pagination-sm pull-right float-right" id="paginationprod">
								<script>
									var pgno='<xsl:value-of select="sqroot/body/bodyContent/browse/info/TotalRows/."/>';
									if (pgno>&gt;0)
									createPaging('<xsl:value-of select="sqroot/body/bodyContent/browse/info/TotalRows/."/>', 'account_browse', 'contentAccount', '<xsl:value-of select="sqroot/body/bodyContent/browse/info/pageNo/."/>');
								</script>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="sqroot/body/bodyContent/browse/header/column">
		<xsl:variable name="align">
			<xsl:choose>
				<xsl:when test="@align=1">center</xsl:when>
				<xsl:when test="@align=2">right</xsl:when>
				<xsl:otherwise>left</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<th style="width:{@width}px;text-align:{$align}">
			<xsl:value-of select="translate(., $smallcase, $uppercase)"/>
		</th>
	</xsl:template>
	<xsl:template match="sqroot/body/bodyContent/browse/content/row">
		<tr>
			<xsl:apply-templates select="fields/field"/>
			<td>
				<a onclick="showReferral('{@GUID}')" class="btn btn-default">View</a>
				<xsl:if test="/sqroot/body/bodyContent/browse/info/permission/allowDelete/.=1">
				<a onclick="deleteRow('{/sqroot/body/bodyContent/browse/info/code/.}', '{@GUID}',20);" class="btn btn-default">Delete</a>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="fields/field">
		<xsl:variable name="tbContent">
			<xsl:choose>
				<xsl:when test="@digit = 0 and .!=''">
					<xsl:value-of select="format-number(., '#,##0', 'dot-dec')"/>
				</xsl:when>
				<xsl:when test="@digit  = 1 and .!=''">
					<xsl:value-of select="format-number(., '#,##0.0', 'dot-dec')"/>
				</xsl:when>
				<xsl:when test="@digit  = 2 and .!=''">
					<xsl:value-of select="format-number(., '#,##0.00', 'dot-dec')"/>
				</xsl:when>
				<xsl:when test="@digit  = 3 and .!=''">
					<xsl:value-of select="format-number(., '#,##0.000', 'dot-dec')"/>
				</xsl:when>
				<xsl:when test="@digit  = 4 and .!=''">
					<xsl:value-of select="format-number(., '#,##0.0000', 'dot-dec')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="align">
			<xsl:choose>
				<xsl:when test="@align=1">
					center
				</xsl:when>
				<xsl:when test="@align=2">
					right
				</xsl:when>
				<xsl:otherwise>
					left
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<td align="{$align}">
			<xsl:choose>
				<xsl:when test="(@caption)='customstat' and (.) = 'Pending'">
					<span class="label label-warning">
						<xsl:value-of select="."/>
					</span>
				</xsl:when>
				<xsl:when test="(@caption)='customstat' and (.) = 'Approved'">
					<span class="label label-success">
						<xsl:value-of select="."/>
					</span>
				</xsl:when>
				<xsl:when test="(@caption)='customstat' and (.) = 'Rejected'">
					<span class="label label-danger">
						<xsl:value-of select="."/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$tbContent"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</xsl:template>
</xsl:stylesheet>
