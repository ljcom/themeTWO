function startLoadingScreen() {
    $("#content-loader").css("display", "block");
}
function stopLoadingScreen() {
    $(document).ajaxStop(function () {
        $("#content-loader").delay(1000).fadeOut().css("display", "none");
    });
}

function loadContent2(id, f) {
    //main content
    var searchText
    if (getQueryVariable("bSearchText") != undefined || getQueryVariable("bSearchText") == '') {
        searchText = '&bSearchText=' + getQueryVariable("bSearchText");
    } else {
        searchText = '';
    }
    var filename
    if (getPage() == 'product' && getMode() == 'browse') {
        if (getQueryVariable("type") == 'list')
            filename = 'product_browse_list';
        else
            filename = 'product_browse';
    } else {
        filename = getPage() + '_' + getMode();
    }

    if (getCode() == 'DUMY')
        var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
    else {
        //var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
        var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + searchText + '&date=' + getUnique();
    }

    var divname = [id];
    var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + filename + '.xslt'];

    pushTheme(divname, xmldoc, xsldoc, true);

} 

function LoadNewPart(filename, id, code, sqlfilter, searchText, bpageno, showpage, sortOrder, stateid, clearBefore, afterload) {
	if (clearBefore==null || clearBefore==undefined) clearBefore=true;

    if (filename == 'product') {
        filename = filename + '_' + getCookie('browsetype');
        bpageno = getCookie("bpageno");
        sortOrder = getCookie("sortOrder");
        showpage = getCookie("showpage");
    }

    if (bpageno == '' || bpageno == undefined) { bpageno = 1 }
    if (showpage == '' || showpage == undefined) { showpage = 21 }
    if (sortOrder == '' || sortOrder == undefined) { sortOrder = '' }
    if (stateid == '' || stateid == undefined) { stateid = '' }

    var xmldoc = 'OPHCore/api/default.aspx?mode=browse' + '&code=' + code +
		(sqlfilter != '' ? '&sqlfilter=' + sqlfilter : '') +
		(searchText != '' ? '&bSearchText=' + searchText : '') +
		(bpageno != '' ? '&bpageno=' + bpageno : '') +
		(showpage != '' ? '&showpage=' + showpage : '') +
		(sortOrder != '' ? '&sortOrder=' + sortOrder : '') +
		(stateid != '' ? '&stateid=' + stateid : '') + '&date=' + getUnique();

    var divname = [id];
    var xsldoc = ['OPHContent/themes/themeTwo/xslt/' + filename + '.xslt'];

    pushTheme(divname, xmldoc, xsldoc, clearBefore, function() {
        if (typeof afterload === "function") afterload();
 		
	});
}

function LoadNewPartView(filename, id, code, GUID) {
    if (GUID == undefined || GUID == '') GUID = getQueryVariable("GUID");
    //var xmldoc = 'OPHCore/api/default.aspx?mode=view' + '&code=' + code + '&GUID=' + getGUID() + '&date=' + getUnique();
    var xmldoc = 'OPHCore/api/default.aspx?mode=form' + '&code=' + code + '&GUID=' + GUID + '&date=' + getUnique();

    var divname = [id];
    var xsldoc = ['OPHContent/themes/themeTwo/xslt/' + filename + '.xslt'];


    pushTheme(divname, xmldoc, xsldoc, true);
    //showXML(id, xmldoc, xsldoc, true, true, function () {
    //    if (typeof f == "function") f();
    //});
}
function signInFrontEnd(account) {
    var uid = document.getElementById("userid").value;
    var pwd = document.getElementById("pwd").value;
    var cartID = getCookie("cartID");
    var suba = getCookie(account+'_accountid');
    var remember = document.getElementById("rememberme");

    //var dataForm = $('#signinForm').serialize() //.split('_').join('');

    //var dfLength = dataForm.length;
    //dataForm = dataForm.substring(2, dfLength);
    //dataForm = dataForm.split('%3C').join('%26lt%3B');

	var dataForm = new FormData();

    dataForm.append('mode', 'signin');
    dataForm.append('userid', uid);
    dataForm.append('suba', suba);
    dataForm.append('pwd', pwd);
    dataForm.append('autoLogin', '0');
    dataForm.append('source', window.location.toString().replace('&', '*').replace('?', '*'));

    path = "OPHCore/api/default.aspx?cartID=" + cartID;
	

    $.ajax({
        url: path,
        data: dataForm,
        type: 'POST',
        cache: false,
        contentType: false,
        processData: false,
        dataType: "xml",
        timeout: 80000,
        beforeSend: function () {
            //setCursorWait(this);
        },
        success: function (data) {
            var result = $(data).find("hostGUID").text();
            if (result) {
                if (remember.checked == true) { setCookie("userID", uid, 30, 0, 0); }

                setCookie("cartID", "", 0, 1, 0);
                var app = window.location.href.substring(0, window.location.href.indexOf("/index")).substring(window.location.href.substring(0, window.location.href.indexOf("/index")).lastIndexOf("/") + 1).replace(":", "");

                var landingPage = getCookie(app + '_lastPar') === null || getCookie(app + '_lastPar') === '' ? '?' : getCookie(app + '_lastPar');

                //var landingPage = (getCookie('lastPar') == null || getCookie('lastPar') == '') ? '?' : getCookie('lastPar');
                window.location = landingPage;
            } else {
                //alert('Invalid User or password!');
                document.getElementById("loginNotifMsg").innerHTML = 'Invalid User ID or password!';
                //document.getElementById("loginNotif").style.display = 'block';
                $("#loginNotif").show("slow").delay(2000).fadeOut();
            }
        }
    });
}
function changePlusMinus(e) {
    //    alert(e.innerHTML);		
    $(e).find('.plus-button').toggleClass("fa-minus fa-plus");
}

