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
      setCookie("browsetype", "browse_list", 0, 1, 0);
      loadScript('OPHContent/cdn/bigbag-theme/js/custom.js');
    </script>
    <!-- MAIN CONTENT SECTION -->
    <section class="mainContent clearfix productsContent" >
      <div class="container">
        <div class="row">

          <div class="col-md-12 col-sm-12 col-xs-12">
            <div id="contentBrowse">
              <div class="row productListSingle">
                <!--Browse Filters-->
                <xsl:if test="/sqroot/body/bodyContent/browse/info/filters">
                  <div class="row">
                    <div class="col-md-12">
                      <div id="bfBox">
                        <xsl:attribute name="class">
                          <xsl:choose>
                            <xsl:when test="/sqroot/body/bodyContent/browse/info/filters/*/value">box box-default</xsl:when>
                            <xsl:otherwise>box box-default collapsed-box</xsl:otherwise>
                          </xsl:choose>
                        </xsl:attribute>
                        <div class="box-header with-border">
                          <button id="btnAdvancedFilter" type="button" class="btn btn-box-tool" data-widget="collapse">
                            <ix aria-hidden="true">
                              <xsl:attribute name="class">
                                <xsl:choose>
                                  <xsl:when test="/sqroot/body/bodyContent/browse/info/filters/*/value">fa fa-minus</xsl:when>
                                  <xsl:otherwise>fa fa-plus</xsl:otherwise>
                                </xsl:choose>
                              </xsl:attribute>
                            </ix>
                            Advanced Filters
                            <xsl:if test="/sqroot/body/bodyContent/browse/info/filters/*/value">(ACTIVE)</xsl:if>
                          </button>
                        </div>
                        <div class="box-body">
                          <form id="formFilter">
                            <xsl:apply-templates select="/sqroot/body/bodyContent/browse/info/filters" />
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>
                </xsl:if>

                <!--div class="col-md-9 col-sm-8 col-xs-12"-->
                <!--div class="col-md-9 col-sm-8 col-xs-12"-->
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="row filterArea">
                    <div class="col-md-6 col-sm-6 col-xs-6" style="font-size:8px;padding:0;">
                      <select name="combo_setOrder" id="combo_setOrder" class="select-drop"
                              onchange="SortingBy('product', 'contentBrowse', getCode())">
                        <option value="name asc">Default sorting</option>
                        <option value="id asc">Order By Item Code</option>
                        <option value="priceDiscount Desc">Sort from the highest price</option>
                        <option value="priceDiscount Asc">Sort from the lowest price</option>
                      </select>
                    </div>

                    <div class="col-md-6 col-sm-6 col-xs-6" style="padding:0">
                      <div class="btn-group pull-right" role="group" >
                        <button type="button" class="btn btn-default" id="gridtab" onclick="productChangeView('browse', 'contentBrowse')">
                          <span>
                            <ix class="fa fa-th" aria-hidden="false"></ix>
                          </span>
                          <span>Grid</span>
                        </button>
                        <button type="button" class="btn btn-default" id="listtab" onclick="productChangeView('browse_list', 'contentBrowse')">
                          <span>
                            <ix class="fa fa-th-list" aria-hidden="false"></ix>
                          </span>
                          <span>List</span>
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
              </div>

              <div  class="row">
                <div class="col-xs-12">
                  <ul class="pagination pagination-sm" id="paginationprod">
                    <script>
                      createPaging('<xsl:value-of select="sqroot/body/bodyContent/browse/info/TotalRows/." />', 'product', 'contentBrowse');
                    </script>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>


    <script>
      var cartid = getCookie('cartID');
      $(".cartidclass" ).val(cartid);
    </script>
  </xsl:template>

  <!--SIDEBAR CATAGORY-->
  <xsl:template match="sqroot/header/menus/menu[@code='categories']/submenus/submenu">
    <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
      <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}">-->
      <a class="top-envi" data-toggle="collapse" href="{pageURL/.}">
        <ix>
          <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
        </ix>
        <xsl:value-of select="caption/." />
        <xsl:choose>
          <xsl:when test="(@mode)='treeroot'">
            <span class="fa fa-plus" style="position:absolute; right:15px; top:18px; font-size:12px; color:#4c4c4c"></span>
          </xsl:when>
        </xsl:choose>
      </a>
      <xsl:choose>
        <xsl:when test="(@mode)='treeroot'">
          <div id="{id/.}" class="panel-collapse collapse">
            <ul>
              <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
            </ul>
          </div>
        </xsl:when>
      </xsl:choose>
    </div>
  </xsl:template>

  <!--SIDEBAR BRAND-->
  <xsl:template match="sqroot/header/menus/menu[@code='brand']/submenus/submenu">
    <div class="panel top-menu-onphone" style="border-radius:0; margin-top:0;">
      <!--<a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="{pageURL/.}"  >-->
      <a class="top-envi" data-toggle="collapse" href="{pageURL/.}">
        <span href="#" title="{link/.}" onclick="goToRef(this, '{link/.}')">
          <ix>
            <img src="{icon/img/.}" style="width:15px; margin-right:8px;" />
          </ix>
          <xsl:value-of select="caption/." />
          <br />
          <span style="margin-left:24px;">
            <xsl:value-of select="link/." />
            <br />
          </span>
        </span>
        <xsl:choose>
          <xsl:when test="(@mode)='treeroot'">
            <span class="fa fa-plus" style="position:absolute; right:15px; top:30px; font-size:12px; color:#4c4c4c" ></span>
          </xsl:when>
        </xsl:choose>
      </a>
      <div id="{id/.}" class="panel-collapse collapse">
        <ul>
          <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
        </ul>
      </div>
    </div>
  </xsl:template>

  <!--SIDEBAR Treeview-->
  <xsl:template match="submenus/submenu[@mode='treeview']">
    <xsl:choose>
      <xsl:when test="submenus!=''">
        <li>
          <a data-toggle="collapse" href="{pageURL/.}" class="top-envi-lv2">
            <span style="margin-right:10px; font-size:9px;">➤</span>
            <xsl:value-of select="caption/." />
            <xsl:choose>
              <xsl:when test="submenus!=''">
                <span class="fa fa-plus" style="position:absolute; right:15px; top:16px;"></span>
              </xsl:when>
            </xsl:choose>
          </a>
          <xsl:choose>
            <xsl:when test="submenus!=''">
              <div id="{id/.}" class="panel-collapse collapse">
                <ul>
                  <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
                </ul>
              </div>
            </xsl:when>
          </xsl:choose>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <a href="{pageURL/.}">
            <span style="margin-right:10px; font-size:9px;">➤</span>
            <xsl:value-of select="caption/." />
          </a>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--Data Content-->

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <!--image src-->
    <xsl:variable name="imageprod">
      OPHContent/documents/<xsl:value-of select="/sqroot/header/info/account/."/>/<xsl:value-of select="fields/field[@caption = 'productphotos']/." />
    </xsl:variable>

    <div class="col-xs-12">
      <div class="media">
        <div class="media-left">
          <div style="height:200px; text-align:center">
            <img style="height:90%;  width: auto; margin:0 auto;" class="media-object" src="{$imageprod}" alt="Image" onerror="this.src='ophcontent/themes/themeTWO/images/white.png'" />
          </div>
          <span class="maskingImage">
            <a href="index.aspx?code={/sqroot/header/info/code/id/.}&amp;guid={@GUID}" class="btn viewBtn">View</a>
          </span>
        </div>
        <div class="media-body">
          <h5 style="height:10px;margin-bottom:2px">
            <xsl:value-of select="fields/field[@caption = 'ID']/." />
          </h5>
          <h4 style="height:20px;margin-bottom:5px">
            <xsl:value-of select="fields/field[@caption = 'Name']/." />
          </h4>
          <!--<p style="margin:0; padding:0;">
            Code : <xsl:value-of select="fields/field[@caption = 'ID']/." />
          </p>-->
          <p style="margin:0; padding:0;">
            <!--Division : <xsl:value-of select="fields/field[@caption = 'divisionName']/." />-->
            <xsl:value-of select="fields/field[@caption = 'SignatureName']/@title" /> : <xsl:value-of select="fields/field[@caption = 'SignatureName']/." />
          </p>
          <xsl:choose>
            <xsl:when test="(fields/field[@caption = 'evenname']/.)!='Website online'">
              <span class="sticker">
                <xsl:value-of select="fields/field[@caption = 'evenname']/." />
              </span>
            </xsl:when>
          </xsl:choose>
          <!--<xsl:choose>
            <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
               <span class="sticker" style="top:30px; font-size:18px; padding:5px 5px;"><xsl:value-of select="fields/field[@caption = 'discount']/." />% OFF</span>
            </xsl:when>
          </xsl:choose>-->
          <p>
            <xsl:value-of select="fields/field[@caption = 'Description']/." />
          </p>
          <div style="height:40px;">
            <xsl:choose>
              <xsl:when test="(fields/field[@caption = 'discount']/.)!= '0'">
                <span style="text-decoration:line-through; font-size:12px; margin:0">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
                </span>
                <br />
                <!--<h3 style="font-size:20px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" /></h3>-->
                <span style="font-size:20px;">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
                  <span style="font-size:12px; color:white; padding:5px; margin-top:-30px !important; margin-left:10px; background:#47bac1;">
                    <xsl:value-of select="fields/field[@caption = 'discount']/." />%
                  </span><br />

                </span>

              </xsl:when>
              <xsl:when test="(fields/field[@caption = 'price']/.) != (fields/field[@caption = 'priceDiscount']/.)">
                <span style="text-decoration:line-through; font-size:12px; margin:0">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
                </span>
                <br />
                <!--<h3 style="font-size:20px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" /></h3>-->
                <span style="font-size:20px;">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'priceDiscount']/., '#,##0', 'dot-dec')" />
                </span>
              </xsl:when>
              <xsl:otherwise>
                <span style="font-size:20px; margin:0">
                  Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" />
                </span>
              </xsl:otherwise>
            </xsl:choose>
            <!--<h3 style="font-size:20px; margin:0">Rp. <xsl:value-of select="format-number(fields/field[@caption = 'price']/., '#,##0', 'dot-dec')" /></h3>-->
          </div>
          <div class="btn-group" role="group">
            <form method="post" id="productform_{@GUID}">
              <!--untuk insert dipaksa ada input-->
              <input type="hidden" class="cartidclass" name="cartID" value="" />
              <input type="hidden" name="Availaible" value="1" />
              <input type="hidden" name="EVENPSKUGUID" value="{@GUID}" />
              <input type="hidden" value="{fields/field[@caption = 'PRODGUID']/.}" name="PRODGUID"/>
              <input type="hidden" name="price" value="{fields/field[@caption = 'price']/.}" />
              <a onclick="AddToCart('{../../info/code/.}', 'productform_{@GUID}')" class="btn btn-default">
                <span style="font-size:20px;">
                  <ix class="fa fa-shopping-cart"></ix>
                </span>
              </a>
            </form>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/info/filters">
    <div class="row">
      <xsl:apply-templates select="comboFilter"/>
    </div>
    <div class="row">
      <div class="col-md-12">
        <button type="button" id="btnFilter" class="btn btn-success btn-flat" data-loading-text="Applying Filter..." onclick="applySQLFilter(this)">
          Apply Filters
        </button>
        <button type="button" id="btnResetFilter" class="btn btn-warning btn-flat" data-loading-text="Reseting Filter..." onclick="resetSQLFilter(this)" >
          <xsl:if test="not(comboFilter/value)">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          Reset Filters
        </button>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="comboFilter">
    <div class="col-md-6">
      <div class="form-group">
        <label id="label_{@id}">
          <xsl:value-of select="@caption"/>
        </label>
        <label id="chain_{@id}" data-toggle="tooltip" style="display:none">
          &#160;<ix class="far fa-link"></ix>
        </label>
        <select id="{@id}" name="{@id}" class="comboFilter select2" style="width: 100%;" data-wf1="{@wf1}" data-wf2="{@wf2}" data-old="{value}" data-selected="{value}">
          <option></option>
        </select>
      </div>
    </div>
    <span id="clear{@id}" style="cursor: pointer;margin: 8px 30px 0px 0px;position: absolute;top: 0px;right: 0px; display:none">
      <ix class="far fa-times" title= "Clear Selection" data-toggle="tooltip"></ix>
    </span>
    <script>
      $("#<xsl:value-of select="@id"/>").on("select2:select", function(e) {
      $('#clear<xsl:value-of select="@id"/>').show();

      var oldSelected = $('#<xsl:value-of select="@id"/>').data("selected", "");
      var newSelected = $('#<xsl:value-of select="@id"/>').val();

      //WhereField Condition
      $(".comboFilter.select2").each(function(){
      if ($(this).data('wf1') == '<xsl:value-of select="@id"/>') {
      $("#" + this.id).prop("disabled", false);
      //$("#select2-" + this.id + "-container").tooltip("disable");

      if (oldSelected != newSelected) $("#clear" + this.id).click();
      }
      });

      $('#<xsl:value-of select="@id"/>').data("selected", newSelected);
      });

      $("#clear<xsl:value-of select="@id"/>").on("click", function(e) {
      $('#<xsl:value-of select="@id"/>').val(null).trigger("change.select2");
      $('#<xsl:value-of select="@id"/>').data("selected", "");
      $(this).hide();

      //WhereField Condition
      $(".comboFilter.select2").each(function(){
      if ($(this).data('wf1') == '<xsl:value-of select="@id"/>') {
      $("#clear" + this.id).click();
      $("#" + this.id).prop("disabled", true);
      $("#select2-" + this.id + "-container").tooltip("enable");
      }
      });

      });

      $("#<xsl:value-of select="@id"/>").select2({
      placeholder: 'Select All [<xsl:value-of select="@caption"/>] Data',
      ajax: {
      url:"OPHCORE/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      code:"<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code/."/>",
      colkey:"<xsl:value-of select="@id"/>",
      search: params.term==undefined?'':params.term.toString().split('+').join('%2B'),
      wf1value: ($("#<xsl:value-of select='@wf1'/>").val() == undefined ? "" : $("#<xsl:value-of select='@wf1'/>").val()),
      wf2value: ($("#<xsl:value-of select='@wf2'/>").val() == undefined ? "" : $("#<xsl:value-of select='@wf2'/>").val()),
      parentCode: getCode(),
      page: params.page
      }
      return query;
      },
      dataType: 'json',
      }
      });

      $selection = $('#select2-<xsl:value-of select="@id"/>-container').parents('.selection');
      if ($selection.children('#clear<xsl:value-of select="@id"/>').length == 0) $('#clear<xsl:value-of select="@id"/>').appendTo($selection);
      $('#clear<xsl:value-of select="@id"/>').show();

      var cb<xsl:value-of select="@id"/> = '<xsl:value-of select="value"/>';
      if (cb<xsl:value-of select="@id"/> != '') {
      var defer = [];
      autosuggestSetValue(defer,'<xsl:value-of select="@id"/>','<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code/."/>','<xsl:value-of select="@id"/>', '<xsl:value-of select="value"/>', '<xsl:value-of select="@wf1"/>', '<xsl:value-of select="@wf2"/>')
      } else {
      $('#clear<xsl:value-of select="@id"/>').click();
      }

      var label_bfwf1 = $('#label_<xsl:value-of select="@wf1"/>').text();
      var label_bfwf2 = $("#label_<xsl:value-of select='@wf2'/>").text();
      if (label_bfwf1 != '') {
      var chainCaps = 'Linked with field ['+label_bfwf1+']';
      if (label_bfwf2 != '') chainCaps = chainCaps + ' and ['+label_bfwf2+']';

      $("#chain_<xsl:value-of select="@id"/>").attr('title', chainCaps);
      $("#chain_<xsl:value-of select="@id"/>").show();

      if(cb<xsl:value-of select="@id"/> == "") {
      $('#select2-<xsl:value-of select="@id"/>-container').attr('title', 'Please Select ['+label_bfwf1+'] First')
      $('#select2-<xsl:value-of select="@id"/>-container').attr('data-toggle', 'tooltip');
      }
      }
    </script>
  </xsl:template>
</xsl:stylesheet>
