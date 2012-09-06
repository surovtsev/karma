
<%@ page import="ru.sggr.karma.KarmaHistory" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'karmaHistory.label', default: 'KarmaHistory')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li class="active">
							<g:link class="list" action="list">
								<i class="icon-list icon-white"></i>
								<g:message code="default.list.label" args="[entityName]" />
							</g:link>
						</li>
						<li>
							<g:link class="create" action="create">
								<i class="icon-plus"></i>
								<g:message code="default.create.label" args="[entityName]" />
							</g:link>
						</li>
					</ul>
				</div>
			</div>

			<div class="span9">
				
				<div class="page-header">
					<h1><g:message code="default.list.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>
				
				<table class="table table-striped">
					<thead>
						<tr>
                            <th></th>
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'karmaHistory.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'karmaHistory.lastUpdated.label', default: 'Last Updated')}" />
						
							<th class="header"><g:message code="karmaHistory.announce.label" default="Announce" /></th>
						
							<th class="header"><g:message code="karmaHistory.author.label" default="Author" /></th>
						
							<th class="header"><g:message code="karmaHistory.user.label" default="User" /></th>
						
							<g:sortableColumn property="karmaChange" title="${message(code: 'karmaHistory.karmaChange.label', default: 'Karma Change')}" />
						

						</tr>
					</thead>
					<tbody>
					<g:each in="${karmaHistoryInstanceList}" var="karmaHistoryInstance">

						<tr>
                            <td class="link">
                                <g:link action="show" id="${karmaHistoryInstance.id}" class="btn btn-small"><g:message code="default.show.label"/> &raquo;</g:link>
                            </td>
						
							<td><g:formatDate date="${karmaHistoryInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${karmaHistoryInstance.lastUpdated}" /></td>
						
							<td>${fieldValue(bean: karmaHistoryInstance, field: "announce")}</td>
						
							<td>${fieldValue(bean: karmaHistoryInstance, field: "author")}</td>
						
							<td>${fieldValue(bean: karmaHistoryInstance, field: "user")}</td>
						
							<td>${fieldValue(bean: karmaHistoryInstance, field: "karmaChange")}</td>
						

						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${karmaHistoryInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
