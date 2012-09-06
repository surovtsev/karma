<%@ page import="ru.sggr.karma.announce.HelpAnnounce; ru.sggr.karma.announce.WikiAnnounce" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap"/>
    <title>Рейтинг кармы</title>

</head>

<body>
<style>
.hero-unit {
    padding: 15px;
}

</style>

<div class="row-fluid">
    <aside id="application-status" class="span3">
        <div class="well sidebar-nav">

            <h2>Есть что-то полезное?</h2>

            <p><g:link controller="wikiAnnounce"
                       action="create">Добавьте ссылку на статью wiki</g:link>, чтобы другие разработчики ознакомились с ней и могли оценить ее</p>

            <h2>Обучили другого разработчика?</h2>

            <p><g:link controller="helpAnnounce"
                       action="create">Не стесняйтесь!</g:link> Это хорошее дело, не должно быть не замеченным.</p>

            <h2>Есть гениальная идея?</h2>

            <p><g:link controller="Announce"
                       action="create">Расскажите!</g:link> Все только рады рациональныем предложениям, реализациям, влияющим на скорость и качество разработки.</p>

        </div>
    </aside>

    <section id="main" class="span9">

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <div class="row-fluid">
            <div class="span8">
                <div class="hero-unit">
                    <h2>Добро пожаловать в приложение "Карма"</h2>

                    <p>Все мы любим программировать и рассказывать какие классные штуки сделали, и, самое глваное, как.</p>

                    <div class="row-fluid">

                        <div class="span8">
                            <p>Чтобы поощрять стремления, делиться знаниями и понимать какие из стремлений были полезны другим разработчикам, и было создано это приложение.</p>
                            <p>По итогам квартала определяется лидер кармы, который получает ценный приз:</p>
                            <p>Правила начисления кармы описаны в <g:link url="http://wiki/PravilaKarmy">wiki</g:link></p>
                        </div>

                        <div class="span4">
                            <img class="img-polaroid" height="150px" alt="iphone4s" alt="iPhone или аналогичный по ценности приз"
                                 src="${resource(dir: 'images', file: 'iphone4s.png')}"/>
                        </div>
                    </div>

                </div>
            </div>

            <div class="span4">
                <h2>Рейтинг кармы:</h2>

                <table class="table table-striped">
                    <tbody>
                    <g:each in="${karmaList}" var="karmaUserInstance">
                        <tr>
                            <td><g:link controller="user" action="show"
                                        id="${karmaUserInstance.id}">${fieldValue(bean: karmaUserInstance, field: "name")}</g:link></td>
                            <td>${fieldValue(bean: karmaUserInstance, field: "karma")}</td>
                            <td>(${WikiAnnounce.findAllByAuthor(karmaUserInstance).size()} статей wiki, помог ${HelpAnnounce.findAllByAuthor(karmaUserInstance).size()} разработчикам)</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span8">

                <h2>Новые статьи wiki</h2>
                <h5>требующие оценки</h5>

                <ul>
                    <g:each in="${wikiAnnouncesList}" var="WikiAnnounceInstance">
                        <li><g:link controller="wikiAnnounce" action="show" id="${WikiAnnounceInstance.id}">
                            ${fieldValue(bean: WikiAnnounceInstance, field: "name")}</g:link>
                            <g:if test="${WikiAnnounceInstance.isVoted}">
                                <i class="icon-thumbs-up icon-blue"></i>
                            </g:if>
                            (<g:link url="${((WikiAnnounce) WikiAnnounceInstance).link}">ссылка</g:link>)
                            от <g:link controller="user" action="show"
                                       id="${WikiAnnounceInstance.author.id}">${fieldValue(bean: WikiAnnounceInstance, field: "author")}</g:link>
                        </li>
                    </g:each>
                </ul>

                <h2>Помощь других разработчиков</h2>
                <h5>Помощь была полезна?</h5>
                <ul>
                    <g:each in="${helpAnnouncesList}" var="HelpAnnounceInstance">
                        <li><g:link controller="HelpAnnounce" action="show" id="${HelpAnnounceInstance.id}">
                            ${fieldValue(bean: HelpAnnounceInstance, field: "name")}</g:link>
                            <g:if test="${HelpAnnounceInstance.isVoted}">
                                <i class="icon-thumbs-up icon-white"></i>
                            </g:if>
                            от <g:link controller="user" action="show"
                                       id="${HelpAnnounceInstance.author.id}">${fieldValue(bean: HelpAnnounceInstance, field: "author")}</g:link>
                        </li>
                    </g:each>
                </ul>
                <sec:ifAnyGranted roles="ROLE_ADMIN">
                    <h2>Оцените идею</h2>
                    <h5>Есть за что поощерить?</h5>
                    <ul>
                        <g:each in="${announcesList}" var="AnnounceInstance">
                            <li><g:link controller="Announce" action="show" id="${AnnounceInstance.id}">
                                ${fieldValue(bean: AnnounceInstance, field: "name")}</g:link>
                                <g:if test="${AnnounceInstance.isVoted}">
                                    <i class="icon-thumbs-up icon-white"></i>
                                </g:if>
                                от <g:link controller="user" action="show"
                                           id="${AnnounceInstance.author.id}">${fieldValue(bean: AnnounceInstance, field: "author")}</g:link>
                            </li>
                        </g:each>
                    </ul>
                </sec:ifAnyGranted>

            </div>
            <div class="span4">
                <h2>Новости вашей кармы:</h2>
                <ul>
                    <g:each in="${karmaHistoryList}" var="karmaHistoryInstance">
                        <li>${karmaHistoryInstance.karmaChange}
                        <g:if test="${karmaHistoryInstance.announce}">
                            за "${karmaHistoryInstance?.announce.name}"
                        </g:if>
                        </li>
                    </g:each>
                </ul>

            </div>



        </div>

    </section>
</div>

</body>
</html>
