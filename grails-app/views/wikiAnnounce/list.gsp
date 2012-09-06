
<%@ page import="ru.sggr.karma.announce.WikiAnnounce" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'wikiAnnounce.label', default: 'WikiAnnounce')}" />
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
						
							<g:sortableColumn property="name" title="${message(code: 'wikiAnnounce.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="karma" title="${message(code: 'wikiAnnounce.karma.label', default: 'Karma')}" />
						
							<th class="header"><g:message code="wikiAnnounce.author.label" default="Author" /></th>
						
							<g:sortableColumn property="announceType" title="${message(code: 'wikiAnnounce.announceType.label', default: 'Announce Type')}" />
						
							<g:sortableColumn property="dateCreated" title="${message(code: 'wikiAnnounce.dateCreated.label', default: 'Date Created')}" />
						
							<g:sortableColumn property="lastUpdated" title="${message(code: 'wikiAnnounce.lastUpdated.label', default: 'Last Updated')}" />
						

						</tr>
					</thead>
					<tbody>
					<g:each in="${wikiAnnounceInstanceList}" var="wikiAnnounceInstance">

						<tr>
                            <td class="link">
                                <g:link action="show" id="${wikiAnnounceInstance.id}" class="btn btn-small"><g:message code="default.show.label"/> &raquo;</g:link>
                            </td>
						
							<td>${fieldValue(bean: wikiAnnounceInstance, field: "name")}</td>
						
							<td>${fieldValue(bean: wikiAnnounceInstance, field: "karma")}</td>
						
							<td>${fieldValue(bean: wikiAnnounceInstance, field: "author")}</td>
						
							<td>${fieldValue(bean: wikiAnnounceInstance, field: "announceType")}</td>
						
							<td><g:formatDate date="${wikiAnnounceInstance.dateCreated}" /></td>
						
							<td><g:formatDate date="${wikiAnnounceInstance.lastUpdated}" /></td>
						

						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${wikiAnnounceInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
