<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contacts.aspx.cs" Inherits="CapstoneFinal.contacts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <title>Contacts</title>
    
	<link type="text/css" rel="stylesheet" href="./css/contactPageStyle.css"/>
        <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>

    <script type="text/javascript">
        function LoadPage() {
            //the url of the webservice we will be talking to
             var webMethod = "./MentoreeService.asmx/LoadMeetingConnections";

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
                        
                    }
                },
                error: function (e) {
                    //if something goes wrong in the mechanics of delivering the
                    //message to the server or the server processing that message,
                    alert("boo...");
                }
            });
        }
        function loadConnection(email) {
            console.log('test');
            //the url of the webservice we will be talking to
            var webMethod = "./MentoreeService.asmx/NewProfile";

            var parameters = "{\"email\":\"" + encodeURI(email) + "\"}";

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

                        window.location.href = "connectionProfile.aspx";
                    }
                    else {
                        //server replied false, so let the user know
                        //the logon failed
                       
                    }
                },
                error: function (e) {
                    //if something goes wrong in the mechanics of delivering the
                    //message to the server or the server processing that message,
                    
                }
            });
        }


        function createDom(msg) {
            var obj = JSON.parse(msg.d);
            console.log(obj);

            for (i = 0; i < obj.length; i++) {

                var contact = document.createElement('div');
                var contactLeft = document.createElement('div');
                var image = document.createElement('div');
                var contactRight = document.createElement('div');
                var name = document.createElement('h4');
                var job = document.createElement('div');
                var location = document.createElement('div');
                var detail = document.createElement('div');
                var img = document.createElement('img');

                contact.setAttribute('class', 'contact');
                contactLeft.setAttribute('class', 'contactLeft');
                image.setAttribute('class', 'profileImage');
                contactRight.setAttribute('class', 'contactRight');
                name.setAttribute('class', 'name');
                job.setAttribute('class', 'jobTitle');
                location.setAttribute('class', 'location');
                detail.setAttribute('class', 'subDetail');

                img.setAttribute('src', './images/profilePic4.jpg');
                img.setAttribute('alt', 'Profile Image');
                img.setAttribute('onclick', 'loadConnection("'+obj[i].Email+'")')

                name.append(obj[i].FirstName + " " + obj[i].LastName);
                job.append(obj[i].CurrentPosition);
                location.append(obj[i].UserCity);

                image.append(img);
                contactLeft.append(image);

                contactRight.append(name);
                contactRight.append(job);
                contactRight.append(location);
                contactRight.append(detail);

                contact.append(contactLeft);
                contact.append(contactRight);

                $("#addData").append(contact);
            }
        }
     </script>

</head>
<body onload="LoadPage()">
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
            <a class="nav-item nav-link ml-2" href="editProfile.aspx"> Edit Profile </a>
            <a class="nav-item nav-link ml-2" href="calendar.aspx">Calendar</a>
            <a class="nav-item nav-link ml-2 active" href="contacts.aspx">Contacts<span class="sr-only">(current)</span></a>
            <a class="nav-item nav-link ml-2" href="index.aspx">Logout</a>
        </div>
    </div>
    
</nav>
    <form id="form1" runat="server">
        <div>
            	<h2 class="title">Recommended Contacts: </h2>

	<div class="contactsContainer" id="recommendedContacts">

		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\profilePic.jpeg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Dr.Manly Tee</h4>
				<p class="jobTitle">Senior Business Consultant at Pacific Ocean</p>
				<p class="location">San Francisco, CA</p>
				<p class="subDetail">Recommended to you by: Mary Tea</p>							
			</div>
		</div>

		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\sealImage.jpg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Nota Manitee</h4>
				<p class="jobTitle">Student at ASU</p>
				<p class="location">Phoenix, AZ</p>
				<p class="subDetail">Recommended based on your Goals</p>					
			</div>
		</div>



	</div>

	<hr>
	
	<h2 class="title">All Contacts: </h2>	
	<div class="contactsContainer" id="allContacts">
        
		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\profilePic4.jpg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Mary Tea</h4>
				<p class="jobTitle">Senior Developer at Pacific Ocean</p>
				<p class="location">San Francisco, CA</p>
				<p class="subDetail">Last meetup: 11/10/2018</p>				
			</div>
		</div>

        <div id="addData">

        </div>

		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\profilePic2.jpg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Antonio Paoletti</h4>
				<p class="jobTitle">Web Developer at Pacific Ocean</p>
				<p class="location">Phoenix, AZ</p>
				<p class="subDetail"></p>							
			</div>
		</div>



		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\manateeRyan.jpg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Ryan Gosling</h4>
				<p class="jobTitle">Actor at Pacific Ocean</p>
				<p class="location">Hollywood, CA</p>		
			</div>
		</div>

		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\manateeContacts.jpg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Steve Seacow</h4>
				<p class="jobTitle">HR Representative at Pacific Ocean</p>
				<p class="location">San Francisco, CA</p>
				<p class="subDetail"></p>							
			</div>
		</div>

		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\manateeScarJo.jpg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Scarlett Johansson</h4>
				<p class="jobTitle">Actress at Pacific Ocean</p>
				<p class="location">Paris, France</p>
				<p class="subDetail"></p>							
			</div>
		</div>

		<div class="contact">
			<div class="contactLeft">
				<div class="profileImage">
					<img src = ".\images\profilePic3.jpg" alt = "Profile Image">
				</div>
			</div>
			<div class="contactRight">
				<h4 class="name">Murphy C. Cow</h4>
				<p class="jobTitle">Database Administrator at Pacific Ocean</p>
				<p class="location">San Francisco, CA</p>
				<p class="subDetail">Last meetup: 11/08/2018</p>							
			</div>
		</div>

	</div>

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
