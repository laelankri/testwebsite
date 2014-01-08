<%@ Page Language="C#" AutoEventWireup="true" CodeFile="facebook.aspx.cs" Inherits="facebook" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


--%>

<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
</script>
</head>
<body>
<h1>aaa</h1>
<div id="fb-root"></div>
<script>
    window.fbAsyncInit = function () {
        FB.init({
            appId: '771728996176526',
            status: true, // check login status
            cookie: true, // enable cookies to allow the server to access the session
            xfbml: true  // parse XFBML
        });

        showLikes("www.ynet.co.il");

        FB.Event.subscribe('edge.create',
                 function (href, widget) {
                     alert('You liked the URL: ' + href);
                 }
           );
        FB.Event.subscribe('auth.login', function (response) {
            alert("inside");
        });
        // Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
        // for any authentication related change, such as login, logout or session refresh. This means that
        // whenever someone who was previously logged out tries to log in again, the correct case below 
        // will be handled. 
        FB.Event.subscribe('auth.authResponseChange', function (response) {
            // Here we specify what we do with the response anytime this event occurs. 
            if (response.status === 'connected') {
                // The response object is returned with a status field that lets the app know the current
                // login status of the person. In this case, we're handling the situation where they 
                // have logged in to the app.
                document.getElementById("div").innerHTML = response.status + "<br/>";
                document.getElementById("div").innerHTML += response.authResponse.accessToken + "<br/>";
                document.getElementById("div").innerHTML += response.authResponse.expiresIn + "<br/>";
                FB.api('/me', function (response) {
                    alert(response.name);
                    var dataString = 'name=' + response.name + '&gender=' + response.gender;
                    $.ajax({ // ajax call starts
                        url: 'fbData.asmx/insertNewUser',   // server side method
                        data: dataString,    // the parameters sent to the server
                        type: 'POST',

                        success: function (data) // Variable data contains the data we get from serverside
                        {
                            alert("success");
                        }
                    });
                });


                //                    success: function (data) // Variable data contains the data we get from serverside
                //                    {
                //                        alert("POI set at lat:" + lat + " , lng: " + lng);
                //                    }, // end of success
                //                    error: function (e) {
                //                        alert("failed in setPOI :( " + e.responseText);
                //                    } // end of error
                // end of ajax call
                testAPI();

            } else if (response.status === 'not_authorized') {
                // In this case, the person is logged into Facebook, but not into the app, so we call
                // FB.login() to prompt them to do so. 
                // In real-life usage, you wouldn't want to immediately prompt someone to login 
                // like this, for two reasons:
                // (1) JavaScript created popup windows are blocked by most browsers unless they 
                // result from direct interaction from people using the app (such as a mouse click)
                // (2) it is a bad experience to be continually prompted to login upon page load.
                FB.login(function (response) {
                    // handle the response
                }, { scope: 'email' });
            } else {
                // In this case, the person is not logged into Facebook, so we call the login() 
                // function to prompt them to do so. Note that at this stage there is no indication
                // of whether they are logged into the app. If they aren't then they'll see the Login
                // dialog right after they log in to Facebook. 
                // The same caveats as above apply to the FB.login() call here.
                FB.login(function (response) {
                    // handle the response
                }, { scope: 'email' });
            }
        });
    };

    // Load the SDK asynchronously
    (function (d) {
        var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        ref.parentNode.insertBefore(js, ref);
    } (document));

    // Here we run a very simple test of the Graph API after login is successful. 
    // This testAPI() function is only called in those cases. 
    function testAPI() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function (response) {
            console.log('Good to see you, ' + response.name + '.');
            
        });
    }

    function out() {
        FB.logout(function (response) {
            location.reload();
            // Person is now logged out
        });
    }

    function send() {
        FB.ui({ method: 'apprequests',
            message: 'My Great Request'
        });
    }

    function showLikes(toLike) {
        url = "http://" + toLike;
        $.getJSON('http://graph.facebook.com/?id=' + url,
        function (data) {
            $('#span').empty();
            $('#span').append("<b>" + (data.shares || 0) + "</b>");
        });
    }
</script>

<!--
  Below we include the Login Button social plugin. This button uses the JavaScript SDK to
  present a graphical Login button that triggers the FB.login() function when clicked. -->
  <form runat="server">
<fb:login-button show-faces="true" width="200" perms="email" max-rows="1"></fb:login-button>
  <%--  <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />--%>
<div id="div"></div>
<div id="btnLike" class="fb-like" data-href="http://test.talavidan4.com" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>
<br /><input type="button" value="log out" onclick="out()" />
<br />
<input type="button" value="send message" onclick="send()" />
<br />
<br />
<br />
choose:
<input type="button" value="facebook" onclick="showLikes('www.facebook.com')"/> &nbsp &nbsp <input type="button" value="ynet" onclick="showLikes('www.ynet.co.il')"/>
<br />
numbers of like: <span id="span"></span>


</body>
</form>
</html>


