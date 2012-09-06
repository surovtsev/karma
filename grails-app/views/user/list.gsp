
<%@ page import="ru.sggr.karma.User" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
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
						
							<g:sortableColumn property="name" title="${message(code: 'user.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
						
							<g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'user.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'user.lastUpdated.label', default: 'Last Updated')}" />
						
							<g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}" />
						

						</tr>
					</thead>
					<tbody>
					<g:each in="${userInstanceList}" var="userInstance">

						<tr>
                            <td class="link">
                                <g:link action="show" id="${userInstance.id}" class="btn btn-small"><g:message code="default.show.label"/> &raquo;</g:link>
                            </td>
						
							<td>${fieldValue(bean: userInstance, field: "name")}</td>
						
							<td>${fieldValue(bean: userInstance, field: "username")}</td>
						
							<td>${fieldValue(bean: userInstance, field: "email")}</td>
						
							<td><g:formatDate date="${userInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${userInstance.lastUpdated}" /></td>
						
							<td><g:formatBoolean boolean="${userInstance.enabled}" /></td>
						

						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${userInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
