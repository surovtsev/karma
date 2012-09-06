<%@ page import="ru.sggr.karma.KarmaHistory" %>



<div class="fieldcontain ${hasErrors(bean: karmaHistoryInstance, field: 'announce', 'error')} ">
    <label for="announce">
        <g:message code="karmaHistory.announce.label" default="Announce"/>
        
    </label>
    <g:select id="announce" name="announce.id" from="${ru.sggr.karma.announce.AbstractAnnounce.list()}" optionKey="id" value="${karmaHistoryInstance?.announce?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: karmaHistoryInstance, field: 'author', 'error')} ">
    <label for="author">
        <g:message code="karmaHistory.author.label" default="Author"/>
        
    </label>
    <g:select id="author" name="author.id" from="${ru.sggr.karma.User.list()}" optionKey="id" value="${karmaHistoryInstance?.author?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: karmaHistoryInstance, field: 'user', 'error')} ">
    <label for="user">
        <g:message code="karmaHistory.user.label" default="User"/>
        
    </label>
    <g:select id="user" name="user.id" from="${ru.sggr.karma.User.list()}" optionKey="id" value="${karmaHistoryInstance?.user?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: karmaHistoryInstance, field: 'karmaChange', 'error')} required">
    <label for="karmaChange">
        <g:message code="karmaHistory.karmaChange.label" default="Karma Change"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="karmaChange" value="${fieldValue(bean: karmaHistoryInstance, field: 'karmaChange')}" required=""/>
</div>

