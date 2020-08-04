<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    
    <div class="col-xs-12">
      <div class="innerWrapper">
        <!--h3>Welcome <span id="userLogins">-</span></h3>
        <script>
          document.getElementById("userLogins").innerHTML = document.getElementById("hiddenUsrName").value;
        </script-->
        <!--ul class="list-inline">
          <li><a href="?code=causerfron&amp;GUID={/sqroot/header/info/user/userGUID/.}" class="btn btn-default btn-lg">
            <span><ix class="fa fa-user" aria-hidden="true"></ix>
            </span> <br/> Profile</a></li>
          <li><a href="?code=tapcs3" class="btn btn-default btn-lg">
            <span><ix class="fa fa-list" aria-hidden="true"></ix>
            </span> <br/>Orders History</a></li>
        </ul-->
        		
        <div class="orderBox" id="orderBoxs">
          <h4>Order Status</h4>
          <script>
            var cartID = getCookie("cartID");
            if(cartID != '' || cartID != undefined) {
				cartID = " and docguid != '" +cartID+ "'"
            }
            var GUIDhidden = document.getElementById("hiddenUsrGUID").value;
            var filterkey = "carolGUID='"+ GUIDhidden +"'";// and status = '99' "; //+ cartID;
            LoadNewPart('account_browse_orders_unpaid', 'orderBoxs', 'tapcs4', filterkey, '', 1, 200, null, '0');
			//LoadNewPartView('account_browse_orders_unpaid', 'orderBoxs', 'tapcs4');
          </script>
        </div>
        
      </div>
    </div>

  </xsl:template>
  
</xsl:stylesheet>
