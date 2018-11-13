﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editProfile.aspx.cs" Inherits="CapstoneFinal.editProfiel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <title>Mentoree Profile</title>
    <link href = "./css/profileEditStyles.css" type = "text/css" rel= "stylesheet"/>
    <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>

      <script type="text/javascript"> 
          function LoadPage() {
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

                      if (msg.d != null) {
                          createDom(msg);
                      }
                      else {
                          //server replied false, so let the user know
                          //the logon failed
                          window.location.href = "index.aspx";
                      }
                  },
                  error: function (e) {
                      //if something goes wrong in the mechanics of delivering the
                      //message to the server or the server processing that message,
                      alert("boo...");
                  }
              });
          }


          function createDom(mgs)
          {
              var obj = JSON.parse(msg.d);
              console.log(obj);
          }
          </script>
</head>
<body onload="LoadPage();">
    <form id="form1" runat="server">
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bgark">
    <a class="navbar-brand" href="mainProfile.aspx"><img class="brand-image" src="./images/manatee-transparent-background.png" height="30" width="30"/>Mentoree</a>
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse text-center" id="navbarNavAltMarkup">
        <div class="navbar-nav mr-auto navbar-left font-sz-5">
        </div>
        <div class="navbar-nav ml-auto navbar-right font-sz-5">
            <a class="nav-item nav-link ml-2" href="mainProfile.aspx">Home </a>
            <a class="nav-item nav-link ml-2 active" href="editProfile.aspx"> Edit Profile <span class="sr-only">(current)</span></a>
            <a class="nav-item nav-link ml-2" href="calendar.aspx">Calendar</a>
            <a class="nav-item nav-link ml-2" href="contacts.aspx">Contacts</a>
            <a class="nav-item nav-link ml-2" href="index.aspx">Logout</a>
        </div>
    </div>
    
</nav>
        <div id="profileImage">

		<img src=".\images\sealImage.jpg" alt="profileImage" width ="300" height="300">

		<button type="button">Edit Picture</button>
	</div>
	
	<div id="rightHeader">
		<form id="basicInfo" action="">
			<fieldset>
				<legend>Basic Information:</legend>

			<div> First name: <input id="firstName" type="text" name="firstName"> </div>
			<div> Last name: <input id="lastName" type="text" name="lastName"> </div>
			<div> Current Position: <input id="position" type="text" name="position"> </div>
			<div> Certification: <input id="cert" type="text" name="cert"> </div>
			<div> City: <input id="city" type="text name="city"> </div>
			<div> State: <input id="state" type="text name="state"> </div>
			<div> Country: <input id="country" type="text" name="country"> </div>

			</fieldset>
		</form>
	</div>
	
	<div id="profileInfo">

		<hr align="center" width="90%" size="1px" color="maroon">

		<form action="">
		<fieldset>
				<legend>Mentorship Information</legend>
			<h2>Goals:</h2> 
			<ul>
				<li>
				<select id="goals1" name="Goals1">
					<option value="blank"></option>
					<option value="Leadership">Leadership</option>
					<option value="Management">Management</option>
					<option value="Technical">Technical</option>
					<option value="Marketing">Marketing</option>
					<option value="Sustainability">Sustainability</option>
					<option value="Consulting">Consulting</option>
					<option value="Communication">Communication</option>
				</select>
				</li>
				
				<li>
				<select id="goals2" name="Goals2">
					<option value="blank"></option>
					<option value="Leadership">Leadership</option>
					<option value="Management">Management</option>
					<option value="Technical">Technical</option>
					<option value="Marketing">Marketing</option>
					<option value="Sustainability">Sustainability</option>
					<option value="Consulting">Consulting</option>
					<option value="Communication">Communication</option>
				</select>
				</li>
			</ul>
			
		<h2>Skills:</h2>
		<ul>
			<li>
			<select id="skills1" name="Skills1">
				<option value="blank"></option>
				<option value="Leadership">Leadership</option>
				<option value="Management">Management</option>
				<option value="Technical">Technical</option>
				<option value="Marketing">Marketing</option>
				<option value="Sustainability">Sustainability</option>
				<option value="Consulting">Consulting</option>
				<option value="Communication">Communication</option>
			</select>
			</li>
		
			<li>
			<select id="skills2" name="Skills2">
				<option value="blank"></option>
				<option value="Leadership">Leadership</option>
				<option value="Management">Management</option>
				<option value="Technical">Technical</option>
				<option value="Marketing">Marketing</option>
				<option value="Sustainability">Sustainability</option>
				<option value="Consulting">Consulting</option>
				<option value="Communication">Communication</option>
			</select>
			</li>
			</ul>
			
			<h2>Experience:</h2>  
			<ul>
				<li><input id="experience1" type="text"></li>
				<li><input id="experience2" type="text"></li>
				<li><input id="experience3" type="text"></li>
			</ul>
		
			<h2>Availability:</h2> 

            
			<input  id="availability"type="text" value="Best times to reach me: ..." name="availability" size ="40">
            <br />
            <br />
            <button onclick="" class="btn btn-primary">Submit</button>
		</fieldset>

		</form>
	</div>
		<footer class="footer bg-dark">
            <div class="container  w-100 h-100">
                   <div class="row">
                     <div class="col pt-4">
                          <p class="text-white text-right"><a href="#">Notice of Privacy Practices</a></p>
                     </div>
                 </div>
              </div>
        </footer>
         <script src="https://code.jquery.com/jquery-3.0.0.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="./js/bootstrap.js"></script>  
    </form>
</body>
</html>