function ChangePages(type, id) {
    var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + type + '.xslt';
    var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&date=' + getUnique();

    showXML(id, xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
        //if (isAdhoc) setCursorDefault();
    });
}


function searchFront() {
    var type = '', event = '', eventcode = ''
    if (getQueryVariable("type") != '' && getQueryVariable("type") != undefined) type = '&type=' + getQueryVariable("type");
    if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) event = '&event=' + getQueryVariable("event");
    if (getQueryVariable("eventcode") != '' && getQueryVariable("eventcode") != undefined) eventcode = '&eventcode=' + getQueryVariable("eventcode");

    setCookie("bpageno", "1", 0, 1, 0);
    searchText = document.getElementById("searchText").value;
    setCookie("browseSearch", searchText, 0, 1, 0);
    window.location.href = 'index.aspx?env=front&code=maprodfron' + type + event + eventcode + '&bSearchText=' + searchText;
}
function searchkeypressFront(e) {
    if (e.keyCode == 13) {
        var type = '', event = '', eventcode = ''
        if (getQueryVariable("type") != '' && getQueryVariable("type") != undefined) type = '&type=' + getQueryVariable("type");
        if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) event = '&event=' + getQueryVariable("event");
        if (getQueryVariable("eventcode") != '' && getQueryVariable("eventcode") != undefined) eventcode = '&eventcode=' + getQueryVariable("eventcode");

        setCookie("bpageno", "1", 0, 1, 0);
        searchText = document.getElementById("searchText").value;
        setCookie("browseSearch", searchText, 0, 1, 0);
        window.location.href = 'index.aspx?env=front&code=maprodfron' + type + event + eventcode + '&bSearchText=' + searchText;
    }
}
function clearSearch() {
	var type = '', event = '', eventcode = ''
	if (getQueryVariable("type") != '' && getQueryVariable("type") != undefined) type = '&type=' + getQueryVariable("type");
	if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) event = '&event=' + getQueryVariable("event");
	if (getQueryVariable("eventcode") != '' && getQueryVariable("eventcode") != undefined) eventcode = '&eventcode=' + getQueryVariable("eventcode");

	setCookie("browseSearch", "", 0, 1, 0);
	window.location.href = 'index.aspx?env=front&code=maprodfron' + type + event + eventcode;
}

function loginkeypressFront(e) {
    if (e.keyCode == 13) {
        signInFrontEnd();
    }
}
function goToRef(name, url) {
    window.open(url, '_blank');
}

function createPaging(totalrows, filename, id, curpage) {
    var rowperpages = 21;
    var totalpages = Math.ceil(totalrows / rowperpages);
    var i, len, text, lenpage;
    filename = "'" + filename + "'";
    id = "'" + id + "'";
    var pagenow = curpage;
    if (pagenow == undefined) pagenow = getQueryVariable('bpageno');
    if (pagenow == undefined) pagenow = getCookie("bpageno");

    if (pagenow == undefined || pagenow == '') pagenow = 1;

    if (totalpages > 5 && pagenow > 5) {
        lenpage = parseInt(pagenow) - 5;
    } else {
        lenpage = parseInt(pagenow) - (parseInt(pagenow) - 1);
    }
    var totallen = parseInt(lenpage) + 10;

    if (totallen > totalpages) {
        totallen = totalpages + 1;
    }
    for (i = lenpage, len = totallen, text = ""; i < len; i++) {
        j = i;
        if (pagenow != j) {
            text += '<li><a href="#" onclick="GoNextPage(' + filename + ', ' + id + ', ' + j + ', ' + rowperpages + ')">' + j + '</a></li>';
        } else {
            text += '<li><a style="background:#47bac1; color:white" href="#" onclick="GoNextPage(' + filename + ', ' + id + ', ' + j + ', ' + rowperpages + ')">' + j + '</a></li>';
        }
    }
    document.getElementById("paginationprod").innerHTML = '<li><a href="#" onclick="GoNextPage(' + filename + ', ' + id + ', 1, 21)">First Page</a></li>' + text + '<li><a href="#" onclick="GoNextPage(' + filename + ', ' + id + ', ' + totalpages + ', 21)">Last Page</a></li>';
}
function AddToCart(code, formid, guid) {
	
	saveThemeTWO(code, guid, '', formid);
	$('#detailmodal').modal('hide');
}

