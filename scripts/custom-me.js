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
    //showXML(id, xmldoc, xsldoc, true, true, function () {
    //    //run this to make the default value effect appear
    //    //preview(1, vCode, vGUID);
    //    if (typeof f == "function") f();
    //    //if (isAdhoc) setCursorDefault();
    //});

} function LoadNewPart(filename, id, code, sqlfilter, searchText, bpageno, showpage, sortOrder) {
    if (filename == 'product') {
        filename = filename + '_' + getCookie('browsetype');
        bpageno = getCookie("bpageno");
        sortOrder = getCookie("sortOrder");
        showpage = getCookie("showpage");
    }

    if (bpageno == '' || bpageno == undefined) { bpageno = 1 }
    if (showpage == '' || showpage == undefined) { showpage = 21 }
    if (sortOrder == '' || sortOrder == undefined) { sortOrder = '' }
    var xmldoc = 'OPHCore/api/default.aspx?mode=browse' + '&code=' + code + '&sqlfilter=' + sqlfilter + '&bSearchText=' + searchText + '&bpageno=' + bpageno + '&showpage=' + showpage + '&sortOrder=' + sortOrder + '&date=' + getUnique();

    var divname = [id];
    var xsldoc = ['OPHContent/themes/themeTwo/xslt/' + filename + '.xslt'];

    pushTheme(divname, xmldoc, xsldoc, true);
    //showXML(id, xmldoc, xsldoc, true, true, function () {
    //    if (typeof f == "function") f();
    //});
}

function LoadNewPartView(filename, id, code, GUID) {
    if (GUID == undefined || GUID == '') GUID = getQueryVariable("GUID");
    //var xmldoc = 'OPHCore/api/default.aspx?mode=view' + '&code=' + code + '&GUID=' + getGUID() + '&date=' + getUnique();
    var xmldoc = 'OPHCore/api/default.aspx?mode=view' + '&code=' + code + '&GUID=' + GUID + '&date=' + getUnique();

    var divname = [id];
    var xsldoc = ['OPHContent/themes/themeTwo/xslt/' + filename + '.xslt'];

    pushTheme(divname, xmldoc, xsldoc, true);
    //showXML(id, xmldoc, xsldoc, true, true, function () {
    //    if (typeof f == "function") f();
    //});
}
function signInFrontEnd() {
    var uid = document.getElementById("userid").value;
    var pwd = document.getElementById("pwd").value;
    var cartID = getCookie("cartID");
    var remember = document.getElementById("rememberme");

    var dataForm = $('#signinForm').serialize() //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.substring(2, dfLength);
    dataForm = dataForm.split('%3C').join('%26lt%3B');
    path = "OPHCore/api/default.aspx?mode=signin&userid=" + uid + "&pwd=" + pwd + "&cartID=" + cartID;

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
            var result = $(data).find("hostGUID").text();
            if (result) {
                if (remember.checked == true) { setCookie("userID", uid, 30, 0, 0); }
                setCookie("cartID", "", 0, 1, 0);
                var landingPage = (getCookie('lastPar') == null || getCookie('lastPar') == '') ? '?' : getCookie('lastPar');
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
    var xmldoc = 'OPHCore/api/?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&date=' + getUnique();

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
        window.location.href = 'index.aspx?env=front&code=maprodfron' + type + event + eventcode + '&bSearchText=' + searchText;
    }
}
function loginkeypressFront(e) {
    if (e.keyCode == 13) {
        signInFrontEnd();
    }
}
function goToRef(name, url) {
    window.open(url, '_blank');
}

function createPaging(totalrows, filename, id) {
    var rowperpages = 21;
    var totalpages = Math.ceil(totalrows / rowperpages);
    var i, len, text, lenpage;
    filename = "'" + filename + "'";
    id = "'" + id + "'";
    var pagenow = getCookie("bpageno");

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
function AddToCart(code, formid) {
    startLoadingScreen();
    var path = 'OPHCore/api/default.aspx?mode=save&code=' + code
    var id = "#" + formid
    //$.post(path, $(id).serialize()) //Serialize looks good name=textInNameInput&&telefon=textInPhoneInput---etc
    //  .done(function(data) {
    //      window.location.reload()
    //  });
    //  return false;

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
                document.getElementById("popupMsgContent").innerHTML = result;
                $("#popupMsg").show("slow"); 
            } else {
                window.location.reload();
            }
            stopLoadingScreen();
        }
    });

}

function goToAnotherPage(url) {
    window.location.href = url;

}

