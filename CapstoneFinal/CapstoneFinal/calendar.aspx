<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="calendar.aspx.cs" Inherits="CapstoneFinal.calendar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link type="text/css" rel="stylesheet" href="calendarPageStyle.css">
        <script type="text/javascript" src="calendarPageScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
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
			
			<h3>Today: 11/12/2018</h3>
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
</body>
</html>