function goToAnotherPage(url) {
    window.location.href = url;

}
function loadProduct(bSearchText) {
    setCookie('browseSearch', bSearchText, 0, 1, 0);
    if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) {
        sqlfilter = "evenGUID = " + getQueryVariable("event")
    }
    setCookie('bpageno', '1', 0, 1, 0);
    bpageno = 1;
    //goToProductBrowse(bSearchText);
	$('#contentBrowse').html('');
    LoadNewPart('product_browse', 'contentBrowse', 'maprodfron', sqlfilter, bSearchText, bpageno, showpage, sortOrder, '', true);
    //window.location = 'index.aspx?code=maprodfron&';

}

function productChangeView(type, id) {

    startLoadingScreen();
    var code = getCode();
    var filename = 'product_' + type;
    bpageno = getCookie("bpageno");
    sortOrder = getCookie("sortOrder");
    showpage = getCookie("showpage");
    setCookie('browseType', type, 0, 1, 0);
    var bSearchText = ''; // getQueryVariable("bSearchText");
    if (bSearchText == undefined) bSearchText = getCookie('browseSearch');
    var sqlfilter = getQueryVariable("sqlfilter");
    var sortorder = getCookie("sortorder");

    if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) {
        sqlfilter = "evenGUID  =" + getQueryVariable("event");
    }

    if (bpageno == '' || bpageno == undefined) { bpageno = 1 }
    if (showpage == '' || showpage == undefined) { showpage = 21 }
    if (sortOrder == '' || sortOrder == undefined) { sortOrder = '' }
    if (bSearchText == undefined) { bSearchText = "" }
    if (sqlfilter == undefined) { sqlfilter = "" }
    if (sortorder == undefined) { sortorder = "" }

    LoadNewPart(filename, id, code, sqlfilter, bSearchText, bpageno, showpage, sortorder, '', true);

    stopLoadingScreen();

}

function GoNextPage(filename, id, bpageno, showpage) {
    var url
    var code = getQueryVariable("code");
    var type = getQueryVariable("type");
    if (type == undefined) type = '';
    //var searchText = getQueryVariable("bSearchText");
    var bSearchText = getCookie('browseSearch');
    if (bSearchText == undefined) bSearchText = getQueryVariable("bSearchText");
    if (bSearchText == undefined) bSearchText = '';
    var sqlfilter = ''; //getCookie("sqlfilter");
    if (sqlfilter == undefined) sqlfilter = getQueryVariable("sqlfilter");
    var sortorder = getCookie("sortorder");

    if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) {
        sqlfilter = "evenGUID = " + getQueryVariable("event");
    }

    setCookie("bpageno", bpageno, 0, 1, 0);
    setCookie("showpage", showpage, 0, 1, 0);

    //if (searchText == undefined) { searchText = "" }
    //if (sqlfilter == undefined) { sqlfilter = "" }
    //if (sortorder == undefined) { sortorder = "" }

    $("#content-loader").css("display", "block");

    if (filename == 'product') {
        filename = filename + '_' + getCookie('browsetype');
        LoadNewPart(filename, id, code, sqlfilter, bSearchText, bpageno, showpage, sortorder, '', true);
    }
    else {
        url = 'index.aspx?env=front&code=' + code + '&bpageno=' + bpageno + '&showpage=' + showpage + type + sqlfilter + bSearchText
        window.location.href = url;

    }
    $(document).ajaxStop(function () {
        $("#content-loader").delay(1000).fadeOut().css("display", "none");
    });
}
function deleteRow(code, GUID, location) {
    //location: 20 form; 10 cart
	path = "OPHCore/api/default.aspx?mode=function&code=" + code + "&cfunctionlist=" + GUID + '&cfunction=delete';

    $.post(path).done(
        function (data) {
			var result = $(data).find("message").text();
			if (result!='' && result!=null) {
				showMessage(result);
			}
			else if (location==10) {
				showMessage('Product has been removed from cart');

				//var GUIDs = getGUID();
				var filterkey = "parentdocguid='" +  getCookie("cartID") + "'";
				LoadNewPart('cart_top', 'carttop', 'tapcs1deta', filterkey, '', '1', '3', 'createddate desc', '', true);
				
				var filterkey = "parentdocguid='" +  getCookie("cartID") + "'";
				LoadNewPartView('cart_form', 'contentWrapper', 'tapcs1', getCookie("cartID"));

			}
            else {
				
				//LoadNewPartView('cart_form', 'contentWrapper', 'tapcs1', getCookie("cartID"));

				window.location.reload();
				//$('#contentWrapper').html('');
				//LoadNewPartView('cart_form', 'contentWrapper', 'tapcs1', getGUID());
			}

			//document.getElementById("popupMsgContent").innerHTML = 'Product has been removed from cart';
            //$("#popupMsg").show("slow");
        }
    );
}

function NewTabAnotherPage(url) {
    window.open(url, '_blank');
}

