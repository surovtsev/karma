<%@ page import="ru.sggr.karma.announce.Announce" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'announce.label', default: 'Announce')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
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
                    <li class="active">
                        <g:link class="create" action="create">
                            <i class="icon-plus icon-white"></i>
                            <g:message code="default.create.label" args="[entityName]"/>
                        </g:link>
                    </li>
                </ul>
            </div>
        </div>
    </sec:ifAllGranted>

    <div class="span9">

        <div class="page-header">
            <h1><g:message code="announce.create.label" args="[entityName]"/></h1>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <g:hasErrors bean="${announceInstance}">
            <bootstrap:alert class="alert-error">
                <ul>
                    <g:eachError bean="${announceInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </bootstrap:alert>
        </g:hasErrors>

        <fieldset>
            <g:form class="form-horizontal" action="create">
                <fieldset>
                    <f:field bean="announceInstance" property="name" input-class="input-xxlarge" />
                    <f:field bean="announceInstance" property="description" input-class="input-xxlarge" input-rows="8"/>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="icon-ok icon-white"></i>
                            <g:message code="default.button.create.label" default="Create"/>
                        </button>
                    </div>
                </fieldset>
            </g:form>
        </fieldset>

    </div>

</div>
</body>
</html>
