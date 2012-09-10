<%@ page import="ru.sggr.karma.User" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="row-fluid">
    <div class="span3">
        <sec:ifAnyGranted roles="ROLE_ADMIN">
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
        </sec:ifAnyGranted>

        <div class="page-header">
            <h1><g:message code="user.label" args="[entityName]"/></h1>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <dl>

            <f:display bean="userInstance" property="name"/>

            <g:if test="${userInstance?.username}">
                <dt><g:message code="user.username.label" default="Username"/></dt>

                <dd><g:fieldValue bean="${userInstance}" field="username"/></dd>

            </g:if>

            <g:if test="${userInstance?.email}">
                <dt><g:message code="user.email.label" default="Email"/></dt>

                <dd><g:fieldValue bean="${userInstance}" field="email"/></dd>

            </g:if>


            <dt><g:message code="user.karma.label" default="Karma"/></dt>

            <dd><g:fieldValue bean="${userInstance}" field="karma"/>
            <sec:ifAnyGranted roles="ROLE_ADMIN">
                <g:link controller="karmaHistory" action="create" params="['user.id': userInstance?.id]"><g:message
                        code="default.change.label"/></g:link>
            </sec:ifAnyGranted>
            </dd>



            <g:if test="${userInstance?.dateCreated}">
                <dt><g:message code="user.dateCreated.label" default="Date Created"/></dt>

                <dd><g:formatDate date="${userInstance?.dateCreated}"/></dd>

            </g:if>

            <g:if test="${userInstance?.lastUpdated}">
                <dt><g:message code="user.lastUpdated.label" default="Last Updated"/></dt>

                <dd><g:formatDate date="${userInstance?.lastUpdated}"/></dd>

            </g:if>

            <g:if test="${userInstance?.enabled}">
                <dt><g:message code="user.enabled.label" default="Enabled"/></dt>

                <dd><g:formatBoolean boolean="${userInstance?.enabled}"/></dd>

            </g:if>

            <g:if test="${userInstance?.accountExpired}">
                <dt><g:message code="user.accountExpired.label" default="Account Expired"/></dt>

                <dd><g:formatBoolean boolean="${userInstance?.accountExpired}"/></dd>

            </g:if>

            <g:if test="${userInstance?.accountLocked}">
                <dt><g:message code="user.accountLocked.label" default="Account Locked"/></dt>

                <dd><g:formatBoolean boolean="${userInstance?.accountLocked}"/></dd>

            </g:if>

            <g:if test="${userInstance?.passwordExpired}">
                <dt><g:message code="user.passwordExpired.label" default="Password Expired"/></dt>

                <dd><g:formatBoolean boolean="${userInstance?.passwordExpired}"/></dd>

            </g:if>

        </dl>
        <sec:ifAnyGranted roles="ROLE_ADMIN">
            <g:form>
                <g:hiddenField name="id" value="${userInstance?.id}"/>
                <div class="form-actions">
                    <g:link class="btn" action="edit" id="${userInstance?.id}">
                        <i class="icon-pencil"></i>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
                    <button class="btn btn-danger" type="submit" name="_action_delete">
                        <i class="icon-trash icon-white"></i>
                        <g:message code="default.button.delete.label" default="Delete"/>
                    </button>
                </div>
            </g:form>
        </sec:ifAnyGranted>
    </div>

    <div class="span9">
        <div class="page-header">
            <h1><g:message code="user.karmaHistory" default="KarmaHistory"/></h1>
        </div>
        <table class="table table-striped">
            <thead>
            <tr>
                <sec:ifAnyGranted roles="ROLE_ADMIN">
                    <th></th>
                </sec:ifAnyGranted>

                <g:sortableColumn property="dateCreated"
                                  title="${message(code: 'user.karmaHistory.dateCreated.label', default: 'Date Created')}"/>

                <th class="header"><g:message code="user.karmaHistory.announce.label" default="Announce"/></th>

                <th class="header"><g:message code="user.karmaHistory.author.label" default="Author"/></th>

                <g:sortableColumn property="karmaChange"
                                  title="${message(code: 'user.karmaHistory.karmaChange.label', default: 'Karma Change')}"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${karmaHistory}" var="historyEntry">

                <tr>
                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <td class="link">
                            <g:link controller="karmaHistory" action="show" id="${historyEntry.id}"
                                    class="btn btn-small"><g:message
                                    code="default.show.label"/> &raquo;</g:link>
                        </td>
                    </sec:ifAnyGranted>

                    <td><g:formatDate date="${historyEntry.dateCreated}"/></td>

                    <td>${fieldValue(bean: historyEntry, field: "announce")}</td>

                    <td>${fieldValue(bean: historyEntry, field: "author")}</td>

                    <td>
                        <g:if test="${(fieldValue(bean: historyEntry, field: "karmaChange") as Long) > 0}">
                            +${fieldValue(bean: historyEntry, field: "karmaChange")}
                        </g:if>
                        <g:else>
                            ${fieldValue(bean: historyEntry, field: "karmaChange")}
                        </g:else>
                    </td>

                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pagination">
            <bootstrap:paginate total="${karmaHistoryTotal}"/>
        </div>
    </div>

</div>
</body>
</html>
