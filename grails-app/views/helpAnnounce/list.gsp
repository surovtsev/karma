
<%@ page import="ru.sggr.karma.announce.HelpAnnounce" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'helpAnnounce.label', default: 'HelpAnnounce')}" />
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
						
							<g:sortableColumn property="name" title="${message(code: 'helpAnnounce.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="karma" title="${message(code: 'helpAnnounce.karma.label', default: 'Karma')}" />
						
							<th class="header"><g:message code="helpAnnounce.author.label" default="Author" /></th>
						
							<g:sortableColumn property="announceType" title="${message(code: 'helpAnnounce.announceType.label', default: 'Announce Type')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'helpAnnounce.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'helpAnnounce.lastUpdated.label', default: 'Last Updated')}" />
						

						</tr>
					</thead>
					<tbody>
					<g:each in="${helpAnnounceInstanceList}" var="helpAnnounceInstance">

						<tr>
                            <td class="link">
                                <g:link action="show" id="${helpAnnounceInstance.id}" class="btn btn-small"><g:message code="default.show.label"/> &raquo;</g:link>
                            </td>
						
							<td>${fieldValue(bean: helpAnnounceInstance, field: "name")}</td>
						
							<td>${fieldValue(bean: helpAnnounceInstance, field: "karma")}</td>
						
							<td>${fieldValue(bean: helpAnnounceInstance, field: "author")}</td>
						
							<td>${fieldValue(bean: helpAnnounceInstance, field: "announceType")}</td>
						
							<td><g:formatDate date="${helpAnnounceInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${helpAnnounceInstance.lastUpdated}" /></td>
						

						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${helpAnnounceInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
