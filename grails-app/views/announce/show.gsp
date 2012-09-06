<%@ page import="ru.sggr.karma.announce.Announce" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'announce.label', default: 'Announce')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="row-fluid">
    <sec:ifAnyGranted roles="ROLE_ADMIN">
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
    </sec:ifAnyGranted>
    <div class="span9">

        <div class="page-header">
            <h1><g:message code="default.show.label" args="[entityName]"/></h1>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <dl>

            <g:if test="${announceInstance?.name}">
                <dt><g:message code="announce.name.label" default="Name"/></dt>

                <dd><g:fieldValue bean="${announceInstance}" field="name"/></dd>

            </g:if>

            <g:if test="${announceInstance?.karma}">
                <dt><g:message code="announce.karma.label" default="Karma"/></dt>

                <dd><g:fieldValue bean="${announceInstance}" field="karma"/></dd>

            </g:if>

            <g:if test="${announceInstance?.author}">
                <dt><g:message code="announce.author.label" default="Author"/></dt>

                <dd><g:link controller="user" action="show"
                            id="${announceInstance?.author?.id}">${announceInstance?.author?.encodeAsHTML()}</g:link></dd>

            </g:if>

            <g:if test="${announceInstance?.announceType}">
                <dt><g:message code="announce.announceType.label" default="Announce Type"/></dt>

                <dd><g:fieldValue bean="${announceInstance}" field="announceType"/></dd>

            </g:if>

            <g:if test="${announceInstance?.dateCreated}">
                <dt><g:message code="announce.dateCreated.label" default="Date Created"/></dt>

                <dd><g:formatDate date="${announceInstance?.dateCreated}"/></dd>

            </g:if>

            <g:if test="${announceInstance?.lastUpdated}">
                <dt><g:message code="announce.lastUpdated.label" default="Last Updated"/></dt>

                <dd><g:formatDate date="${announceInstance?.lastUpdated}"/></dd>

            </g:if>

        </dl>

        <g:form>

            <g:hiddenField name="id" value="${announceInstance?.id}"/>
            <div class="form-actions">
                <sec:ifAnyGranted roles="ROLE_ADMIN">
                    <g:link class="btn" action="edit" id="${announceInstance?.id}">
                        <i class="icon-pencil"></i>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
                    <button class="btn btn-danger" type="submit" name="_action_delete">
                        <i class="icon-trash icon-white"></i>
                        <g:message code="default.button.delete.label" default="Delete"/>
                    </button>
                    <karma:thanksButton announceId="${announceInstance?.id}"/>
                </sec:ifAnyGranted>
            </div>
        </g:form>

    </div>

</div>
</body>
</html>
