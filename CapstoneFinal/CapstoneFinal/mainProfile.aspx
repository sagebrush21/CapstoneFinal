<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainProfile.aspx.cs" Inherits="CapstoneFinal.mainProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mentoree Profile</title>
    <link href = "./css/ProfilePageStyle.css" type = "text/css" rel= "stylesheet">
</head>
<body>
    <form id="form1" runat="server">
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

		<footer>
			<div class="footer">
				<p>Notice of Privacy Practices</p>
			</div>
		</footer>

    </form>
</body>
</html>