function loadContent2(id, f) {
    //main content
    var searchText
    if (getQueryVariable("bSearchText") != undefined || getQueryVariable("bSearchText") == '') {
        searchText = '&bSearchText=' + getQueryVariable("bSearchText");
    } else {
        searchText = '';
    }
    var filename
    if (getPage() == 'product' && getMode() == 'browse') {
        if (getQueryVariable("type") == 'list')
            filename = 'product_browse_list';
        else
            filename = 'product_browse';
    } else {
        filename = getPage() + '_' + getMode();
    }

    var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/' + filename + '.xslt';
    if (getCode() == 'DUMY')
        var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
    else {
        //var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
        var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + searchText + '&date=' + getUnique();
    }
    showXML(id, xmldoc, xsldoc, true, true, function () {
        //run this to make the default value effect appear
        //preview(1, vCode, vGUID);
        if (typeof f == "function") f();
        //if (isAdhoc) setCursorDefault();
    });

}

function SortingBy(xsltname, id, code) {
    var fieldtype = $("select#guiest_id1").val();

    if (xsltname == 'product' && getCookie('browseType')!=null) 
        xsltname = xsltname + '_' + getCookie('browseType');
    else
        xsltname = xsltname + '_' + 'browse';
		
    setCookie("sortorder", fieldtype, 0, 1, 0);
    var bpageno = 1;
    var showpage = getCookie("showpage");

    var bSearchText = getQueryVariable("bSearchText");
    var sqlfilter = getQueryVariable("sqlfilter");
    if (bpageno == '' || bpageno == undefined || bpageno > 1) { bpageno = 1; }
    if (showpage == '' || showpage == undefined) { showpage = 20; }
    if (bSearchText == '' || bSearchText == undefined) { bSearchText = ''; }
    if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) {
        sqlfilter = "evenGUID = " + getQueryVariable("event");
    }
    if (sqlfilter == '' || sqlfilter == undefined) { sqlfilter = ''; }


    setCookie("bpageno", bpageno, 0, 1, 0);
    setCookie("showpage", showpage, 0, 1, 0);

    $("#content-loader").css("display", "block");
	$('#'+id).html('');
    LoadNewPart(xsltname, id, code, sqlfilter, bSearchText, bpageno, showpage, fieldtype, '', true);
}
function hidePopUp(id) {
    $("#" + id).hide("slow");
}

function batchSave(code) {
    var cfunctionlist
    cfunctionlist = document.getElementById("cfunctionlist").value;
    $("#content-loader").css('display', 'block');
    var matches = cfunctionlist.match(/,/g);
    if (matches == null) {
        matches = '1'
    } else {
        matches = matches.length + 1
    }
    var i;
    var formId
    var countX = 0;countY = 0;
    for (i = 0; i < matches; i++) {
        countX++;
        //text += cars[i] + "<br>";
        if (cfunctionlist.indexOf(",") == -1) {
            formId = cfunctionlist
        } else {
            formId = cfunctionlist.substring(0, cfunctionlist.indexOf(","));
        }

        if (document.getElementById("popupMsg").style.display == 'none') {

            //SaveData(code, formId)
            var formid = formId
			var id = "#" + formid
            var guid=$(id+' input[name=guid]').val();
            //var path = 'OPHCore/api/default.aspx?mode=save&code='+code+'&guid='+guid;
            var dataForm = $(id).serialize(); //.split('_').join('');

            //var dfLength = dataForm.length;
            //dataForm = dataForm.split('%3C').join('%26lt%3B');
			
			const ret=saveFunction1(code, guid, '30', formId, dataForm, function (data) {
				countY++;
				var result = $(data).find("message").text();
				if (result) {
					showMessage(result);
				} else {
				}
				if (countY >= matches) {
					LoadNewPartView('cart_form', 'contentWrapper', 'tapcs1', getGUID());                        
				}
			});
			/*
            $.ajax({
                url: path,
                data: dataForm,
                type: 'POST',
                dataType: "xml",
                timeout: 80000,
                beforeSend: function () {
                    //setCursorWait(this);
                },
                success: function (data) {
                    countY++;
                    var result = $(data).find("message").text();
                    if (result) {
						showMessage(result);
                    } else {
                    }
                    if (countY >= matches) {
                        LoadNewPartView('cart_form', 'contentWrapper', 'tapcs1', getGUID());                        

                    }
                }
            });
			*/
        }
        cfunctionlist = cfunctionlist.substring(formId.length + 2, cfunctionlist.length);

    }

    $(document).ajaxStop(function () {
        //countY++;
        //if (countY = matches) {
            //window.location.reload();
        //}
        //if (document.getElementById("popupMsg").style.display == 'none') {
            //window.location.reload();
            //document.getElementById("popupMsgContent").innerHTML = 'Product(s) has been updated in cart';
            //$("#popupMsg").show("slow");



        //}
        //$("#content-loader").css('display', 'none');
    });
    

}
function changePlusMinus(e) {
    //    alert(e.innerHTML);
    $(e).find('.plus-button').toggleClass("fa-minus fa-plus");
}

function changeColorMenuFront() {
    var code = getCode().toLowerCase();
    var eventcode = getQueryVariable("eventcode");
    var menuCon = ''
    if (code == 'home') {
        menuCon = document.getElementById("prim-Home")
    } else if (code == 'maprodfron' && eventcode == 'online') {
        menuCon = document.getElementById("prim-e-kitashop")
    } else if (code == 'maprodfron' && eventcode == 'bazaar') {
        menuCon = document.getElementById("prim-e-Bazaar")
    }
    else if (code == 'maprodfron') {
        menuCon = document.getElementById("prim-Shop")
    } else if (code == 'account' || code == 'causerfron' || code == 'tapcs3') {
        menuCon = document.getElementById("prim-My Account")
    }
    if (menuCon != undefined && menuCon != null && menuCon != '') {
        $('#'+menuCon).addClass('active');
    }
}

