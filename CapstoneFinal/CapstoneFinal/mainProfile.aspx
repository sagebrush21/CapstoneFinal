<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainProfile.aspx.cs" Inherits="CapstoneFinal.mainProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mentoree Profile</title>
    <link href = "./css/ProfilePageStyle.css" type = "text/css" rel= "stylesheet">
    <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>

    <script type="text/javascript"> 
        function LogOn(email, pass) {
            //the url of the webservice we will be talking to
            var webMethod = "./MentoreeService.asmx/LoadProfile";

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
                    console.log("test");
                    if (msg != null) {
                        
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

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bgark">
    <a class="navbar-brand" href="index.aspx"><img class="brand-image" src="./images/manatee-transparent-background.png" height="30" width="30"/>CoffeeMate</a>
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse text-center" id="navbarNavAltMarkup">
        <div class="navbar-nav mr-auto navbar-left font-sz-5">
        </div>
        <div class="navbar-nav ml-auto navbar-right font-sz-5">
            <a class="nav-item nav-link ml-2 active" href="mainProfile.aspx">Home <span class="sr-only">(current)</span></a>
            <a class="nav-item nav-link" href="editProfile.aspx"> Edit Profile </a>
            <a class="nav-item nav-link ml-2" href="calendar.aspx">Calendar</a>
            <a class="nav-item nav-link ml-2" href="index.aspx">Logout</a>
        </div>
    </div>
    
</nav>
        <header >
		<div>
			<div id = "leftHeader"> 
				<img src = "./images/sealImage.jpg" alt = "Profile Image" width="300" height="300">
			</div>

			<div id = "rightHeader">
				<h1> Dr.Manly Tee</h1>
				<h6> Senior Business Consultant at PacificRim</h6>
				<h6> PhD in bubbies, Arizona State University</h6>
				<h6> San Francisco, CA</h6>
			</div>
		</div>
	</header>

		<hr style = "color = 1px maroon;">

		<main>
			<div>
				<div class="container">
					<h2>Goals: </h2>
					<nav>
						<ul>
							<li>Gain experience in marketing</li>
							<li>Cross training in sustainability</li>
							<li>Further my career in business leadership</li>
						</ul>
					</nav>
				</div>

				<div class="container">
					<h2>Skills: </h2>
					<nav>
						<ul>
							<li>Leadership</li>
							<li>Management</li>
							<li>Communication</li>
							<li>Consulting</li>
						</ul>
					</nav>
				</div>

				<div class="container">
					<h2>Experience: </h2>
					<nav>
						<ul>
							<li>25 years of Shark Management</li>
							<li>Well practiced bubble blower</li>
						</ul>
					</nav>
				</div>


				<div class="container">
					<h2>Best times to reach me: </h2>
					
					<p>M-F at 12-2pm or Weekends from 3-6pm.</p>
				</div>

			</div>
		</main>
        <div id="profileDisplay">

        </div>
		<footer>
			<div class="footer">
				<p>Notice of Privacy Practices</p>
			</div>
		</footer>

    </form>
</body>
</html>
