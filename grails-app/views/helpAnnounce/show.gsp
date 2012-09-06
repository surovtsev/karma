<%@ page import="ru.sggr.karma.announce.HelpAnnounce" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'helpAnnounce.label', default: 'HelpAnnounce')}"/>
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

            <g:if test="${helpAnnounceInstance?.name}">
                <dt><g:message code="helpAnnounce.name.label" default="Name"/></dt>

                <dd><g:fieldValue bean="${helpAnnounceInstance}" field="name"/></dd>

            </g:if>

            <g:if test="${helpAnnounceInstance?.karma}">
                <dt><g:message code="helpAnnounce.karma.label" default="Karma"/></dt>

                <dd><g:fieldValue bean="${helpAnnounceInstance}" field="karma"/></dd>

            </g:if>

            <g:if test="${helpAnnounceInstance?.author}">
                <dt><g:message code="helpAnnounce.author.label" default="Author"/></dt>

                <dd><g:link controller="user" action="show"
                            id="${helpAnnounceInstance?.author?.id}">${helpAnnounceInstance?.author?.encodeAsHTML()}</g:link></dd>

            </g:if>

            <g:if test="${helpAnnounceInstance?.announceType}">
                <dt><g:message code="helpAnnounce.announceType.label" default="Announce Type"/></dt>

                <dd><g:fieldValue bean="${helpAnnounceInstance}" field="announceType"/></dd>

            </g:if>

            <g:if test="${helpAnnounceInstance?.dateCreated}">
                <dt><g:message code="helpAnnounce.dateCreated.label" default="Date Created"/></dt>

                <dd><g:formatDate date="${helpAnnounceInstance?.dateCreated}"/></dd>

            </g:if>

            <g:if test="${helpAnnounceInstance?.lastUpdated}">
                <dt><g:message code="helpAnnounce.lastUpdated.label" default="Last Updated"/></dt>

                <dd><g:formatDate date="${helpAnnounceInstance?.lastUpdated}"/></dd>

            </g:if>
            <g:if test="${helpAnnounceInstance?.helpedDevelopers}">
                <dt><g:message code="helpAnnounce.helpedDevelopers.label" default="Помог рарзарботчикам"/></dt>
                <g:each in="${helpAnnounceInstance?.helpedDevelopers}" var="developer">
                    <dd>${developer.name}</dd>
                </g:each>




            </g:if>

        </dl>

        <g:form>
            <g:hiddenField name="id" value="${helpAnnounceInstance?.id}"/>
            <div class="form-actions">
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <g:link class="btn" action="edit" id="${helpAnnounceInstance?.id}">
                        <i class="icon-pencil"></i>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
                    <button class="btn btn-danger" type="submit" name="_action_delete">
                        <i class="icon-trash icon-white"></i>
                        <g:message code="default.button.delete.label" default="Delete"/>
                    </button>
                </sec:ifAllGranted>
                <karma:thanksButton announceId="${helpAnnounceInstance?.id}"/>
            </div>
        </g:form>

    </div>

</div>
</body>
</html>