function waitUntil(isready, success, error, count, interval) {
    if (count === undefined) {
        count = 3000;
    }
    if (interval === undefined) {
        interval = 20;
    }
    if (isready()) {
        success();
        return;
    }
    // The call back isn't ready. We need to wait for it
    setTimeout(function () {
        if (!count) {
            // We have run out of retries
            if (error !== undefined) {
                error();
            }
        } else {
            // Try again
            waitUntil(isready, success, error, count - 1, interval);
        }
    }, interval);
}

function showtheLimit() {
    waitUntil(function () {
        return $('#theLimit').length > 0;
    }, function () {
        document.getElementById("LimitUsers").innerHTML = $("#theLimit").html();
    }, function () {

    });
}
function ForgotPwdMail(accountid, step) {
    var code = getCode();
    if (step == 'sendemail') {
        var email = document.getElementById("personalemail").value;
        var dataForm = $('#forgotpwd').serialize() //.split('_').join('');\
        var dfLength = dataForm.length;
        //dataForm = dataForm.substring(2, dfLength);
        dataForm = dataForm.split('%3C').join('%26lt%3B');
        path = "OPHCore/api/default.aspx?step=" + step + "&mode=forgotpwd&code=" + code + "&email=" + email+'&suba='+accountid;
    } else if (step == 'verifycode') {
        var email = getQueryVariable("personalemail");
        var vercode = getQueryVariable("verifycode");
        if (vercode != undefined) {
            vercode = vercode;
        } else {
            vercode = document.getElementById("vercode").value;
        }
        var dataForm = $('#verifycode').serialize() //.split('_').join('');\
        var dfLength = dataForm.length;
        dataForm = dataForm.substring(2, dfLength);
        dataForm = dataForm.split('%3C').join('%26lt%3B');
        path = "OPHCore/api/default.aspx?step=" + step + "&mode=forgotpwd&code=" + code + "&email=" + email + "&verifycode=" + vercode+'&suba='+accountid;

    }
    $.ajax({
        url: path,
        data: dataForm,
        type: 'POST',
        dataType: "xml",
        timeout: 80000,
        beforeSend: function () {
            //setCursorWait(this);
        },
        success: function (data) {
            if (step == 'sendemail') {
                var result = $(data).text();
                if (result) {
					//if ($(this)[0].nodeName === "sent") {
					if (result=='1') {				
						setCookie('personalemail', email, 0, 1, 0);
						window.location = 'index.aspx?code=verifycode&personalemail=' + email;					
					}
					else {
						// alert(result);
						//document.getElementById("popupMsgContent").innerHTML = result;
						//$("#popupMsg").show("slow");
						showMessage(result);
					}
				} 
            } else {
                var x = $(data).find("sqroot").children().each(function () {
                    var result = $(this).text();
                    if (result == '1') {
						window.location='index.aspx?code=changepassword&email='+getQueryVariable("personalemail")+'&secret='+vercode;
						//if ($(this)[0].nodeName == "userGUID") window.location = "index.aspx?code=changepassword&GUID=" + result
                        if ($(this)[0].nodeName == "message") {
                            //document.getElementById("popupMsgContent").innerHTML = result;
                            //$("#popupMsg").show("slow");
                        }
                    } else {
						showMessage(result);
                    }
                });
            }

        }
    });
}

