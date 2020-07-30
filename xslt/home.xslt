<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
		<!-- Tell the browser to be responsive to screen width -->
		var meta = document.createElement('meta');
		meta.name = "viewport";
		meta.content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no";
		loadMeta(meta);

		setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '<xsl:value-of select="/sqroot/header/info/account"/>', 1, 1, 0);

		//loadScript('OPHContent/themes/themeTWO/custom-me.js');
		$('body').css('background-color', 'white');
		
		LoadNewPart('home_browse', 'contentWrapper', 'home', '','');
		changeColorMenuFront();
		
		var n=new Date(Date.now());
		$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));

		if (getCookie("isLogin") == '1' &amp;&amp; username != '') {
			var filterkey = "parentdocguid='" +  getCookie("cartID") + "'";
			LoadNewPart('home_browse_cart_top', 'carttop', 'tapcs1deta', filterkey, '');
		 }
		//endLoading();
    </script>
    <!-- Page script -->
    
    <!--before loadpage-->
     <!-- Message -->
    <div id="popupMsg" class="alert alert-warning" style="background:#47BAC1; color:white; position:fixed; z-index:1000; top:5%;  right:3%; width:350px; margin:0 auto; display:none">
      <button type="button" class="close" onclick="hidePopUp('popupMsg')" aria-hidden="true" style="color:white; opacity:1;">
        x
      </button>
      <!--<span class="glyphicon glyphicon-record">&#xA0;</span>
      <strong>&#xA0;</strong>
      <hr class="message-inner-separator" />-->
        <p style="color:white;" id="popupMsgContent">
          Notification
        </p>
    </div>

    <!--LOGIN MODAL-->
    <div class="modal fade login-modal" id="login" tabindex="-1" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3 class="modal-title">log in</h3>
          </div>
          <div class="modal-body">
            <form action="" method="POST" role="form">
              <div class="form-group">
                <label for="">User ID</label>
                <input type="text" class="form-control" id="userid" onkeypress="loginkeypressFront(event)"/>
              </div>
              <div class="form-group">
                <label for="">Password</label>
                <input type="password" class="form-control" id="pwd" onkeypress="loginkeypressFront(event)"/>
              </div>
              <div class="alert alert-danger" id="loginNotif" style="display:none;height:35px;padding-top:8px;">
                <span class="glyphicon glyphicon-exclamation-sign">&#xA0;</span> 
                <span id="loginNotifMsg">&#xA0;</span>
               </div>
        
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="rememberme"/> Remember Me
                </label>
              </div>
              <a class="btn btn-primary btn-block" onclick ="signInFrontEnd('{/sqroot/header/info/account}')">log in</a>
              <a href="index.aspx?code=login2" class="btn btn-link btn-block">Get New Password ?</a>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!--Limit Modal-->
    <div class="modal fade limit-modal" id="limitmodal" tabindex="-1" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3 class="modal-title">Remaining Limit</h3>
          </div>
          <div class="modal-body" id="limitmodalbody">
            Loading Please Wait...
          </div>
        </div>
      </div>
    </div>

    <!--Loading Screen--><!--
    <div id="content-loader">
      <div class="loader" style="">
        &#xA0;
      </div>
    </div>-->

    <!--Stop Loading Screen-->
    <!--script>
      $( document ).ajaxStop(function() {
      $("#content-loader").show("slow").delay(500).fadeOut();
      if ($("#LimitUser > span").html() != undefined) if ( $("#LimitUsers").html()!= undefined) document.getElementById("LimitUsers").innerHTML = $("#LimitUser > span").html();
      
      });
    </script-->
    
    <!--HEADER-->
    <div class="header clearfix headerV3">
      <!-- TOPBAR -->
      <div class="topBar">
        <div class="container">
          <div class="row">
            <div class="col-md-6 hidden-sm hidden-xs">
              &#xA0;
            </div>
            <div class="col-md-6 col-xs-12">
              <ul class="list-inline pull-right top-right">
                <li class="account-login" id="loginbuttons">
                  <script>
                    var username = '<xsl:value-of select="sqroot/header/info/user/userName/." />';
                    topbutton(username);
                  </script>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <!-- NAV TOP -->
      <div class="navTop text-center" style="padding-bottom: 10px">
        <div class="container">
          <div class="navbar-header">
            <a class="navbar-brand" href="javascript:void(0)">
              <img src="OPHContent/themes/themeTWO/images/logo2.jpg" style="width:200px;" alt="logo" />
            </a>
          </div>
          <div class="navTop-middle" >
            <div class="searchBox" style="margin-left:15%; width:75%">
              <span class="input-group" style="border-left:1px #cccccc solid;">
                <input type="text" id="searchText" class="form-control" placeholder="Search…" aria-describedby="basic-addon2" onkeypress="searchkeypressFront(event)" />
                <button type="submit" class="input-group-addon" onclick="searchFront()">
                  <ix class="fa fa-search"></ix>
                </button>
              </span>
            </div>
          </div>
          <div class="dropdown cart-dropdown" id="carttop" style="margin-left:5px">&#160;</div>
        </div>
      </div>

      <nav class="navbar navbar-main navbar-default nav-V3" role="navigation">
        <div class="container">
          <div class="nav-category dropdown">
            <a href="javascript:void(0)" class="dropdown-toggle"  data-toggle="collapse" data-target="#demo5">
              <span class="resize-font-12px">Category &amp; Brand</span>
              <button type="button">
                <span class="icon-bar">&#xA0;</span>
                <span class="icon-bar">&#xA0;</span>
                <span class="icon-bar">&#xA0;</span>
              </button>
            </a>
            <div class="" id="demo5" style="color:white; position:absolute; background:#white; z-index:100; width:100%; right:0px; top:50px; overflow:hidden !important; overflow-y:scroll !important; max-height:520px !important;">
                <div class="panel-group">
					<p class="resize-font-10px" style="color:white; background:#37acb2;  display:block; font-size:15px; padding:5px 10px;  margin-bottom:0px;">
					Choose By Category
					</p>
					<div class="panel panel-default">
					<div class="accordian-body collapse in top-menu-div product-menu" id="demo6" style="">
					  <div class="panel-group" id="accordion2">
						<!-- SIDEBAR -->
						<!--<xsl:apply-templates select="sqroot/header/menus/menu[@code='catagory']/submenus/submenu" />-->
						<div id="CategoryMenu">
						  <script>
							//if (getGUID() == undefined){
							var xslfile = 'Category';
							var id = 'CategoryMenu';
							var code = 'MaCTGRFRON';
							var prnt = 'PARNCTGRGUID is null ';
							LoadNewPart('home_browse_menu_sidebar', id, code, prnt, '', '1', '5', 'name asc');
							//}
						  </script>
						</div>
					  </div>
					</div>
					</div>
				</div>
				<div class="panel-group">
					<p class="resize-font-10px" style="color:white; background:#37acb2;  display:block; font-size:15px; padding:5px 10px;  margin-bottom:0px;">
					Choose By Division
					</p>
					<div class="panel panel-default">
					<div class="accordian-body collapse in top-menu-div product-menu" id="demo6" style="">
					  <div class="panel-group" id="accordion2">
						<!-- SIDEBAR -->
						<!--<xsl:apply-templates select="sqroot/header/menus/menu[@code='catagory']/submenus/submenu" />-->
						<div id="DivisionMenu">
						  <script>
							//if (getGUID() == undefined){
							var xslfile = 'Category';
							var id = 'DivisionMenu';
							var code = 'MaBRANFRON';
							var prnt = 'PARNBRANGUID is null ';
							LoadNewPart('home_browse_menu_sidebar', id, code, prnt, '', '1', '5', 'name asc');
							//}
						  </script>
						</div>
					  </div>
					</div>
					</div>
				</div>				
            </div>
              
            
          </div>
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"> &#xA0;</span>
              <span class="icon-bar"> &#xA0;</span>
              <span class="icon-bar"> &#xA0;</span>
            </button>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
              <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu" />
              <script type="text/javascript">
                if (getCookie("isLogin") == "0"){   
                    $('.needlogin').attr('href','.login-modal')
                }
              </script>
            </ul>
          </div>
          <!-- /.navbar-collapse -->
        </div>
      </nav>

    </div>
    
    <!-- BANNER -->
    <div class="container">
      <div class="bannercontainer bannerV4">
        <div class="fullscreenbanner-container">
          <div class="fullscreenbanner">
            <ul id="sliderloc">
              <span id="loadingslider">Loading Please Wait...</span>
              <xsl:apply-templates select="sqroot/header/menus/menu[@code='slider']/submenus/submenu" />
              <!--<script>
                LoadNewPart('home_browse_slider', 'sliderloc', 'maSLDRIMGE', "SLDRGUID ='5F5A7C4F-17F8-48CA-A179-AEF41DFA099F'", '', '', '', 'imgCaption asc');
              </script>-->
            </ul>
          </div>
        </div>
      </div>

    </div>
	
    <div  id="contentWrapper" class="content-wrapper">
      a
    </div>

    <!-- COPY RIGHT -->
    <div class="copyRight clearfix">
      <div class="container">
        <div class="row">
          <div class="col-sm-7 col-xs-12">
            <p id="cp">
              © #year# Copyright <a style="color:white" href="http://www.loreal.com/">L'oreal Indonesia</a>
            </p>
          </div>
          <!--<div class="col-sm-5 col-xs-12">
            <p class="poweredby">
              Powered By <a href="http://operahouse.systems/" style="color:white">OPERAHOUSE.SYSTEMS</a>
            </p>
          </div>-->
        </div>
      </div>
    </div>
    
    <!--Stop Loading Screen-->
    <script>
      showtheLimit();
    </script>
    
  </xsl:template>


  <xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
    <li class="dropdown">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">
          <a href="{pageURL/.}" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="prim-{caption/.}">
            <xsl:value-of select="caption/." />
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <xsl:apply-templates select="submenus/submenu[@type='treeview']" />
          </ul>
        </xsl:when>
        <xsl:when test="(@type)='label'"><a href="{pageURL/.}" id="prim-{caption/.}"><xsl:value-of select="caption/." /></a></xsl:when>
      </xsl:choose>
    </li>
  </xsl:template>
  

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a  class="needlogin" data-toggle="modal" href="{pageURL/.}"><xsl:value-of select="caption/." /></a>
    </li>
  </xsl:template>


  
    <!--slider1-->
  <xsl:template match="sqroot/header/menus/menu[@code='slider']/submenus/submenu">
   <li data-transition="slidehorizontal" data-slotamount="5" data-masterspeed="700"  data-title="Slide 3" class="homeslider" style="display:none;">
      <img src="OPHContent/documents/{/sqroot/header/info/account/.}/{pageURL/.}" onerror="this.src='ophcontent/themes/themeTWO/images/white.jpg'" alt="slidebg1" data-bgfit="cover" data-bgposition="center center" data-bgrepeat="no-repeat" />
      <div class="slider-caption slider-captionV4">
         <xsl:if test="link/. != ''">
            <div class="tp-caption rs-caption-4 sft"
              data-hoffset="0"
              data-x="550"
              data-y="400"
              data-speed="800"
              data-start="3500"
              data-easing="Power4.easeOut"
              data-endspeed="300"
              data-endeasing="Power1.easeIn"
              data-captionhidden="off">
              <span class="page-scroll">
                <a href="{link/.}" class="btn primary-btn">
                  Klik Disini<ix class="glyphicon glyphicon-chevron-right"></ix>
                </a>
              </span>
            </div>
          </xsl:if>
        
      </div>
    </li>
  </xsl:template>
</xsl:stylesheet>
