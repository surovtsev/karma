<%@ page import="org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><g:layoutTitle default="${meta(name: 'app.name')}"/></title>
    <meta name="description" content="">
    <meta name="author" content="">

    <meta name="viewport" content="initial-scale = 1.0">

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

    <r:require modules="scaffolding"/>

    <!-- Le fav and touch icons -->

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon-iphone.png')}">
    <link rel="apple-touch-icon" sizes="72x72" href="${resource(dir: 'images', file: 'apple-touch-icon-ipad.png')}">
    <link rel="apple-touch-icon" sizes="114x114"
          href="${resource(dir: 'images', file: 'apple-touch-icon-iphone4.png')}">
    <link rel="apple-touch-icon" sizes="144x144" href="${resource(dir: 'images', file: 'apple-touch-icon-ipad3.png')}">

    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body>

<nav class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">

            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <a class="brand" href="${createLink(uri: '/')}">Karma</a>

            <div class="nav-collapse">
                <ul class="nav">
                    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_USER">
                        <li><g:link controller="wikiAnnounce" action="create">Добавить ссылку wiki</g:link></li>
                        <li><g:link controller="helpAnnounce" action="create">Помог разработчику</g:link></li>
                        <li><g:link controller="announce" action="create">Есть идея</g:link></li>
                    </sec:ifAnyGranted>

                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <li><g:link controller="user">Разработчики</g:link></li>
                        <li><g:link controller="karmaHistory" action="create">Изменить карму</g:link></li>
                        <li><g:link controller="wikiAnnounce">Все wiki - анонсы</g:link></li>
                        <li><g:link controller="helpAnnounce">Помощь разработчикм</g:link></li>
                        <li><g:link controller="announce">Все идеи</g:link></li>
                    </sec:ifAllGranted>
                    <sec:ifLoggedIn>
                        <li><g:link controller="user" action="profile"><sec:username/></g:link></li>
                        <li><g:link controller="logout">Выйти</g:link></li>
                    </sec:ifLoggedIn>
                    <sec:ifNotLoggedIn>
                        <li><g:link controller="login">Войти</g:link></li>
                    </sec:ifNotLoggedIn>
                </ul>
            </div>

        </div>
    </div>
</nav>

<div class="container-fluid">
    <g:layoutBody/>

    <hr>

    <footer>
        <p>&copy; SG-Group 2012</p>
    </footer>
</div>

<r:layoutResources/>

</body>
</html>