function changePwd(accountid) {
    //var GUID = getQueryVariable("GUID");
	var email=getQueryVariable("email");
	var secret=getQueryVariable("secret");
    var pwd = document.getElementById("CAUPWDpassword").value;
    var confirmpwd = document.getElementById("confirmpwd").value;
    var dataForm = $('#changepwd').serialize() //.split('_').join('');

    if (pwd == '') {
        alert('Password is can not be null')
    } else if (pwd != confirmpwd) {
        alert('Password and confirm password must be same')
    }
    else {
        var dfLength = dataForm.length;
        var code = 'user';
        dataForm = dataForm.substring(2, dfLength);
        dataForm = dataForm.split('%3C').join('%26lt%3B');
        //path = "OPHCore/api/default.aspx?code=" + code + "&mode=save&cfunctionlist=" + GUID + "&",
        path = 'OPHCore/api/default.aspx?code=' + code + '&mode=resetpwd&newpwd='+pwd+'&confirmpwd='+pwd+'&email='+email+'&suba='+accountid+'&secret='+secret;

        $.ajax({
            url: path,
            data: dataForm,
            type: 'POST',
            dataType: "xml",
            timeout: 80000,
            beforeSend: function () {
                //setCursorWait(this);
            },
            success: function (data) {
                var result = $(data).text();
                if (result=='1') {
                    //window.location = 'index.aspx?env=front&code=verifycode';
                    //                    alert(result);
                    window.location = 'index.aspx?env=front&code=login2';

                } else {
					showMessage(result);
					//window.location = 'index.aspx?env=front&code=login2';
                }
                var app = window.location.href.substring(0, window.location.href.indexOf("/index")).substring(window.location.href.substring(0, window.location.href.indexOf("/index")).lastIndexOf("/") + 1).replace(":", "");

                setCookie(app+"lastPar", "index.aspx?env=FRONT&code=home", 0, 1, 0);
            }
        });
    }
}
function topbutton(username) {
    if (getCookie("isLogin") == '1' && username != '') {
        document.getElementById("loginbuttons").innerHTML = '<span><a class="resize-font480-10px" href="#">Welcome, <span class="resize-font480-10px frThemeColor" style="font-weight:bold; font-size:14px;">' + username + '</a> </span> <span> | <a class="resize-font480-10px" data-toggle="modal" href="#" onClick="signOut(\'login2\')"><ix class="fa fa-sign-out"></ix><span class="hidden-xs"> Log Out</a></span>';
    } else {
        document.getElementById("loginbuttons").innerHTML = '<a data-toggle="modal" onclick="javascript:showLogin()"><ix class="fa fa-sign-in"></ix><span class="hidden-xs"> Log In</span></a></span>';
    }
}
function showLogin() {
	$('#login').modal('show');
}
function showProduct(guid) {
	var filterkey = "docguid='" + guid + "'";
	$('#productmodalbody').html('');
	LoadNewPartView('product_form', 'productmodalbody', 'maprodfron2', guid);
	$('#detailmodal').modal('show');
}
function showReferral(guid) {
	var filterkey = "carolguid='" + guid + "'";
	$('#referralmodalbody').html('');
	LoadNewPartView('account_childform', 'referralmodalbody', 'referrals', guid);
	$('#detailmodal').modal('show');
}

function saveThemeTWO(code, guid, location, formId) {
    //executeFunction(code, guid, 'cart', 10, null, null, '', function (data) {
	var dataForm = $('#'+formId).serialize();
	if (code=='referrals') {
		parentGUID=$('#cid').val();
		dataForm +='&cid='+parentGUID;
	}		
	saveFunction1(code, guid, location, formId, dataForm, function (data) {
        var result = $(data).find("message").text();
        if (result) {
            //document.getElementById("popupMsgContent").innerHTML = result;
            //$("#popupMsg").show("slow");
			showMessage(result);
		} else {
            //goToProductBrowse();
			if (code.toLowerCase()=='maprodfron') {
				var filterkey = "parentdocguid='" + getCookie("cartID") + "'";
				LoadNewPart('cart_top', 'carttop', 'tapcs1deta', filterkey, '', '1', '3', 'createddate desc', '', true);
				//document.getElementById("popupMsgContent").innerHTML = 'Product has been added to cart';
				//$("#popupMsg").show("slow");
				showMessage('Product has been added to cart');
			}
			else
				$('#detailmodal').modal('hide');
			window.location.reload();
		}
        //stopLoadingScreen();

    }, null);
}
function clearCookies() {
    setCookie("bpageno", "1", 0, 1, 0);
    setCookie("showpage", "21", 0, 1, 0);
    setCookie("bSearchText", "", 0, 1, 0);
    setCookie("sortOrder", "", 0, 1, 0);
    setCookie("parentctgr1", "", 0, 3, 0);
    setCookie("parentctgr2", "", 0, 3, 0);
}
function goToProductDetails(url) {
    var searchtext = getQueryVariable("bSearchText"), event = getQueryVariable("event"), eventcode = getQueryVariable("eventcode");

    if (searchtext != undefined && searchtext != '') searchtext = '&bSearchText=' + searchtext;
    else searchtext = '';

    if (event != undefined && event != '') event = '&event=' + event;
    else event = '';

    if (eventcode != undefined && eventcode != '') eventcode = '&eventcode=' + eventcode;
    else eventcode = '';

    var newurl
    newurl = url + searchtext + event + eventcode;
    window.location.replace(newurl);
}
function goToProductBrowse(search) {
    var code = 'maprodfron';
    var url = 'index.aspx?code=' + code
    var searchtext = getQueryVariable("bSearchText")

    var searchtext = getCookie('browseSearch');
    if (search != undefined) searchtext = search;

    var pageno = '&bpageno=' + getCookie('bpageno');
    var event = getQueryVariable("event"), eventcode = getQueryVariable("eventcode");

    if (searchtext != undefined && searchtext != '') searchtext = '&bSearchText=' + searchtext;
    else searchtext = '';
    if (event != undefined && event != '') event = '&event=' + event;
    else event = '';
    if (eventcode != undefined && eventcode != '') eventcode = '&eventcode=' + eventcode;
    else eventcode = '';

    var newurl
    newurl = url + searchtext + pageno + event + eventcode;
    window.location.replace(newurl);
}
function colapsingMenu() {

}
function findParent(numbers, guid) {
    var parent1 = '', parent2 = ''
    if (numbers == 3) {

        parent1 = document.getElementById('parent_' + guid).value;
        setCookie("parentctgr1", parent1, 0, 3, 0);

        parent2 = document.getElementById('parent_' + parent1).value;
        setCookie("parentctgr2", parent2, 0, 3, 0);

    } else if (numbers == 2) {

        parent2 = document.getElementById('parent_' + guid).value;
        setCookie("parentctgr2", parent2, 0, 3, 0);
    }
}
function generatePayment(code, tablename, formid, locations, GUID, delcookie) {
    if (GUID == '') { GUID = getGUID() }
    var path = 'OPHCore/api/midtrans.aspx?mode=checkdata&code=' + tablename + '&GUID=' + GUID
    var id = "#" + formid
    //$.post(path, $(id).serialize());
    var dataForm = $(id).serialize() //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.split('%3C').join('%26lt%3B');

    $.ajax({
        url: path,
        data: dataForm,
        crossdomain: true,
        type: 'POST',
        dataType: "xml",
        timeout: 80000,
        beforeSend: function () {
            //setCursorWait(this);
        },
        success: function (data) {
            var result = $(data).find("message").text();
            var newUrl = $(data).find("newurl").text();

            if (result) {
                //document.getElementById("popupMsgContent").innerHTML = result;
                //$("#popupMsg").show("slow")
				showMessage(result);
			}
            if (newUrl) {
                window.location = newUrl
            }
        }
    });
}

