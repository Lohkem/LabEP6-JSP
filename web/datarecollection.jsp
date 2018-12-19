<%-- 
    Document   : grafico
    Created on : Dec 18, 2018, 12:19:59 PM
    Author     : Lokem
--%>

<%
    int partyNumber = 0;
    try{
        partyNumber = Integer.parseInt(request.getParameter("partyNumber"));
    }catch(Exception e){}
    if(partyNumber >= 3 && partyNumber <= 5){%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grafico Electoral</title>
    </head>
    <body>
        <h1>La cantidad de partidos es: <%= request.getParameter("partyNumber") %></h1><hr><br>
        <form name="graphForm" method="post" action="graph.jsp">
        <%for(int i=1; i<=partyNumber;i++){%>
        Nombre del partido politico: <input type="text" name="partyName<%=i%>"/><br><br>
        Numero de votos: <input type="text" name="voteCount<%=i%>"/><br><br>
        Color asignado: <input type="color" name="color<%=i%>" value="#1BF44A"><br><br><br><hr><br>
        <%}%>
        <input type="hidden" name="partyNumber" value="<%=partyNumber%>"/>
        <input type="submit" name="submit" value="Generar grafico"/>
        </form>
        <a href="inicio.html">Volver</a>
    </body>
</html>
<%  }
    else{%>
    <html>
        <head>
            <title>Grafico Electoral</title>
        </head>
        <body>
            <h1>Por favor, elija un numero entre 3 y 5!</h1>
            <a href="inicio.html">Volver</a>
        </body>
    </html>
    <%}%>

