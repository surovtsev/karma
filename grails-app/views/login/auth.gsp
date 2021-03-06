<html>
<head>
	<meta name='layout' content='bootstrap'/>
	<title><g:message code="springSecurity.login.title"/></title>

</head>

<body>
<div class="row">
    <div class='span4'>
        <img src="${resource(dir: 'images', file: 'goodkarma.png')}" alt="Karma">
    </div>
	<div class='span4'>
		<legend><g:message code="springSecurity.login.header"/></legend>

		<g:if test='${flash.message}'>
			<div class='alert'>${flash.message}</div>
		</g:if>

		<form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
			<p>
				<label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class='text_' name='j_username' id='username'/>
			</p>

			<p>
				<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='text_' name='j_password' id='password'/>
			</p>

			<p id="remember_me_holder">
                <label class="checkbox">
				    <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				    <g:message code="springSecurity.login.remember.me.label"/>
                </label>
			</p>

			<p>
				<input type='submit' id="submit" class="btn btn-primary" value='${message(code: "springSecurity.login.button")}'/>
			</p>
		</form>
	</div>
</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
