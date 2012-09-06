<%@ page import="ru.sggr.karma.announce.WikiAnnounce" %>



<div class="fieldcontain ${hasErrors(bean: wikiAnnounceInstance, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="wikiAnnounce.name.label" default="Name"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${wikiAnnounceInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: wikiAnnounceInstance, field: 'link', 'error')} required">
    <label for="link">
        <g:message code="wikiAnnounce.link.label" default="Link"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field type="url" name="link" required="" value="${wikiAnnounceInstance?.link}"/>
</div>