function getTransactionDetails(tablename, GUID) {
    var path = 'OPHCore/api/midtrans.aspx?mode=gettransaction&code=' + tablename + '&GUID=' + GUID
    var formid = 'cartForm'
    var id = "#" + formid
    var dataForm = $(id).serialize()

    var dfLength = dataForm.length;
    dataForm = dataForm.split('%3C').join('%26lt%3B');

    $.ajax({
        url: path,
        data: dataForm,
        crossdomain: true,
        type: 'POST',
        dataType: "xml",
        timeout: 80000,
        beforeSend: function () {
            //setCursorWait(this);
        },
        success: function (data) {
            var result = $(data).find("message").text();
            var transaction = $(data).find("transaction").text();
            if (transaction) {
                var transactionData = transaction
                snap.show();
                ajaxGetToken(transactionData, function (error, snapToken) {
                    if (error) {
                        snap.hide();
                    } else {
                        snap.pay(snapToken);
                    }
                });
            }
            else {

                if (result == '') { result = 'something wrong !'; }
                //document.getElementById("popupMsgContent").innerHTML = result;
                //$("#popupMsg").show("slow")
				showMessage(result);
			}
        }
    });

}
function ajaxGetToken(transactionData, callback) {
    var snapToken;
    // Request get token to your server & save result to snapToken variable
    var path = 'OPHCore/api/midtrans.aspx?mode=checkdatatest&code=TaPCSO&GUID=' + getGUID()
    var formid = 'cartForm'
    var id = "#" + formid
    var dataForm = $(id).serialize() //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.split('%3C').join('%26lt%3B');

    $.ajax({
        url: path,
        data: dataForm,
        crossdomain: true,
        type: 'POST',
        dataType: "xml",
        timeout: 80000,
        beforeSend: function () {
            //setCursorWait(this);
        },
        success: function (data) {
            var result = $(data).find("message").text();
            var newUrl = $(data).find("newurl").text();
            var token = $(data).find("token").text();
            if (token) {
                snapToken = token
                if (snapToken) {
                    callback(null, snapToken);
                } else {
                    callback(new Error('Failed to fetch snap token'), null);
                }
            }
        }
    });

    //    if (snapToken) {
    //        callback(null, snapToken);
    //    } else {
    //        callback(new Error('Failed to fetch snap token'), null);
    //    }
}

//function timeIsUpfront() {
//    //lastPar = window.location;
//    //setCookie('lastPar', lastPar);
//    //setCookie("userId", "", 0, 0, 0);
//    window.location = 'index.aspx?env=acct&code=home';
//}
//setTimeout(function () { timeIsUpfront(); }, 1000 * 2 * 60);

//for doku
function getRequestDateTime() {
    var now = new Date();

    document.MerchatPaymentPage.REQUESTDATETIME.value = dateFormat(now, "yyyymmddHHMMss");
}

function randomString(STRlen) {
    var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
    var string_length = STRlen;
    var randomstring = '';
    for (var i = 0; i < string_length; i++) {
        var rnum = Math.floor(Math.random() * chars.length);
        randomstring += chars.substring(rnum, rnum + 1);
    }

    return randomstring;

}

