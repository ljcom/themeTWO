﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
      
      <input type="hidden" id="cfunctionlist"/>
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

    <script>
      if (document.getElementById('BASKETTOTAL').value != '0') {
      var amount = parseInt(document.getElementById('AMOUNT').value)
      var baskettotal = parseInt(document.getElementById('BASKETTOTAL').value)
      var basket = document.getElementById('BASKET').value
      var ppn = amount - baskettotal
      document.getElementById('BASKET').value = basket + 'PPN 10%,'+ppn+'.00'+',1,'+ppn+'.00'

      basket = document.getElementById('BASKET').value
      document.getElementById('BASKET').value = basket.replace(';,', ';');

      basket = document.getElementById('BASKET').value
      document.getElementById('BASKET').value = basket.substring(1, basket.length)
      getWords()
      }
    </script>
           
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column">

    <xsl:choose>
      <xsl:when test="(@fieldName)!='TotalSales' and (@fieldName)!='TotalQty' and (@fieldName)!='EVENPSKUGUID'">
        <th style="width:{@width}px">
          <xsl:value-of select="translate(titleCaption/., $smallcase, $uppercase)" />
        </th>
      </xsl:when>
    </xsl:choose>


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
            <span class="cartImage" style="height:70px;" >
              <img src="OPHContent/documents/{/sqroot/header/info/account/.}/{.}" alt="image" style="height:100%; width:auto; margin:0 auto;" />
            </span>
          </td>
        </xsl:when>
        <xsl:when test="(@caption)='Qty'">
          <td class="col-xs-2">
            <xsl:value-of select="$tbContent" />
          </td>
          <script>
            var basket = document.getElementById('BASKET').value
            document.getElementById('BASKET').value = basket + ',<xsl:value-of select="$tbContent" />'
          </script>
        </xsl:when>
        <xsl:when test="(@caption)='TotalSales' or (@caption)='TotalQty' or (@caption) ='EVENPSKUGUID'">
          <!--kosong-->
        </xsl:when>
        <xsl:otherwise>
          <td>
          <xsl:value-of select="$tbContent" />
          </td>
          <script>
            var basket = document.getElementById('BASKET').value
            var caption = '<xsl:value-of select="(@caption)" />'
            if (caption == 'Price'){
              document.getElementById('BASKET').value = basket + ',<xsl:value-of select="format-number(., '#.00')" />'
            }else if (caption == 'TotalPrice'){
              document.getElementById('BASKET').value = basket + ',<xsl:value-of select="format-number(., '#.00')" />;'
            }else {
              document.getElementById('BASKET').value = basket + ',<xsl:value-of select="." />'
            }

            if (caption == 'TotalPrice') {
              document.getElementById('BASKETTOTAL').value = parseInt(document.getElementById('BASKETTOTAL').value) + <xsl:value-of select="format-number(., '0')"/>
            }
          </script>
        </xsl:otherwise>
      </xsl:choose>
   
  </xsl:template>
</xsl:stylesheet>
