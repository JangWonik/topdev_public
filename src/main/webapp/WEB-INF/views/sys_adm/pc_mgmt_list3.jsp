<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1" />
<title>Freeze Header Demo Page</title>
<style>

body {
    font-family: "Lucida Grande", Helvetica, Verdana, sans-serif;
    font-size: 10pt;
    line-height: 14pt;
}

h1 {
    line-height: 30px;
}

.data-table, .data-table td, .data-table th {
    border-color: black;
    border-style: solid;
}

.data-table {
    border-width: 0 0 0px 0px;  
    border-spacing: 0;
    border-collapse: collapse; 
    margin: 0;
}

.data-table td, .data-table th {
    margin: 0px;
    padding: 6px;
    border-width: 1px;
    vertical-align: top;
}

.data-table th {
    background-color: gold; 
}


</style>

    <script src="./resources/jquery/jquery.min_1_12.js"></script>

    <script src="./resources/jquery/jquery.browser.js"></script>
    <script src="./resources/jquery/jquery.freezeheader.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("table").freezeHeader({ top: true, left: true });
});

</script>

</head>
<body>

<h1>Freeze Header Demo Page</h1>

<p><a href="http://brentmuir.com/projects/freezeheader/">What is Freeze Header?</a></p>

<p>Scroll down and watch the table headers.</p>

<p>Shrink the window and try scrolling to the right.</p>

<table id="maintable" class="data-table">
    <colgroup>
        <col style="background-color: #ddd">
        <col>
        <col>
        <col>
    </colgroup>

	<thead>
		<tr><th style="background-color: #F5E9A3">&nbsp;</th><th>Heading 2</th><th>Heading 3</th><th>Heading 4</th></tr>
	</thead>
		<tr><td>Row 12232, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 2, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 3, Column 1</td><td>Column 2</td><td><div style="white-space:nowrap;">Column 3 This is a really long sentence without any breaks and it goes on and on.</div></td><td>Column 4</td></tr>
		<tr><td>Row 4, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 5, Column 1</td><td><span style="white-space:nowrap;">Column 2 This is a long sentence</span> to show what happens when the height of the table cell is stretched vertically. Notice how the left table header matches the height of this cell.</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 6, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 7, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 8, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 9, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 10, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 11, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 12, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 13, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 14, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 15, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 16, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 17, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 18, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 19, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 20, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 21, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 22, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 23, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 24, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 25, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 26, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 27, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 28, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 29, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 30, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 31, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 32, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 33, Column 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
</table>

<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>

<h1>An indented table:</h1>

<div style="margin-left:20px">
<table id="maintable2" class="data-table">
    <colgroup>
        <col style="background-color: #ddd">
        <col>
        <col>
        <col>
    </colgroup>

	<thead>
		<tr><th style="background-color: #F5E9A3">&nbsp;</th><th>Heading 2</th><th>Heading 3</th><th>Heading 4</th></tr>
	</thead>
	<tbody>
		<tr><td>Row 1</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 2</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 3</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 4</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 5</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 6</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 7</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 8</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 9</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 10</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 11</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 12</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 13</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 14</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 15</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 16</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 17</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 18</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 19</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 20</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 21</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 22</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 23</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 24</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 25</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 26</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 27</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 28</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 29</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 30</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 31</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 32</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
		<tr><td>Row 33</td><td>Column 2</td><td>Column 3</td><td>Column 4</td></tr>
	</tbody>
</table>
</div>

<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>
<p>Filler text.</p>

</body>
</html>
