
<%@ page import="ru.sggr.karma.KarmaHistory" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'karmaHistory.label', default: 'KarmaHistory')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li>
							<g:link class="list" action="list">
								<i class="icon-list"></i>
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
					<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>

				<dl>
				
					<g:if test="${karmaHistoryInstance?.dateCreated}">
						<dt><g:message code="karmaHistory.dateCreated.label" default="Date Created" /></dt>
						
							<dd><g:formatDate date="${karmaHistoryInstance?.dateCreated}" /></dd>
						
					</g:if>
				
					<g:if test="${karmaHistoryInstance?.lastUpdated}">
						<dt><g:message code="karmaHistory.lastUpdated.label" default="Last Updated" /></dt>
						
							<dd><g:formatDate date="${karmaHistoryInstance?.lastUpdated}" /></dd>
						
					</g:if>
				
					<g:if test="${karmaHistoryInstance?.announce}">
						<dt><g:message code="karmaHistory.announce.label" default="Announce" /></dt>
						
							<dd><g:link controller="abstractAnnounce" action="show" id="${karmaHistoryInstance?.announce?.id}">${karmaHistoryInstance?.announce?.encodeAsHTML()}</g:link></dd>
						
					</g:if>
				
					<g:if test="${karmaHistoryInstance?.author}">
						<dt><g:message code="karmaHistory.author.label" default="Author" /></dt>
						
							<dd><g:link controller="user" action="show" id="${karmaHistoryInstance?.author?.id}">${karmaHistoryInstance?.author?.encodeAsHTML()}</g:link></dd>
						
					</g:if>
				
					<g:if test="${karmaHistoryInstance?.user}">
						<dt><g:message code="karmaHistory.user.label" default="User" /></dt>
						
							<dd><g:link controller="user" action="show" id="${karmaHistoryInstance?.user?.id}">${karmaHistoryInstance?.user?.encodeAsHTML()}</g:link></dd>
						
					</g:if>
				
					<g:if test="${karmaHistoryInstance?.karmaChange}">
						<dt><g:message code="karmaHistory.karmaChange.label" default="Karma Change" /></dt>
						
							<dd><g:fieldValue bean="${karmaHistoryInstance}" field="karmaChange"/></dd>
						
					</g:if>
				
				</dl>

				<g:form>
					<g:hiddenField name="id" value="${karmaHistoryInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn" action="edit" id="${karmaHistoryInstance?.id}">
							<i class="icon-pencil"></i>
							<g:message code="default.button.edit.label" default="Edit" />
						</g:link>
						<button class="btn btn-danger" type="submit" name="_action_delete">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete" />
						</button>
					</div>
				</g:form>

			</div>

		</div>
	</body>
</html>