function SaveData(code, formid, locations, GUID, delcookie, tablename, reloadpage, afterSuccess) {
    if (reloadpage == '' || reloadpage == undefined) { reloadpage = '1' }
    if (delcookie == '') { delcookie = '0' }

    if (GUID != undefined && GUID != '') { GUID = '&cfunctionlist=' + GUID; }
    else { GUID = '' }
    var path = 'OPHCore/api/default.aspx?mode=save&code=' + code + GUID
    var id = "#" + formid
    //$.post(path, $(id).serialize());
    var dataForm = $(id).serialize() //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.split('%3C').join('%26lt%3B');

    $.ajax({
        url: path,
        data: dataForm,
        type: 'POST',
        dataType: "xml",
        timeout: 80000,
        beforeSend: function () {
            //setCursorWait(this);
        },
        success: function (data) {
            var result = $(data).find("message").text();
            if (result) {
                if (result == 'gotopending') {
                    if (delcookie == '1') setCookie("cartID", "", 0, 0, 0);

                    window.location = 'index.aspx?code=account';
                }
                else if (result == 'gotomidtrans') {
                    if (GUID == '') { GUID = getGUID() }
                    if (delcookie == '1') setCookie("cartID", "", 0, 0, 0);
                    generatePayment(code, tablename, formid, locations, GUID, delcookie)   //vtweb
                    //getTransactionDetails(tablename, GUID)      //snap
                }
                else if (result == 'gotodoku') {
                    //remove flag sam 20191015   
                    //if (delcookie == '1') setCookie("cartID", "", 0, 0, 0);
                    //document.getElementById('submit').click()
					window.location ='ophcore/api/doku.aspx?mode=payment&code=tapcs2&guid='+getGUID();
                }
                else {
                    //document.getElementById("popupMsgContent").innerHTML = result;
                    //$("#popupMsg").show("slow")
					showMessage(result);
				}
            } else {
                if (getCode().toLowerCase() == 'tapcsd') {
                    //alert("test");
                    if (delcookie == '1') setCookie("cartID", "", 0, 0, 0);
                    window.location="index.aspx?env=front&code=tapcs2&guid="+getGUID();
                }
				else if (getCode().toLowerCase() == 'tapcsd' && locations == '') {
                    //alert("test");
                    if (delcookie == '1') setCookie("cartID", "", 0, 0, 0);
                    location.replace("index.aspx?env=front&code=tapcs3");
                }
                else if (location != '') {
                    if (delcookie == '1') setCookie("cartID", "", 0, 0, 0);
                    if (reloadpage == 1) {
                        window.location = locations
                    }
                } else {
                    if (reloadpage == 1) {
                        window.location.reload();
                    }
                }
            }
			if (typeof afterSuccess === "function") afterSuccess(data);
        }
    });

}

var nbLoad = 1;
function endLoading(loader, div) {
    if (loader == undefined) loader = 'loader';
    if (div == undefined) div = 'frameMaster';
    nbLoad--;
    //if (nbLoad <= 0) {
    //document.getElementById(loader).style.display = "none";
    //document.getElementById(div).style.display = "block";
    nbLoad = 0;
    //}
}
function setLoading(loader, div) {
    nbLoad++;
    if (loader == undefined) loader = 'loader';
    if (div == undefined) div = 'frameMaster';

    //document.getElementById(loader).style.display = "block";
    //document.getElementById(div).style.display = "none";
}

function showMessage(msg, type)
{
	//alert(msg);
	document.getElementById("popupMsgContent").innerHTML = msg;
	document.getElementById("popupMsg").style.zIndex = 10000;
	$("#popupMsg").show("slow");
	setTimeout(function() {
		$('#popupMsg').hide('slow');
	}, 3000);
	
}

	function loadNextProductPage() {
		if ((window.innerHeight + document.documentElement.scrollTop) >= document.body.offsetHeight*0.80 && autopage==1) {
				// you're at the bottom of the page
			var bpageno = getCookie("bpageno");
			var nbPages = getCookie("nbPages");
			if (nbPages==null && bpageno>0) nbPages=bpageno+1;
			if (parseInt(nbPages)>parseInt(bpageno)) {
				if ($('#loadingnextpage').hasClass('hide')) $('#loadingnextpage').removeClass('hide');

				autopage=0;	//wait until next load completed		
				var showpshowpage = getCookie("showpage");
				var bSearchText = getCookie('browseSearch');
				var sortOrder = getCookie("sortorder");

				if (bpageno == '' || bpageno == undefined) {bpageno = 1 ;}
				if (showpage == '' || showpage == undefined) {showpage = 21 ;}
				if (bSearchText == '' || bSearchText == undefined) {bSearchText = '' ;}
				if (sortOrder == '' || sortOrder == undefined) {
					sortOrder = 'Name Asc' ;
					setCookie("sortorder", sortOrder, 0, 1, 0);
				}
				bpageno++;
				console.log('bottom '+bpageno);
				setCookie("bpageno", bpageno, 1,0,0);


				if (getQueryVariable("type") == 'list'){
					setCookie("browsetype", "browse_list", 0, 1, 0);
					$('#contentBrowse').addClass('productListSingle');
					LoadNewPart('product_browse_list', 'contentBrowse', 'maprodfron', sqlfilter, bSearchText, bpageno, showpage, sortOrder, '', false, function() {
						autopage=1;
						loadNextProductPage();
					});
				}
				else {
					setCookie("browsetype", "browse", 0, 1, 0);
					LoadNewPart('product_browse', 'contentBrowse', 'maprodfron', sqlfilter, bSearchText, bpageno, showpage, sortOrder, '', false, function() {
						autopage=1;
						loadNextProductPage();
					});
				}
				var cartid = getCookie('cartID');
				$(".cartidclass" ).val(cartid);
			}
			else {
			}
		}
	}

function isBigger(a,b) {return a>b;}
function isSmaller(a,b) {return a<b;}