function productChangeView(type, id) {

    startLoadingScreen();
    var code = getCode();
    var filename = 'product_' + type;
    bpageno = getCookie("bpageno");
    sortOrder = getCookie("sortOrder");
    showpage = getCookie("showpage");
    var searchText = getQueryVariable("bSearchText");
    var sqlfilter = getQueryVariable("sqlfilter");
    var sortorder = getCookie("sortorder");

    if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) {
        sqlfilter = "evenGUID  =" + getQueryVariable("event");
    }

    if (bpageno == '' || bpageno == undefined) { bpageno = 1 }
    if (showpage == '' || showpage == undefined) { showpage = 21 }
    if (sortOrder == '' || sortOrder == undefined) { sortOrder = '' }
    if (searchText == undefined) { searchText = "" }
    if (sqlfilter == undefined) { sqlfilter = "" }
    if (sortorder == undefined) { sortorder = "" }

    LoadNewPart(filename, id, code, sqlfilter, bSearchText, bpageno, showpage, sortorder);

    stopLoadingScreen();

}

function GoNextPage(filename, id, bpageno, showpage) {
    var url
    var code = getQueryVariable("code");
    var type = getQueryVariable("type");
    var searchText = getQueryVariable("bSearchText");
    var sqlfilter = getQueryVariable("sqlfilter");
    var sortorder = getCookie("sortorder");

    if (getQueryVariable("event") != '' && getQueryVariable("event") != undefined) {
        sqlfilter = "evenGUID = " + getQueryVariable("event") ;
    } 

    setCookie("bpageno", bpageno, 0, 1, 0);
    setCookie("showpage", showpage, 0, 1, 0);

    if (filename == 'product') {
        filename = filename + '_' + getCookie('browsetype');
    }
    if (searchText == undefined) { searchText = "" }
    if (sqlfilter == undefined) { sqlfilter = "" }
    if (sortorder == undefined) { sortorder = "" }

    //url = 'index.aspx?env=front&code=' + code + '&bpageno=' + bpageno + '&showpage=' + showpage + type + sqlfilter + searchText
    //window.location.href = url;
    $("#content-loader").css("display", "block");

    LoadNewPart(filename, id, code, sqlfilter, bSearchText, bpageno, showpage, sortorder);

    $(document).ajaxStop(function () {
        $("#content-loader").delay(1000).fadeOut().css("display", "none");
    });
}
function deleteRow(code, GUID) {

    path = "OPHCore/api/default.aspx?mode=function&code=" + code + "&cfunctionlist=" + GUID + '&cfunction=delete';

    $.post(path).done(window.location.reload());
}
function goToAnotherPage(url) {
    window.location.href = url;

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
        var xmldoc = 'OPHCore/api/?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + searchText + '&date=' + getUnique();
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

    if (xsltname == 'product') {
        xsltname = xsltname + '_' + getCookie('browsetype');
    }
    setCookie("sortorder", fieldtype, 0, 1, 0);
    var bpageno = getCookie("bpageno");
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
    LoadNewPart(xsltname, id, code, sqlfilter, bSearchText, bpageno, showpage, fieldtype);
    $(document).ajaxStop(function () {
        $("#content-loader").delay(1000).fadeOut().css("display", "none");
    });
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
    for (i = 0; i < matches; i++) {
        //text += cars[i] + "<br>";
        if (cfunctionlist.indexOf(",") == -1) {
            formId = cfunctionlist
        } else {
            formId = cfunctionlist.substring(0, cfunctionlist.indexOf(","));
        }

        if (document.getElementById("popupMsg").style.display == 'none') {

            //SaveData(code, formId)
            var formid = formId
            var path = 'OPHCore/api/?mode=save&code=' + code
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
                        document.getElementById("popupMsgContent").innerHTML = result;
                        $("#popupMsg").show("slow")
                    } else {

                    }
                }
            });
        }
        cfunctionlist = cfunctionlist.substring(formId.length + 2, cfunctionlist.length);

    }

    $(document).ajaxStop(function () {
        if (document.getElementById("popupMsg").style.display == 'none') {
            window.location.reload();
        }
        $("#content-loader").css('display', 'none');
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
    if (menuCon != undefined && menuCon != null && menuCon != ''){
        menuCon.style.color = '#47BAC1';
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
function ForgotPwdMail(step) {
    var code = getCode();
    if (step == 'sendemail') {
        var email = document.getElementById("personalemail").value;
        var dataForm = $('#forgotpwd').serialize() //.split('_').join('');\
        var dfLength = dataForm.length;
        dataForm = dataForm.substring(2, dfLength);
        dataForm = dataForm.split('%3C').join('%26lt%3B');
        path = "OPHCore/api/default.aspx?step=" + step + "&mode=forgotpwd&code=" + code + "&email=" + email;
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
        path = "OPHCore/api/default.aspx?step=" + step + "&mode=forgotpwd&code=" + code + "&email=" + email + "&verifycode=" + vercode;

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
                    // alert(result);
                    document.getElementById("popupMsgContent").innerHTML = result;
                    $("#popupMsg").show("slow");
                } else {
                    setCookie('personalemail', email, 0, 1, 0);
                    window.location = 'index.aspx?code=verifycode&personalemail=' + email;
                }
            } else {
                var x = $(data).find("sqroot").children().each(function () {
                    var result = $(this).text();
                    if (result != '') {
                        if ($(this)[0].nodeName == "userGUID") window.location = "index.aspx?code=changepassword&GUID=" + result
                        if ($(this)[0].nodeName == "message") {
                            document.getElementById("popupMsgContent").innerHTML = result;
                            $("#popupMsg").show("slow");
                        }
                    } else {
                        alert('error');
                    }
                });
            }

        }
    });
}

