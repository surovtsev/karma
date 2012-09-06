<g:if test="${!alreadySaidThanks}">
    <g:link class="btn btn-success" controller="karmaHistory" action="thanks" id="${announceId}">
        <i class="icon-thumbs-up icon-white"></i>
        <g:message code="default.button.thanks.label" default="Спасибо!"/>
    </g:link>
</g:if>

<g:if test="${alreadySaidThanks}">
    <button class="btn btn-success disabled">
        <i class="icon-thumbs-up icon-white"></i>
        <g:message code="default.button.thanks.label" default="Спасибо!"/>
    </button>
</g:if>