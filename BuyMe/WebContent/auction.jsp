<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%--
 * auction.jsp
 *
 * Copyright (c) 2019
 * All rights reserved.
 *
 * Rutgers University: School of Arts and Sciences
 * 01:198:336 Principles of Information and Data Management, Spring 2019
 * Professor Miranda Garcia
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe - eCommerce</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>

<body>

<div class="header-container">
	<div class="TopMenu">
		<ul class="social">
			<li><a href="https://twitter.com/RutgersU"><img src="data\img\social\twitter.png" height="25px" width="25px"></a></li>
			<li><a href="https://www.facebook.com/RutgersU"><img src="data\img\social\facebook.png" height="25px" width="25px"></a></li>
			<li><a href="https://www.instagram.com/RutgersU"><img src="data\img\social\instagram.png" height="25px" width="25px"></a></li>
		</ul>
		
		<ul class="Links">
			<li><a class="dt" id="dt"></a></li><br>
			<li class="links"><a href="login.jsp">Sign in</a> or <a href="signup.jsp">Create an Account</a></li>
		</ul>
	</div>
</div>

<div class="subheader">
	<a href="index.jsp"><img src="data\img\project\logo.png"></a>
</div>

<div class="content">
	<hr width="100%">

</div>

<%-- 
<div class="footer">
	<hr>
	

	<div class="container well">
		<p>Footer things to add later...</p>
	</div>

	
</div>
--%>

<script>
	var tday=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
	var tmonth=["January","February","March","April","May","June","July","August","September","October","November","December"];

	function GetClock(){
		var d=new Date();
		var nday=d.getDay(),nmonth=d.getMonth(),ndate=d.getDate(),nyear=d.getFullYear();
		var nhour=d.getHours(),nmin=d.getMinutes(),nsec=d.getSeconds(),ap;

		if(nhour == 0) {	
			ap=" AM";
			nhour = 12;
		} else if(nhour < 12) {
			ap=" AM";
		} else if(nhour == 12){
			ap=" PM";
		} else if(nhour > 12){
			ap=" PM";
			nhour -= 12;
		}

		if(nmin<=9) 
			nmin="0"+nmin;
		if(nsec<=9) 
			nsec="0"+nsec;

		var clocktext=""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+" "+nhour+":"+nmin+":"+nsec+ap+"";
		document.getElementById('dt').innerHTML=clocktext;
	}

	GetClock();
	setInterval(GetClock,1000);
</script>

<br>
<br>

