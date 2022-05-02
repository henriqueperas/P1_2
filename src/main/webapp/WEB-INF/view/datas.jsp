<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<meta charset="ISO-8859-1">
<title>Datas da Rodada</title>
</head>
<body>
	<div align="center">
		<jsp:include page="menu.jsp"></jsp:include>
	</div>
	<br />
	<br />

	<div id="centro" align="center">
		<h1 class=texto>Campeonato Paulista</h1>
		<h3 class=tarefa>Escolha a data da rodada (23 Janeiro - 13 abril 2022)</h3>
		<div align="center">
			<form action="datas" method="post">
				<table>
				<tr>
					<td>
						<input type="date" id=data_rodada name=data_rodada required="required">
						<input type="submit" id=botao name=botao value="Pesquisar">
						<input type="submit" id=botao name=botao value="Pontuar">
					</td>
				</tr>
				<tr>
					<td>
						<h3 class=tarefa>gols time 1 e gols time 2</h3>	
						<input class="number" type="number" min="0" step="0" id="gols1" name="gols1" placeholder="#GolsTime1">
						<input class="number" type="number" min="0" step="0" id="gols2" name="gols2" placeholder="#GolsTime2">
					</td>
				</tr>
				<tr>
					<td>
						<h3 class=tarefa>time 1 e time 2</h3>
						<input class="number" type="number" min="0" step="0" id="time1" name="time1" placeholder="#Time1">
						<input class="number" type="number" min="0" step="0" id="time2" name="time2" placeholder="#Time2">
					</td>
				</tr>
				</table>
			</form>
		</div>
		<div align="center">
			<c:if test="${not empty erro}">
				<h4>
					<c:out value="${erro}"></c:out>
				</h4>
			</c:if>
		</div>
		<br />
		<div align="center">
			<c:if test="${not empty saida}">
				<h4>
					<c:out value="${saida}"></c:out>
				</h4>
			</c:if>
		</div>
		<br />
			<c:if test="${not empty partida }">
				<table class=table_home>
					<thead>
						<tr>
							<th>Codigo do jogo</th>
							<th>Time 1</th>
							<th>Time 2</th>
							<th>Gols 1 </th>
							<th>Gols 2 </th>
							<th>Data</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${partida}" var="p">
							<tr>
								<td align="center"><c:out value="${p.codigoJogo } "></c:out></td>
								<td align="center"><c:out value="${p.time1.codigo_T } "></c:out></td>
								<td align="center"><c:out value="${p.time2.codigo_T } "></c:out></td>
								<td align="center"><c:out value="${p.golsTime1 }  "></c:out></td>
								<td align="center"><c:out value="${p.golsTime2 }  "></c:out></td>
								<td align="center"><c:out value="${p.dataJogo }"></c:out></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>

</body>
</html>
