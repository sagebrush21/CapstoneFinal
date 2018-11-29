<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="calendar.aspx.cs" Inherits="CapstoneFinal.calendar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Calendar</title>
    <link type="text/css" rel="stylesheet" href="./css/calendarPageStyle.css">
     <link rel="stylesheet" href="./css/bootstrap.css"/>
    <link rel="stylesheet" href="./css/webCSS.css"/>"
        <script type="text/javascript" src="./js/calendarPageScript.js"></script>
</head>
<body>
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
            <a class="nav-item nav-link ml-2 " href="mainProfile.aspx">Home </a>
            <a class="nav-item nav-link ml-2" href="editProfile.aspx"> Edit Profile </a>
            <a class="nav-item nav-link ml-2 active" href="calendar.aspx">Calendar<span class="sr-only">(current)</span></a>
            <a class="nav-item nav-link ml-2" href="contacts.aspx">Contacts</a>
            <a class="nav-item nav-link ml-2" href="index.aspx">Logout</a>
        </div>
    </div>
    </nav>
        <div id="topHalf">
        <div id="calendar-container">
            <div id="calendar-header">
                <span id="calendar-month-year"></span>
            </div>
            <div id="calendar-dates">
            </div>
        </div>
        <hr id="calendarLine">
    </div>
		

		
		<div id="event-container">
			
			<h3>Today: 11/29git/2018</h3>
			<div class="event">				
				<p>--none------------</p>
			</div>
			
			<h3>This Week:</h3>	
			<div class="event">
				<p> <h4>Company Event: </h4> <b>Spend Saturday at Work Day!</b> <br> Saturday 11/17/2018 <br> 3:30pm in room 101 </p>
			</div>
			
			<h3>This Month:</h3>
			<div class="event">
				<p> <h4>One on One: </h4> <b> with Manny Tee</b> <br> Tuesday 11/20/2018 <br> 4:00pm at Starbucks. </p>
			</div>
			<div class="event">
				<p> <h4>Company Event: </h4> <b>Thanksgiving Lunch!</b> <br> Thursday 11/22/2018 <br> Free turkey sandwiches in lunch room </p>
			</div>
			<div class="event">
				<p> <h4>One on One: </h4> <b>with Manny Tee</b> <br> Tuesday 11/27/2018 <br> 4:00pm via Skype</p>				
			</div>

		</div>

    </form>
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
</body>
</html>
