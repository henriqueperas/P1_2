<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<meta charset="ISO-8859-1">
<title>Participantes das Quartas de Final</title>
</head>
<body>
	<div align="center">
		<jsp:include page="menu.jsp"></jsp:include>
	</div>
	<br/><br/>
	<div align="center">
		<h1 class=texto>Campeonato Paulista</h1>
		<h3>Exibir participantes das quartas de final</h3>
	</div>
	<div align="center">
		<form action="quartas" method="post">
			<input type="submit" id=botao name=botao value="Listar quartas de final">
		</form>
	</div>
	<div align="center">
		<c:if test="${not empty erro}">
			<h4><c:out value="${erro}"></c:out></h4>
		</c:if>
	</div>
	<br />
	<br>
	<div class = "container grid">
		<c:if test="${not empty grupoA }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo A</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoA}" var="g">
					<tr>
						<td><c:out value="${g.nome }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty grupoB }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo B</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoB}" var="g">
					<tr>
						<td><c:out value="${g.nome }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		</div>
		<br>
		<br>
		<div class="container grid">
		<br>
		<br>
		<c:if test="${not empty grupoC }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo C</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoC}" var="g">
					<tr>
						<td><c:out value="${g.nome }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty grupoD }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo D</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoD}" var="g">
					<tr>
						<td><c:out value="${g.nome }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>