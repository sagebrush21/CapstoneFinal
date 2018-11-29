﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainProfile.aspx.cs" Inherits="CapstoneFinal.mainProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <title>Mentoree Profile</title>
    <link href = "./css/ProfilePageStyle.css" type = "text/css" rel= "stylesheet"/>
    <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>

    <style>
      /*  .profilePic {
            border-radius: 100%;
            float: left;
            z-index: 3;
            position: relative;
            box-shadow: 2px 1px 8px 0px #000000;
        }
       
        #rightHeader {
            width: 85%;
            height: 250px;
            text-align: left;
            overflow: auto;
            float: left;
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
            background-color: #bfe5ff;
            margin-left: -200px;
            padding-left: 220px;
            z-index: 2;
        }

        #leftHeader {
            height: 320px;
            text-align: center;
            overflow: auto;
            float: left;
            padding-right: 10px;
            padding-left: 10px;
            z-index: 200;

        }

        .nameTitle {
            margin-bottom: 30px;
        }
          */
        .connectionButton {
            background-color: #268bd2;
            cursor: pointer;
        }

    </style>

    <script type="text/javascript"> 
        function LogOn() {
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

        function Connection() {
            //the url of the webservice we will be talking to
            var webMethod = "./MentoreeService.asmx/LoadConnections";

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
                        console.log(msg);
                        createConnections(msg);
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

        function TestCode(code, tmpEmail) {
            //the url of the webservice we will be talking to
            var webMethod = "./MentoreeService.asmx/CheckMeetup";

            var parameters = "{\"code\":\"" + encodeURI(code) + "\",\"email\":\"" + encodeURI(tmpEmail)+ "\"}";

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
                        alert("Please enter a correct code");
                    }
                },
                error: function (e) {
                    //if something goes wrong in the mechanics of delivering the
                    //message to the server or the server processing that message,
                    
                }
            });
        }

        function createDom(msg) {

            $(document).keypress(
                function (event) {
                    if (event.which == '13') {
                        event.preventDefault();
                    }
                });

            var obj = JSON.parse(msg.d);
            console.log(obj);

            var name = document.createElement('h1');
            var email = document.createElement('h6');
            var position = document.createElement('h6');
            var cert = document.createElement('h6');
            var city = document.createElement('h6');

            name.setAttribute('class', 'nameTitle')

            email.append(obj[0].Email);
            name.append(obj[0].FirstName + " " + obj[0].LastName);
            position.append(obj[0].CurrentPosition);
            cert.append(obj[0].Edu_or_cert);
            city.append(obj[0].UserCity);

           
            $("#rightHeader").append(name);
            $("#rightHeader").append(email);
            $("#rightHeader").append(position);
            $("#rightHeader").append(cert);
            $("#rightHeader").append(city);

            var goals = obj[0].Goals.split(",");
            var displayGoal = document.createElement('ul');

           
            for (i = 0; i < goals.length; i++){
                var goalLi = document.createElement('li');
                goalLi.appendChild(document.createTextNode(goals[i]));
                displayGoal.appendChild(goalLi);
            }
            
            $('#goals').append(displayGoal);

           
            var skills = obj[0].Skills.split(",");
            var displaySkills = document.createElement('ul');
            
            
            console.log(skillsLi);
            for (i = 0; i < skills.length; i++){
                var skillsLi = document.createElement('li');
                skillsLi.appendChild(document.createTextNode(skills[i]));
                displaySkills.appendChild(skillsLi);

               
            }
            $('#skills').append(displaySkills);
            

            var experience = obj[0].Experience.split(",");
            var displayExperience = document.createElement('ul');

           
            for (i = 0; i < experience.length; i++) {
                var experienceLi = document.createElement('li');
                experienceLi.appendChild(document.createTextNode(experience[i]));
                displayExperience.appendChild(experienceLi);
            }

            $('#experience').append(displayExperience);

            var times = document.createElement('p');

            times.append(obj[0].UserAvailability);

            $("#times").append(times);

            Connection();
        }



        function createConnections(msg) {
            var obj = JSON.parse(msg.d);
            console.log(obj);
            var container = document.createElement('div');
            container.setAttribute('class', 'row');

            for (i = 0; i < obj.length; i++){
                

                var card = document.createElement('div');
                card.setAttribute("class", "card mr-5 mt-5 text-center");
                card.setAttribute("style", "width: 18rem");

                var img = document.createElement('img');
                img.setAttribute("class", "card-img-top");
                img.setAttribute('src', './images/sealImage.jpg');
                img.setAttribute('alt', 'Profile Image');

                var cardBody = document.createElement('div');
                cardBody.setAttribute('class', 'card-body');

                var cardName = document.createElement('h5');
                cardName.setAttribute('class', 'card-title');

                cardName.append(obj[i].FirstName + " " + obj[i].LastName);

                var cardButton = document.createElement('button');
                cardButton.setAttribute('class', 'btn btn-primary');
                cardButton.setAttribute('onclick', 'newProfile("'+ obj[i].Email +'");');

                cardButton.append("View Profile");

                var input = document.createElement('div');
                input.setAttribute('class', 'input-group mt-2 mb-2');

                var inputText = document.createElement('input');
                inputText.setAttribute('type', 'text');
                inputText.setAttribute('class', 'form-control');
                inputText.setAttribute('id','inputId'+i)
                inputText.setAttribute('placeholder', 'Meeting ID');

                var inputButtonGroup = document.createElement('div');
                inputButtonGroup.setAttribute('class', 'input-group-append');

                var inputButton = document.createElement('button');
                inputButton.setAttribute('class', 'btn btn-primary');
                inputButton.setAttribute('type', 'button');
                inputButton.setAttribute('onclick', 'TestCode($("#inputId'+i+'").val(),"'+ obj[i].Email+'");');

                inputButton.append("Submit Code");

                inputButtonGroup.append(inputButton);

                input.append(inputText);
                input.append(inputButtonGroup);



                cardBody.append(cardName);
                cardBody.append(input);
                cardBody.append(cardButton);
                

                card.append(img);
                card.append(cardBody);

                container.append(card);
                

                
            }

           

            $('#profileDisplay').append(container);
        }

        function newProfile(email) {
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
                        alert("unable to find profile");
                    }
                },
                error: function (e) {
                    //if something goes wrong in the mechanics of delivering the
                    //message to the server or the server processing that message,
                    alert("boo...");
                }
            });
        }

        async function createRandomConnections() {
            console.log('test');
            //the url of the webservice we will be talking to
            var webMethod = "./MentoreeService.asmx/CreateRandomConnection";

           
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

                    if (msg.d) {

                        window.location.href = "mainProfile.aspx";
                    }
                    else {
                        //server replied false, so let the user know
                        //the logon failed
                        alert("unable to find profile");
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
<body onload="LogOn();">
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
            <button class="nav-item nav-link ml-2 connectionButton" onclick="createRandomConnections()">Create Connections</button>
            <a class="nav-item nav-link ml-2 active" href="mainProfile.aspx">Home <span class="sr-only">(current)</span></a>
            <a class="nav-item nav-link ml-2" href="editProfile.aspx"> Edit Profile </a>
            <a class="nav-item nav-link ml-2" href="calendar.aspx">Calendar</a>
            <a class="nav-item nav-link ml-2" href="contacts.aspx">Contacts</a>
            <a class="nav-item nav-link ml-2" href="index.aspx">Logout</a>
        </div>
    </div>
    
</nav>
        <header >
		<div>
			<div id = "leftHeader"> 
				<img src = "./images/sealImage.jpg" alt="Profile Image" width="300" height="300" class="profilePic" />
			</div>

			<div id = "rightHeader">
				<!--<h1> Dr.Manly Tee</h1>
				<h6> Senior Business Consultant at PacificRim</h6>
				<h6> PhD in bubbies, Arizona State University</h6>
				<h6> San Francisco, CA</h6> -->
			</div>
		</div>
	</header>

		<hr style = "color = 1px maroon;" />

		<main>
			<div>
				<div id="goals" class="container">
					<h2>Goals: </h2>
					<!--<nav>
						<ul>
							<li>Gain experience in marketing</li>
							<li>Cross training in sustainability</li>
							<li>Further my career in business leadership</li>
						</ul>
					</nav>-->
				</div>

				<div id="skills" class="container">
					<h2>Skills: </h2>
					<!--<nav>
						<ul>
							<li>Leadership</li>
							<li>Management</li>
							<li>Communication</li>
							<li>Consulting</li>
						</ul>
					</nav>-->
				</div>

				<div id="experience" class="container">
					<h2>Experience: </h2>
					<!--<nav>
						<ul>
							<li>25 years of Shark Management</li>
							<li>Well practiced bubble blower</li>
						</ul>
					</nav>-->
				</div>


				<div id="times" class="container">
					<h2>Best times to reach me: </h2>
					
					<!--<p>M-F at 12-2pm or Weekends from 3-6pm.</p>-->
				</div>

			</div>
            <div id="profileDisplay" class="container">
                   <h2>Connections: </h2>

        </div>
		</main>
        
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
