<%@ page import="ru.sggr.karma.announce.HelpAnnounce" %>



<div class="fieldcontain ${hasErrors(bean: helpAnnounceInstance, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="helpAnnounce.name.label" default="Name"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${helpAnnounceInstance?.name}"/>
</div>

