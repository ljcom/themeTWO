﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">

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

        <th style="width:{@width}px">
          <xsl:value-of select="translate(., $smallcase, $uppercase)" />
        </th>
    

  </xsl:template>

  <!--Data Content-->

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr>
      <xsl:apply-templates select="fields/field" />
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

    <xsl:choose>
      <xsl:when test="(@caption)='productphotos'">
        <td class="col-xs-2">
          <span class="cartImage" style="height:70px; margin:0 auto;  width:100%; text-align:center;">
            <img src="OPHContent/documents/kitashop/{.}" 
				onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'"
				alt="image" style="height:100%; width:auto; margin:0 auto;" />
          </span>
        </td>
      </xsl:when>
      <xsl:when test="(@caption)='Qty' or (@caption)='QtyConfirm' or (@caption)='QtyReject' or (@caption)='QtyReturn' or (@caption)='TotalPrice'">
        <td style="text-align:center">
          <xsl:value-of select="$tbContent" />
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:value-of select="$tbContent" />
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
</xsl:stylesheet>