function changePwd() {
    var GUID = getQueryVariable("GUID");
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
        path = "OPHCore/api/default.aspx?code=" + code + "&mode=save&cfunctionlist=" + GUID + "&",
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
                if (result) {
                    //window.location = 'index.aspx?env=front&code=verifycode';
//                    alert(result);
                    window.location = 'index.aspx?env=front&code=login2';
                
                } else {
                    window.location = 'index.aspx?env=front&code=login2';
                }
		setCookie("lastPar", "index.aspx?env=FRONT&code=home", 0, 1, 0);
            }
        });
    }
}
function topbutton(username) {
    if (getCookie("isLogin") == '1' && username != '') {
        document.getElementById("loginbuttons").innerHTML = '<span><a class="resize-font480-10px" href="#">Welcome, <span class="resize-font480-10px" style="color:#47BAC1; font-weight:bold; font-size:14px;">' + username + '</a> </span> <span> | <a class="resize-font480-10px" data-toggle="modal" href="#" onClick="signOut()">Log Out</a> </span>';
    } else {
        document.getElementById("loginbuttons").innerHTML = '<span><a data-toggle="modal" href=".login-modal">Log in</a></span>';
    }
}

function saveThemeTWO(code, guid, location, formId) {
    saveFunction(code, guid, location, formId, function (data) {
        var result = $(data).find("message").text();
        if (result) {
            document.getElementById("popupMsgContent").innerHTML = result;
            $("#popupMsg").show("slow");
        } else {
            window.location.reload();
        }
        stopLoadingScreen();

    });
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
function goToProductBrowse(){
    var code = 'maprodfron';
    var url = 'index.aspx?code='+ code 
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
    if (GUID == ''){GUID = getGUID()}
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
                document.getElementById("popupMsgContent").innerHTML = result;
                $("#popupMsg").show("slow")
            }
            if (newUrl) {
                window.location = newUrl
            }
        }
    });
}


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

function genInvoice() {
    document.MerchatPaymentPage.TRANSIDMERCHANT.value = randomString(12);
}

function genSessionID() {
    document.MerchatPaymentPage.SESSIONID.value = randomString(20);
}

function genBookingCode() {
    document.MerchatPaymentPage.BOOKINGCODE.value = randomString(6);
}

function getWords() {

    var msg = document.MerchatPaymentPage.AMOUNT.value + document.MerchatPaymentPage.MALLID.value + "ENHp2f42yJ2p" + document.MerchatPaymentPage.TRANSIDMERCHANT.value;

    document.MerchatPaymentPage.WORDS.value = SHA1(msg);
}
function genDokuValues() {
    var amount = '', email = '', cusname = '', address = '', docno = ''
    if (document.getElementById('TotalAmount') != null) {
        amount = document.getElementById('TotalAmount').innerHTML + '.00'
        amount = amount.replace(/,/g, '')
        document.getElementById('AMOUNT').value = amount
        document.getElementById('PURCHASEAMOUNT').value = amount
    }
    if (document.getElementById('PCSO_personalEmail') != null) {
        email = document.getElementById('PCSO_personalEmail').value
        document.getElementById('EMAIL').value = email
    }
    if (document.getElementById('PCSO_CustomerName') != null) {
        cusname = document.getElementById('PCSO_CustomerName').value
        document.getElementById('NAME').value = cusname
    }
    if (document.getElementById('PCSO_CustomerAddress') != null) {
        address = document.getElementById('PCSO_CustomerAddress').value
        document.getElementById('ADDRESS').value = address
    }
    docno = document.getElementById('documentnumber').innerHTML
    document.getElementById('TRANSIDMERCHANT').value = docno
}

function genPaymentChannel() {
    var paymguid = document.getElementById("PAYMGUID");
    var value = document.getElementById("PAYMGUID").value
    var name = paymguid.options[paymguid.selectedIndex].innerHTML;

    if (value == '041C201B-DB46-4E4A-828E-B4C856009990' || name == '3 - Credit Card') {
        document.getElementById('PAYMENTCHANNEL').value = '15'
    } else if (value == '65D4EC5A-1B14-4A26-9EC2-4D31877779B2' || name == '4 - Bank Transfer') {
        document.getElementById('PAYMENTCHANNEL').value = '36'
    } else {
        document.getElementById('PAYMENTCHANNEL').value = ''
    }

}