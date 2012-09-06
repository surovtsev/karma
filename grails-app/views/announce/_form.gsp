<%@ page import="ru.sggr.karma.announce.Announce" %>



<div class="fieldcontain ${hasErrors(bean: announceInstance, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="announce.name.label" default="Name"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${announceInstance?.name}"/>
</div>

