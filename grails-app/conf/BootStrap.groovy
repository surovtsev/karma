import grails.util.GrailsUtil
import org.codehaus.groovy.grails.commons.GrailsApplication
import ru.sggr.karma.Role
import ru.sggr.karma.User
import ru.sggr.karma.UserRole
import ru.sggr.karma.announce.Announce
import ru.sggr.karma.announce.HelpAnnounce
import ru.sggr.karma.announce.WikiAnnounce

class BootStrap {

    def init = { servletContext ->

        def adminRole = Role.findByAuthority("ROLE_ADMIN")
        if (!adminRole) {
            adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        }

        def userRole = Role.findByAuthority("ROLE_USER")
        if (!userRole) {
            userRole = new Role(authority: 'ROLE_USER').save(flush: true)
        }

        def admin = User.findByUsername("admin");
        if (!admin) {
            admin = new User(
                    username: 'admin',
                    enabled: true,
                    password: '1',
                    email: 'admin@sg-gr.ru',
                    name: 'Администратор')

            admin.save(flush: true)

            UserRole.create admin, adminRole, true
            UserRole.create admin, userRole, true
        }
        assert Role.count() == 2

        if (GrailsUtil.environment == GrailsApplication.ENV_DEVELOPMENT) {
            def user = User.findByUsername("user");
            if (!user) {
                user = new User(
                        username: 'user',
                        enabled: true,
                        password: '1',
                        email: 'user@sg-gr.ru',
                        name: 'Пользователь')

                user.save(flush: true)

                UserRole.create user, userRole, true
            }

            new WikiAnnounce(name: "Основы программирования Java", karma: 0, author: user, link: "http://wikipedia.ru/java").save(flush: true);
            new HelpAnnounce(name: "Помог разобраться в методе Админу", karma: 0, author: user, helpedDevelopers: [admin]).save(flush: true);
            new HelpAnnounce(name: "Помог разобраться в методе Пользователю", karma: 0, author: user, helpedDevelopers: [user]).save(flush: true);
            new Announce(name: "За ускорение сборки проекта", karma: 0, author: user).save(flush: true);
        }
    }
    def destroy = {
    }
}
