<%@ page import="ru.sggr.karma.announce.WikiAnnounce" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'wikiAnnounce.label', default: 'WikiAnnounce')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="row-fluid">
    <sec:ifAllGranted roles="ROLE_ADMIN">
        <div class="span3">
            <div class="well">
                <ul class="nav nav-list">
                    <li class="nav-header">${entityName}</li>
                    <li>
                        <g:link class="list" action="list">
                            <i class="icon-list"></i>
                            <g:message code="default.list.label" args="[entityName]"/>
                        </g:link>
                    </li>
                    <li>
                        <g:link class="create" action="create">
                            <i class="icon-plus"></i>
                            <g:message code="default.create.label" args="[entityName]"/>
                        </g:link>
                    </li>
                </ul>
            </div>
        </div>
    </sec:ifAllGranted>

    <div class="span9">

        <div class="page-header">
            <h1><g:message code="default.show.label" args="[entityName]"/></h1>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <dl>

            <g:if test="${wikiAnnounceInstance?.name}">
                <dt><g:message code="wikiAnnounce.name.label" default="Name"/></dt>

                <dd><g:fieldValue bean="${wikiAnnounceInstance}" field="name"/></dd>

            </g:if>

            <g:if test="${wikiAnnounceInstance?.karma}">
                <dt><g:message code="wikiAnnounce.karma.label" default="Karma"/></dt>

                <dd><g:fieldValue bean="${wikiAnnounceInstance}" field="karma"/></dd>

            </g:if>

            <g:if test="${wikiAnnounceInstance?.author}">
                <dt><g:message code="wikiAnnounce.author.label" default="Author"/></dt>

                <dd><g:link controller="user" action="show"
                            id="${wikiAnnounceInstance?.author?.id}">${wikiAnnounceInstance?.author?.encodeAsHTML()}</g:link></dd>

            </g:if>

            <g:if test="${wikiAnnounceInstance?.announceType}">
                <dt><g:message code="wikiAnnounce.announceType.label" default="Announce Type"/></dt>

                <dd><g:fieldValue bean="${wikiAnnounceInstance}" field="announceType"/></dd>

            </g:if>

            <g:if test="${wikiAnnounceInstance?.dateCreated}">
                <dt><g:message code="wikiAnnounce.dateCreated.label" default="Date Created"/></dt>

                <dd><g:formatDate date="${wikiAnnounceInstance?.dateCreated}"/></dd>

            </g:if>

            <g:if test="${wikiAnnounceInstance?.lastUpdated}">
                <dt><g:message code="wikiAnnounce.lastUpdated.label" default="Last Updated"/></dt>

                <dd><g:formatDate date="${wikiAnnounceInstance?.lastUpdated}"/></dd>

            </g:if>

            <g:if test="${wikiAnnounceInstance?.link}">
                <dt><g:message code="wikiAnnounce.link.label" default="Link"/></dt>

                <dd><g:link url="${wikiAnnounceInstance.link}" target="_new"><g:fieldValue bean="${wikiAnnounceInstance}" field="link"/></g:link> </dd>

            </g:if>

        </dl>

        <g:form>
            <g:hiddenField name="id" value="${wikiAnnounceInstance?.id}"/>
            <div class="form-actions">
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <g:link class="btn" action="edit" id="${wikiAnnounceInstance?.id}">
                        <i class="icon-pencil"></i>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
                    <button class="btn btn-danger" type="submit" name="_action_delete">
                        <i class="icon-trash icon-white"></i>
                        <g:message code="default.button.delete.label" default="Delete"/>
                    </button>
                </sec:ifAllGranted>
                <karma:thanksButton announceId="${wikiAnnounceInstance?.id}"/>
            </div>
        </g:form>

    </div>

</div>
</body>
</html>
