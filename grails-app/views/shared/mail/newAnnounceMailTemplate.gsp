<%@ page contentType="text/html"%>
<html>
<head>
  <title>Новое предложение, идея от разработчика ${announceInstance.name}</title>
</head>
<body>
    Появилость новое предложение, идея от разработчика <g:link controller="announce" action="show" id="${announceInstance.id}" absolute="true">${announceInstance.name}</g:link> <br/>
    от  ${announceInstance.author.name}
</body>
</html>