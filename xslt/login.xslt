﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
     
	//var filterkey = "parentdocguid='" +  getCookie("cartID") + "'";
	//LoadNewPart('cart_top', 'carttop', 'tapcs1deta', filterkey, '');

     //endLoading();
	
	var n=new Date(Date.now());
	$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));	 
	
    </script>
    <!-- Page script -->

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
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="javascript:goHome()">
              <img src="OPHContent/themes/themeTWO/images/logo2.jpg" style="width:200px;" alt="logo" />
            </a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav navbar-right">
              <xsl:apply-templates select="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu" />
            </ul>
          </div>
          <!-- /.navbar-collapse -->
        </div>
      </nav>
    </div>

    <!-- LIGHT SECTION -->
    <section class="lightSection clearfix pageHeader">
      <div class="container">
        <div class="row">
          <div class="col-xs-6">
            <div class="page-title">
              <h2 id="PageTitle" style="color:black;">LOGIN</h2>
            </div>
          </div>
          <!--<div class="col-xs-6">
            <ol class="breadcrumb pull-right" id="breadcrumbs">
              <li>
                <a href="index.aspx?code=home">Home</a>
              </li>
              <li class="active">Product</li>
            </ol>
          </div>-->
        </div>
      </div>
    </section>

    <section class="mainContent clearfix logIn" style="padding:50px 0 0 0">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3>log in</h3>
              </div>
              <div class="panel-body">
                <form id="formlogin">
                  <div class="form-group enabled-input">
                    <label>User Name</label>
                    <input type="text" class="form-control" name ="userid" id ="userid" onkeypress="loginkeypressFront(event)"/>
                  </div>
                  <div class="form-group enabled-input">
                    <label>Password</label>
                    <input type="password" class="form-control" name ="pwd" id ="pwd" onkeypress="loginkeypressFront(event)"/>
                  </div>
                  <div class="alert alert-danger" id="loginNotif" style="display:none;height:35px;padding-top:8px;">
                    <span class="glyphicon glyphicon-exclamation-sign">&#xA0;</span>
                    <span id="loginNotifMsg">&#xA0;</span>
                  </div>
                  <br/>
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" id="rememberme"/> Remember Me
                    </label>
                  </div>

                  <div style="text-align:center">
                    <a class="btn btn-primary btn-block" onclick ="signInFrontEnd('{/sqroot/header/info/account}')">log in</a>
                  </div>
                </form>

              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3>Get New Password</h3>
              </div>
              <div class="panel-body">
                <form id="forgotpwd" method="POST" role="form">
                  <p class="help-block">Enter the e-mail address associated with your account. Click submit to have Code e-mailed to you.</p>
                  <div class="form-group">
                    <label for="">Enter Email</label>
                    <input type="email" class="form-control" id="personalemail" name="personalemail" />
                    </div>
                  <a onclick="ForgotPwdMail('{/sqroot/header/info/account}', 'sendemail')" class="btn btn-primary btn-block">Submit</a>
                </form>
              </div>
            </div>
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

    <!--LOGIN MODAL-->
    <!--<div class="modal fade login-modal" id="login" tabindex="-1" role="dialog">
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
                  <input type="checkbox" /> Remember Me
                </label>
              </div>
              <a class="btn btn-primary btn-block" onclick ="signInFrontEnd()">log in</a>
              <button type="button" class="btn btn-link btn-block">Forgot Password?</button>
            </form>
          </div>
        </div>
      </div>
    </div>-->


    <!-- Message -->
    <div id="popupMsg" class="alert alert-warning bgThemeColor" style="color:white; position:fixed; z-index:1000; top:5%;  right:3%; width:350px; margin:0 auto; display:none">
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
    <!--Loading Screen--><!--
    <div id="content-loader">
      <div class="loader" style="">
        &#xA0;
      </div>
    </div>-->

    <!--Stop Loading Screen-->
    <script>
      $( document ).ajaxStop(function() {
      $("#content-loader").show("slow").delay(500).fadeOut();
      });
    </script>
  </xsl:template>
  <!--primary front menu-->

  <xsl:template match="sqroot/header/menus/menu[@code='primaryfront']/submenus/submenu">
    <li class="dropdown">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">
          <a href="{pageURL/.}" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="prim-{caption/.}">
            <xsl:value-of select="caption/." />
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <xsl:apply-templates select="submenus/submenu[@mode='treeview']" />
          </ul>
        </xsl:when>
        <xsl:when test="(@type)='label'">
          <a href="{pageURL/.}" id="prim-{caption/.}">
            <xsl:value-of select="caption/." />
          </a>
        </xsl:when>
      </xsl:choose>
    </li>
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a class="needlogin" data-toggle="modal" href="{pageURL/.}">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>
