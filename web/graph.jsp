<%-- 
    Document   : graph
    Created on : Dec 18, 2018, 12:57:15 PM
    Author     : Lokem
--%>
<% 
    int partyNumber = Integer.parseInt(request.getParameter("partyNumber"));
    int totalVotes = 0;
    boolean anyNull = false;
    boolean emptyNumber = false;
    try
    {
       for(int i=0;i<partyNumber;i++){
       totalVotes+=Integer.parseInt(request.getParameter("voteCount"+(i+1)));
       String temp = request.getParameter("partyName"+(i+1));

       if(temp.isEmpty()){
           anyNull=true;
       }
           
    } 
    }catch(Exception e){
        emptyNumber = true;
    }
    
    if(!anyNull && !emptyNumber)
    {
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Resultado Elecciones</title>
    </head>
<body bgcolor="#ffd7a3">
    <h1>Resultado Elecciones</h1>
<svg id = "lienzoSVG" width="260" height="250"></svg>

<script type="text/javascript">
    var lienzoSVG = document.getElementById("lienzoSVG");

    var cx = 130;
    var cy = 120;
    var r = 100;

    var oGrafico = [
        <% for(int i=1; i<=partyNumber; i++){ %>
            {nombre:"<%=request.getParameter("partyName"+i)%>",
             porcentaje:"<%=100*(Integer.parseInt(request.getParameter("voteCount"+i)))/totalVotes%>",
             color:"<%=request.getParameter("color"+i)%>"}
            <%if(i!=partyNumber)%>,
            <%;}%>];


    function coords( a ){
     var arad = ( Math.PI / 180 ) * a;
     var coords = {
     "x" : cx + r * Math.cos( arad ),
     "y" : cy + r * Math.sin( arad )
     };
     return coords;
    }

    function dGajo(ap,af){
    var Xap = coords(ap).x;
    var Yap = coords(ap).y;
    var Xaf = coords(af).x;
    var Yaf = coords(af).y;
    var parametro_d  = "M" + cx + ", " + cy+
                                       " L"+Xap+","+Yap+ 
                                       " A"+r+","+r+" 0 0, 1 "+Xaf+","+Yaf+ 
                                       " z";
            return parametro_d;
             }

    function dSombra(ap,af){
    var Xap = coords(ap).x;
    var Yap = coords(ap).y;
    var Xaf = coords(af).x;
    var Yaf = coords(af).y;		
    var parametro_d  = "M" + Xap + ", " + Yap+
                           " A"+r+","+r+" 0 0, 1"+Xaf+","+Yaf;
            return parametro_d;
            }

    function nuevaSombra(ap,af,color,i){

    var nuevaSombra=document.createElementNS("http:\/\/www.w3.org/2000/svg","path");
    nuevaSombra.setAttributeNS(null,"id", "sombra"+i); 		
    nuevaSombra.setAttributeNS(null,"d", dSombra(ap,af));
    nuevaSombra.setAttributeNS(null,"fill", "none"); 
    nuevaSombra.setAttributeNS(null,"stroke", color);
    nuevaSombra.setAttributeNS(null,"stroke-opacity", .4); 
    nuevaSombra.setAttributeNS(null,"stroke-width", 0);

    lienzoSVG.appendChild(nuevaSombra);

    var sombraSet = document.createElementNS("http:\/\/www.w3.org/2000/svg","set");
    sombraSet.setAttributeNS(null,"attributeName", "stroke-width");
    sombraSet.setAttributeNS(null,"attributeType", "XML");
    sombraSet.setAttributeNS(null,"to", 15);
    sombraSet.setAttributeNS(null,"begin", "gajo"+i+".mouseover; sombra"+i+".mouseover");
    sombraSet.setAttributeNS(null,"end", "gajo"+i+".mouseleave; sombra"+i+".mouseleave");

    nuevaSombra.appendChild(sombraSet);
    }

    function nuevoGajo(ap,af,color,i){
    var nuevoGajo=document.createElementNS("http:\/\/www.w3.org/2000/svg","path");
    nuevoGajo.setAttributeNS(null,"id", "gajo"+i); 			
    nuevoGajo.setAttributeNS(null,"d", dGajo(ap,af));
    nuevoGajo.setAttributeNS(null,"fill", color); 
    nuevoGajo.setAttributeNS(null,"stroke", "#fff"); 
    nuevoGajo.setAttributeNS(null,"stroke-width", "2"); 
    lienzoSVG.appendChild(nuevoGajo);
    }

    var ap = Array(); // angulos de partida
    var af = Array(); // angulos finales

    for( var i=0; i < oGrafico.length; i++ ){
       var porcentaje = oGrafico[ i ].porcentaje;
       var color = oGrafico[ i ].color;
       // calcula el valor del ángulo
       af[i] = ((porcentaje*360)/100);

       if( i>0 ){
          af[ i ] += af[ i-1 ];
          ap[ i ] = af[ i-1 ];
        } else { ap[ i ] = 0; }

       nuevoGajo(ap[ i ],af[ i ],color,i);
       nuevaSombra(ap[ i ],af[ i ],color,i);
    }   
</script>
    <% for(int i=1; i<=partyNumber; i++){ %>
    <p><%=request.getParameter("partyName"+i)%></p>
    <svg width="40" height="20">
        <rect width="30" height="10" style="fill:<%=request.getParameter("color"+i)%>;stroke-width:1;stroke:rgb(0,0,0)"/>
    </svg>
    <% } %>
</body>
</html>
<% 
   }else{ 
%>
<html>
    <head>
        <title>Grafico Electoral</title>
    </head>
    <body bgcolor="#ffd7a3">
        <h1>Por favor, el nombre de partido y/o el numero de votos no puede estar en blanco!</h1>
        <a href="inicio.html">Volver</a>
    </body>
</html>
<% } %>
