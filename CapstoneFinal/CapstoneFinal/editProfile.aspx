<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editProfile.aspx.cs" Inherits="CapstoneFinal.editProfiel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <title>Mentoree Profile</title>
    <link href = "./css/ProfileEditStyle.css" type = "text/css" rel= "stylesheet"/>
    <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bgark">
    <a class="navbar-brand" href="index.aspx"><img class="brand-image" src="./images/manatee-transparent-background.png" height="30" width="30"/>Mentoree</a>
    
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
		<img src="..\images\sealImage.jpg" alt="profileImage">
		<button type="button">Edit Picture</button>
	</div>
	
	<div id="rightHeader">
		<form id="basicInfo" action="">
			<fieldset>
				<legend>Basic Information:</legend>
			<div> First name: <input type="text" name="firstName"> </div>
			<div> Last name: <input type="text" name="lastName"> </div>
			<div> Current Position: <input type="text" name="position"> </div>
			<div> Certification: <input type="text" name="cert"> </div>
			<div> City: <input type="text name="city"> </div>
			<div> State: <input type="text name="state"> </div>
			<div> Country: <input type="text" name="country"> </div>
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
				<select name="Goals1">
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
				<select name="Goals2">
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
			<select name="Skills1">
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
			<select name="Skills2">
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
				<li><input type="text"></li>
				<li><input type="text"></li>
				<li><input type="text"></li>
			</ul>
		
			<h2>Availability:</h2> 
			<input type="text" value="Best times to reach me: ..." name="availability">
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

    </form>
</body>
</html>