<%-- BEGIN ITEM/AUCTION LISTING --%>
<h1>CREATE NEW ITEM/AUCTION</h1>

	<%-- BEGIN ITEM LISTING --%>
	<h2>ITEM INFORMATION</h2>
	
	<p>Name<br>
	<input type="text">

	<p>Description<br>
	<textarea rows="10" cols="28">(enter description here)</textarea>

	<p>Condition<br>
	<select>
		<option>(unspecified)</option>
		<option>New</option>
		<option>Like New</option>
		<option>Excellent</option>
		<option>Good</option>
		<option>Poor</option>
		<option>For Parts Only</option>
	</select>

	<form action="someplace.php" method="post" enctype="multipart/form-data">
		<fieldset>
			<legend>Upload image file</legend>
			<label for="uploadfile">File name: </label>
			<input type="file" name="uploadfile" id="uploadfile">
		</fieldset>
	</form>
	<%--END ITEM LISTING --%>

	
	<%-- BEGIN AUCTION LISTING --%>
	<h2>AUCTION INFORMATION/SETTINGS</h2>
	
	<p>Auction Title<br>
	<input type="text">
	
	<p>Start Date (MM/DD/YYYY)<br>
	<select>
		<option>01 (Jan)</option>
		<option>02 (Feb)</option>
		<option>03 (Mar)</option>
		<option>04 (Apr)</option>
		<option>05 (May)</option>
		<option>06 (Jun)</option>
		<option>07 (Jul)</option>
		<option>08 (Aug)</option>
		<option>09 (Sep)</option>
		<option>10 (Oct)</option>
		<option>11 (Nov)</option>
		<option>12 (Dec)</option>
	</select>
	
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
		<option>21</option>
		<option>22</option>
		<option>23</option>
		<option>24</option>
		<option>25</option>
		<option>26</option>
		<option>27</option>
		<option>28</option>
		<option>29</option>
		<option>30</option>
		<option>31</option>
	</select>
	
	<select>
		<option>2019</option>
		<option>2020</option>
		<option>2021</option>
		<option>2022</option>
		<option>2023</option>
		<option>2024</option>
		<option>2025</option>
		<option>2026</option>
		<option>2027</option>
		<option>2028</option>
		<option>2029</option>
	</select>
	
	<p>Start Time (hh:mm:ss AM/PM)<br>
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
	</select>
	
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
		<option>21</option>
		<option>22</option>
		<option>23</option>
		<option>24</option>
		<option>25</option>
		<option>26</option>
		<option>27</option>
		<option>28</option>
		<option>29</option>
		<option>30</option>
		<option>31</option>
		<option>32</option>
		<option>33</option>
		<option>34</option>
		<option>35</option>
		<option>36</option>
		<option>37</option>
		<option>38</option>
		<option>39</option>
		<option>40</option>
		<option>41</option>
		<option>42</option>
		<option>43</option>
		<option>44</option>
		<option>45</option>
		<option>46</option>
		<option>47</option>
		<option>48</option>
		<option>49</option>
		<option>50</option>
		<option>51</option>
		<option>52</option>
		<option>53</option>
		<option>54</option>
		<option>55</option>
		<option>56</option>
		<option>57</option>
		<option>58</option>
		<option>59</option>
	</select>
	
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
		<option>21</option>
		<option>22</option>
		<option>23</option>
		<option>24</option>
		<option>25</option>
		<option>26</option>
		<option>27</option>
		<option>28</option>
		<option>29</option>
		<option>30</option>
		<option>31</option>
		<option>32</option>
		<option>33</option>
		<option>34</option>
		<option>35</option>
		<option>36</option>
		<option>37</option>
		<option>38</option>
		<option>39</option>
		<option>40</option>
		<option>41</option>
		<option>42</option>
		<option>43</option>
		<option>44</option>
		<option>45</option>
		<option>46</option>
		<option>47</option>
		<option>48</option>
		<option>49</option>
		<option>50</option>
		<option>51</option>
		<option>52</option>
		<option>53</option>
		<option>54</option>
		<option>55</option>
		<option>56</option>
		<option>57</option>
		<option>58</option>
		<option>59</option>
	</select>
	
	<select>
		<option>A.M</option>
		<option>P.M</option>
	</select>
	
	<p>End Date (MM/DD/YYYY)<br>
	<select>
		<option>01 (Jan)</option>
		<option>02 (Feb)</option>
		<option>03 (Mar)</option>
		<option>04 (Apr)</option>
		<option>05 (May)</option>
		<option>06 (Jun)</option>
		<option>07 (Jul)</option>
		<option>08 (Aug)</option>
		<option>09 (Sep)</option>
		<option>10 (Oct)</option>
		<option>11 (Nov)</option>
		<option>12 (Dec)</option>
	</select>
	
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
		<option>21</option>
		<option>22</option>
		<option>23</option>
		<option>24</option>
		<option>25</option>
		<option>26</option>
		<option>27</option>
		<option>28</option>
		<option>29</option>
		<option>30</option>
		<option>31</option>
	</select>
	
	<select>
		<option>2019</option>
		<option>2020</option>
		<option>2021</option>
		<option>2022</option>
		<option>2023</option>
		<option>2024</option>
		<option>2025</option>
		<option>2026</option>
		<option>2027</option>
		<option>2028</option>
		<option>2029</option>
	</select>
	
	<p>End Time (hh:mm:ss AM/PM)<br>
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
	</select>
	
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
		<option>21</option>
		<option>22</option>
		<option>23</option>
		<option>24</option>
		<option>25</option>
		<option>26</option>
		<option>27</option>
		<option>28</option>
		<option>29</option>
		<option>30</option>
		<option>31</option>
		<option>32</option>
		<option>33</option>
		<option>34</option>
		<option>35</option>
		<option>36</option>
		<option>37</option>
		<option>38</option>
		<option>39</option>
		<option>40</option>
		<option>41</option>
		<option>42</option>
		<option>43</option>
		<option>44</option>
		<option>45</option>
		<option>46</option>
		<option>47</option>
		<option>48</option>
		<option>49</option>
		<option>50</option>
		<option>51</option>
		<option>52</option>
		<option>53</option>
		<option>54</option>
		<option>55</option>
		<option>56</option>
		<option>57</option>
		<option>58</option>
		<option>59</option>
	</select>
	
	<select>
		<option>01</option>
		<option>02</option>
		<option>03</option>
		<option>04</option>
		<option>05</option>
		<option>06</option>
		<option>07</option>
		<option>08</option>
		<option>09</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
		<option>21</option>
		<option>22</option>
		<option>23</option>
		<option>24</option>
		<option>25</option>
		<option>26</option>
		<option>27</option>
		<option>28</option>
		<option>29</option>
		<option>30</option>
		<option>31</option>
		<option>32</option>
		<option>33</option>
		<option>34</option>
		<option>35</option>
		<option>36</option>
		<option>37</option>
		<option>38</option>
		<option>39</option>
		<option>40</option>
		<option>41</option>
		<option>42</option>
		<option>43</option>
		<option>44</option>
		<option>45</option>
		<option>46</option>
		<option>47</option>
		<option>48</option>
		<option>49</option>
		<option>50</option>
		<option>51</option>
		<option>52</option>
		<option>53</option>
		<option>54</option>
		<option>55</option>
		<option>56</option>
		<option>57</option>
		<option>58</option>
		<option>59</option>
	</select>
	
	<select>
		<option>A.M</option>
		<option>P.M</option>
	</select>
	
	<p>Bid Increment ($x.xx)<br>
	<input type="text">
	
	<p>Minimum Bid Permitted ($x.xx)<br>
	<input type="text">
	
	<p>Starting Price ($x.xx)<br>
	<input type="text">
	
	</p>
	<%-- END AUCTION LISTING --%>
	
<p>
<button type="button">Submit</button>
</p>

<%-- END ITEM/AUCTION LISTING --%>
</body>
</html>
 
 