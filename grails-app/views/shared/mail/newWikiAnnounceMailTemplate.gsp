<%@ page contentType="text/html"%>
<html>
<head>
  <title>Появилась новая статья wiki ${wikiAnnounceInstance.name}</title>
</head>
<body>
    Появилась новая статья wiki <g:link controller="wikiAnnounce" action="show" id="${wikiAnnounceInstance.id}" absolute="true">${wikiAnnounceInstance.name}</g:link> <br/>
    от  ${wikiAnnounceInstance.author.name}
</body>
</html>