<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contacts.aspx.cs" Inherits="CapstoneFinal.contacts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contacts</title>
	<link type="text/css" rel="stylesheet" href="./css/contactPageStyle.css"/>
        <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>
</head>
<body>
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
        <script src="https://code.jquery.com/jquery-3.0.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="./js/bootstrap.js"></script>  
    </form>
</body>
</html>
