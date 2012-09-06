<%@ page contentType="text/html"%>
<html>
<head>
  <title>Помощь от ${helpAnnounceInstance.author.name}</title>
</head>
<body>
    Разработчик ${helpAnnounceInstance.author.name} помог вам (<g:link controller="helpAnnounce" action="show" id="${helpAnnounceInstance.id}" absolute="true">${helpAnnounceInstance.name}</g:link>). Его помощь была полезной?  <br/>
</body>
</html>