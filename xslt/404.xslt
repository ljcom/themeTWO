<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
  <script>
  			var n=new Date(Date.now());
			$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));
  </script>
 <section class="header clearfix notFound">
       <div class="topBar">
        <div class="container">
          <div class="row">
            <div class="col-md-6 hidden-sm hidden-xs">
              &#xA0;
            </div>
            <div class="col-md-6 col-xs-12">
              <ul class="list-inline pull-right top-right">
                <li class="account-login" id="loginbuttons">
                  Loading Please Wait...
                  <script>
                    var username = '<xsl:value-of select="sqroot/header/info/user/userName/." />';
                    topbutton(username);
                  </script>
                </li>
                <li class="searchBox">
                  <a href="#"><ix class="fa fa-search"></ix></a>
                  <ul class="dropdown-menu dropdown-menu-right">
                    <li>
                      <span class="input-group">
                        <input type="text" id="searchText" class="form-control" placeholder="Search…" aria-describedby="basic-addon2" onkeypress="searchkeypressFront(event)" />
                        <button type="submit" class="input-group-addon" onclick="searchFront()">Submit</button>
                      </span>
                    </li>
                  </ul>
                </li>
                <li class="dropdown cart-dropdown" id="carttop">&#160;</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
	  
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-4 col-12">
		  <a href="index.html" class="navbar-brand pageLogo"><img src="OPHContent/themes/themeTWO/images/logo2.jpg" alt="logo"/></a>
		  </div>
		  <div class="col-md-8 col-12">
            
            <h1>404</h1>
            <h2>Oops! Page Not Found</h2>
            <div class="input-group">
              <input type="text" class="form-control" placeholder="Search again" aria-describedby="basic-addon2"/>
              <a href="#" class="input-group-addon" id="basic-addon2"><i class="fa fa-search"></i></a>
            </div>
            <a class="btn btn-default" href="?" role="button">Go Home</a>
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


</xsl:stylesheet>
