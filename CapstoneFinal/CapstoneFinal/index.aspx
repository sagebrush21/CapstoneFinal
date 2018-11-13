<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="CapstoneFinal.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"/>
<head runat="server">
      <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <title>Welcome to Mentoree!</title>
    
    <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>
    
    <style type="text/css">
	
    </style>

    <script type="text/javascript"> 
        function LogOn(email, pass) {
            //the url of the webservice we will be talking to
            var webMethod = "./MentoreeService.asmx/LogOn";

            var parameters = "{\"email\":\"" + encodeURI(email) + "\",\"pass\":\"" + encodeURI(pass) + "\"}";

            //jQuery ajax method
            $.ajax({
                //post is more secure than get, and allows
                //us to send big data if we want.  really just
                //depends on the way the service you're talking to is set up, though
                type: "POST",
                //the url is set to the string we created above
                url: webMethod,
                //same with the data
                data: parameters,
                //these next two key/value pairs say we intend to talk in JSON format
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //jQuery sends the data and asynchronously waits for a response.  when it
                //gets a response, it calls the function mapped to the success key here
                success: function (msg) {
                    //the server response is in the msg object passed in to the function here
                  
                    if (msg.d) {
                        
                        window.location.href = "mainProfile.aspx";
                    }
                    else {
                        //server replied false, so let the user know
                        //the logon failed
                        alert("logon failed");
                    }
                },
                error: function (e) {
                    //if something goes wrong in the mechanics of delivering the
                    //message to the server or the server processing that message,
                    alert("boo...");
                }
            });
        }


        function LogOff() {
            //the url of the webservice we will be talking to
            var webMethod = "./MentoreeService.asmx/LogOff";

            //jQuery ajax method
            $.ajax({
                //post is more secure than get, and allows
                //us to send big data if we want.  really just
                //depends on the way the service you're talking to is set up, though
                type: "POST",
                //the url is set to the string we created above
                url: webMethod,
                //these next two key/value pairs say we intend to talk in JSON format
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //jQuery sends the data and asynchronously waits for a response.  when it
                //gets a response, it calls the function mapped to the success key here
                success: function (msg) {
                    //the server response is in the msg object passed in to the function here
                  
                },
                error: function (e) {
                    //if something goes wrong in the mechanics of delivering the
                    //message to the server or the server processing that message,
                    alert("boo...");
                }
            });
        }
    </script>
</head>
<body onload="LogOff()">
    <form id="form1" runat="server">
        <div>
            <!-- NAVBAR -->
<%--<nav class="navbar fixed-top navbar-expand-lg navbar-dark bgark">
    <a class="navbar-brand" href="index.aspx"><img class="brand-image" src="./images/manatee-transparent-background.png" height="30" width="30"/>CoffeeMate</a>
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse text-center" id="navbarNavAltMarkup">
        <div class="navbar-nav mr-auto navbar-left font-sz-5">
        </div>
        <div class="navbar-nav ml-auto navbar-right font-sz-5">
            <a class="nav-item nav-link ml-2 active" href="index.aspx">Login <span class="sr-only">(current)</span></a>
        </div>
    </div>
    
</nav>--%>
<!-- BANNER -->    
<!-- MAIN BODY INFO --> 

<div class="container text-center pt-5 form-signin">
        <img class="mb-4" src="./images/MentoreeLogo1.png" alt="Mentoree" width="50%">
    <h1>Please sign in</h1>
		<br />
			<asp:TextBox ID="usernameTextBox" runat="server" CssClass="form-control" placeholder="Email Address"></asp:TextBox>
            <br />
			<asp:TextBox ID="passwordTextBox" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox><br />
            <!--<asp:Button ID="loginButton" runat="server" Text="Sign In" OnClick="loginButton_Click" OnClientClick="LogOn($('#usernameTextBox').val(), $('#passwordTextBox').val()); return false;" CssClass="btn btn-lg btn-primary btn-block" /><-->
		    <button class="btn btn-lg btn-primary btn-block" onclick="LogOn($('#usernameTextBox').val(), $('#passwordTextBox').val()); return false;">Login</button>	
        <br/>
            <br />
		<a href="signUp.aspx"><h4>New User? Click here</h4></a><br />
        <asp:Label ID="errorLabel" runat="server" Visible="False" ForeColor="Red"></asp:Label>
</div> 
<!-- FOOTER -->
<!--<footer class="footer bg-dark">
    <div class="container  w-100 h-100">
        <div class="row">
            <div class="col pt-4">
                <p class="text-white text-right"><a href="#">Notice of Privacy Practices</a></p>
            </div>
        </div>
    </div>
</footer>-->
<script src="https://code.jquery.com/jquery-3.0.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="./js/bootstrap.js"></script>    
<!-- <script src="../js/webJava.js"></script> -->
            
        </div>
    </form>
</body>
