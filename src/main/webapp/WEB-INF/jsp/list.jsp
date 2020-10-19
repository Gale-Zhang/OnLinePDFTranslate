<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<link href="/kpi/resources/css/mystyle.css" rel="stylesheet" type="text/css" />
<body align="center">
<h2 style="font-size:30px">意见</h2>
<a align="center" href="/pdftranslate/index.jsp"><u>返回首页</u></a>
<!-- <a href="findclass">查找(待完成)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="modifyclass">修改(待完成)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --><br/><br/>
<table width="1000" align="center">
	<tr>
		<th>提出时间</th><th>意见内容</th><th></th>
	</tr>
	<c:forEach var="suggestion" items="${list}">
	<tr>
		<td align="center">${suggestion.time}</td><td align="center">${suggestion.suggestion}</td>
		<td align="center"><a href="/pdftranslate/translate/delete?id=${suggestion.id}"><u>删除</u></a> </td>
	</tr>
	</c:forEach>
</table>
</body>
</html>
