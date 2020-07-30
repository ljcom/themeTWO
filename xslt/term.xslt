<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes"/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:template match="/">
	<script>
			var n=new Date(Date.now());
			$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));
	</script>
		<section class="header clearfix headerV3">
			<!-- TOPBAR -->
			<div class="topBar">
				<div class="container">
					<div class="row">
						<div class="col-md-6 hidden-sm hidden-xs">
							&#xA0;
						</div>
						<div class="col-md-6 col-xs-12">
							<ul class="list-inline pull-right top-right">
								<!--<li class="account-login" id="loginbuttons">
                  Loading Please Wait...
                  <script>
                    var username = '<xsl:value-of select="sqroot/header/info/user/userName/." />';
                    topbutton(username);
                  </script>
                </li>-->
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- NAVBAR -->
			<nav class="navbar navbar-main navbar-default" role="navigation">
				<div class="container">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"/>
							<span class="icon-bar"/>
							<span class="icon-bar"/>
						</button>
						<a class="navbar-brand" href="javascript:goHome();">
							<img src="OPHContent/themes/themeTWO/images/logo2.jpg" style="width:200px;" alt="logo"/>
						</a>
					</div>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse navbar-ex1-collapse">
						<ul class="nav navbar-nav navbar-right">
							<xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu"/>
						</ul>
					</div>
					<!-- /.navbar-collapse -->
				</div>
			</nav>
		</section>
		<!-- LIGHT SECTION -->
		<section class="lightSection clearfix pageHeader">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <div class="page-title">
                <h2><xsl:value-of select="/sqroot/header/info/title/." /></h2>
              </div>
            </div>
            <div class="col-md-6">
              <ol class="breadcrumb float-right">
                <li>
                  <a href="?">Home</a>
                </li>
                <li class="active"><xsl:value-of select="/sqroot/header/info/title/." /></li>
              </ol>
            </div>
          </div>
        </div>
      </section>
		<section class="mainContent clearfix logIn" style="padding:50px 0 0 0">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h3>Some Title Should Be Here</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. </p>
						<p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
						<p>Enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. </p>
						<p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.</p>
					</div>
				</div>
			</div>
		</section>
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
	</xsl:template>
	<!--primary menu-->
	<xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
		<li class="dropdown">
			<xsl:choose>
				<xsl:when test="(@type)='treeroot'">
					<a href="{pageURL/.}" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="prim-{caption/.}">
						<xsl:value-of select="caption/."/>
					</a>
					<ul class="dropdown-menu dropdown-menu-right">
						<xsl:apply-templates select="submenus/submenu[@type='treeview']"/>
					</ul>
				</xsl:when>
				<xsl:when test="(@type)='label'">
					<a href="{pageURL/.}" id="prim-{caption/.}">
						<xsl:value-of select="caption/."/>
					</a>
				</xsl:when>
			</xsl:choose>
		</li>
	</xsl:template>
	<!--treeview-->
	<xsl:template match="submenus/submenu[@type='treeview']">
		<li>
			<a href="{pageURL/.}">
				<xsl:value-of select="caption/."/>
			</a>
		</li>
	</xsl:template>
	<!--secondary menu-->
	<xsl:template match="sqroot/header/menus/menu[@code='Account']/submenus/submenu">
		<xsl:choose>
			<xsl:when test="(@type)='treeroot'">
			</xsl:when>
			<xsl:when test="(@type)='label' and (caption/.)='Profile'">
				<a href="{pageURL/.}{../../../../info/user/userGUID/.}" class="btn btn-default {@active}">
					<span style="margin-right:10px;">
						<ix class="{icon/fa/.}" aria-hidden="true"/>
					</span>
					<xsl:value-of select="caption/."/>
				</a>
			</xsl:when>
			<xsl:when test="(@type)='label' and (caption/.)!='Profile'">
				<a href="{pageURL/.}" class="btn btn-default {@active}">
					<span style="margin-right:10px;">
						<ix class="{icon/fa/.}" aria-hidden="true"/>
					</span>
					<xsl:value-of select="caption/."/>
				</a>
			</xsl:when>
		</xsl:choose>
	</xsl:template>	
</xsl:stylesheet>
